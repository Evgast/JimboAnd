SMODS.Atlas {
	key = "that_freak",
	path = "that_freak.png",
    atlas_table = "ANIMATION_ATLAS",
    frames = 13,
    fps = 8,
	px = 34,
	py = 34
}

SMODS.Blind{
    key = "h_iii",
    atlas = "that_freak",
    pos = {x = 0, y = 0},
    boss = {showdown = true},
    boss_colour = G.C.RED,
    dollars = 8,
    mult = 2 or G.GAME.blinds_skipped and 2 + (G.GAME.blinds_skipped*3),
    jand_pack = "mew",
    jand_blind_reset = function(self)
        local loc = {}
        local message = {}
        localize{type = 'other', key = "hitler_mess", default_col = G.C.UI.TEXT_LIGHT, nodes = loc, vars = {}}
        message = {transparent_multiline_text(loc)}
        G.FUNCS.overlay_menu({
            definition = create_UIBox_generic_options({
                contents = {
                    {n=G.UIT.C, config = {align = "cm", r = 0.1, colour = G.C.CLEAR}, nodes=
                        message
                    }
                }
            })     
        })
        G.GAME.prevent_showdown = true
        G.GAME.round_resets.blind_choices.Small = get_new_boss()
        G.GAME.round_resets.blind_choices.Big = get_new_boss()
        G.GAME.prevent_showdown = false
    end
}