function nikola_card_ui(card)
	if card.config.center.set == "Joker" then
		if card.config.center.rarity == 4 then
			card.lv = 10
		elseif card.config.center.rarity == 3 then
			card.lv = 3
		elseif card.config.center.rarity == 2 or 1 then
			card.lv = 2
		end
	else
		card.lv = 1
	end
	local t1 = JAND.price_tag({object = DynaText({string = {{prefix = "LV", ref_table = card, ref_value = 'lv'}}, colours = {G.C.SECONDARY_SET.Planet},shadow = true, silent = true, bump = true, pop_in = 0, scale = 0.5})})
	card.children.lv_price = UIBox{
        definition = t1,
        config = {
            align="tm",
            offset = {x=0,y=0.42},
            major = card,
            bond = 'Weak',
            parent = card
        }
    }
end

G.FUNCS.can_buy_lv = function(e)
    if get_hand_levels() >= e.config.ref_value.lv then
		e.config.colour = G.C.SECONDARY_SET.Planet
		e.config.button = "buy_lv_butt"
	else
		e.config.colour = G.C.BLACK
		e.config.button = nil
	end
end

local do_that = function(card)
	for k, v in pairs(G.GAME.hands) do
		if card.ability.hand_type == v.key then
			card.planet_lv = v.level
		end
	end
	if card.planet_lv and  card.planet_lv <= 1 then
		card.debuff = true
	end
	card.sacrifice = true
	card.T.w = card.T.w / 2
	card.T.h = card.T.h / 2
end

