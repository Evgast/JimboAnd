return {
    descriptions = {
            Joker={
                --AZUMATSUBA
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
                --GIIKO
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
                --MEEEEEEEEEEEEWGENICS
                j_jand_meteor = {
                    name = "Small Meteor",
                    text = {
                        "Refreshed when beating",
                        "a {C:attention}Boss Blind{}",
                        "{C:inactive}(Currently: #1#)",
                        "-#2#-"
                    }
                },
                j_jand_meteor_alt = {
                    name = "Small Meteor",
                    text = {
                        "Copies a random {C:purple}Tarot{} when created,",
                        "can be used once, resfreshed when",
                        "beating a {C:attention}Boss Blind{}"
                    }
                },
                j_jand_bone = {
                    name = "Glowing Bone",
                    text = {
                        "Refreshed when beating",
                        "a {C:attention}Boss Blind{}",
                        "{C:inactive}(Currently: #1#)",
                        "-#2#-"
                    }
                },
                j_jand_bone_alt = {
                    name = "Glowing Bone",
                    text = {
                        "Copies a random {C:spectral}Spectral{} when created,",
                        "can be used once, resfreshed when",
                        "beating a {C:attention}Boss Blind{}"
                    }
                },
                j_jand_steven = {
                    name = "#3# Steven",
                    text = {
                        "Refreshed when beating",
                        "a {C:attention}Boss Blind{}",
                        "{C:inactive}(Currently: #1#)",
                        "-#2#-"
                    }
                },
                j_jand_steven_alt = {
                    name = "#1# Steven",
                    text = {
                        "Copies a random {C:attention}#1#{} when created,",
                        "can be used once, resfreshed when",
                        "beating a {C:attention}Boss Blind{}"
                    }
                },
                j_jand_slocker = {
                    name = "Storage Locker",
                    text = {
                        "Shops are skipped",
                        "Open a {C:attention}Mega Pack{} after",
                        "beating a {C:attention}Blind{}"
                    }
                },
                j_jand_akey = {
                    name = "Armory Key",
                    text = {
                        "When entering shop, open",
                        "random {C:attention}Normal Pack{}"
                    },
                    unlock = {
                        "Ask {C:attention}Beanies{} about this",
                    },
                },
                j_jand_glass_cannon = {
                    name = "Glass Cannon",
                    text = {
                        {
                            "First drawn hand each round",
                            "is turned to {C:attention}Glass Cards{}",
                            "{C:attention}Glass {C:green}probabilities{} are doubled"
                        },
                        {
                            "{C:inactive}Yes, I did forget about",
                            "{C:inactive}fragile challenge. Shut"
                        }
                    }
                },
                j_jand_fixed_cannon = {
                    name = {
                        "Glass Cannon",
                        "{s:0.7,C:inactive}(Fixed){}"
                    },
                    text = {
                        "If hand contains {C:attention}1{} Card",
                        "turn it to {C:attention}Glass Card"
                    },
                    unlock = {
                        "Ask {C:attention}Beanies{} about this",
                    },
                },
                j_jand_redacted = {
                    name = "Redacted",
                    text = {
                        "Hides most of {C:attention}Card Values{}"
                    }
                },
                j_jand_pbag = {
                    name = "Paper Bag",
                    text = {
                        "{C:red}Mult{} equals to {C:attention}Highest Value",
                        "of the {C:attention}Joker{} to the right",
                        "{C:red}+#1#{} Mult"
                    },
                    unlock = {
                        "Ask {C:attention}Beanies{} about this",
                    },
                },
                j_jand_arthur = {
                    name = "Arthur",
                    text = {
                        "Copies {C:attention}#1#{} random Jokers",
                        "Rerolls copied Jokers if no {C:blue}Hands",
                        "remains at the end of the round"
                    },
                    unlock = {
                        "{E:1,s:1.3}?????",
                    },
                },
            },
            Blind = {
                bl_jand_h_iii = {
                    name = "Hitler III",
                    text = {
                        "Small and Big Blinds",
                        "are Boss Blinds this ante",
                        "Only one skip is allowed"
                    }
                }
            },
            Shopkeeper = {
                sk_jand_nikola = {
                    name = "Nikola",
                    text = {
                        "Sells {C:attention}2{} {C:rare}Rare{} Jokers",
                        "each at cost of",
                        "{C:planet}3{} hand levels"
                    }
                },
                sk_jand_crows = {
                    name = "Shogunate of Birds",
                    text = {
                        "Offers {C:attention}3{} consumables",
                        "of random type",
                        "for {C:attention}free{}"
                    }
                },
                sk_jand_ika = {
                    name = "Ika",
                    text = {
                        "Sells {C:attention}2{} Booster Packs",
                        "{C:inactive,s:0.5}(Yes, that's it)"
                    }
                },
                sk_jand_sprue = {
                    name = "Sprue",
                    text = {
                        "Sells {C:attention}3{} Jokers",
                        "with {C:attention}Quirk Stickers{}"
                    }
                },
                sk_jand_hapoten = {
                    name = "Sprue",
                    text = {
                        "Sells {C:attention}3{} Jokers...",
                        "At a different price?"
                    }
                },
                --REVO'S VAULT CROSSY MOD
                --We're adding fucking moon knight apparently
                sk_jand_revo = {
                    name = {"Moon Knight",
                            "{C:inactive,s:0.6}Dracula owes him money{}"
                    },
                    text = {
                        "Ready to trade his",
                        "{C:purple}Random Bullshit{} for",
                        "your {C:purple}Random Bullshit{}",
                        "{C:inactive,s:0.6}(Printers for Jokers)"
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
                sk_jand_nikola_1 = {
                    name = "",
                    text = {
                        "Prrrmjau..."
                    }
                },
                sk_jand_nikola_2 = {
                    name = "",
                    text = {
                        "Mjau..."
                    }
                },
                sk_jand_nikola_3 = {
                    name = "",
                    text = {
                        "Prrrrrrrr..."
                    }
                },
                sk_jand_nikola_4 = {
                    name = "",
                    text = {
                        "..."
                    }
                },
                sk_jand_nikola_5 = {
                    name = "",
                    text = {
                        "Ma! Ma, there's a weird-"
                    }
                },
                --CROWS QUIPS
                sk_jand_crows_1 = {
                    name = "",
                    text = {
                        "Feel {C:attention}free{} to",
                        "{C:attention}take{} what you need!"
                    }
                },
                sk_jand_crows_2 = {
                    name = "",
                    text = {
                        "Help yourself to those",
                        "{C:attention}cards{} on the table",
                        "We picked them",
                        "{C:attention}nice and pona{},",
                        "just for you!"
                    }
                },
                sk_jand_crows_3 = {
                    name = "",
                    text = {
                        "Toki! The {C:attention}Shogunate{}",
                        "welcomes you!"
                    }
                },
                sk_jand_crows_4 = {
                    name = "",
                    text = {
                        "Crows, we're crows!",
                        "Not {C:inactive}ghosts{}...",
                        "Or {C:diamonds}pinecones{}..."
                    }
                },
                --IKA QUIPS . 
                sk_jand_ika_1 = {
                    name = "",
                    text = {
                        "Welcome to {C:attention}One-Eight-One{}!",
                        "What kinda '{C:attention}Yay! Yay!{}'",
                        "experience can we",
                        "offer you today?"
                    }
                },
                sk_jand_ika_2 = {
                    name = "",
                    text = {
                        "{C:inactive}*Your attempt at",
                        "{C:inactive}petting the dog",
                        "{C:inactive}didn't work out...*"
                    }
                },
                sk_jand_ika_3 = {
                    name = "",
                    text = {
                        "No, they don't {C:green}restock{}",
                        "when you buy them all...",
                    }
                },
                sk_jand_ika_4 = {
                    name = "",
                    text = {
                        "Too jaded to quip,",
                        "leave a tip"
                    }
                },
                --SPRUE QUIPS
                sk_jand_sprue_1 = {
                    name = "",
                    text = {
                        "Get your sweaty {C:blue}hands{}",
                        "off the {C:attention}cards{}!"
                    }
                },
                sk_jand_sprue_2 = {
                    name = "",
                    text = {
                        "So you're into weird",
                        "little {C:attention}stickers{}, aren't",
                        "you?"
                    }
                },
                sk_jand_sprue_3 = {
                    name = "",
                    text = {
                        "Mean quip that only",
                        "only poker {c:attention}larpers{}",
                        "can read"
                    }
                },
                sk_jand_sprue_4 = {
                    name = "",
                    text = {
                        "{C:inactive}*She's sleeping...",
                        "{C:inactive}during workhours????",
                        "{C:inactive}Scandalous...*"
                    }
                },
                --SECRET GIRL QUIPS (HAPOTEN (THERE'S NOTHING SECRET ABOUT HER IN THE MOD LMAO))
                sk_jand_hapoten_1 = {
                    name = "",
                    text = {
                        "Number {C:attention}1{} rated",
                        "{C:attention}hot single{} in your area"
                    }
                },
                sk_jand_hapoten_2 = {
                    name = "",
                    text = {
                        "{C:attention}Hapoten{} is your",
                        "{C:hearts}favorite{} character!"
                    }
                },
                sk_jand_hapoten_3 = {
                    name = "",
                    text = {
                        "{C:inactive}*Her sprite looks bad...",
                        "{C:inactive}even when comparing",
                        "{C:inactive}to other in this mod.*"
                    }
                },
                sk_jand_hapoten_4 = {
                    name = "",
                    text = {
                        "{C:white,X:red}DIE{}!!! Go {C:white,X:red}die{} in a",
                        "big hooooole of {C:diamonds}shit{}!",
                        "PUSSY!!!!!"
                    }
                },
                j_jand_revo_1 = {
                    name = "",
                    text = {
                        "RANDOM",
                        "{C:attention}BULLSHIT",
                        "GO!!!!"
                    }
                },
                j_jand_revo_2 = {
                    name = "",
                    text = {
                        "What the...",
                        "Fish."
                    }
                },
                j_jand_revo_3 = {
                    name = "",
                    text = {
                        "I don't know what I'm doing."
                    }
                },
                j_jand_revo_4 = {
                    name = "",
                    text = {
                        "Let me know if you see {C:mult}Dracula{}"
                    }
                },
                j_jand_revo_5 = {
                    name = "",
                    text = {
                        "Hello"
                    }
                },
            },
            JandDialogue = {
                beanies_tutor_1 = {
                    name = "",
                    text = {
                        "{C:attention}Science{}!!!"
                    }
                },
                beanies_tutor_2 = {
                    name = "",
                    text = {
                        "Scared you didn't I? You might say that",
                        "it's the 'random creepy man screaming",
                        "at you at the casino' factor, but..."
                    }
                },
                beanies_tutor_3 = {
                    name = "",
                    text = {
                        "I believe what really scared you is",
                        "that buzzword - {C:attention}'Science'{}!"
                    }
                },
                beanies_tutor_4 = {
                    name = "",
                    text = {
                        "But would you react the same way",
                        "if I said that {C:attention}science{} can help you",
                        "cheat in your weird fucked up poker game?"
                    }
                },
                beanies_tutor_5 = {
                    name = "",
                    text = {
                        "Your {C:red}'Jokers'{} for instance,",
                        "A {C:attention}science{} made the {c:attention}cards{}",
                        "and ink they're printed with."
                    }
                },
                beanies_tutor_6 = {
                    name = "",
                    text = {
                        "Now that your subpar gambling mind",
                        "is focused, I'll show you a collection",
                        "of {C:red}Beta Jokers{} I have on me."
                    }
                },
                beanies_tutor_7 = {
                    name = "",
                    text = {
                        "Click on one of these, and I'll",
                        "explain how I plan to become a",
                        "{C:money}billionaire{} at YOUR expense"
                    }
                },
                beanies_tutor2_1 = {
                    name = "",
                    text = {
                        "You may have noticed that these",
                        "wonderful things are {C:red}DETRIMENTAL{}",
                        "and are going to make your life worse."
                    }
                },
                beanies_tutor2_2 = {
                    name = "",
                    text = {
                        "Making your life worse than it",
                        "already is is a fit on itself.",
                        "You better bet that I'm proud!"
                    }
                },
                beanies_tutor2_3 = {
                    name = "",
                    text = {
                        "Speaking of fits, if you manage",
                        "to beat a run with a {C:red}Beta Joker{}",
                        "I will mass-produce a {C:attention}finished version{}.",
                        "{C:inactive,s:0.8}(These are actually beneficial!)"
                    }
                },
                beanies_tutor2_4 = {
                    name = "",
                    text = {
                        "Then you will be able to buy it",
                        "in shop, and I'll become a {C:money}billionaire{}",
                        "by abusing your addiction!"
                    }
                },
                beanies_tutor2_5 = {
                    name = "",
                    text = {
                        "Or you can click on the selected",
                        "{C:red}Beta Joker{} and puss out.",
                        "{C:inactive,s:0.8}(Ignore the button that lets you skip them)"
                    }
                },
                beanies_tutor2_6 = {
                    name = "",
                    text = {
                        "Did you catch everything?"
                    }
                },
                beanies_tutor2_7 = {
                    name = "",
                    text = {
                        "As expected. Well then..."
                    }
                },
                beanies_tutor2_8 = {
                    name = "",
                    text = {
                        "Perfect, go make some",
                        "horrible decisions!"
                    }
                },
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
                --
                arthur_info = {
                    name = "Arthur Extra Info",
                    text = {
                        "{C:attention}Highlight{} this Joker to view",
                        "copied Jokers' descriptions",
                        "Can't copy {C:attention}Scaling{} and",
                        "{C:legendary}Legendary{} Jokers"
                    }
                },
                hitler_mess = {
                    name = "Arthur Extra Info",
                    text = {
                        "{s:5}Hitler is back!"
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
            jand_minty = "Minty",
            k_jand_beta = "Beta",
        },
        dictionary = {
            k_jand_beta = "Beta",
            b_lab = "Lab",
            k_yup_ex = "Yup!",
            pck_azuma = "0.1 - Jimbo & Azumapack! (Yotsuba&!, Azumanga Daioh)",
            pck_giiko = "0.2 - Jimbo & Jabberwock Night! (GIMMIKO)",
            pck_mew = "0.3 - Jimbo & Mewgenics!",
            pck_curr_non = "Rhytm isn't right"
        }
    },
}
