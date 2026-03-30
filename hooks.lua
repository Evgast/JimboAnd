local highlight_hooky = Card.highlight
function Card:highlight(is_highlighted)
    highlight_hooky(self, is_highlighted)
    local danbo_use = {n = G.UIT.ROOT, config = { minw = 1, minh = 1, align = "tm", colour = G.C.CLEAR}, nodes = {
	            {n = G.UIT.C, config = { minw = 1, minh = 1, colour = G.C.CLEAR, r = 0.1, padding = 0.15, func = "jand_recalc" }, nodes = {
                    UIBox_button{ label = {localize("b_use")}, scale = 0.6, minw = 1.5, minh = 1, colour = G.C.BLACK, r = 0.1, button = nil, ref_table = self, func = "danboskill", shadow = true},
            }}}}
    local lv_buy = { n=G.UIT.ROOT, config = {ref_table = card, minw = 1.1, maxw = 1.3, padding = 0.1, align = 'bm', colour = G.C.SECONDARY_SET.Planet, shadow = true, r = 0.08, minh = 0.94, hover = true, ref_value = self, func = "can_buy_lv", button = "buy_lv_butt"}, nodes={
                {n=G.UIT.T, config={text = localize('b_buy'),colour = G.C.WHITE, scale = 0.5}}
            }}
    local sacrifice = {n = G.UIT.ROOT, config = { minw = 1, minh = 1, align = "tm", colour = G.C.CLEAR}, nodes = {
	            {n = G.UIT.C, config = { minw = 1, minh = 1, colour = G.C.CLEAR, r = 0.1, padding = 0.15,  }, nodes = {
                    UIBox_button{ label = {"SACRIFICE"}, scale = 0.6, minw = 1.5, minh = 1, colour = G.C.BLACK, r = 0.1, button = nil, ref_table = self, func = "sacrifunc", shadow = true},
            }}}}
    local rbs_buy = { n=G.UIT.ROOT, config = {ref_table = card, minw = 1.1, maxw = 1.3, padding = 0.1, align = 'bm', colour = G.C.PURPLE, shadow = true, r = 0.08, minh = 0.94, hover = true, ref_value = self, func = "can_buy_rbs", button = "buy_rbs_butt"}, nodes={
                {n=G.UIT.T, config={text = "TRADE",colour = G.C.WHITE, scale = 0.5}}
            }}
    local rbs_confirm = { n=G.UIT.ROOT, config = {ref_table = card, minw = 1.1, maxw = 1.3, padding = 0.1, align = 'bm', colour = G.C.PURPLE, shadow = true, r = 0.08, minh = 0.94, hover = true, ref_value = self, funcs = "can_confirm_rbs", button = "rbs_confirm"}, nodes={
                {n=G.UIT.T, config={text = "TRADE",colour = G.C.WHITE, scale = 0.5}}
            }}
    --danbo
    if self.highlighted and self.config.center.key == "j_jand_danbo" and not self.ability.extra.to_copy then
        self.children.danbo_button = UIBox({    
            definition = danbo_use,
            config = {
            parent = self,
            align = 'tm',
            offset = { x = 0, y = 3.55 },
            colour = G.C.CLEAR}})
    elseif self.children.danbo_button and not self.highlighted and self.config.center.key == "j_jand_danbo" then
        self.children.danbo_button:remove()
        self.children.danbo_button = nil
    end
    --hand level shop buy
    if self.highlighted and self.children.lv_price and not self.children.buy_lv then
        self.children.buy_lv = UIBox{
            definition = lv_buy,
            config = {
                align="bm",
                offset = {x=0,y=-0.35},
                major = self,
                bond = 'Weak',
                parent = self
                }
            }
    elseif self.children.buy_lv and not self.highlighted then
        self.children.buy_lv:remove()
        self.children.buy_lv = nil
    end
    --hand level sacrifice
    if self.highlighted and self.sacrifice then
        self.children.use_button= UIBox{
            definition = sacrifice,
            config = {
                align="bm",
                offset = {x=0,y=-0.35},
                major = self,
                bond = 'Weak',
                parent = self
                }
            }
    elseif self.sacrifice and self.children.use_button and not self.highlighted then
        self.children.use_button:remove()
        self.children.use_button = nil
    end
    --I might be an idiot but yeah
    if self.highlighted and self.area.config.jand_no_use and self.children.use_button then
        self.children.use_button:remove()
        self.children.use_button = nil
    end
    --Revo buy 
    if self.highlighted and self.children.rbs_price and not self.children.rbs_buy then
        self.children.rbs_buy = UIBox{
            definition = rbs_buy,
            config = {
                align="bm",
                offset = {x=0,y=-0.35},
                major = self,
                bond = 'Weak',
                parent = self
                }
            }
    elseif self.children.rbs_buy and not self.highlighted then
        self.children.rbs_buy:remove()
        self.children.rbs_buy = nil
    end
    --Revo trade
    if self.highlighted and self.printer then
        self.children.use_button = UIBox{
            definition = rbs_confirm,
            config = {
                align="bm",
                offset = {x=0,y=-0.35},
                major = self,
                bond = 'Weak',
                parent = self
            }
        }
    end
end

local align_hooky = CardArea.align_cards
function CardArea:align_cards()
    local pre_align = {}
    if self.config.type == "joker" then
        for k, v in pairs(self.cards) do
            pre_align[#pre_align+1] = v
        end
    end
    align_hooky(self)
    local joker_realigned = false
    if self.config.type == "joker" then
        for k, v in pairs(self.cards) do
            if pre_align[k] ~= v then
                joker_realigned = true
            end
        end
    end
    if joker_realigned then
        SMODS.calculate_context({jimband_joker_align = true})
    end
end

local scale_hook = SMODS.scale_card
function SMODS.scale_card(card, args)
	if #SMODS.find_card("j_jand_yomi") ~= 0 then
		for k, v in pairs(G.P_CENTER_POOLS["Food"]) do
			if v.key == card.config.center.key then
				SMODS.calculate_effect({message = localize("k_nope_ex"), colour = G.C.PURPLE, delay = 0.2}, card)
				return
			end
		end
	end
	scale_hook(card, args)
end

local start_run_ref = Game.start_run
function Game:start_run(args)
    start_run_ref(self, args)
    extra_shop_create()
    if not G.GAME.stocked then
        restock_extra_shop()
    end
    for k, v in pairs(G.jand_shopkeep.cards) do
		v.config.center:apply()
	end
    G.GAME.stocked = true
end

local use_hook = G.FUNCS.use_card
function G.FUNCS.use_card(e, mute, nosave)
    use_hook(e, mute, nosave)
    if G.GAME.current_shop == "Jand" then
        JAND.hide_shop(G.extra_shop)
        G.E_MANAGER:add_event(Event({
            trigger = "after", 
            delay = 0.3, 
            func = function() 
                JAND.show_shop(G.extra_shop)
                return true 
            end
        }))
    end
end

local menu_hook = Game.main_menu
function Game:main_menu(change_context)
    JAND.merge_pools("Food", {"flynnset_food"}, true)
    return menu_hook(self, change_context)
end


