G.jand_col_blind = function(v, area, hover) --mostly stealing this bullshit from smods. Ugh, blinds succckkkkk
	local atlas_key = v.discovered and v.atlas or 'blind_chips'
	local temp_blind = SMODS.create_sprite(area.T.x + area.T.w/2, area.T.y, 1.3, 1.3, atlas_key, v.discovered and v.pos or G.b_undiscovered.pos)
	temp_blind.states.click.can = false
	temp_blind.states.drag.can = false
	temp_blind.states.hover.can = true
	local card = Card(area.T.x + area.T.w/2, area.T.y, 1.3, 1.3, G.P_CARDS.empty, G.P_CENTERS.c_base)
	temp_blind.states.click.can = false
	card.states.drag.can = false
	card.states.hover.can = true
	card.children.center = temp_blind
	temp_blind:set_role({major = card, role_type = 'Glued', draw_major = card})
	card.set_sprites = function(...)
		local args = {...}
		if not args[1].animation then return end -- fix for debug unlock
		local c = card.children.center
		Card.set_sprites(...)
	card.children.center = c
	end
	temp_blind:define_draw_steps({
		{ shader = 'dissolve', shadow_height = 0.05 },
		{ shader = 'dissolve' }
	})
	temp_blind.float = true
	card.states.collide.can = true
	card.config.blind = v
	card.config.force_focus = true
	if v.discovered and not v.alerted then
		blinds_to_be_alerted[#blinds_to_be_alerted + 1] = card
	end
	if hover then
		card.hover = function()
			if not G.CONTROLLER.dragging.target or G.CONTROLLER.using_touch then
				if not card.hovering and card.states.visible then
					card.hovering = true
					card.hover_tilt = 3
					card:juice_up(0.05, 0.02)
					play_sound('chips1', math.random() * 0.1 + 0.55, 0.12)
					card.config.h_popup = create_UIBox_blind_popup(v, card.config.blind.discovered)
					card.config.h_popup_config = card:align_h_popup()
					Node.hover(card)
					if card.children.alert then
						card.children.alert:remove()
						card.children.alert = nil
						card.config.blind.alerted = true
						G:save_progress()
					end
				end
			end
			card.stop_hover = function()
				card.hovering = false; Node.stop_hover(card); card.hover_tilt = 0
			end
		end
	else
		card.no_ui = true
	end
	card.blind = true
	card.jand_pack = v.jand_pack
	area:emplace(card)
	return card
end

G.jand_create_colcards = function(pack, area)
	local creation_order = { "Joker", "Shopkeeper" }
	local bg_black = {darken(G.C.BLACK, 0.2)[1], darken(G.C.BLACK, 0.2)[2], darken(G.C.BLACK, 0.2)[3], 0.7}
	for i=1, #creation_order do
		local set = creation_order[i]
		if G.jand_collection_tables and G.jand_collection_tables[pack][set] then
			local card = SMODS.create_card({area = area, key = G.jand_collection_tables[pack][set][1].key, no_edition = true, bypass_discovery_center = true})
			area:emplace(card)
			card.no_ui = true
			local discovered = 0
			for k, v in pairs(G.jand_collection_tables[pack][set]) do
				if v.discovered then
					discovered = discovered + 1
				end
			end
			card.jand_click_func = G.this_pack_col
			card.children.colcard_info = UIBox{
        		definition = {n=G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR, padding = 0.05}, nodes={
					{n=G.UIT.C, config={align = "cm"}, nodes={
						{n=G.UIT.R, config={align = "cm", colour = bg_black, r = 0.1, padding = 0.05}, nodes={
							{n=G.UIT.T, config={text = card.config.center.set, colour = G.C.UI.TEXT_LIGHT, scale = 0.5}}
						}},
						{n=G.UIT.R, config={align = "cm", colour = bg_black, r = 0.1}, nodes={
							{n=G.UIT.T, config={text = discovered.."/"..#G.jand_collection_tables[pack][set], colour = G.C.UI.TEXT_LIGHT, scale = 0.5}}
						}}
					}}
    			}},
        		config = {
					align="cm",
					offset = {x=0,y=1},
					major = card,
					parent = card
        		}
    		}
		end
	end
	if G.jand_collection_tables and G.jand_collection_tables[pack]["Blinds"] then
		local card = G.jand_col_blind(G.jand_collection_tables[pack]["Blinds"][1], area)
		card.jand_click_func = G.this_pack_col
		local discovered = 0
		for i=1, #G.jand_collection_tables[pack]["Blinds"] do
			if G.jand_collection_tables[pack]["Blinds"][i].discovered then
				discovered = discovered + 1
			end
		end
		card.children.colcard_info = UIBox{
        	definition = {n=G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR, padding = 0.05}, nodes={
				{n=G.UIT.C, config={align = "cm"}, nodes={
					{n=G.UIT.R, config={align = "cm", colour = bg_black, r = 0.1, padding = 0.05}, nodes={
						{n=G.UIT.T, config={text = "Blind", colour = G.C.UI.TEXT_LIGHT, scale = 0.5}}
					}},
					{n=G.UIT.R, config={align = "cm", colour = bg_black, r = 0.1}, nodes={
						{n=G.UIT.T, config={text = discovered.."/"..#G.jand_collection_tables[pack]["Blinds"], colour = G.C.UI.TEXT_LIGHT, scale = 0.5}}
					}}
				}}
    		}},
        	config = {
				align="cm",
				offset = {x=0,y=1},
				major = card,
				parent = card
        	}
    	}
	end
end

G.JAND_PACKCOL = function()
	local first_packs = { "azuma", "giiko"}
	G.jand_packs_col = { localize("pck_"..first_packs[1]), localize("pck_"..first_packs[2])}
	G.jand_pack_area = {}
	for i=1, 2 do
		G.jand_pack_area[i] = CardArea(
            0,0, G.CARD_W*5, G.CARD_H*1.05, { card_limit = 5, type = 'joker', no_card_count = true}
        )
		G.jand_pack_area[i].can_highlight = function ()
			return false
		end
		G.jand_create_colcards(first_packs[i],G.jand_pack_area[i])
	end
	local pack_pages = {}
	for i = 1, math.ceil(#JAND.PackKeys/2) do
		table.insert(pack_pages, localize('k_page')..' '..tostring(i)..'/'..tostring(math.ceil(#JAND.PackKeys/2)))
	end
	return {n = G.UIT.ROOT, config = { align = "cm", colour = G.C.CLEAR }, nodes = {
		{n = G.UIT.C, config = { align = "cm", padding = 0.1 }, nodes = {
			{n = G.UIT.R, config = { colour = darken(G.C.GREEN, 0.3), r = 0.1 }, nodes = {
				{n = G.UIT.C, config = { padding = 0.1 }, nodes = {
					{n = G.UIT.R, config = { align = "cm" }, nodes = {
						{n=G.UIT.T, config={ref_table = G.jand_packs_col, ref_value = 1, scale = 0.45, colour = G.C.WHITE}},
					}},
					{n = G.UIT.R, config = { }, nodes = {
						{n = G.UIT.O, config = { object = G.jand_pack_area[1] }},
					}}
				}}
			}},
			{n = G.UIT.R, config = { colour = darken(G.C.GREEN, 0.3), r = 0.1 }, nodes = {
				{n = G.UIT.C, config = { padding = 0.1 }, nodes = {
					{n = G.UIT.R, config = { align = "cm" }, nodes = {
						{n=G.UIT.T, config={ref_table = G.jand_packs_col, ref_value = 2, scale = 0.45, colour = G.C.WHITE}},
					}},
					{n = G.UIT.R, config = { }, nodes = {
						{n = G.UIT.O, config = { object = G.jand_pack_area[2] }},
					}}
				}}
			}},
			create_option_cycle({options = pack_pages, w = 4.5, cycle_shoulders = true, opt_callback = 'pack_option_cycle', current_option = 1, colour = G.C.GREEN, no_pips = true, focus_args = {snap_to = true, nav = 'wide'}})
		}}
	}}
end

G.FUNCS.pack_option_cycle = function(args)
	if not args or not args.cycle_config then return end
	for a=1, #G.jand_pack_area do
		for ca=1, #G.jand_pack_area[a].cards do
			local c = G.jand_pack_area[a]:remove_card(G.jand_pack_area[a].cards[ca])
			c:remove()
		end
	end
	for i=0, 1 do
		local key = JAND.PackKeys[args.cycle_config.current_option * 2 - (1-i)]
		G.jand_packs_col[1+i] = key and localize("pck_"..key) or localize("pck_curr_non")
		if key then
			G.jand_create_colcards(key,G.jand_pack_area[1+i])
		end
	end
end

G.this_pack_col = function(self)
	G.SETTINGS.paused = true
	G.this_pack_area = CardArea(
		0,0,
		5*G.CARD_W,
		0.95*G.CARD_H, 
		{card_limit = 5, type = 'title', highlight_limit = 0}
	)
	local col_options = {}
	if not self.blind then
		local pack = self.config.center.jand_pack
		local set = self.config.center.set
		G.current_col = G.jand_collection_tables[pack][set]
		for i=1, 5 do
			if G.current_col[i] then
				local key = G.current_col[i].key
				local card = SMODS.create_card({set = set, area = G.this_pack_area, key = key, no_edition = true})
				G.this_pack_area:emplace(card)
			end
		end
	else
		local pack = self.jand_pack
		G.current_col = G.jand_collection_tables[pack]["Blinds"]
		for i=1, 5 do
			if G.current_col[i] then
				local blind = G.current_col[i] and G.jand_col_blind(G.current_col[i], G.this_pack_area, true)
				G.this_pack_area:emplace(blind)
			end
		end
	end
	for i=1, math.ceil(#G.current_col/5) do
		table.insert(col_options, localize('k_page')..' '..tostring(i)..'/'..tostring(math.ceil(#G.current_col/5)))
	end
  	G.FUNCS.overlay_menu{
    	definition = create_UIBox_generic_options({
			back_func = "openModUI_jand",
			contents = {
				{ n = G.UIT.C, config = {minw=1, minh=1, colour = G.C.CLEAR }, nodes = {
					{ n = G.UIT.R, config={align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05 }, nodes={
						{ n = G.UIT.O, config={object = G.this_pack_area}}
					}}, 
					{ n = G.UIT.R, config={align = "cm"}, nodes={
						create_option_cycle({options = col_options, w = 4.5, cycle_shoulders = true, opt_callback = 'this_pack_cycle', current_option = 1, colour = G.C.RED, no_pips = true, focus_args = {snap_to = true, nav = 'wide'}})
					}}
				}},
			}
		}),
  	}
end

G.FUNCS.this_pack_cycle = function(args)
	if not args or not args.cycle_config then return end
	for i=1, #G.this_pack_area.cards do
		local c = G.this_pack_area:remove_card(G.this_pack_area.cards[i])
		c:remove()
	end
	for i=1, 5 do
		if G.current_col[((args.cycle_config.current_option-1)*5)+i] then
			local center = G.current_col[((args.cycle_config.current_option-1)*5)+i]
			local key = center.key
			local card = SMODS.create_card({set = center.set, area = G.this_pack_area, key = center.key, no_edition = true})
			G.this_pack_area:emplace(card)
		end
	end
end

function init_colsets()
	G.jand_collection_tables = {}
	local collection_sets = {"Joker", "Shopkeeper", "Tarot", "Planet"}
	for k, v in pairs(collection_sets) do
		if G.P_CENTER_POOLS[v] then
			for i=1, #G.P_CENTER_POOLS[v] do
				local center = G.P_CENTER_POOLS[v][i]
				if center.jand_pack then
					if not G.jand_collection_tables[center.jand_pack] then
						G.jand_collection_tables[center.jand_pack] = {}
					end
					if not G.jand_collection_tables[center.jand_pack][v] then
						G.jand_collection_tables[center.jand_pack][v] = {}
					end
					local table = G.jand_collection_tables[center.jand_pack][v]
					table[#table+1] = center
				end
			end
		end
	end
	for k, v in pairs(G.P_BLINDS) do
		if v.jand_pack then
			if not G.jand_collection_tables[v.jand_pack] then
				G.jand_collection_tables[v.jand_pack] = {}
			end
			if not G.jand_collection_tables[v.jand_pack]["Blinds"] then
				G.jand_collection_tables[v.jand_pack]["Blinds"] = {}
			end
			local table = G.jand_collection_tables[v.jand_pack]["Blinds"]
			table[#table+1] = v
		end
	end
end