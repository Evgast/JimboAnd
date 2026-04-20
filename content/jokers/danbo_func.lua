
function G.FUNCS.jand_recalc(e)
    e.parent.UIBox:recalculate()
end

function G.FUNCS.danboskill(e)
    local card = e.config.ref_table
    if card.config.center:can_use(card) then
        e.config.button = "danbobutt"
        e.config.colour = G.C.GREEN
    else
        e.config.button = nil
        e.config.colour = G.C.BLACK
    end
end

function G.FUNCS.danbobutt(e)
    local card = e.config.ref_table
    card.config.center:use(card)
    card:highlight(false)
end