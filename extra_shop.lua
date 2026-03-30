if G.low_buttons then
	G.low_buttons[#G.low_buttons+1] = function()
		return {n=G.UIT.R, config={align = "cm", minw = 2.8, minh = 1, r=0.15,colour = G.C.BLUE, button = 'extra_shop_swap', hover = true,shadow = true}, nodes = {
			{n=G.UIT.R, config={align = "cm", maxw = 2}, nodes={
				{n=G.UIT.T, config={text = G.shopname, func = "shopname_upd", scale = 1, colour = G.C.WHITE, shadow = true}},
			}}               
		}}
	end
end

function G.FUNCS.shopname_upd(e)
	if e.config.text ~= G.shopname then
		e.config.text = G.shopname
	end
end

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

function JAND.price_tag(config)
	return {n=G.UIT.ROOT, config = {minw = 0.6, align = 'tm', colour = darken(G.C.BLACK, 0.2), shadow = true, r = 0.05, padding = 0.05, minh = 1}, nodes={
        {n=G.UIT.R, config={align = "cm", colour = lighten(G.C.BLACK, 0.1), r = 0.1, minw = 1, minh = 0.55, emboss = 0.05, padding = 0.03}, nodes={
            {n=G.UIT.O, config=config},
        }}
    }}
end

function G.FUNCS.your_collection_shopkeepers()
	G.SETTINGS.paused = true
	G.your_collection_sk = CardArea(
      	0,0,
      	5*G.CARD_W,
      	0.95*G.CARD_H, 
      	{card_limit = 5, type = 'title', highlight_limit = 0}
	)
	for i=1, 5 do
		local key = G.P_CENTER_POOLS["jand_sk"][i].key
		local card = SMODS.create_card({set = "jand_sk", area = G.your_collection_sk, key = key, key_append = "jand_sk", no_edition = true})
      	G.your_collection_sk:emplace(card)
	end
	local keepers_options = {}
	for i=1, math.ceil(#G.P_CENTER_POOLS["jand_sk"]/5) do
		table.insert(keepers_options, localize('k_page')..' '..tostring(i)..'/'..tostring(math.ceil(#G.P_CENTER_POOLS["jand_sk"]/5)))
	end
  	G.FUNCS.overlay_menu{
    	definition = create_UIBox_generic_options({
        contents = {
			{ n = G.UIT.C, config = {minw=1, minh=1, colour = G.C.CLEAR }, nodes = {
                { n = G.UIT.R, config={align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05 }, nodes={
					{ n = G.UIT.O, config={object = G.your_collection_sk}}
				}}, 
                { n = G.UIT.R, config={align = "cm"}, nodes={
                    create_option_cycle({options = keepers_options, w = 4.5, cycle_shoulders = true, opt_callback = 'sk_collection_slider', current_option = 1, colour = G.C.RED, no_pips = true, focus_args = {snap_to = true, nav = 'wide'}})
        		}}
			}},
		}
		}), 
  	}
end

G.FUNCS.sk_collection_slider = function(args)
  	if not args or not args.cycle_config then return end
	for i=1, #G.your_collection_sk.cards do
		local c = G.your_collection_sk:remove_card(G.your_collection_sk.cards[i])
		c:remove()
	end
	for i=1, 5 do
		if G.P_CENTER_POOLS["jand_sk"][((args.cycle_config.current_option-1)*5)+i] then
			local key = G.P_CENTER_POOLS["jand_sk"][((args.cycle_config.current_option-1)*5)+i].key
			local card = SMODS.create_card({set = "jand_sk", area = G.your_collection_sk, key = key, key_append = "jand_sk", no_edition = true})
			G.your_collection_sk:emplace(card)
		end
	end
end

function JAND.show_shop(shop)
    if shop and shop.alignment.offset.ppy then --double p to separate from py. Makes life easier I think
      shop.alignment.offset.y = shop.alignment.offset.ppy
      shop.alignment.offset.ppy = nil
    end
end

function JAND.hide_shop(shop)
    if shop and not shop.alignment.offset.ppy then
      shop.alignment.offset.ppy = shop.alignment.offset.y
      shop.alignment.offset.y = G.ROOM.T.y + 29
    end
end

function G.UIDEF.extra_shop()
	local loc = {}
	local quip = {}
	localize{type = "descriptions", key = "shopkeep_oopsie", set = "ShopQuips", default_col = G.C.UI.TEXT_DARK, nodes = loc, vars = {}, scale = 1}
	quip = {transparent_multiline_text(loc)}
	t = {n = G.UIT.ROOT, config = {r = 0.1, minw = 1, minh = 1, align = "tm", colour = G.C.CLEAR}, nodes = {
        UIBox_dyn_container({
			{n = G.UIT.C, config = {colour = G.C.BLACK, r = 0.1, align = "cm"}, nodes = {
				{n = G.UIT.R, config = {colour = G.C.CLEAR, align = "cm", padding = 0.3}, nodes = {
					{n=G.UIT.C, config= { colour = G.C.CLEAR, w = 1, h = 1, align = "cm" }, nodes={
						{n = G.UIT.O, config = {object = G.jand_shopkeep}},
					}},
					{n=G.UIT.C, config = {align = "cm", minh = 1, minw = 5, r = 0.3, padding = 0.07, colour = G.C.JOKER_GREY, shadow = true}, nodes={
						{n=G.UIT.R, config={align = "cm", minh = G.CARD_H --[[just trust the process]], minw = 5, r = 0.2, padding = 0.1, func = "shop_quip_func", colour = G.C.WHITE}, nodes=
							quip
						}
					}},
					{n=G.UIT.C, config= { button = "extra_shop_swap", colour = G.C.GREEN, minw = G.CARD_W, h = 1, r = 0.1, align = "cm" }, nodes={
						{n=G.UIT.T, config={text = "Return", colour = G.C.UI.TEXT_LIGHT, scale = 0.5}}
					}}
				}},
				{n = G.UIT.R, config = {colour = G.C.L_BLACK, align = "cl", r = 0.1}, nodes = {
					{n = G.UIT.O, config = {object = G.jand_shop}},
				}},
			}},
			
		})
	}}
    return t
end

function G.FUNCS.shop_quip_func(e)
	if e.children and e.children[1] and G.update_quipbox then
		local loc = {}
		local quip = {}
		localize{type = "descriptions", key = G.GAME.shop_quip, set = "ShopQuips", default_col = G.C.UI.TEXT_DARK, nodes = loc, vars = {}, scale = 1.5}
		quip = {transparent_multiline_text(loc)}
		G.update_quipbox = false
		e.children[1]:remove()
		e.children[1] = nil
		local new_quip = {n=G.UIT.C, config = {align = "cm", colour = G.C.CLEAR}, nodes=
							quip
						}
		e.UIBox:add_child(new_quip, e)
	end
end

function JAND.update_quipbox()
	if G.jand_shopkeep and G.jand_shopkeep.cards[1] then
		local card = G.jand_shopkeep.cards[1]
		G.GAME.shop_quip = card.config.center.key .. "_" .. math.random(1, card.ability.quips)
	else
		G.GAME.shop_quip = "shopkeep_oopsie"
	end
	G.update_quipbox = true
end

function G.FUNCS.extra_shop_swap()
	if G.GAME.current_shop == "Vanilla" or G.GAME.current_shop == nil then
		JAND.hide_shop(G.shop)
		JAND.show_shop(G.extra_shop)
		G.GAME.current_shop = "Jand"
	else
		JAND.hide_shop(G.extra_shop)
		JAND.show_shop(G.shop)
		G.GAME.current_shop = "Vanilla"
	end
	JAND.remove_from_used(G.GAME.current_shop)
end

function JAND.remove_from_used(current_shop)
	if current_shop == "Vanilla" then
		if G.shop then
			for k, base_jokers in pairs(G.shop_jokers.cards) do
				G.GAME.used_jokers[base_jokers.config.center.key] = true
			end
			for k, boosters in pairs(G.shop_booster.cards) do
				G.GAME.used_jokers[boosters.config.center.key] = true
			end
			for k, vouchers in pairs(G.shop_vouchers.cards) do
				G.GAME.used_jokers[vouchers.config.center.key] = true
			end
		end
		for k, jand_cards in pairs(G.jand_shop.cards) do
			G.GAME.used_jokers[jand_cards.config.center.key] = nil
		end
	end
	if current_shop == "Jand" then
		for k, base_jokers in pairs(G.shop_jokers.cards) do
			if G.GAME.used_jokers[base_jokers.config.center.key] then
				G.GAME.used_jokers[base_jokers.config.center.key] = nil
			end 
		end
		for k, boosters in pairs(G.shop_booster.cards) do
			if G.GAME.used_jokers[boosters.config.center.key] then
				G.GAME.used_jokers[boosters.config.center.key] = nil
			end 
		end
		for k, vouchers in pairs(G.shop_vouchers.cards) do
			if G.GAME.used_jokers[vouchers.config.center.key] then
				G.GAME.used_jokers[vouchers.config.center.key] = nil
			end 
		end
		for k, jand_cards in pairs(G.jand_shop.cards) do
			G.GAME.used_jokers[jand_cards.config.center.key] = true
		end
	end
	for k, your_jokers in pairs(G.jokers.cards) do
		G.GAME.used_jokers[your_jokers.config.center.key] = true
	end
	for k, your_consume in pairs(G.consumeables.cards) do
		G.GAME.used_jokers[your_consume.config.center.key] = true
	end
end

function extra_shop_create()
	G.extra_shop = UIBox{
		definition = G.UIDEF.extra_shop(),
		config = {align='tmi', offset = {x=0,y=G.ROOM.T.y+29,ppy=-5},major = G.hand, bond = 'Weak'} --Is this fucking dumb
	}
end

function remove_vanilla_price(card)
	if card.children.price then 
		card.children.price:remove()
        card.children.price = nil
	end
    if card.children.buy_button then 
		card.children.buy_button:remove()
        card.children.buy_button = nil
	end
end

function JAND.add_booster_to_area(key, area)
    if key then assert(G.P_CENTERS[key], "Invalid booster key: "..key) else key = get_pack('shop_pack').key end
    local card = Card(area.T.x + area.T.w/2,
    area.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
    create_shop_card_ui(card, 'Booster', area)
    card:start_materialize()
    area:emplace(card)
    return card
end

function restock_extra_shop(key)
	for k, v in pairs(G.jand_shopkeep.cards) do
		v:remove()
	end
	local shopkeep = SMODS.create_card({set = "jand_sk", area = G.jand_shopkeep, key = key or nil, key_append = "jand_sk", no_edition = true})
	shopkeep.states.click.can = false
	for k, v in pairs(G.jand_shop.cards) do
		G.E_MANAGER:add_event(Event({
    	func = function() 
        	v:remove()
        	return true 
    	end
		}))
	end
	G.jand_shopkeep:emplace(shopkeep)
	shopkeep.config.center:restock()
	shopkeep.config.center:apply()
	G.jand_shop.config.card_limit = shopkeep.ability.card_amount + 1 --it looks better this way TRUST
	G.shopname = shopkeep.ability.shopname
	JAND.update_quipbox()
end

SMODS.Keybind {
	key_pressed = 'g',
	action = function(self)
		if G.STATE == G.STATES.SHOP then
			G.FUNCS.extra_shop_swap()
		end
	end
}