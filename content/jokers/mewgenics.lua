function JAND.get_consumable_vars(c)
    local loc_vars
    local info_queue = {}
    local _c = c.config.center
    if _c.set == 'Spectral' then 
        if _c.name == 'Familiar' or _c.name == 'Grim' or _c.name == 'Incantation' then loc_vars = {_c.config.extra}
        elseif _c.name == 'Immolate' then loc_vars = {_c.config.extra.destroy, _c.config.extra.dollars}
        elseif _c.name == 'Hex' then info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
        elseif _c.name == 'Talisman' then info_queue[#info_queue+1] = {key = 'gold_seal', set = 'Other'}
        elseif _c.name == 'Deja Vu' then info_queue[#info_queue+1] = {key = 'red_seal', set = 'Other'}
        elseif _c.name == 'Trance' then info_queue[#info_queue+1] = {key = 'blue_seal', set = 'Other'}
        elseif _c.name == 'Medium' then info_queue[#info_queue+1] = {key = 'purple_seal', set = 'Other'}
        elseif _c.name == 'Cryptid' then loc_vars = {_c.config.extra}
        end
        if _c.name == 'Ectoplasm' then info_queue[#info_queue+1] = G.P_CENTERS.e_negative; loc_vars = {G.GAME.ecto_minus or 1} end
        if _c.name == 'Aura' then
            info_queue[#info_queue+1] = G.P_CENTERS.e_foil
            info_queue[#info_queue+1] = G.P_CENTERS.e_holo
            info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
        end
    elseif _c.set == 'Tarot' then
        if _c.name == "The Magician" then loc_vars = {_c.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = _c.config.mod_conv}}; info_queue[#info_queue+1] = G.P_CENTERS[_c.config.mod_conv]
        elseif _c.name == "The High Priestess" then loc_vars = {_c.config.planets}
        elseif _c.name == "The Empress" then loc_vars = {_c.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = _c.config.mod_conv}}; info_queue[#info_queue+1] = G.P_CENTERS[_c.config.mod_conv]
        elseif _c.name == "The Emperor" then loc_vars = {_c.config.tarots}
        elseif _c.name == "The Hierophant" then loc_vars = {_c.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = _c.config.mod_conv}}; info_queue[#info_queue+1] = G.P_CENTERS[_c.config.mod_conv]
        elseif _c.name == "The Lovers" then loc_vars = {_c.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = _c.config.mod_conv}}; info_queue[#info_queue+1] = G.P_CENTERS[_c.config.mod_conv]
        elseif _c.name == "The Chariot" then loc_vars = {_c.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = _c.config.mod_conv}}; info_queue[#info_queue+1] = G.P_CENTERS[_c.config.mod_conv]
        elseif _c.name == "Justice" then loc_vars = {_c.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = _c.config.mod_conv}}; info_queue[#info_queue+1] = G.P_CENTERS[_c.config.mod_conv]
        elseif _c.name == "The Hermit" then loc_vars = {_c.config.extra}
        elseif _c.name == "The Wheel of Fortune" then loc_vars = {G.GAME.probabilities.normal, _c.config.extra};  info_queue[#info_queue+1] = G.P_CENTERS.e_foil; info_queue[#info_queue+1] = G.P_CENTERS.e_holo; info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome; 
        elseif _c.name == "Strength" then loc_vars = {_c.config.max_highlighted}
        elseif _c.name == "The Hanged Man" then loc_vars = {_c.config.max_highlighted}
        elseif _c.name == "Death" then loc_vars = {_c.config.max_highlighted}
        elseif _c.name == "Temperance" then
            local _money = 0
            if G.jokers then
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i].ability.set == 'Joker' then
                        _money = _money + G.jokers.cards[i].sell_cost
                    end
                end
            end
            loc_vars = {_c.config.extra, math.min(_c.config.extra, _money)}
        elseif _c.name == "The Devil" then loc_vars = {_c.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = _c.config.mod_conv}}; info_queue[#info_queue+1] = G.P_CENTERS[_c.config.mod_conv]
        elseif _c.name == "The Tower" then loc_vars = {_c.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = _c.config.mod_conv}}; info_queue[#info_queue+1] = G.P_CENTERS[_c.config.mod_conv]
        elseif _c.name == "The Star" then loc_vars = {_c.config.max_highlighted,  localize(_c.config.suit_conv, 'suits_plural'), colours = {G.C.SUITS[_c.config.suit_conv]}}
        elseif _c.name == "The Moon" then loc_vars = {_c.config.max_highlighted, localize(_c.config.suit_conv, 'suits_plural'), colours = {G.C.SUITS[_c.config.suit_conv]}}
        elseif _c.name == "The Sun" then loc_vars = {_c.config.max_highlighted, localize(_c.config.suit_conv, 'suits_plural'), colours = {G.C.SUITS[_c.config.suit_conv]}}
        elseif _c.name == "Judgement" then
        elseif _c.name == "The World" then loc_vars = {_c.config.max_highlighted, localize(_c.config.suit_conv, 'suits_plural'), colours = {G.C.SUITS[_c.config.suit_conv]}}
        end
    else
        if _c.loc_vars then
            if _c:loc_vars(info_queue, c)["vars"] then
                loc_vars = _c:loc_vars(info_queue, c)["vars"]
            end
        end
    end
    return {vars = loc_vars, info_queue = info_queue}
end

SMODS.Joker {
	key = 'meteor',
	rarity = 2,
	atlas = 'jimband',
	pos = { x = 4, y = 1 },
    jand_pack = "mew",
	cost = 5,
    jand_usable = true,
    jand_butt_colour = G.C.PURPLE,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
    jand_gemini_compat = false,
    attributes = { "copying", "tarot", "space"},
	config = { extra = { ready = "true" } },
	loc_vars = function(self, info_queue, card)
        local child
        if G.jand_util_area then
            for k, v in pairs(G.jand_util_area.cards) do
                if v.ability.parent_joker == card.sort_id then
                    child = v
                end
            end
        end
        if child and JAND.get_consumable_vars(child)["info_queue"] then
            JAND.merge_tables(info_queue, JAND.get_consumable_vars(child)["info_queue"])
        end
        if card.area.config.type == "joker" then
            local loc = {}
            local description = {}
            localize{type = "descriptions", key = child.config.center.key, set = "Tarot", default_col = G.C.UI.TEXT_DARK, nodes = loc, vars = JAND.get_consumable_vars(child)["vars"] or {}, scale = 1}
            description = {transparent_multiline_text(loc)}
            local main_end = {{n=G.UIT.C, config={align = "cm", colour = G.C.WHITE}, nodes=
				description
			}}
		    return { main_end = main_end, vars = { (card.ability.extra.ready and "Ready!") or "Used...", localize{type = 'name_text', key = child.config.center.key, set = 'Tarot'} } }
        else
            return { key = card.config.center.key .. "_alt" }
        end
	end,
    set_ability = function(self, card, initial, delay_sprites)
        if G.jand_util_area then
            local chosen_card = pseudorandom_element(G.P_CENTER_POOLS["Tarot"])
            local _card = SMODS.create_card({area = G.jand_util_area, skip_materialize = true, key = chosen_card.key, bypass_discovery_center = true})
            _card.ability.parent_joker = card.sort_id
            G.jand_util_area:emplace(_card)
        end
    end,
    remove_general = function(self, card)
        if G.jand_util_area then
            for k, v in pairs(G.jand_util_area.cards) do
                if v.ability.parent_joker == card.sort_id then
                    v:remove()
                end
            end
        end
    end,
    use = function (self, card)
        for k, v in pairs(G.jand_util_area.cards) do
            if v.ability.parent_joker == card.sort_id then
                card.ability.extra.ready = false
                v:use_consumeable()
            end
        end
    end,
    can_use = function (self, card)
        for k, v in pairs(G.jand_util_area.cards) do
            if v.ability.parent_joker == card.sort_id then
                if v:can_use_consumeable() and card.ability.extra.ready then
                    return true
                end
            end
        end
    end,
	calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and context.beat_boss then
            card.ability.extra.ready = true
            return {
                message = "Refreshed!"
            }
        end
    end,
}

SMODS.Joker {
	key = 'bone',
	rarity = 3,
	atlas = 'jimband',
	pos = { x = 5, y = 1 },
    jand_pack = "mew",
	cost = 7,
    jand_usable = true,
    jand_butt_colour = G.C.SECONDARY_SET.Spectral,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
    jand_gemini_compat = false,
    attributes = { "copying", "spectral" },
	config = { extra = { ready = "true" } },
	loc_vars = function(self, info_queue, card)
        local child
        if G.jand_util_area then
            for k, v in pairs(G.jand_util_area.cards) do
                if v.ability.parent_joker == card.sort_id then
                    child = v
                end
            end
        end
        if child and JAND.get_consumable_vars(child)["info_queue"] then
            JAND.merge_tables(info_queue, JAND.get_consumable_vars(child)["info_queue"])
        end
        if card.area.config.type == "joker" then
            local loc = {}
            local description = {}
            localize{type = "descriptions", key = child.config.center.key, set = "Spectral", default_col = G.C.UI.TEXT_DARK, nodes = loc, vars = JAND.get_consumable_vars(child)["vars"] or {}, scale = 1}
            description = {transparent_multiline_text(loc)}
            local main_end = {{n=G.UIT.C, config={align = "cm", colour = G.C.WHITE}, nodes=
				description
			}}
		    return { main_end = main_end, vars = { (card.ability.extra.ready and "Ready!") or "Used...", localize{type = 'name_text', key = child.config.center.key, set = 'Spectral'} } }
        else
            return { key = card.config.center.key .. "_alt" }
        end
	end,
    set_ability = function(self, card, initial, delay_sprites)
        if G.jand_util_area then
            local chosen_card = pseudorandom_element(G.P_CENTER_POOLS["Spectral"])
            local _card = SMODS.create_card({area = G.jand_util_area, skip_materialize = true, key = chosen_card.key, bypass_discovery_center = true})
            _card.ability.parent_joker = card.sort_id
            G.jand_util_area:emplace(_card)
        end
    end,
    remove_general = function(self, card)
        if G.jand_util_area then
            for k, v in pairs(G.jand_util_area.cards) do
                if v.ability.parent_joker == card.sort_id then
                    v:remove()
                end
            end
        end
    end,
    use = function (self, card)
        for k, v in pairs(G.jand_util_area.cards) do
            if v.ability.parent_joker == card.sort_id then
                card.ability.extra.ready = false
                v:use_consumeable()
            end
        end
    end,
    can_use = function (self, card)
        for k, v in pairs(G.jand_util_area.cards) do
            if v.ability.parent_joker == card.sort_id then
                if v:can_use_consumeable() and card.ability.extra.ready then
                    return true
                end
            end
        end
    end,
	calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and context.beat_boss then
            card.ability.extra.ready = true
            return {
                message = "Refreshed!"
            }
        end
    end,
}

G.STEVEN_EXCEPTIONS = {}

function JAND.steven_exclude(set_keys)
    for i = 1, #set_keys do
        if not G.STEVEN_EXCEPTIONS[set_keys[i]] then
            G.STEVEN_EXCEPTIONS[#G.STEVEN_EXCEPTIONS+1] = set_keys[i]
        end
    end
end

JAND.steven_exclude{"Alphabet","crv_boons","crv_Rune","phanta_Zodiac","EnchancedDocuments","Superior","Shape","Colour"}

for k, v in pairs(SMODS.ConsumableTypes) do
    if v.mod and not table.contains(G.STEVEN_EXCEPTIONS, v.key) then
        SMODS.Joker {
            key = 'steven_' .. v.key,
            rarity = 2,
            atlas = 'jimband',
            pos = { x = 6, y = 1 },
            jand_pack = "mew",
            cost = 5,
            jand_usable = true,
            jand_butt_colour = v.primary_colour,
            blueprint_compat = false,
            eternal_compat = true,
            perishable_compat = true,
            jand_gemini_compat = false,
            attributes = { "copying" },
            config = { extra = { copied_atlas = nil, copied_pos = nil, ready = "true" } },
            loc_vars = function(self, info_queue, card)
                local child
                if G.jand_util_area then
                    for k, v in pairs(G.jand_util_area.cards) do
                        if v.ability.parent_joker == card.sort_id then
                            child = v
                        end
                    end
                end
                if child and JAND.get_consumable_vars(child)["info_queue"] then
                    JAND.merge_tables(info_queue, JAND.get_consumable_vars(child)["info_queue"])
                end
                if card.area.config.type == "joker" then
                    local loc = {}
                    local description = {}
                    localize{type = "descriptions", key = child.config.center.key, set = v.key, default_col = G.C.UI.TEXT_DARK, nodes = loc, vars = JAND.get_consumable_vars(child)["vars"] or {}, scale = 1}
                    description = {transparent_multiline_text(loc)}
                    local main_end = {{n=G.UIT.C, config={align = "cm", colour = G.C.WHITE}, nodes=
                        description
                    }}
                    return { main_end = main_end, key = "j_jand_steven", vars = { (card.ability.extra.ready and "Ready!") or "Used...", localize{type = 'name_text', key = child.config.center.key, set = v.key}, localize('k_' .. string.lower(v.key)) } }
                else
                    return { key = "j_jand_steven_alt", vars = {localize('k_' .. string.lower(v.key))} }
                end
            end,
            set_ability = function(self, card, initial, delay_sprites)
                if G.jand_util_area then
                    local chosen_card = pseudorandom_element(G.P_CENTER_POOLS[v.key])
                    card.ability.extra.copied_atlas = chosen_card.atlas
                    card.ability.extra.copied_pos = chosen_card.pos
                    local _card = SMODS.create_card({area = G.jand_util_area, skip_materialize = true, key = chosen_card.key, bypass_discovery_center = true})
                    _card.ability.parent_joker = card.sort_id
                    G.jand_util_area:emplace(_card)
                end
            end,
            remove_general = function(self, card)
                if G.jand_util_area then
                    for k, v in pairs(G.jand_util_area.cards) do
                        if v.ability.parent_joker == card.sort_id then
                            v:remove()
                        end
                    end
                end
            end,
            use = function (self, card)
                for k, v in pairs(G.jand_util_area.cards) do
                    if v.ability.parent_joker == card.sort_id then
                        card.ability.extra.ready = false
                        v:use_consumeable()
                    end
                end
            end,
            can_use = function (self, card)
                for k, v in pairs(G.jand_util_area.cards) do
                    if v.ability.parent_joker == card.sort_id then
                        if v:can_use_consumeable() and card.ability.extra.ready then
                            return true
                        end
                    end
                end
            end,
            calculate = function(self, card, context)
                if context.end_of_round and context.game_over == false and context.main_eval and context.beat_boss then
                    card.ability.extra.ready = true
                    return {
                        message = "Refreshed!"
                    }
                end
            end,
            draw = function(self, card, layer)
                if card.ability.extra.copied_atlas and not card.children.floating_sprite then
                    card.children.floating_sprite = SMODS.create_sprite(card.T.x, card.T.y, card.T.w, card.T.h, card.ability.extra.copied_atlas, card.ability.extra.copied_pos)
                end
                if card.children and card.children.floating_sprite then
                    card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, -0.7, nil, nil, 0.8)
                end
            end
        }
    end
end

--lab jokers start 

SMODS.Joker {
	key = 'slocker',
	rarity = "jand_beta",
	atlas = 'jimband',
	pos = { x = 7, y = 1 },
    jand_pack = "mew",
	cost = 0,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
    beta_unlock = "j_jand_akey",
    attributes = { },
	config = { extra = { hold_boost = false } },
	loc_vars = function(self, info_queue, card)
        return { vars = { } }
	end,
    set_ability = function(self, card, initial, delay_sprites)
        card:add_sticker("eternal", true)
    end,
	calculate = function(self, card, context)
        local booster_func = function ()
            local boost = SMODS.create_card{set = "Booster", area = G.hand, key_append = "only_mega"}
            boost:start_materialize()
            boost.T.w = G.CARD_W*1.27
            boost.T.h = G.CARD_H*1.27
            G.FUNCS.use_card{config = { ref_table = boost }}
        end

        if context.starting_shop and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
            booster_func()
        elseif context.starting_shop then
            card.ability.extra.hold_boost = true
        end

        if card.ability.extra.hold_boost and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
            card.ability.extra.hold_boost = false
            booster_func()
        end
        if context.ending_booster then
            local close_shop = true
            for i = 1, #G.jokers.cards do
                G.jokers.cards[i]:calculate_joker({using_consumeable = true, consumeable = card})
                if G.jokers.cards[i].ability.extra.hold_boost then
                    close_shop = false
                end
            end
            if close_shop then --Kinda unelegant, compatibility concern?
                G.FUNCS.toggle_shop()
            end
        end
    end,
}

SMODS.Joker {
	key = 'akey',
	rarity = 2,
	atlas = 'jimband',
	pos = { x = 8, y = 1 },
    jand_pack = "mew",
	cost = 8,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
    jand_gemini_compat = false,
    attributes = { },
	config = { extra = { hold_boost = false } },
    unlocked = false,
	loc_vars = function(self, info_queue, card)
        return { vars = { } }
	end,
	calculate = function(self, card, context)
        local booster_func = function ()
            local boost = SMODS.create_card{set = "Booster", area = G.hand, key_append = "only_normal"}
            boost.T.w = G.CARD_W*1.27
            boost.T.h = G.CARD_H*1.27
            G.FUNCS.use_card{config = { ref_table = boost }}
        end

        if context.starting_shop and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
            booster_func()
        elseif context.starting_shop then
            card.ability.extra.hold_boost = true
        end

        if card.ability.extra.hold_boost and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
            card.ability.extra.hold_boost = false
            booster_func()
        end
        if context.ending_booster then
            G.E_MANAGER:add_event(Event({
                func = function() 
                    for i = 1, #G.jokers.cards do
                        G.jokers.cards[i]:calculate_joker()
                    end
                    return true 
                end
            }))
        end
    end,
}

SMODS.Joker {
	key = 'glass_cannon',
	rarity = "jand_beta",
	atlas = 'jimband',
	pos = { x = 9, y = 1 },
    jand_pack = "mew",
	cost = 0,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
    beta_unlock = "j_jand_fixed_cannon",
    attributes = { },
	config = { extra = { enhance = "m_glass" } },
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return { vars = { } }
	end,
    set_ability = function(self, card, initial, delay_sprites)
        card:add_sticker("eternal", true)
    end,
	calculate = function(self, card, context)
        if context.first_hand_drawn then
            JAND.convert(context.hand_drawn, card, card.ability.extra.enhance)
        end
        if context.mod_probability and context.identifier == "glass" then
            return {
                numerator = context.numerator * 2
            }
        end
    end,
}

SMODS.Joker {
	key = 'fixed_cannon',
	rarity = 2,
	atlas = 'jimband',
	pos = { x = 0, y = 2 },
    jand_pack = "mew",
	cost = 6,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
    jand_gemini_compat = false,
    attributes = { },
	config = { extra = { enhance = "m_glass" } },
    unlocked = false,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return { vars = { } }
	end,
	calculate = function(self, card, context)
        if context.before and #context.full_hand == 1 then
            JAND.convert(context.full_hand, card, card.ability.extra.enhance)
        end
    end,
}

SMODS.Joker {
	key = 'redacted',
	rarity = "jand_beta",
	atlas = 'jimband',
	pos = { x = 1, y = 2 },
    jand_pack = "mew",
	cost = 0,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
    beta_unlock = "j_jand_pbag",
    attributes = { },
	config = { extra = { } },
	loc_vars = function(self, info_queue, card)
        return { vars = { } }
	end,
    set_ability = function(self, card, initial, delay_sprites)
        card:add_sticker("eternal", true)
    end,
}

SMODS.Joker {
	key = 'pbag',
	rarity = 2,
	atlas = 'jimband',
	pos = { x = 2, y = 2 },
    jand_pack = "mew",
	cost = 6,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
    jand_gemini_compat = false,
    attributes = { },
	config = { extra = { mult = 0 } },
    unlocked = false,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
        card.ability.extra.mult = 0
        local my_pos
        for i=1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                my_pos = i
            end
        end
        if G.jokers.cards[my_pos+1] then
            local no_values = true
            for k, v in pairs(G.jokers.cards[my_pos+1].ability) do
                if (type(v) == "number") and (v > card.ability.extra.mult) and k ~= "order" then
                    card.ability.extra.mult = v
                    no_values = false
                elseif type(v) == "table" then
                    for k, vv in pairs(v) do
                        if (type(vv) == "number") and (vv > card.ability.extra.mult) and not string.find(k, "odds") then
                            card.ability.extra.mult = vv
                            no_values = false
                        end
                    end
                end
            end
            if no_values then
                card.ability.extra.mult = 0
            end
        else
            card.ability.extra.mult = 0
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
}

--lab jokers stop

arthur_get_joka = function()
    local chosen_card = pseudorandom_element(G.P_CENTER_POOLS["Joker"])
    local key = chosen_card.key
    if (not chosen_card.unlocked) or (not chosen_card.blueprint_compat) or (chosen_card.attributes and chosen_card.attributes.scaling) or (chosen_card.rarity == 4) then
        return arthur_get_joka()
    end
    return key
end 

SMODS.Joker {
	key = 'arthur',
	rarity = 4,
	atlas = 'jimband',
	pos = { x = 4, y = 2 },
    soul_pos = { x = 3, y = 2 },
    jand_pack = "mew",
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
    jand_gemini_compat = false,
    attributes = {"copying"},
	config = { extra = { copies = 3 } },
    unlocked = false,
	loc_vars = function(self, info_queue, card)
        local main_end
        info_queue[#info_queue+1] = { key = 'arthur_info', set = "Other" }
        if not G.arthur_cheatsheet then
            G.arthur_cheatsheet = {}
        end
        if G.jand_util_area and (card.area == G.jokers) then
            G.arthur_cheatsheet[card.sort_id] = CardArea(
                0,0,
                G.CARD_W*3,
                G.CARD_H*0.8, 
                { card_limit = 1, type = 'title'}
            )
            main_end = {
                {n = G.UIT.R, config = {align = "cm", r = 0.1, padding = 0.1}, nodes = {
                    {n = G.UIT.C, config = {align = "cm", padding = 0.3, colour = G.C.L_BLACK, r = 0.1}, nodes = {
                        {n = G.UIT.O, config = {object = G.arthur_cheatsheet[card.sort_id] }}
                    }}
                }}
            }
            for i=1, #G.jand_util_area.cards do
                if G.jand_util_area.cards[i].ability.parent_joker == card.sort_id then
                    local copy = copy_card(G.jand_util_area.cards[i])
                    copy.T.w = copy.T.w
                    copy.T.h = copy.T.h
                    G.arthur_cheatsheet[card.sort_id]:emplace(copy)
                end
            end
        end
        return { main_end = main_end, vars = { card.ability.extra.copies } }
	end,
	calculate = function(self, card, context)
        local jokers = {}
        for i=1, #G.jand_util_area.cards do
            if G.jand_util_area.cards[i].ability.parent_joker == card.sort_id then
                jokers[#jokers+1] = SMODS.blueprint_effect(card, G.jand_util_area.cards[i], context)
            end
        end
        if context.main_eval and context.end_of_round and G.GAME.current_round.hands_left < 1 then
            for k, v in pairs(G.jand_util_area.cards) do
                if v.ability.parent_joker == card.sort_id then
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            print(v.config.center.key)
                            v:remove()
                            return true 
                        end
                    }))
                end
            end
            for i=1, card.ability.extra.copies do
                local key = arthur_get_joka()
                local _card = SMODS.create_card({area = G.jand_util_area, key = key, no_edition = true, skip_materialize = true})
                _card.ability.parent_joker = card.sort_id
                G.jand_util_area:emplace(_card)
            end
            return { 
                message = "Reroll!",
                colour = G.C.RED,
            }
        end
        return SMODS.merge_effects(jokers)
    end,
    add_to_deck = function(self, card, from_debuff)
        if G.jand_util_area then
            for i=1, card.ability.extra.copies do
                local key = arthur_get_joka()
                local _card = SMODS.create_card({area = G.jand_util_area, key = key, bypass_discovery_center = true, no_edition = true, skip_materialize = true})
                _card.ability.parent_joker = card.sort_id
                G.jand_util_area:emplace(_card)
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.jand_util_area then
            for k, v in pairs(G.jand_util_area.cards) do
                if v.ability.parent_joker == card.sort_id then
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            print(v.config.center.key)
                            v:remove()
                            return true 
                        end
                    }))
                end
            end
        end
    end,
}
