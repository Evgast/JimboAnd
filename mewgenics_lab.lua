G.beta_key = nil

SMODS.Rarity {
	key = 'beta',
    badge_colour = G.C.RED,
}

JAND.fuck_dialogues = {}
JAND.dialogues = {}

function JAND.Dialogue(args)
    JAND.fuck_dialogues[args.key] = {}
    for k, v in pairs(args) do
        if k ~= "key" then
            JAND.fuck_dialogues[args.key][k] = v
        end
    end
end

JAND.Dialogue{
    key = "beanies_tutor",
    close_func = function ()
        G.PROFILES[G.SETTINGS.profile].lab_tutor_end = true
    end,
    dialogue_1 = { card = "j_jand_beanies", text_size = 10},
    dialogue_7 = { option = { close = true }}
}

JAND.Dialogue{
    key = "beanies_tutor2",
    close_func = function ()
        G.PROFILES[G.SETTINGS.profile].lab_tutor_2_end = true
    end,
    dialogue_1 = { card = "j_jand_beanies"},
    dialogue_6 = { option_1 = { custom = true, choice_number = 7, text = localize('k_nope_ex'), pos = 1}, option_2 = { custom = true, choice_number = 8, text = function() return localize('k_yup_ex') end, pos = 2} }, --I love that smods loads localization files after main.lua that's so cool that's so nice
    dialogue_7 = { option = { custom = true, choice_number = 1, text = "<" }},
    dialogue_8 = { option = { close = true }}
}

SMODS.Joker {
    key = "beanies",
    atlas = "dialogue",
    pos = { x = 0, y = 0 },
    no_collection = true,
    discovered = true,
    in_pool = function (self, args)
    if args and args.source == "jand_dialogue" then
            return true
        else
            return false
        end
    end,
}
--I'm doing so much weird bullshit here. If you wanted to read this code for some reason: please: don't
function JAND.create_dialogue(key, number)
    if not G.char_area then
        G.char_area = CardArea(
            0,0,
            G.CARD_W,
            G.CARD_H, 
            { card_limit = 1, type = 'title', highlight_limit = 0 }
        )
    end
    if not number then
        number = 1
    elseif number == 0 then
        if JAND.dialogues[key] and JAND.dialogues[key].close_func then
            JAND.dialogues[key]:close_func()
        end
        G.current_dialogue:remove()
        G.current_dialogue = nil
        G.FUNCS.exit_overlay_menu()
        G.char_area = nil
        return
    end
    local text_size = 1
    local buttons = {}
    local function dialogue_stuff(t)
        buttons = {}
        local no_options = true
        for k, v in pairs(t) do
            if k == "card" then
                if G.char_area.cards and G.char_area.cards[1] then
                    G.char_area.cards[1]:remove()
                end
                local card = SMODS.create_card({area = G.char_area, key = t.card, no_edition = true, bypass_discovery_center = true})
                G.char_area:emplace(card)
                card.states.hover.can = false
            end
            if k == "text_size" then
                text_size = v
            end
            if string.find(k, "option") then
                local next_button = {n=G.UIT.C, config = {align = "cm"}, nodes = {
                                    UIBox_button{ label = {">"}, scale = 0.6, minw = 1, minh = 1, colour = G.C.RED, r = 0.1, ref_table = { key, v.choice_number or number+1, v.option_func or nil }, button = "dialogue_button", shadow = true}
                                }}
                local close_button = {n=G.UIT.C, config = {align = "cm"}, nodes = {
                                    UIBox_button{ label = {"x"}, scale = 0.6, minw = 1, minh = 1, colour = G.C.RED, r = 0.1, ref_table = { key, 0, v.option_func or nil }, button = "dialogue_button", shadow = true}
                                }}
                if v.next then
                    if v.pos then
                        table.insert(buttons, v.pos, next_button)
                    else
                        table.insert(buttons, next_button)
                    end
                    no_options = false
                end
                if v.close then
                    if v.pos then
                        table.insert(buttons, v.pos, close_button)
                    else
                        table.insert(buttons, close_button)
                    end
                    no_options = false
                end
                if v.custom then
                    local custom_button = {n=G.UIT.C, config = {align = "cm"}, nodes = {
                                            UIBox_button{ label = {type(v.text) == "function" and v:text() or v.text or ">"}, scale = 0.6, minw = 1, minh = 1, colour = G.C.RED, r = 0.1, ref_table = { key, v.choice_number or number+1, v.option_func or nil }, button = "dialogue_button", shadow = true}
                                        }}
                    if v.pos then
                        table.insert(buttons, v.pos, custom_button)
                    else
                        table.insert(buttons, custom_button)
                    end
                    no_options = false
                end
            end
        end
        if no_options then
            table.insert(
                buttons, 
                {n=G.UIT.C, config = {align = "cm"}, nodes = {
                    UIBox_button{ label = {">"}, scale = 0.6, minw = 1, minh = 1, colour = G.C.RED, r = 0.1, ref_table = { key, number+1}, button = "dialogue_button", shadow = true}
                }}
            )
        end
    end
    dialogue_stuff(JAND.dialogues[key])
    for k, v in pairs(JAND.dialogues[key]) do
        local default = true
        if k == "dialogue_"..number then
            default = false
        else 
            default = true
        end
        if not default then
            dialogue_stuff(v)
        end
    end
    local loc = {}
	local text = {}
	localize{type = "descriptions", key = key .."_".. number, set = "JandDialogue", default_col = G.C.UI.TEXT_DARK, nodes = loc, vars = {}, scale = text_size}
	text = {transparent_multiline_text(loc)}
    local text_box = {n=G.UIT.R, config={align = "cm", minh = G.CARD_H, minw = 5, r = 0.2, colour = G.C.WHITE}, nodes =
                        text
                    }
    local buttons_noded = {n=G.UIT.R, config = {align = "cr", padding = 0.1}, nodes=
                                buttons
                            }
    if G.current_dialogue then
        local node = G.current_dialogue:get_UIE_by_ID("dialogue_text")
        node.children[1]:remove()
        node.children[1] = nil
        G.current_dialogue:add_child(text_box, node)
        local buttons_node = G.current_dialogue:get_UIE_by_ID("dialogue_buttons")
        buttons_node.children[1]:remove()
        buttons_node.children[1] = nil
        G.current_dialogue:add_child(buttons_noded, buttons_node)
    end
    if not G.current_dialogue then
        G.current_dialogue = UIBox({
            definition = {n=G.UIT.ROOT, config = {align = "cm", minw = G.ROOM.T.w*5, minh = G.ROOM.T.h*5, colour = {G.C.GREY[1], G.C.GREY[2], G.C.GREY[3],0.7}}, nodes={
                {n=G.UIT.R, config={align = "cm", minh = 1,r = 0.3, padding = 0.07, minw = 1, colour = G.C.JOKER_GREY, emboss = 0.1}, nodes={
                    {n=G.UIT.C, config = {align = "cm", padding = 0.1, r = 0.1, colour = G.C.L_BLACK}, nodes={
                        {n=G.UIT.R, config = {align = "cm"}, nodes = {
                            {n=G.UIT.C, config = {align = "cm", id = "dialogue_text", minh = 1, minw = 5, r = 0.3, padding = 0.1, colour = G.C.JOKER_GREY, shadow = true}, nodes={
                                text_box
                            }},
                            {n=G.UIT.C, config = {align = "cm"}, nodes={
                                {n=G.UIT.O, config = {object = G.char_area}},
                            }},
                        }},
                        {n=G.UIT.R, config = {align = "cr"}, nodes={
                            {n=G.UIT.C, config = {align = "cm", id = "dialogue_buttons"}, nodes={
                                {n=G.UIT.R, config = {align = "cr", padding = 0.1}, nodes=
                                    buttons
                                }
                            }}
                        }}
                    }},
                }}
            }},
            config = {type = "cm"}
        })
        G.FUNCS.overlay_menu({
            definition = {n=G.UIT.O, config = {object = G.current_dialogue}}
        })
    end
