for k, v in pairs(G.P_CENTER_POOLS["Booster"]) do
    local booster_sizes = {"normal", "jumbo", "mega"}
    for k, size in pairs(booster_sizes) do
        if string.find(v.key, size) then
            v.size = size
        end
    end
    if v.size then
        if v.in_pool then --hook in case of booster pack already having a in_pool function... No idea if this works 
            local pool_hook = v.in_pool
            v.in_pool = function(self, args)
                for k, size in pairs(booster_sizes) do
                    if v.size ~= size then
                        if args and args.source then
                            if args.source == "only_"..size then
                                return false
                            end
                        end
                    end
                end
                return pool_hook(self, args)
            end
        end
        if not v.in_pool then
            v.in_pool = function(self, args)
                for k, size in pairs(booster_sizes) do
                    if v.size ~= size then
                        if args and args.source then
                            if args.source == "only_"..size then
                                return false
                            end
                        end
                    end
                end
                return true
            end
        end
    end
end

JAND.booster_emplace = function(card)
    create_shop_card_ui(card, 'Booster', G.shop_booster)
    card.ability.booster_pos = #G.shop_booster.cards + 1
    card:start_materialize()
    card.T.w = G.CARD_W*1.27
    card.T.h = G.CARD_H*1.27
    G.shop_booster:emplace(card)
end