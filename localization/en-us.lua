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
                "{C:attention}Shop{} contains an additional",
                "{C:attention}Jumbo Booster Pack{}"
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
                "Gains {C:mult}+#2#{} Mult",
                "{C:inactive}(Currently: +{C:mult}#1#{C:inactive})",
                "{C:inactive}(Hands remaining: #4#)",
                "{C:inactive}(Previous hand: #5#)"
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
                j_jand_merci = {
                    name = 'Merci',
		            text = {
                "Earn {C:money}$#1#{} at the end of the round,",
                "{C:green}#3# in #4#{} chance to {C:attention}raise{} payout",
                "by {C:money}$2{} when playing a hand,",
                "resets at the start of the round"
                    },
                },
                j_jand_tailend = {
                    name = "Tail's End",
		            text = {
                "Shops have {C:attention}additional card{}",
                "which can be bought for",
                "{C:planet}Hand Levels{}"
                    },
                },
                j_jand_shotoku = {
                    name = 'Shotoku',
		            text = {
                "{C:white,X:red}X#1#{} Mult",
                "{C:dark_edition}-1{} Joker slot"
                    },
                },
                j_jand_picasso = {
                    name = 'Picasso',
		            text = {
                "Applies Non-{C:dark_edition}Negative{} editions",
                "to adjacent {C:attention}Jokers{} when sold"
                    },
                },
                --SHOPKEEPERS HERE
                j_jand_nikola = {
                    name = "Nikola",
                    text = {
                        "Sells {C:attention}2{} {C:rare}Rare{} Jokers",
                        "each at cost of",
                        "{C:planet}3{} hand levels"
                    }
                },
                j_jand_crows = {
                    name = "Shogunate of Birds",
                    text = {
                        "Offers {C:attention}3{} consumables",
                        "of random type",
                        "for {C:attention}free{}"
                    }
                },
                j_jand_ika = {
                    name = "Ika",
                    text = {
                        "Sells {C:attention}2{} Booster Packs",
                        "{C:inactive,s:0.5}(Yes, that's it)"
                    }
                },
                j_jand_sprue = {
                    name = "Sprue",
                    text = {
                        "Sells {C:attention}3{} Jokers",
                        "with {C:attention}Quirk Stickers{}"
                    }
                },
                j_jand_hapoten = {
                    name = "Sprue",
                    text = {
                        "Sells {C:attention}3{} Jokers...",
                        "At a different price?"
                    }
                },
            },
            ShopQuips = {
                shopkeep_oopsie = {
                    name = "",
                    text = {
                        "Uh-oh, seems like",
                        "{C:attention}something{} went",
                        "{C:red}terribly wrong{}"
                    }
                },
                --NIKOLA QUIPS
                j_jand_nikola_1 = {
                    name = "",
                    text = {
                        "Prrrmjau..."
                    }
                },
                j_jand_nikola_2 = {
                    name = "",
                    text = {
                        "Mjau..."
                    }
                },
                j_jand_nikola_3 = {
                    name = "",
                    text = {
                        "Prrrrrrrr..."
                    }
                },
                j_jand_nikola_4 = {
                    name = "",
                    text = {
                        "..."
                    }
                },
                j_jand_nikola_5 = {
                    name = "",
                    text = {
                        "Ma! Ma, there's a weird-"
                    }
                },
                --CROWS QUIPS
                j_jand_crows_1 = {
                    name = "",
                    text = {
                        "Feel {C:attention}free{} to",
                        "{C:attention}take{} what you need!"
                    }
                },
                j_jand_crows_2 = {
                    name = "",
                    text = {
                        "Help yourself to those",
                        "{C:attention}cards{} on the table",
                        "We picked them",
                        "{C:attention}nice and pona{},",
                        "just for you!"
                    }
                },
                j_jand_crows_3 = {
                    name = "",
                    text = {
                        "Toki! The {C:attention}Shogunate{}",
                        "welcomes you!"
                    }
                },
                j_jand_crows_4 = {
                    name = "",
                    text = {
                        "Crows, we're crows!",
                        "Not {C:inactive}ghosts{}...",
                        "Or {C:diamonds}pinecones{}..."
                    }
                },
                --IKA QUIPS . 
                j_jand_ika_1 = {
                    name = "",
                    text = {
                        "Welcome to {C:attention}One-Eight-One{}!",
                        "What kinda '{C:attention}Yay! Yay!{}'",
                        "experience can we",
                        "offer you today?"
                    }
                },
                j_jand_ika_2 = {
                    name = "",
                    text = {
                        "{C:inactive}*Your attempt at",
                        "{C:inactive}petting the dog",
                        "{C:inactive}didn't work out...*"
                    }
                },
                j_jand_ika_3 = {
                    name = "",
                    text = {
                        "No, they don't {C:green}restock{}",
                        "when you buy them all...",
                    }
                },
                j_jand_ika_4 = {
                    name = "",
                    text = {
                        "Too jaded to quip,",
                        "leave a tip"
                    }
                },
                --SPRUE QUIPS
                j_jand_sprue_1 = {
                    name = "",
                    text = {
                        "Get your sweaty {C:blue}hands{}",
                        "off the {C:attention}cards{}!"
                    }
                },
                j_jand_sprue_2 = {
                    name = "",
                    text = {
                        "So you're into weird",
                        "little {C:attention}stickers{}, aren't",
                        "you?"
                    }
                },
                j_jand_sprue_3 = {
                    name = "",
                    text = {
                        "Mean quip that only",
                        "only poker {c:attention}larpers{}",
                        "can read"
                    }
                },
                j_jand_sprue_4 = {
                    name = "",
                    text = {
                        "{C:inactive}*She's sleeping...",
                        "{C:inactive}during workhours????",
                        "{C:inactive}Scandalous...*"
                    }
                },
                --SECRET GIRL QUIPS (HAPOTEN (THERE'S NOTHING SECRET ABOUT HER IN THE MOD LMAO))
                j_jand_hapoten_1 = {
                    name = "",
                    text = {
                        "Number {C:attention}1{} rated",
                        "{C:attention}hot single{} in your area"
                    }
                },
                j_jand_hapoten_2 = {
                    name = "",
                    text = {
                        "{C:attention}Hapoten{} is your",
                        "{C:hearts}favorite{} character!"
                    }
                },
                j_jand_hapoten_3 = {
                    name = "",
                    text = {
                        "{C:inactive}*Her sprite looks bad...",
                        "{C:inactive}even when comparing",
                        "{C:inactive}to other in this mod.*"
                    }
                },
                j_jand_hapoten_4 = {
                    name = "",
                    text = {
                        "{C:white,X:red}DIE{}!!! Go {C:white,X:red}die{} in a",
                        "big hooooole of {C:diamonds}shit{}!",
                        "PUSSY!!!!!"
                    }
                }
            },
            Tutor = {
                extra_shop_keyb = {
                    name = "Fartass fork knife",
                    text = {
                        "I'm looking at someone... Who plays",
                        "with {C:purple}Revo's Vault{}!.. Or not. I don't",
                        "check for that. Regardless, you can check",
                        "the new {C:green}Jimbo&!{} shop by pressing the {C:attention}'G'{} key",
                        "on your {C:attention}board{} {C:inactive}(short for keyboard).{}",
                        "This is meant as a temporal compatibility",
                        "solution but also we can keep it lmao...",
                        "Remember... Restocks when beating a {C:attention}Boss Blind{}"
                    }
                }
            },
            Other = {
                jand_gemini = {
                    name = "Gemini",
                    text = {
                "This {C:attention}Joker{} is",
                "actually {C:attention}two",
                "{C:attention}Values{} of this Joker",
                "are {C:red}halved{} once split",
                "One can {C:red}not{} exist",
                "without another",
                "The {C:attention}copy{} doesn't take space"
                    }
                },
                jand_scratched = {
                    name = "Scratched",
                    text = {
                "Fixed {C:green}1 in 5{} chance",
                "this Joker {C:attention}retriggers{}"
                    }
                },
                jand_slippery = {
                    name = "Slippery",
                    text = {
                "Can't be moved after",
                "selecting the {C:attention}Blind{}",
                "Can be moved after",
                "beating the {C:attention}Blind{}"
                    }
                },
                jand_weight_d = {
                    name = "Weighted Down",
                    text = {
                "{C:red}Debuffed{} when on the {C:attention}right{}",
                "side of the card area",
                    }
                },
                jand_weight_u = {
                    name = "Weighted Up",
                    text = {
                "{C:red}Debuffed{} when on the {C:attention}left{}",
                "side of the card area",
                    }
                },
                jand_minty = {
                    name = "Minty",
                    text = {
                "Can't be {C:red}Debuffed{}",
                    }
                },
            },
    },
    misc = {
        labels = {
           jand_gemini = "Gemini",
           jand_scratched = "Scratched",
           jand_slippery = "Slippery",
           jand_weight_d = "Weighted Down",
           jand_weight_u = "Weighted Up",
           jand_minty = "Minty"
        }
    },
}