end

function G.FUNCS.dialogue_button(e)
    if e.config.ref_table[3] then
        e.config.ref_table[3]()
    end
    JAND.create_dialogue(e.config.ref_table[1], e.config.ref_table[2])
end

function G.UIDEF.beta_choice()
    if not G.PROFILES[G.SETTINGS.profile].lab_tutor_end then
        JAND.create_dialogue("beanies_tutor")
    end
    G.beta_options = CardArea(
        0,0,
        3*G.CARD_W,
        G.CARD_H, 
        { card_limit = 3, type = 'title', highlight_limit = 0 }
	)
    G.beta_chosen = CardArea(
      	0,0,
      	G.CARD_W,
      	G.CARD_H, 
      	{ card_limit = 1, type = 'title', highlight_limit = 0 }
	)
    if G.beta_key then
        local card = SMODS.create_card({ set = "Joker", area = G.beta_chosen, key = G.beta_key, key_append = "jand_beta", no_edition = true})
        card.jand_click_func = function()
            card:remove()
            G.beta_key = nil
        end
        G.beta_chosen:emplace(card)
    end
    local beta = {}
    for k, v in pairs(G.P_CENTER_POOLS["Joker"]) do
        if v.rarity == "jand_beta" then
            beta[#beta+1] = v.key
        end
    end
	for i = 1, 3 do
        if beta[i] then
		    local card = SMODS.create_card({set = "Joker", area = G.beta_options, key = beta[i], no_edition = true, key_append = "jand_beta"})
            card.jand_click_func = function()
                if not G.PROFILES[G.SETTINGS.profile].lab_tutor_2_end then
                    JAND.create_dialogue("beanies_tutor2")
                end
                if not G.beta_key then
                    local _card = SMODS.create_card({ set = "Joker", area = G.beta_chosen, key = card.config.center.key, key_append = "jand_beta", no_edition = true})
                    _card.jand_click_func = function()
                        _card:remove()
                        G.beta_key = nil
                    end
                    G.beta_chosen:emplace(_card)
                    G.beta_key = _card.config.center.key
                end
            end
            G.beta_options:emplace(card)
        end
	end
	local beta_pages = {}
	for i = 1, math.ceil(#beta/3) do
		table.insert(beta_pages, localize('k_page')..' '..tostring(i)..'/'..tostring(math.ceil(#beta/3)))
	end
	return { n = G.UIT.ROOT, config = {minw = 1, minh = 1, colour = G.C.CLEAR }, nodes = {
        { n = G.UIT.C, config = { align = "cm", padding = 0.1 }, nodes={
            { n = G.UIT.R, config = { align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05 }, nodes = {
                { n = G.UIT.R, config={align = "cm", emboss = 0.05 }, nodes={
                    { n = G.UIT.O, config = { object = G.beta_options } }
                }}
            }},
            { n = G.UIT.R, config = { align = "cm", r = 0.1, maxw = G.CARD_W, maxh = G.CARD_H }, nodes = {
                { n = G.UIT.R, config = { align = "cm", r = 0.1, maxw = G.CARD_W, maxh = G.CARD_H, colour = G.C.BLACK, emboss = 0.05 }, nodes = {
                    { n = G.UIT.O, config = { object = G.beta_chosen, colour = G.C.BLACK, r = 0.1 } },
                }}
            }},
            { n = G.UIT.R, config = { align = "cm" }, nodes = {
                UIBox_button{ label = {"I'm too bad at the game,", "please skip this Beta Joker"}, scale = 1, minw = 5, minh = 1, colour = G.C.RED, r = 0.1, ref_table = G.beta_chosen.cards[1], func = "skip_beta_func", button = "skip_beta", shadow = true}
            }},
            { n = G.UIT.R, config = { align = "cm" }, nodes = {
                create_option_cycle({options = beta_pages, w = 4.5, cycle_shoulders = true, opt_callback = 'beta_option_cycle', current_option = 1, colour = G.C.RED, no_pips = true, focus_args = {snap_to = true, nav = 'wide'}})
            }}
        }}
	}}
end

G.FUNCS.skip_beta_func = function (e)
    if G.beta_chosen.cards and e.config.ref_table and (e.config.ref_table == G.beta_chosen.cards[1]) and G.P_CENTERS[e.config.ref_table.config.center.beta_unlock].unlocked then
        e.config.button = nil
        e.config.colour = G.C.BLACK
    elseif G.beta_chosen.cards and G.beta_chosen.cards[1] then
        e.config.button = "skip_beta"
        e.config.colour = G.C.RED
        e.config.ref_table = G.beta_chosen.cards[1]
    else
        e.config.button = nil
        e.config.colour = G.C.BLACK
    end
end

G.FUNCS.skip_beta = function (e)
    unlock_card(G.P_CENTERS[e.config.ref_table.config.center.beta_unlock])
end

G.FUNCS.beta_option_cycle = function(args)
  	if not args or not args.cycle_config then return end
	for card=1, #G.beta_options.cards do
		local c = G.beta_options:remove_card(G.beta_options[i].cards[card])
		c:remove()
	end
    local beta = {}
    for k, v in pairs(G.P_CENTER_POOLS["Joker"]) do
        if v.rarity == "jand_beta" then
            beta[#beta+1] = v.key
        end
    end
	for i=1, #beta do
		if (i > (args.cycle_config.current_option-1)*3) and (i <= args.cycle_config.current_option*3) then
			local used
			if G.GAME.used_jokers[beta[i]] then
				used = true
			end
			local card = SMODS.create_card({area = G.beta_options, key = beta[i], bypass_discovery_center = true, no_edition = true, key_append = "jand_beta" })
            card.jand_click_func = function()
                if not G.PROFILES[G.SETTINGS.profile].lab_tutor_2_end then
                    JAND.create_dialogue("beanies_tutor2")
                end
                if not G.beta_key then
                    local _card = SMODS.create_card({ set = "Joker", area = G.beta_chosen, key = card.config.center.key, key_append = "jand_beta", no_edition = true})
                    _card.jand_click_func = function()
                        _card:remove()
                        G.beta_key = nil
                    end
                    G.beta_chosen:emplace(_card)
                    G.beta_key = _card.config.center.key
                end
            end
			if not used then
				G.GAME.used_jokers[beta[i]] = nil
			end
			G.beta_options:emplace(card)
		end
	end
end

function JAND.auto_beta() -- automizing this is so stupid wtf am i doing
    for k, v in pairs(G.P_CENTER_POOLS.Joker) do
        if v.rarity == "jand_beta" then
            v.no_collection = true
            v.discovered = true
            if not v.in_pool then
                v.in_pool = function(args)
                    if args.source == "jand_beta" then
                        return true
                    else
                        return false
                    end
                end
            end
            if not v.set_ability then
                v.set_ability = function(self, card, initial, delay_sprites)
                    card:add_sticker("eternal", true)
                end
            end
            if v.beta_unlock then
                G.P_CENTERS[v.beta_unlock].check_for_unlock = function(self, args)
                    if args.type == "win_custom" and next(SMODS.find_card(v.key, true)) then
                        unlock_card(self)
                    end
                end
            end
        end
    end
end