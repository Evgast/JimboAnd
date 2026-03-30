if next(SMODS.find_mod("RevosVault")) then
    
new_shopkeep{
    key = "revo",
    atlas = "keepers",
    pos = { x = 0, y = 1},
    card_amount = 2,
    quips = 5,
    shopname = "Revo's Vault",
    restock = function ()
        for i = 1, 2 do
            local card = SMODS.create_card({set = "Joker", rarity = "crv_p", area = G.jand_shop, bypass_discovery_center = true})
            G.jand_shop:emplace(card)
        end
    end,
    apply = function ()
        for i = 1, #G.jand_shop.cards do
            revo_price_ui(G.jand_shop.cards[i])
        end
    end
}

function revo_price_ui(card)
	card.rbs = 1 --random bullshit is always 1? Unless I decide otherwise at some point lmao
	local t1 = JAND.price_tag({object = DynaText({string = {{prefix = "RBS", ref_table = card, ref_value = 'rbs'}}, colours = {G.C.PURPLE},shadow = true, silent = true, bump = true, pop_in = 0, scale = 0.5})})
	card.children.rbs_price = UIBox{
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

G.FUNCS.can_buy_rbs = function(e)
    if #G.jokers.cards >= e.config.ref_value.rbs then
		e.config.colour = G.C.PURPLE
		e.config.button = "buy_rbs_butt"
	else
		e.config.colour = G.C.BLACK
		e.config.button = nil
	end
end

G.FUNCS.buy_rbs_butt = function(e)
	G.rbs_jokers = CardArea(
		0, 0, G.jokers.T.w, G.jokers.T.h,
        {
            card_limit = 5, 
            type = 'joker', 
            highlight_limit = 1,
            no_card_count = true
        }
	)
    for i = 1, #G.jokers.cards do
        local copy = copy_card(G.jokers.cards[i])
        copy.original = G.jokers.cards[i]
        copy.printer = e.config.ref_value
        G.rbs_jokers:emplace(copy)
    end
    G.FUNCS.overlay_menu({
        definition = create_UIBox_generic_options({
            contents = {
                {n=G.UIT.O, config={object = G.rbs_jokers}},
            }
        })     
	})
end

function G.FUNCS.can_confirm_rbs()
    if #G.jokers.cards > card.printer.rbs then
        e.config.colour = G.C.PURPLE
        e.config.button = "rbs_confirm"
    else
        e.config.colour = G.C.BLACK
        e.config.button = nil
    end
end

function G.FUNCS.rbs_confirm(e)
    local card = e.config.ref_value
    card.original:start_dissolve()
    card.printer.children.rbs_price:remove()
    card.printer.children.rbs_price = nil
    card.printer.area:remove_card(card.printer)
    card.printer:add_to_deck()
    G.jokers:emplace(card.printer)
    G.FUNCS.exit_overlay_menu()
end

end