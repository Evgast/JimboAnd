
function G.FUNCS.jand_recalc(e)
    e.parent.UIBox:recalculate()
end

function G.FUNCS.jand_joker_use(e)
    local card = e.config.ref_table
    if card.config.center:can_use(card) then
        e.config.button = "jand_joker_butt"
        e.config.colour = card.config.center.jand_butt_colour or G.C.GREEN
    else
        e.config.button = nil
        e.config.colour = G.C.BLACK
    end
end

function G.FUNCS.jand_joker_butt(e)
    local card = e.config.ref_table
    card:highlight(false)
    card.config.center:use(card)
end