
SMODS.current_mod.custom_card_areas = function(G)
	G.danbo = CardArea(
		0, 0, 0, 0,
        {
            card_limit = 1, 
            type = 'discard', 
            highlight_limit = 1, 
            no_card_count = true 
        }
	)
end

SMODS.Atlas {
	key = "jimband",
	path = "jimband.png",
	px = 71,
	py = 95
}

if not SMODS.ObjectTypes['Food'] then
	SMODS.ObjectType({
    	key = "Food",
    	default = "j_ice_cream",
    	cards = {
        	j_gros_michel = true,
        	j_egg = true,
        	j_ice_cream = true,
        	j_cavendish = true,
        	j_turtle_bean = true,
        	j_diet_cola = true,
        	j_popcorn = true,
        	j_ramen = true,
        	j_selzer = true,
    },
})
end

SMODS.load_file("hooks.lua")()


--I'll probably add a feature for disabling packs one day
SMODS.load_file("content/jokers/azumatsuba.lua")()
SMODS.load_file("content/jokers/danbo_func.lua")()


function table.contains(table, element) --why did I have that again? Sure I'll probably use it one day but I still didn't do so
    if table and type(table) == "table" then
        for _, value in pairs(table) do
            if value == element then
                return true
            end
        end
        return false
    end
end