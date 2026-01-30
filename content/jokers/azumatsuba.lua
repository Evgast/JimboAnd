SMODS.Joker {
	key = 'yotsuba',
	rarity = 2,
	atlas = 'jimband',
	pos = { x = 0, y = 0 },
	cost = 5,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = { numerator = 0, numerator_gain = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.numerator_gain } }
	end,
	calculate = function(self, card, context)
        if context.mod_probability then
            return {
                numerator = context.numerator + card.ability.extra.numerator
            }
        end
        if context.scoring_hand and context.before then
            for k, v in pairs(context.scoring_hand) do
                if v:get_id() == 4 then
                    card.ability.extra.numerator = card.ability.extra.numerator + card.ability.extra.numerator_gain
                end
            end
        end
        if context.after then
            G.E_MANAGER:add_event(Event({
            func = function() 
                card.ability.extra.numerator = 0
                return true 
            end
            }))
        end
    end
}

SMODS.Joker {
	key = 'jumbo',
	rarity = 1,
	atlas = 'jimband',
	pos = { x = 1, y = 0 },
	cost = 4,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = { numerator = 0, numerator_gain = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.numerator_gain } }
	end,
	calculate = function(self, card, context)
        if context.starting_shop then
            local boost = SMODS.create_card{set = "Booster"}
            local boost_to_create = {}
            boost.states.visible = false
            for k, v in pairs(G.P_CENTER_POOLS["Booster"]) do
                if v.kind == boost.config.center.kind then
                    local booster_key = v.key
                    local find_jumbo = string.find(booster_key, "jumbo")
                    if find_jumbo then
                        boost_to_create[#boost_to_create+1] = v.key
                    end
                end
            end
            boost:remove()
            SMODS.add_booster_to_shop(pseudorandom_element(boost_to_create, "boost"))
        end
    end
}

SMODS.Joker {
	key = 'yomi',
	rarity = 2,
	atlas = 'jimband',
	pos = { x = 2, y = 0 },
	cost = 4,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
}

SMODS.Joker {
	key = 'tomo',
	rarity = 2,
	atlas = 'jimband',
	pos = { x = 3, y = 0 },
	cost = 4,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = { mult = 0, mult_gain = 2, tomo_slot = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain} }
	end,
    update = function(self, card, dt)
        local my_pos = nil
        if card.area == G.jokers then
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                my_pos = i
            end
        end
        if G.jokers.cards[card.ability.extra.tomo_slot] ~= G.jokers.cards[my_pos] then
            G.jokers.cards[card.ability.extra.tomo_slot], G.jokers.cards[my_pos] = G.jokers.cards[my_pos], G.jokers.cards[card.ability.extra.tomo_slot]
        end
        end
    end,
	calculate = function(self, card, context)
        if not context.blueprint then
            card.states.drag.can = false
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                end
            end
            if context.before and not context.blueprint then
                G.E_MANAGER:add_event(Event({
                func = function() 
                    if G.jokers.cards[#G.jokers.cards] ~= card then
                        card.ability.extra.tomo_slot = my_pos+1
                    end
                    return true 
                end
                }))
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_value = "mult_gain",
                    scaling_message = {
                        message = "+"..card.ability.extra.mult_gain,
                        colour = G.C.MULT
                    }
                })
                return true 
            end
            if context.pre_discard and not context.blueprint then
                if G.jokers.cards[1] ~= card then
                    card.ability.extra.tomo_slot = my_pos-1
                end
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker {
	key = 'chichi',
	rarity = 3,
	atlas = 'jimband',
	pos = { x = 4, y = 0 },
	cost = 7,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = { xmult = 1, xmult_gain = 0.25, odds = 4, suit = "Hearts" } },
	loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'chichi')
		return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain, numerator, denominator, card.ability.extra.suit} }
	end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) and SMODS.pseudorandom_probability(card, 'chichi', 1, card.ability.extra.odds) and not context.blueprint then
            SMODS.destroy_cards(context.other_card)
            SMODS.scale_card(card, {
	            ref_table = card.ability.extra,
                ref_value = "xmult",
	            scalar_value = "xmult_gain",
                scaling_message = {
	                message = "X"..card.ability.extra.xmult_gain,
	                colour = G.C.MULT
                }
            })
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

SMODS.Joker {
	key = 'danbo',
	rarity = 3,
	atlas = 'jimband',
	pos = { x = 5, y = 0 },
	cost = 7,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = { to_copy = nil, } },
	loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
            end
            local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat
            local main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            if not card.ability.extra.to_copy then
		        return { main_end = main_end }
            else
                return { key = "j_jand_danbo_used", vars = { localize{set = "Joker", key = G.danbo.cards[card.ability.extra.to_copy].config.center.key, type = "name_text" } } }   
            end
        end
	end,
	calculate = function(self, card, context)
        if card.ability.extra.to_copy then
            return SMODS.blueprint_effect(card, G.danbo.cards[card.ability.extra.to_copy], context)
        end
    end,
    use = function (self, card)
        local other_joker
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
        end
        local copy = copy_card(other_joker)
        copy.states.visible = true
        copy.states.visible = false
        G.danbo:emplace(copy)
        card.ability.extra.to_copy = #G.danbo.cards
        copy.danbo = card.ability.extra.to_copy
    end,
    can_use = function (self, card)
        local other_joker
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
        end
        local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat
        if compatible then
            return true
        end
    end,
}

