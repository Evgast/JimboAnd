
function G.FUNCS.recalc(e)
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
	key = 'new_use',
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