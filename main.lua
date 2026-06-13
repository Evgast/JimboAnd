JAND = SMODS.current_mod

JAND.optional_features = {
    retrigger_joker = true,
}

function JAND.reset_game_globals(run_start)
	if run_start then
		if G.beta_key then
        	SMODS.add_card({ set = "Joker", area = G.jokers, key = G.beta_key, key_append = "jand_beta", no_edition = true })
    	end
	end
end

JAND.ui_config = {
	colour = darken(G.C.GREEN, 0.6),
	author_colour = G.C.PURPLE,
	bg_colour = { G.C.GREEN[1], G.C.GREEN[2], G.C.GREEN[2], 0.3 },
	back_colour = G.C.GREEN,
	tab_button_colour = G.C.GREEN,
}

JAND.custom_ui = function(nodes)
    local logo = { n = G.UIT.R, config = { align = 'cm' }, nodes = {
        {n = G.UIT.R, config = { align = 'cm' }, nodes = {
            {n = G.UIT.O, config = {object = SMODS.create_sprite(0, 0, 7, 2.8, 'jand_jandgo', { x = 0, y = 0 })}}
        }}
    }}
    table.insert(nodes, 2, logo)
    return nodes
end

JAND.extra_tabs = function()
	return {
		{
			label = 'Packs!',
			tab_definition_function = function()
				return G.JAND_PACKCOL()
			end,
		},
	}
end

JAND.custom_collection_tabs = function()
	local t = UIBox_button({button = 'your_collection_shopkeepers', label = {"Shopkeepers"}, minw = 5})
	return { t }
end

JAND.set_debuff = function(card)
	if card.ability.jand_minty then
		return "prevent_debuff"
	end
end

JAND.calculate = function(self, context)
	if context.ante_change and context.ante_end then
		restock_extra_shop()
		G.GAME.blinds_skipped = 0
	end
	if context.skip_blind then
		if not G.GAME.blinds_skipped then
			G.GAME.blinds_skipped = 1
		else
			G.GAME.blinds_skipped = G.GAME.blinds_skipped + 1
		end
	end
	if context.jimband_joker_align then
		for k, card in pairs(G.jokers.cards) do
			if card.ability.jand_weight_d and card.area == G.jokers then
				for i = 1, #G.jokers.cards do
					if G.jokers.cards[i] == card then
						local half = #G.jokers.cards / 2
						if math.floor(half) < half then
							half = half + 1
						end
						if i > half then
							SMODS.debuff_card(card, true, "weight_d")
						else
							SMODS.debuff_card(card, false, "weight_d")
						end
					end
				end
			end
			if card.ability.jand_weight_u and card.area == G.jokers then
				for i = 1, #G.jokers.cards do
					if G.jokers.cards[i] == card then
						local half = #G.jokers.cards / 2
						local brainfart = false
						if math.floor(half) < half then
							half = math.ceil(half)
							brainfart = true
						end
						if (i <= half and not brainfart) or (i < half and brainfart) then
							SMODS.debuff_card(card, true, "weight_u")
						else
							SMODS.debuff_card(card, false, "weight_u")
						end
					end
				end
			end
		end
	end
end

JAND.custom_card_areas = function(G)
	G.jand_util_area = CardArea(
		0, 0, 0, 0,
        {
            card_limit = 1, 
            type = 'discard', 
            highlight_limit = 1, 
            no_card_count = true 
        }
	)
	G.jand_shopkeep = CardArea(
		0, 0, G.CARD_W * 1.05, G.CARD_H * 1.05,
        {
            card_limit = 1, 
            type = 'joker', 
            highlight_limit = 1, 
            no_card_count = true 
        }
	)
	G.jand_shop = CardArea(
		0, 0, G.CARD_W * 5.05, G.CARD_H * 1.05,
        {
            card_limit = 1, 
            type = 'shop', 
            highlight_limit = 1, 
            no_card_count = true,
			jand_no_use = true
        }
	)
end

SMODS.Atlas {
	key = "jimband",
	path = "jimband.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "cardmods",
	path = "cardmods.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "keepers",
	path = "keepers.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "dialogue",
	path = "dialogue_cards.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "jandgo",
	path = "jandgo.png",
	px = 338,
	py = 133
}

SMODS.Atlas {
	key = "modicon",
	path = "modicon.png",
	px = 34,
	py = 34
}

SMODS.Attributes["food"].attribute_badge = function ()
	return create_badge("Food", G.C.GOLD, G.C.WHITE)
end

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

