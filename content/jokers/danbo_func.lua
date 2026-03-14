
function G.FUNCS.jand_recalc(e)
    e.parent.UIBox:recalculate()
end

function G.FUNCS.danboskill(e)
    local card = e.config.ref_table
    if card.config.center:can_use(card) then
        e.config.button = "danbobutt"
        e.config.colour = G.C.GREEN
    else
        e.config.button = nil
        e.config.colour = G.C.BLACK
    end
end

function G.FUNCS.danbobutt(e)
    local card = e.config.ref_table
    card.config.center:use(card)
    card:highlight(false)
end

SMODS.DrawStep {
	key = 'danbo_use',
	order = -30,
	func = function(self)
        if self.skele_run then
            self.T.x = self.T.x + 0.5
            if self.T.x > G.consumeables.T.x + 10 then
                self:remove()
            end
        end
		if self.children.danbo_button then
            if self.highlighted then
                self.children.danbo_button:draw() 
            else
                self.children.danbo_button:remove() 
                self.children.danbo_button = nil
            end
        end
        if self.children.danbo_button then
            if self.highlighted then
                self.children.danbo_button:draw() 
            else
                self.children.danbo_button:remove() 
                self.children.danbo_button = nil
            end
        end
	end,
}

SMODS.DrawStep {
	key = 'nikola_shop_ui',
	order = -30,
	func = function(self)
        local t2 = {
            n=G.UIT.ROOT, config = {ref_table = card, minw = 1.1, maxw = 1.3, padding = 0.1, align = 'bm', colour = G.C.SECONDARY_SET.Planet, shadow = true, r = 0.08, minh = 0.94, hover = true}, nodes={
                {n=G.UIT.T, config={text = localize('b_buy'),colour = G.C.WHITE, scale = 0.5}}
            }}
		if self.children.lv_price then
            self.children.lv_price:draw() 
        end
        if self.children.buy_lv then
            self.children.buy_lv:draw()
        end
	end,
}