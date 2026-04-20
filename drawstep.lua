SMODS.DrawStep {
	key = 'danbo_use',
	order = -30,
	func = function(self)
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