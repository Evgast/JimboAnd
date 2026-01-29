local highlight_hooky = Card.highlight
function Card:highlight(is_highlighted)
    highlight_hooky(self, is_highlighted)
    local danbo_use = {n = G.UIT.ROOT, config = { minw = 1, minh = 1, align = "tm", colour = G.C.CLEAR}, nodes = {
	            {n = G.UIT.C, config = { minw = 1, minh = 1, colour = G.C.CLEAR, r = 0.1, padding = 0.15, func = "recalc" }, nodes = {
                    UIBox_button{ label = {localize("b_use")}, scale = 0.6, minw = 1.5, minh = 1, colour = G.C.BLACK, r = 0.1, button = nil, ref_table = self, func = "danboskill", shadow = true},
            }}}}
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