
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
		if self.children.lv_price then
            self.children.lv_price:draw() 
        end
        if self.children.buy_lv then
            self.children.buy_lv:draw()
        end
	end,
}

SMODS.DrawStep {
	key = 'revo_shop_ui',
	order = -30,
	func = function(self)
		if self.children.rbs_price then
            self.children.rbs_price:draw() 
        end
        if self.children.rbs_buy then
            self.children.rbs_buy:draw()
        end
	end,
}