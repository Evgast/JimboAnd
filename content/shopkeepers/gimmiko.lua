function new_shopkeep(t)
    SMODS.Joker {
        key = t.key,
        atlas = t.atlas,
        pos = t.pos,
        config = { card_amount = t.card_amount, quips = t.quips, shopname = t.shopname },
        no_collection = true,
        discovered = true,
        in_pool = function (self, args)
            if args.source == "jand_sk" then
                return true
            else
                return false
            end
        end,
        pools = {
            ["jand_sk"] = true
        },
        set_card_type_badge = function(self, card, badges)
            badges[#badges + 1] = create_badge("Shopkeeper", G.C.PURPLE, G.C.WHITE, 1.2)
        end,
        restock = t.restock,
        apply = t.apply,
    }
end

new_shopkeep{
    key = "nikola",
    atlas = "keepers",
    pos = { x = 0, y = 0},
    card_amount = 2,
    quips = 5,
    shopname = "Tail's End",
    restock = function ()
        for i = 1, 2 do
            create_nikola_card("Joker", G.jand_shop, 1)
        end
    end,
    apply = function ()
        for i = 1, #G.jand_shop.cards do
            nikola_card_ui(G.jand_shop.cards[i])
        end
    end
}

new_shopkeep{
    key = "crows",
    atlas = "keepers",
    pos = { x = 1, y = 0},
    card_amount = 3,
    quips = 4,
    shopname = "Utility Poll",
    restock = function ()
        local pool = {}
            for k, v in pairs(G.P_CENTER_POOLS["Consumeables"]) do --There's probably a more reasonable way to get a list of all available consum(e)able types but I'm a dipshit :з 
                if not table.contains(pool, v.set) then
                    table.insert(pool, v.set)
                end
            end
        for i = 1, 3 do
            local set, pos = pseudorandom_element(pool, "crows")
            local card = SMODS.create_card({set = set, area = G.jand_shop, bypass_discovery_center = true})
            G.jand_shop:emplace(card)
            table.remove(pool, pos)
        end
    end,
    apply = function ()
        G.E_MANAGER:add_event(Event({
            func = function() 
                for i = 1, #G.jand_shop.cards do
                    local card = G.jand_shop.cards[i]
                    card.ability.couponed = true
                    create_shop_card_ui(card)
                    card.cost = 0
                end
                return true 
            end
        }))
    end
}

new_shopkeep{
    key = "ika",
    atlas = "keepers",
    pos = { x = 2, y = 0},
    card_amount = 2,
    quips = 4,
    shopname = "1-8-1",
    restock = function ()
        for i = 1, 2 do
            JAND.add_booster_to_area(nil, G.jand_shop)
        end
    end,
    apply = function ()
        G.E_MANAGER:add_event(Event({
            func = function() 
                for i = 1, #G.jand_shop.cards do
                    local card = G.jand_shop.cards[i]
                    create_shop_card_ui(card)
                end
                return true
            end
        }))
    end
}

new_shopkeep{
    key = "sprue",
    atlas = "keepers",
    pos = { x = 3, y = 0},
    card_amount = 3,
    quips = 4,
    shopname = "Sterling's Customs",
    restock = function ()
        for i = 1, 3 do
            local card = SMODS.create_card({set = "Joker", area = G.jand_shop, bypass_discovery_center = true})
            JAND.sprue_apply_stickers(card)
            G.jand_shop:emplace(card)
        end
    end,
    apply = function ()
        G.E_MANAGER:add_event(Event({
            func = function() 
                for i = 1, #G.jand_shop.cards do
                    local card = G.jand_shop.cards[i]
                    create_shop_card_ui(card)
                end
                return true
            end
        }))
    end
}

new_shopkeep{
    key = "hapoten",
    atlas = "keepers",
    pos = { x = 4, y = 0},
    card_amount = 3,
    quips = 4,
    shopname = "Rotten Playroom",
    restock = function ()
        for i = 1, 3 do
            local card = SMODS.create_card({set = "Joker", area = G.jand_shop, bypass_discovery_center = true})
            card.cost = card.cost * math.random(0.5, 2)
            G.jand_shop:emplace(card)
        end
    end,
    apply = function ()
        G.E_MANAGER:add_event(Event({
            func = function() 
                for i = 1, #G.jand_shop.cards do
                    local card = G.jand_shop.cards[i]
                    create_shop_card_ui(card)
                end
                return true
            end
        }))
    end
}
