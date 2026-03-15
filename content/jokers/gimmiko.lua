SMODS.Joker {
	key = 'merci',
	rarity = 2,
	atlas = 'jimband',
	pos = { x = 0, y = 1 },
	cost = 5,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
    pools = {
        ["flynnset_gimmiko"] = true
    },
	config = { extra = { base_dollars = 2, dollars = 2, odds = 2 } },
	loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'merci')
        return { vars = { card.ability.extra.dollars, card.ability.extra.dollars, numerator, denominator } } 
	end,
	calculate = function(self, card, context)
        if context.setting_blind then
            card.ability.extra.dollars = card.ability.extra.base_dollars
        end
        if context.joker_main and SMODS.pseudorandom_probability(card, 'merci', 1, card.ability.extra.odds) then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "dollars",
                scalar_value = "base_dollars",
                scaling_message = {
                    message = "+"..card.ability.extra.base_dollars.."Rt",
                    colour = G.C.MONEY
                }
            })
        end
    end,
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end
}

SMODS.Joker {
	key = "tailend",
	rarity = 2,
	atlas = 'jimband',
	pos = { x = 1, y = 1 },
	cost = 6,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    jand_gemini_compat = false,
    pools = {
        ["flynnset_gimmiko"] = true
    },
	config = { extra = {  } },
	loc_vars = function(self, info_queue, card)
        return { vars = {  } } 
	end,
	calculate = function(self, card, context)
        if context.starting_shop or context.reroll_shop then
            local shop_card = create_card_for_shop(G.shop_jokers)
            G.shop_jokers:emplace(shop_card)
            nikola_card_ui(shop_card)
            G.E_MANAGER:add_event(Event({
                trigger = "after", 
                delay = 0.3, 
                func = function() 
                    remove_vanilla_price(shop_card)
                    return true 
                end
            }))
        end
    end,
}

SMODS.Joker {
	key = "shotoku",
	rarity = 1,
	atlas = 'jimband',
	pos = { x = 2, y = 1 },
	cost = 4,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    pools = {
        ["flynnset_gimmiko"] = true
    },
	config = { card_limit = -1, extra = { xmult = 2 } },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } } 
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}

SMODS.Joker {
	key = "picasso",
	rarity = 2,
	atlas = 'jimband',
	pos = { x = 3, y = 1 },
	cost = 6,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
    jand_gemini_compat = false,
    pools = {
        ["flynnset_gimmiko"] = true
    },
	config = { },
	loc_vars = function(self, info_queue, card)
        return { vars = { } } 
	end,
	calculate = function(self, card, context)
        if context.selling_self then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    G.jokers.cards[i-1]:set_edition(SMODS.poll_edition{ key = "picasso_edition", guaranteed = true, no_negative = true })
                    G.jokers.cards[i+1]:set_edition(SMODS.poll_edition{ key = "picasso_edition", guaranteed = true, no_negative = true }) 
                end
            end
        end
    end,
}