G.FUNCS.buy_lv_butt = function(e)
	G.lv_payment = CardArea(
		0, 0, (G.CARD_W/2) * 5.01, (G.CARD_H/2) * 1.1,
        {
            card_limit = e.config.ref_value.lv, 
            type = 'joker', 
            highlight_limit = 1, 
        }
	)
	G.lv_choice = {}
	local planet_rows = {}
	for i = 1, 3 do
		G.lv_choice[#G.lv_choice+1] = CardArea(
			0, 0, (G.CARD_W/2) * 5.01, (G.CARD_H/2) * 1.1,
			{
				card_limit = 5, 
				type = 'shop', 
				highlight_limit = 5, 
				no_card_count = true 
			}	
		)
		table.insert(planet_rows, {n = G.UIT.R, config = {align = "cm"}, nodes = {
   			{n=G.UIT.O, config={object = G.lv_choice[#G.lv_choice]}}
		}}
		)
	end
	local area_row = 1
	local space_racism = {}
	for i=1, #G.P_CENTER_POOLS["Planet"] do
		if G.P_CENTER_POOLS["Planet"][i].config.hand_type then
			space_racism[#space_racism+1] = G.P_CENTER_POOLS["Planet"][i]
		end
	end
	for i = 1, #space_racism do
		if i<=15 then
			if #G.lv_choice[area_row].cards >= 5 then
				area_row = area_row + 1
			end
			local key = space_racism[i].key
			local card = SMODS.create_card({area = G.lv_choice[area_row], key = key, bypass_discovery_center = true})
			if card.ability.hand_type then
				G.lv_choice[area_row]:emplace(card)
				do_that(card)
			else
				card:remove()
			end
		end
	end
	local sacrifice_options = {}
	for i=1, math.ceil(#space_racism/15) do
		table.insert(sacrifice_options, localize('k_page')..' '..tostring(i)..'/'..tostring(math.ceil(#space_racism/15)))
	end
	G.FUNCS.overlay_menu({
    definition = create_UIBox_generic_options({
        contents = {
			{n = G.UIT.C, config = {align = "cm", padding = 0.3}, nodes = {
				{n = G.UIT.R, config = {align = "cm"}, nodes = {
					{n=G.UIT.O, config={object = G.lv_payment}},
				}},
				{n = G.UIT.R, config = {align = "cm"}, nodes = {
					{n = G.UIT.C, config = {align = "cm"}, nodes = planet_rows}
				}},
                create_option_cycle({options = sacrifice_options, w = 4.5, cycle_shoulders = true, opt_callback = 'sacrifice_pages', current_option = 1, colour = G.C.SECONDARY_SET.Planet, no_pips = true, focus_args = {snap_to = true, nav = 'wide'}}),
				UIBox_button{ label = {"Confirm"}, scale = 0.6, minw = 5, maxh = 1, colour = G.C.BLACK, r = 0.1, ref_table = e.config.ref_value --[[What is he doing lmao]], button = nil, func = "sacrifice_update", shadow = true}
			}},
		}
	})
    })
end

G.FUNCS.sacrifice_pages = function(args)
  	if not args or not args.cycle_config then return end
	for i=1, #G.lv_choice do
		for card=1, #G.lv_choice[i].cards do
			local c = G.lv_choice[i]:remove_card(G.lv_choice[i].cards[card])
			c:remove()
		end
	end
	local area_row = 1
	local space_racism = {}
	for i=1, #G.P_CENTER_POOLS["Planet"] do
		if G.P_CENTER_POOLS["Planet"][i].config.hand_type then
			space_racism[#space_racism+1] = G.P_CENTER_POOLS["Planet"][i]
		end
	end
	for i=1, #space_racism do
		if (i > (args.cycle_config.current_option-1)*15) and (i <= args.cycle_config.current_option*15) then
			if #G.lv_choice[area_row].cards >= 5 then
				area_row = area_row + 1
			end
			local key = space_racism[i].key
			local card = SMODS.create_card({area = G.lv_choice[area_row], key = key, bypass_discovery_center = true})
			if card.ability.hand_type then
				G.lv_choice[area_row]:emplace(card)
				do_that(card)
			else
				card:remove()
			end
		end
	end
end

function G.FUNCS.sacrifice_update(e)
	if G.lv_payment and #G.lv_payment.cards == G.lv_payment.config.card_limit then
		e.config.colour = G.C.SECONDARY_SET.Planet
		e.config.button = "sacrifice_confirm"
	else
		e.config.colour = G.C.BLACK
		e.config.button = nil
	end
end

function G.FUNCS.sacrifice_confirm(e)
	for i=1, #G.lv_payment.cards do
		SMODS.smart_level_up_hand(nil, G.lv_payment.cards[i].ability.hand_type, false, -1)
	end
	local card = e.config.ref_table
	G.FUNCS.exit_overlay_menu()
	card.area:remove_card(card)
    card:add_to_deck()
	if card.ability.consumeable then
        G.consumeables:emplace(card) --not even planning to use it for consum(e)ables but just in case
    else
        G.jokers:emplace(card)
    end
	card.lv = nil
	card.children.lv_price:remove()
	card.children.lv_price = nil
	--tallies for unlocks, copied from vanilla
	G.GAME.round_scores.cards_purchased.amt = G.GAME.round_scores.cards_purchased.amt + 1
    if card.ability.consumeable then
        if card.config.center.set == 'Planet' then
            inc_career_stat('c_planets_bought', 1)
        elseif card.config.center.set == 'Tarot' then
        	inc_career_stat('c_tarots_bought', 1)
        end
    elseif card.ability.set == 'Joker' then
        G.GAME.current_round.jokers_purchased = G.GAME.current_round.jokers_purchased + 1
    end
end

function G.FUNCS.sacrifunc(e)
	if G.lv_payment and #G.lv_payment.cards < G.lv_payment.config.card_limit and e.config.ref_table.planet_lv > 1 then
		e.config.colour = G.C.MULT
		e.config.button = "sacributt"
	else
		e.config.colour = G.C.BLACK
		e.config.button = nil
	end
end

function G.FUNCS.sacributt(e)
	local card = SMODS.create_card({key = e.config.ref_table.config.center.key, area = G.lv_payment, bypass_discovery_center = true})
	e.config.ref_table.planet_lv = e.config.ref_table.planet_lv - 1
	if e.config.ref_table.planet_lv <= 1 then
		e.config.ref_table.debuff = true
	end
	G.lv_payment:emplace(card)
	card.states.click.can = false
	card.T.w = e.config.ref_table.T.w
	card.T.h = e.config.ref_table.T.h
end

function get_hand_levels()
	local t = 0
	for k, v in pairs(G.GAME.hands) do
		t = t + v.level - 1
	end
	return t
end

function create_nikola_card(type, area, rarity, key)
	if not area then
		area = G.jokers
	end
	local card = SMODS.create_card({set = type or "Joker", area = area, rarity = rarity or nil, bypass_discovery_center = true, key = key or nil})
	area:emplace(card)
	nikola_card_ui(card)
	return card
end