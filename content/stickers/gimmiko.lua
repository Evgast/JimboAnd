
SMODS.Sticker {
	key = 'gemini',
	atlas = "cardmods",
    gimmiko_upper = true,
	pos = { x = 0, y = 0 },
    badge_colour = HEX("d9bf2d"),
	loc_vars = function(self, info_queue, card)
	end,
	calculate = function (self, card, context)
        if not G.GAME.gemini_connected then
            G.GAME.gemini_connected = 0
        end
		if not card.ability.gemini_proc then
            JAND.value_mod(card.ability, 0.5)
            G.GAME.gemini_connected = G.GAME.gemini_connected + 1
            card.ability.gemini_proc = G.GAME.gemini_connected
            G.E_MANAGER:add_event(Event({
                trigger = "after", 
                delay = 0.1, 
                func = function() 
                    local copy = copy_card(card)
                    copy.ability.extra_slots_used = -1
                    copy.ability.gemini_proc = G.GAME.gemini_connected
                    G.jokers:emplace(copy)
                    return true 
                end
            }))
        end
        if (context.selling_card or context.joker_type_destroyed) and context.card == card then
            for k, v in pairs(G.jokers.cards) do
                if v.ability.gemini_proc == card.ability.gemini_proc and v ~= card then
                    v:start_dissolve()
                end
            end
        end
	end,
    sets = {
        Joker = true
    },
    compat_exceptions = { j_constellation = true, j_stencil = true, j_four_fingers = true, j_credit_card = true, j_ceremonial = true,
        j_marble = true, j_misprint = true, j_dusk = true, j_raised_fist = true, j_chaos = true, j_scary_face = true, j_abstract = true, j_pareidolia = true,
        j_supernova = true, j_ride_the_bus = true, j_runner = true, j_dna = true, j_splash = true, j_blue_joker = true, j_bull = true, j_trading = true,
        j_sixth_sense = true, j_hiker = true, j_green_joker = true, j_superposition = true, j_red_card = true, j_madness = true, j_square = true, j_seance = true,
        j_vampire = true, j_shortcut = true, j_hologram = true, j_cloud_9 = true, j_obelisk = true, j_midas_mask = true, j_luchador = true, j_photograph = true,
        j_erosion = true, j_fortune_teller = true, j_juggler = true, j_drunkard = true, j_stone = true, j_lucky_cat = true, j_baseball = true, j_flash = true,
        j_ancient = true, j_castle = true, j_campfire = true, j_sock_and_buskin = true, j_swashbuckler = true, j_certificate = true, j_smeared = true, 
        j_throwback = true, j_bloodstone = true, j_glass = true, j_blueprint = true, j_wee = true, j_oops = true, j_idol = true, j_seeing_double = true,
        j_hit_the_road = true, j_duo = true, j_tribe = true, j_brainstorm = true, j_satellite = true, j_cartomancer = true, j_astronomer = true, j_burnt = true,
        j_bootstraps = true, j_caino = true, j_yorick = true, j_chicot = true, j_perkeo = true
    }, --yeah, maybe this IS dumb.
    rate = 0,
}

SMODS.Sticker {
	key = 'scratched',
	atlas = "cardmods",
    gimmiko_upper = true,
	pos = { x = 1, y = 0 },
    badge_colour = HEX("ff9090"),
	loc_vars = function(self, info_queue, card)
	end,
	calculate = function (self, card, context)
        if context.retrigger_joker_check and context.other_card == card and math.random() < 1/5 then
            return { repetitions = 1 }
        end
	end,
    sets = {
        Joker = true
    },
    rate = 0,
}

SMODS.Sticker {
	key = 'slippery',
	atlas = "cardmods",
    gimmiko_lower = true,
	pos = { x = 0, y = 1 },
    badge_colour = HEX("e6b16e"),
	loc_vars = function(self, info_queue, card)
	end,
	calculate = function (self, card, context)
        local my_pos = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                my_pos = i
            end
        end
        if context.setting_blind then
            card.states.drag.can = false
            card.ability.slippery_slot = my_pos
            card.ability.immovable = true
        end
        if context.blind_defeated then
            card.states.drag.can = true
            card.ability.slippery_slot = nil
            card.ability.immovable = false
        end
        if card.ability.slippery_slot and G.jokers.cards[card.ability.slippery_slot] ~= G.jokers.cards[my_pos] then
            G.jokers.cards[card.ability.slippery_slot], G.jokers.cards[my_pos] = G.jokers.cards[my_pos], G.jokers.cards[card.ability.slippery_slot]
        end
	end,
    sets = {
        Joker = true
    },
    rate = 0,
}

SMODS.Sticker {
	key = 'weight_d',
	atlas = "cardmods",
    gimmiko_lower = true,
	pos = { x = 1, y = 1 },
    badge_colour = HEX("52739b"),
	loc_vars = function(self, info_queue, card)
	end,
    sets = {
        Joker = true
    },
    rate = 0,
}

SMODS.Sticker {
	key = 'weight_u',
	atlas = "cardmods",
    gimmiko_lower = true,
	pos = { x = 2, y = 1 },
    badge_colour = HEX("ad8c64"),
	loc_vars = function(self, info_queue, card)
	end,
    sets = {
        Joker = true
    },
    rate = 0,
}

SMODS.Sticker {
	key = 'minty',
	atlas = "cardmods",
    gimmiko_upper = true,
	pos = { x = 2, y = 0 },
    badge_colour = HEX("55eac8"),
	loc_vars = function(self, info_queue, card)
	end,
    sets = {
        Joker = true
    },
    rate = 0,
}

function JAND.sprue_apply_stickers(card) --yes I'm fucking hardcoding this shit fuck off
    local gimmiko_upper = {}
    local gimmiko_lower = {}
    for k, v in pairs(SMODS.Stickers) do
        if card.config.center[v.key.."_compat"] ~= false then
            if not (v.compat_exceptions and v.compat_exceptions[card.config.center.key]) then
                if v.gimmiko_upper then
                    if v.key == "jand_gemini" and card.config.center.perishable_compat ~= false then
                        for k, food in pairs(G.P_CENTER_POOLS["Food"]) do
                            if food.key ~= card.config.center.key then
                                gimmiko_upper[#gimmiko_upper+1] = v.key
                            end
                        end
                    elseif v.key ~= "jand_gemini" then
                        gimmiko_upper[#gimmiko_upper+1] = v.key
                    end
                end
                if v.gimmiko_lower then
                    gimmiko_lower[#gimmiko_lower+1] = v.key
                end
            end
        end
    end
    if #gimmiko_upper > 0 then
        card:add_sticker(pseudorandom_element(gimmiko_upper, "sprue_sticks"), true)
    end
    if #gimmiko_lower > 0 then
        card:add_sticker(pseudorandom_element(gimmiko_lower, "sprue_sticks"), true)
    end
end