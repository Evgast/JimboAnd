return {
    descriptions = {
            Joker={
                j_jand_yotsuba = {
                    name = "Yotsuba",
		            text = {
                "{C:green}+#1#{} to {C:green}probability numerators{}",
                "for every {C:attention}4{} in scoring hand",
                "{C:inactive}(Resets after the hand is scored){}"
		            }
                },
                j_jand_jumbo = {
                    name = "Jumbo",
		            text = {
                "{C:attention}Shops{} contain additional",
                "{C:attention}Jumbo Booster Packs{}"
		            }
                },
                j_jand_yomi = {
                    name = "Yomi",
		            text = {
                "Values of {C:attention}Food Jokers{}",
                "can't be affected"
		            }
                },
                j_jand_tomo = {
                    name = "Tomo",
		            text = {
                "Tomo will {C:mult}NOT{} be moved",
                "Gains {C:mult}+#2#{} Mult per {C:blue}Hand{} played",
                "and moves to the right {C:attention}Joker{} slot",
                "Moves to the left {C:attention}Joker{} slot on {C:mult}Discard{}",
                "{C:inactive}(Currently: {C:mult}+#1#{} {C:inactive}Mult)",
                "{C:inactive}(Tomo starts at the {C:attention}leftmost{} {C:inactive}slot)"
		            }
                },
                j_jand_chichi = {
                    name = "Chiyo-chichi",
		            text = {
                "{C:green}#3# in #4#{} chance to",
                "immediately {C:mult}destroy{} scoring {C:hearts}#5#",
                "and gain {C:white,X:mult}X#2#{} Mult",
                "{C:inactive}(Currently: {C:white,X:mult}X#1#{} {C:inactive}Mult)"
		            }
                },
                j_jand_danbo = {
                    name = "Danbo",
		            text = {
                {
                "On {C:green}use{}, copy ability",
                "of {C:attention}Joker{} to the right"
                },
                {
                "Can copy only one {C:attention}Joker{} per run",
                "Values of the {C:attention}copied{} ability",
                "won't be affected"
		        }
                    },
                },
                j_jand_danbo_used = {
                    name = "Danbo",
		            text = {
                {
                "Currently copying:",
                "{C:attention}#1#"
                },
                {
                "Can copy only one {C:attention}Joker{} per run",
                "Values of the {C:attention}copied{} ability",
                "won't be affected"
		        }
                    },
                },
                j_jand_cat = {
                    name = "Kamineko",
		            text = {
                "If played hand contains a {C:attention}#2#{}",
                "{C:mult}destroys{} scoring cards of the {C:attention}Highest Rank{}",
                "and gains their {C:chips}Chip Values{}",
                "{C:inactive}(Currently: {C:chips}+#1#{} {C:inactive}Chips)"
                    },
                },
                j_jand_milk = {
                    name = "Milk",
		            text = {
                "{C:chips}+#1#{} Chips",
                "{C:chips}#2#{} Chips when changing slots"
                    },
                },
                j_jand_osaka = {
                    name = 'Ayumu "Osaka" Kasuga',
		            text = {
                "After playing {C:blue}#3#{} hands,",
                "each of higher {C:attention}rank{} than previous,",
                "Gains {C:mult}#2#{} Mult",
                "{C:inactive}(Currently: {C:mult}#1#{C:inactive})",
                "{C:inactive}(Previous hand: #4#)"
                    },
                },
                j_jand_andagi = {
                    name = 'Sata Andagi',
		            text = {
                "{C:chips}+#1# Chips{}",
                "{C:mult}Self destructs{} and {C:attention}Copies{} itself",
                "when selecting a {C:attention}Blind{}",
                "{C:green}#2# in #3#{} chance to {C:mult}not copy{}",
                "{C:inactive}(Each copy has a higher chance)"
                    },
                },
        },
    },
}