SMODS.Joker {
	key = 'cat',
	rarity = 2,
	atlas = 'jimband',
	pos = { x = 6, y = 0 },
	cost = 5,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = { chips = 0, chips_gain = 0, highest_rank = 0, ready = false } },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, localize("Straight", 'poker_hands') } } 
	end,
	calculate = function(self, card, context)
        if not context.blueprint then
            if context.before then
                if next(context.poker_hands["Straight"]) then
                    card.ability.ready = true
                else
                    card.ability.ready = false
                end
                card.ability.highest_rank = 0
            end
            if card.ability.ready == true and context.other_card and context.individual and context.cardarea == G.play and context.other_card:get_id() > card.ability.highest_rank then
                card.ability.highest_rank = context.other_card:get_id()
            end
        end
        if context.joker_main and context.scoring_hand then
            if not context.blueprint then
                for k, v in pairs(context.scoring_hand) do
                    if v:get_id() == card.ability.highest_rank then
                        card.ability.extra.chips_gain = v:get_chip_bonus()
                        SMODS.destroy_cards(v)
                        SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = "chips",
                            scalar_value = "chips_gain",
                            scaling_message = {
                                message = "+"..card.ability.extra.chips_gain,
                                colour = G.C.CHIPS
                            }
                        })
                    end
                end
            end
        return {
            chips = card.ability.extra.chips
        }
        end
    end
}

SMODS.Joker {
	key = 'milk',
	rarity = 1,
	atlas = 'jimband',
	pos = { x = 7, y = 0 },
	cost = 5,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
    pools = {
        ["Food"] = true
    },
	config = { extra = { chips = 100, chips_loss = -10, milk_slot = nil } },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chips_loss } } 
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.jimband_joker_align and not context.blueprint then
            for i = 1, (#G.jokers.cards) do
                if G.jokers.cards[i] == card and i ~= card.ability.extra.milk_slot then
                    card.ability.extra.milk_slot = i
                    SMODS.scale_card(card, {
	                    ref_table = card.ability.extra,
                        ref_value = "chips",
	                    scalar_value = "chips_loss",
                        scaling_message = {
	                        message = ""..card.ability.extra.chips_loss,
	                        colour = G.C.CHIPS
                        }
                    })
                end
            end
        end
        if card.ability.extra.chips <= 0 and not context.blueprint then
            card:start_dissolve()
        end
    end,
    add_to_deck = function(self, card, from_debuff) 
        card.ability.extra.milk_slot = #G.jokers.cards + 1
    end
}

SMODS.Joker {
	key = 'osaka',
	rarity = 2,
	atlas = 'jimband',
	pos = { x = 8, y = 0 },
	cost = 5,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = { mult = 0, mult_gain = 8, to_play = 3, remaining = 3, why = nil, lhp = "None" } },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain, card.ability.extra.to_play, card.ability.extra.remaining, card.ability.extra.lhp } } 
	end,
	calculate = function(self, card, context)
        if G.GAME.last_hand_played then
            card.ability.extra.lhp = G.GAME.last_hand_played
        end
        if context.press_play and G.GAME.last_hand_played then
            card.ability.extra.why = G.GAME.last_hand_played
        end
        if context.before and context.scoring_name and not context.blueprint then
            if card.ability.extra.why then
                if (G.GAME.hands[context.scoring_name].order < G.GAME.hands[card.ability.extra.why].order) or not card.ability.extra.why then
                    card.ability.extra.remaining = card.ability.extra.remaining - 1
                    if card.ability.extra.remaining <= 0 then
                        card.ability.extra.remaining = 3
                        SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = "mult",
                            scalar_value = "mult_gain",
                            scaling_message = {
                                message = "+"..card.ability.extra.mult_gain,
                                colour = G.C.MULT
                            }
                        })
                    end
                end
                if (G.GAME.hands[context.scoring_name].order >= G.GAME.hands[card.ability.extra.why].order) and not context.blueprint then
                    card.ability.extra.remaining = 2
                    return {
                        message = "Ah..."
                    }
                end
            else
                card.ability.extra.remaining = card.ability.extra.remaining - 1
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
}

SMODS.Sound {
    key = "sata",
    path = "sata-andagi.mp3",
}

SMODS.Joker {
	key = 'andagi',
	rarity = 1,
	atlas = 'jimband',
	pos = { x = 9, y = 0 },
	cost = 5,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
    pools = {
        ["Food"] = true
    },
	config = { extra = { chips = 50, odds = 5, odds_loss = -1 } },
	loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'andagi')
        return { vars = { card.ability.extra.chips, numerator, denominator } } 
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.setting_blind and not context.blueprint then
            G.E_MANAGER:add_event(Event({
            trigger = "after", 
            delay = 0.1, 
            func = function()
                card:start_dissolve()
                if not SMODS.pseudorandom_probability(card, 'andagi', 1, card.ability.extra.odds) and not (G.jokers.config.card_limit <= #G.jokers.cards) then
                    local again = copy_card(card)
                    G.jokers:emplace(again)
                    SMODS.scale_card(again, {
                    ref_table = again.ability.extra,
                    ref_value = "odds",
                    scalar_value = "odds_loss",
                    scaling_message = {
                        message = "Sata Andagi!",
                        colour = G.C.FILTER
                    }
                    })
                end
                return true 
            end
            }))
        end
    end,
    add_to_deck= function(self, card, from_debuff) 
        play_sound("jand_sata")
    end
}
