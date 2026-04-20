SMODS.DrawStep {
	key = 'jand_danbo_use',
	order = -30,
	func = function(self)
		if self.children.joker_button then
            if self.highlighted then
                self.children.joker_button:draw() 
            else
                self.children.joker_button:remove() 
                self.children.joker_button = nil
            end
        end
        if self.children.joker_button then
            if self.highlighted then
                self.children.joker_button:draw() 
            else
                self.children.joker_button:remove() 
                self.children.joker_button = nil
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