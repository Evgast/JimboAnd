local highlight_hooky = Card.highlight
function Card:highlight(is_highlighted)
    highlight_hooky(self, is_highlighted)
    local joker_use = {n = G.UIT.ROOT, config = { minw = 1, minh = 1, align = "tm", colour = G.C.CLEAR}, nodes = {
	            {n = G.UIT.C, config = { minw = 1, minh = 1, colour = G.C.CLEAR, r = 0.1, padding = 0.15, func = "jand_recalc" }, nodes = {
                    UIBox_button{ label = {localize("b_use")}, scale = 0.6, minw = 1.5, minh = 1, colour = G.C.BLACK, r = 0.1, button = nil, ref_table = self, func = "jand_joker_use", shadow = true},
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
    if self.highlighted and self.config.center.jand_usable and self.area.config.type == "joker" and not self.ability.extra.copying then
        self.children.joker_button = UIBox({    
            definition = joker_use,
            config = {
            parent = self,
            align = 'tm',
            offset = { x = 0, y = 3.55 },
            colour = G.C.CLEAR}})
    elseif self.children.joker_button and self.config.center.jand_usable and not self.highlighted then
        self.children.joker_button:remove()
        self.children.joker_button = nil
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
	if next(SMODS.find_card("j_jand_yomi")) then
        local yomi_owned = false
        for k, v in pairs(SMODS.find_card("j_jand_yomi")) do
            if v.area.config.type == "joker" then
                yomi_owned = true
            end
        end
        if card:has_attribute("food") and yomi_owned then
		    SMODS.calculate_effect({message = localize("k_nope_ex"), colour = G.C.PURPLE, delay = 0.2}, card)
            return nil
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
        JAND.remove_from_used("Vanilla")
    end
    for k, v in pairs(G.jand_shopkeep.cards) do
		v.config.center:apply()
	end
    G.GAME.stocked = true
    G.update_quipbox = true
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
    JAND.dialogues = {}
    for k, v in pairs(JAND.fuck_dialogues) do
        JAND.dialogues[k] = v
    end
    JAND.merge_pools("Food", {"flynnset_food"}, true)
    JAND.pool_to_attribute("Food", "food")
    JAND.auto_beta()
    init_colsets()
    return menu_hook(self, change_context)
end

local click_hook = Card.click
function Card:click()
    click_hook(self)
    if self.jand_click_func then
        self:jand_click_func()
    end
end

local remove_hook = Card.remove
function Card:remove()
    remove_hook(self)
    if self.config.center.remove_general then
        self.config.center:remove_general(self)
    end
end

local h_hook = Card.generate_UIBox_ability_table
function Card:generate_UIBox_ability_table()
    if self.children.h_popup and self.config.center and self.config.center.key == "j_jand_arthur" then 
        return
    end
    return h_hook(self)
end

local stop_h_hook = Node.stop_hover
function Node:stop_hover()
    if self.highlighted and self.config.center and self.config.center.key == "j_jand_arthur" then
        return
    end
    stop_h_hook(self)
end

local mod_badge_hook = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
    if obj then
        if obj.mod == JAND then
            if obj.jand_pack then
                local pack = JAND.Packs[obj.jand_pack]
                local mod = obj.mod
                local badge_text = DynaText({string = mod.display_name, colours = {pack.text_colour},float = true, shadow = true, offset_y = -0.05, silent = true, spacing = 1, scale = 0.33})
                local pack_text = DynaText({string = pack.text, colours = {pack.text_colour},float = true, shadow = true, offset_y = -0.05, silent = true, spacing = 1, scale = 0.33})
                local text_nodes =
                    {
                        { n = G.UIT.R, config = {minw =  0.6, align = "cm",}, nodes = {
                            {n=G.UIT.B, config={h=0.1,w=0.1}},
                                { n = G.UIT.O, config = {object = badge_text}},
                            {n=G.UIT.B, config={h=0.1,w=0.1}}
                        }},
                        { n = G.UIT.R, config = {minw =  0.6, align = "cm",}, nodes = {
                            {n=G.UIT.B, config={h=0.1,w=0.1}},
                                { n = G.UIT.O, config = {object = pack_text}},
                            {n=G.UIT.B, config={h=0.1,w=0.1}}
                        }}
                    }
                badges[#badges + 1] = {n=G.UIT.R, config={align = "cm"}, nodes={
                    {n=G.UIT.R, config={align = "cm", minw = 0.6, colour = pack.badge_colour, r = 1, emboss = 0.05, padding = 0.03}, nodes=text_nodes}
                }}
                return
            end
        end
    end
    return mod_badge_hook(obj, badges)
end

local skip_blind_hook = G.FUNCS.hover_tag_proxy
G.FUNCS.hover_tag_proxy = function(e)
    skip_blind_hook(e)
    if (G.GAME.blinds_skipped and G.GAME.blinds_skipped > 0) and G.GAME.round_resets.blind_choices.Boss == "bl_jand_h_iii" then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end