function JAND.merge_pools(pool1, merge_pools, both_sides) 
	for k, v in pairs(merge_pools) do
		if G.P_CENTER_POOLS[v] then
			for k, center in pairs(G.P_CENTER_POOLS[v]) do
				if not table.contains(G.P_CENTER_POOLS[pool1], center) then
					G.P_CENTER_POOLS[pool1][#G.P_CENTER_POOLS[pool1]+1] = center
				end
			end
			if both_sides then
				for k, center in pairs(G.P_CENTER_POOLS[pool1]) do
					if not table.contains(G.P_CENTER_POOLS[v], center) then
						G.P_CENTER_POOLS[v][#G.P_CENTER_POOLS[v]+1] = center
					end
				end
			end
		end
	end
end

function JAND.merge_tables(taker, source, both_sides)
	for k, v in pairs(source) do
		if not table.contains(taker, v) then
			taker[#taker+1] = v
		end
	end
	if both_sides then
		for k, v in pairs(taker) do
			if not table.contains(source, v) then
				source[#source+1] = v
			end
		end
	end
end


function JAND.pool_to_attribute(pool, attribute) 
	for k, v in pairs(G.P_CENTER_POOLS[pool]) do
		if not table.contains(SMODS.Attributes[attribute].keys, v.key) then
			SMODS.add_attribute(attribute, {v.key})
		end
	end
end

function table.contains(table, element)
    if table and type(table) == "table" then
        for _, value in pairs(table) do
            if value == element then
                return true
            end
        end
        return false
    end
end

SMODS.load_file("hooks.lua")()
SMODS.load_file("extra_shop.lua")()
SMODS.load_file("drawstep.lua")()
SMODS.load_file("booster_util.lua")()
SMODS.load_file("pack_col.lua")()

--I'll probably add a feature for disabling packs one day
SMODS.load_file("content/jokers/azumatsuba.lua")()
SMODS.load_file("content/jokers/danbo_func.lua")()
--gimko
SMODS.load_file("content/jokers/gimmiko.lua")()
SMODS.load_file("content/stickers/gimmiko.lua")()
SMODS.load_file("content/shopkeepers/gimmiko/sk_cards.lua")()
SMODS.load_file("content/shopkeepers/gimmiko/lv_logic.lua")()
--revo's vault crossing
SMODS.load_file("content/shopkeepers/revo.lua")()
--Then that cat gets all fat
SMODS.load_file("content/jokers/mewgenics.lua")()
SMODS.load_file("content/blinds/mewgenics.lua")()
SMODS.load_file("mewgenics_lab.lua")()

function JAND.table_remove(table, element)
	for i = 1, #table do
		if table[i] == element then
			table.remove(table, i)
		end
	end
	return table
end

function JAND.value_mod(value, multiplier, depth)
	for k, v in pairs(value) do
		if not depth then
			depth = 0
		end
		if type(v) == "number" then
			value[k] = value[k] * multiplier
		elseif not (depth>2) and type(v) == "table" then
			JAND.value_mod(v, multiplier, depth+1)
		end
	end
end

function Card:is_movable()
	if self.pinned or self.ability.immovable then
		return false
	else
		return true
	end
end

function JAND.swap_cards(card, type, amount, jump)
	local og_slot
	local sw_slot
	for i=1, #card.area.cards do
		if card.area.cards[i] == card then
			og_slot = i
		end
	end
	if type == "leftmost" then
		if og_slot == 1 then
			sw_slot = 1
		elseif not card.area.cards[1]:is_movable() then
			local stop
			for i=1, #card.area.cards do
				if card.area.cards[i]:is_movable() and not stop then
					sw_slot = i
					stop = true
				end
			end
		elseif card.area.cards[1]:is_movable() then
			sw_slot = 1
		end
	elseif type == "rightmost" then
		if not card.area.cards[#card.area.cards]:is_movable() then
			for i=1, #card.area.cards do
				if card.area.cards[i]:is_movable() then
					sw_slot = i
				end
			end
		else
			sw_slot = #card.area.cards
		end
	elseif type == "adjacent" then
		if card.area.cards[og_slot+amount] then
			if card.area.cards[og_slot+amount]:is_movable() then
				sw_slot = og_slot + amount
			elseif jump and not card.area.cards[og_slot+amount]:is_movable() then
				sw_slot = og_slot
				local stop
				for i=1, #card.area.cards do
					if amount > 0 then
						if (i > og_slot+amount) and not stop then
							if card.area.cards[i] and card.area.cards[i]:is_movable() then
								sw_slot = i
								stop = true
							end
						end
					end
					if amount < 0 then
						if i < og_slot+amount then
							if card.area.cards[i] and card.area.cards[i]:is_movable() then
								sw_slot = i
							end
						end
					end
				end
			else
				sw_slot = og_slot
			end
		end
	end
	if (og_slot and sw_slot) and (og_slot ~= sw_slot) then
		card.area.cards[og_slot], card.area.cards[sw_slot] = card.area.cards[sw_slot], card.area.cards[og_slot]
	end
	return sw_slot
end

function JAND.convert(cards, source, enhancement, suit) --Mostly localthunk code
	if source then
		source:juice_up(0.3, 0.5)
	end
    for i=1, #cards do
		local percent = 1.15 - (i-0.999)/(#cards-0.998)*0.3
        G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.15,
			func = function() 
				cards[i]:flip()
				play_sound('card1', percent)
				cards[i]:juice_up(0.3, 0.3)
				return true 
			end
		}))
    end
    for i=1, #cards do
        G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.1,
			func = function() 
				if suit then
					cards[i]:change_suit(suit)
				end
				if enhancement then
					cards[i]:set_ability(enhancement)
				end
				return true 
			end 
		}))
    end
	for i=1, #cards do
		local percent = 1.15 - (i-0.999)/(#cards-0.998)*0.3
        G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.15,
			func = function() 
				cards[i]:flip()
				play_sound('card1', percent, 0.6)
				cards[i]:juice_up(0.3, 0.3)
				return true 
			end
		}))
    end
end

JAND.Packs = {}
JAND.PackKeys = {} --for the sake of the collection thing. Being a dumbass prolly

JAND.Pack = function(key, text, colour, text_colour)
	JAND.PackKeys[#JAND.PackKeys+1] = key
	JAND.Packs[key] = {
		text = text, --lowkey don't see the point in localizing that
		badge_colour = colour,
		text_colour = text_colour or G.C.WHITE
	}
end

JAND.Pack("azuma", "Azumatsuba", G.C.RED)
JAND.Pack("giiko", "Jabberwock Night", lighten(G.C.RED, 0.5))
JAND.Pack("mew", "Mewgenics", G.C.GREY)

