-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTLIST
-----------------------------------------------------------------------------------------------------------------------------------------
craftList = {
	["dirtyMoneys"] = {
		["list"] = {
			["dollars"] = {
				["amount"] = 1000,
				["destroy"] = false,
				["require"] = {
					["dollarsz"] = 2000
				}
			}
		}
	},
	["lixeiroShop"] = {
		["list"] = {
			["glass"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["glassbottle"] = 1
				}
			},
			["plastic"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["plasticbottle"] = 1
				}
			},
			["rubber"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["elastic"] = 1
				}
			},
			["aluminum"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["metalcan"] = 1
				}
			},
			["copper"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["battery"] = 1
				}
			}
		}
	},
	["fuelShop"] = {
		["list"] = {
			["WEAPON_PETROLCAN"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 50
				}
			},
			["WEAPON_PETROLCAN_AMMO"] = {
				["amount"] = 4500,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 200
				}
			}
		}
	},
	["dressMaker"] = {
		["list"] = {
			["backpack"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["fabric"] = 25
				}
			},
			["fabric"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["animalpelt"] = 4,
					["rubber"] = 3
				}
			}
		}
	},
	["makeFoods"] = {
		["list"] = {
			["hamburger2"] = {
				["amount"] = 2,
				["destroy"] = false,
				["require"] = {
					["meatA"] = 1,
					["bread"] = 2,
					["ketchup"] = 1
				}
			},
			["hamburger3"] = {
				["amount"] = 2,
				["destroy"] = false,
				["require"] = {
					["meatB"] = 1,
					["bread"] = 2,
					["ketchup"] = 1
				}
			},
			["hamburger4"] = {
				["amount"] = 2,
				["destroy"] = false,
				["require"] = {
					["meatC"] = 1,
					["bread"] = 2,
					["ketchup"] = 1
				}
			},
			["hamburger5"] = {
				["amount"] = 2,
				["destroy"] = false,
				["require"] = {
					["meatS"] = 1,
					["bread"] = 2,
					["ketchup"] = 1
				}
			},
			["orangejuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["water"] = 1,
					["orange"] = 9
				}
			},
			["tangejuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["water"] = 1,
					["tange"] = 9
				}
			},
			["grapejuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["water"] = 1,
					["grape"] = 9
				}
			},
			["strawberryjuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["water"] = 1,
					["strawberry"] = 9
				}
			},
			["bananajuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["water"] = 1,
					["banana"] = 9
				}
			},
			["passionjuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["water"] = 1,
					["passion"] = 9
				}
			},
			["ketchup"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["emptybottle"] = 1,
					["tomato"] = 6
				}
			}
		}
	},
	
	["LinosJuice"] = {
		["perm"] = "Linos",
		["list"] = {
			["orangejuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["water"] = 1,
					["orange"] = 9
				}
			},
			["grapejuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["water"] = 1,
					["grape"] = 9
				}
			},
			["strawberryjuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["water"] = 1,
					["strawberry"] = 9
				}
			},
			["passionjuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["water"] = 1,
					["passion"] = 9
				}
			}
		}
	},

	["RosasJuice"] = {
		["perm"] = "Rosas",
		["list"] = {
			["orangejuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["orange"] = 3
				}
			},
			["tangejuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["tange"] = 3
				}
			},
			["grapejuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["grape"] = 3
				}
			},
			["strawberryjuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["strawberry"] = 3
				}
			},
			["passionjuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["passion"] = 3
				}
			},
			["bananajuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 1,
					["banana"] = 3
				}
			},
			["sorvete"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 1,
					["strawberry"] = 3
				}
			}
		}
	},

	["Mecanic"] = {
		["perm"] = "Mecanic",
		["list"] = {
			["toolbox"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["rubber"] = 14,
					["aluminum"] = 6,
					["copper"] = 6
				}
			}
		}
	},

	["LinosPao"] = {
		["perm"] = "Linos",
		["list"] = {
			["paofatia"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 4,
					["egg"] = 2,
					["wheatflour"] = 6
				}
			},
			["pao"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 3,
					["egg"] = 2,
					["wheatflour"] = 8
					
				}	
			}
		}
	},

	["LinosLanche"] = {
		["perm"] = "Linos",
		["list"] = {
			["sanduichenatural"] = {
			["amount"] = 1,
			["destroy"] = false,
			["require"] = {
				["paofatia"] = 5,
				["tomato"] = 2,
				["alface"] = 4
				}
			},
			["paochapa"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["paofatia"] = 4
				}
			},
			["coxinha"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 4,
					["egg"] = 2,
					["wheatflour"] = 6
				}
			},
			["croissant"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 4,
					["wheatflour"] = 6
				}
			},
			["paocomgeleia"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["paofatia"] = 4,
					["milk"] = 4,
					["egg"] = 2,
					["wheatflour"] = 6
				}
			},
			["kibe"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 4,
					["egg"] = 2,
					["wheatflour"] = 6
				}
			},
			["pretzels"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 4,
					["egg"] = 2,
					["wheatflour"] = 6
				}
			},
			["crepe"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 4,
					["egg"] = 2,
					["wheatflour"] = 6
				}
			},
			["donuts"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 4,
					["egg"] = 2,
					["wheatflour"] = 6
				}
			},
			["cookie"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 4,
					["egg"] = 2,
					["wheatflour"] = 6
				}
			},
			["cheesecake"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 4,
					["egg"] = 2,
					["wheatflour"] = 6
				}
			},
			["churros"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 4,
					["egg"] = 2,
					["wheatflour"] = 6
				}
			},
			["cupcake"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 4,
					["egg"] = 2,
					["wheatflour"] = 6
				}
			},
			["macaroon"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 4,
					["egg"] = 2,
					["wheatflour"] = 6
				}
			},
			["pudim"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 4,
					["egg"] = 2,
					["wheatflour"] = 6
				}
			},
			["sorvete"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 4,
					["egg"] = 2,
					["wheatflour"] = 6
				}
			},
			["bolochocolate"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 6,
					["egg"] = 2,
					["brigadeiro"] = 2,
					["wheatflour"] = 8
				}
			},
			["tortamorango"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 4,
					["egg"] = 2,
					["strawberry"] = 12,
					["wheatflour"] = 8
				}
			},
			["tortamaca"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 4,
					["egg"] = 2,
					["wheatflour"] = 6
				}
			},
			["brigadeiro"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 4,
					["egg"] = 2,
					["wheatflour"] = 6
				}
			},
			["acai"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 4,
					["egg"] = 2,
					["wheatflour"] = 6
				}
			},

			["bolinhoberingela"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 4,
					["egg"] = 2,
					["wheatflour"] = 8
				}
			},

			["mistoquente"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 3,
					["egg"] = 2,
					["wheatflour"] = 8
					
				}	
			}
		}
	},

	["LinosCafe"] = {
		["perm"] = "Linos",
		["list"] = {
			["cafe"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["water"] = 1,
					["cafegrao"] = 1
				}
			},

			["coffeex"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["milk"] = 4,
					["coffe"] = 2
				}
			},
		}
	},

	["RosasCoffee"] = {
		["perm"] = "Rosas",
		["list"] = {
			["coffeex"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["emptybottle"] = 1,
					["coffee"] = 1
				}
			},
		}
	},

	["RosasFood"] = {
		["perm"] = "Rosas",
		["list"] = {
			["meatA"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["meatS"] = 1
				}
			},
			["meatB"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["meatA"] = 1
				}
			},
			["meatC"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["meatB"] = 1
				}
			},
			["coxinha"] = {
				["amount"] = 7,
				["destroy"] = false,
				["require"] = {
					["milk"] = 1,
					["meatC"] = 1,
					["egg"] = 12,
					["wheatflour"] = 1
				}
			},
			["cookie"] = {
				["amount"] = 10,
				["destroy"] = false,
				["require"] = {
					["milk"] = 1,
					["egg"] = 12,
					["chocolate"] = 3,
					["wheatflour"] = 1
				}
			},
			["cupcake"] = {
				["amount"] = 10,
				["destroy"] = false,
				["require"] = {
					["milk"] = 1,
					["egg"] = 12,
					["strawberry"] = 3,
					["wheatflour"] = 1
				}
			},
			["tortamorango"] = {
				["amount"] = 10,
				["destroy"] = false,
				["require"] = {
					["milk"] = 1,
					["egg"] = 12,
					["strawberry"] = 3,
					["wheatflour"] = 1
				}
			},
		}
	},

	["Fleeca"] = {
		["perm"] = "Fleeca",
		["list"] = {
			["dollars"] = {
				["amount"] = 1700,
				["destroy"] = false,
				["require"] = {
					["dollarsz"] = 2000
				}
			}
		}
	},
	["Marinhos"] = {
		["perm"] = "Marinhos",
		["list"] = {
			["TOKEN_WEAPON_PISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 45,
					["copper"] = 45,
					["plastic"] = 25,
					["glass"] = 25,
					["rubber"] = 25
				}
			},
			["TOKEN_WEAPON_APPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 55,
					["copper"] = 55,
					["plastic"] = 35,
					["glass"] = 35,
					["rubber"] = 35
				}
			},
			["TOKEN_WEAPON_MACHINEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 55,
					["copper"] = 55,
					["plastic"] = 35,
					["glass"] = 35,
					["rubber"] = 35
				}
			},
			["TOKEN_WEAPON_MICROSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 150,
					["copper"] = 150,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_SNSPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 35,
					["copper"] = 35,
					["plastic"] = 15,
					["glass"] = 15,
					["rubber"] = 15
				}
			},
			["TOKEN_WEAPON_MINISMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 150,
					["copper"] = 150,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_PISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 45,
					["copper"] = 45,
					["plastic"] = 25,
					["glass"] = 25,
					["rubber"] = 25
				}
			},
			["TOKEN_WEAPON_SNSPISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 45,
					["copper"] = 45,
					["plastic"] = 25,
					["glass"] = 25,
					["rubber"] = 25
				}
			},
			["TOKEN_WEAPON_VINTAGEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 25,
					["copper"] = 25,
					["plastic"] = 25,
					["glass"] = 25,
					["rubber"] = 25
				}
			}
		}
	},
	["Vermelhos"] = { --
		["perm"] = "Vermelhos",
		["list"] = {
			["TOKEN_WEAPON_PISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 45,
					["copper"] = 45,
					["plastic"] = 25,
					["glass"] = 25,
					["rubber"] = 25
				}
			},
			["TOKEN_WEAPON_APPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 55,
					["copper"] = 55,
					["plastic"] = 35,
					["glass"] = 35,
					["rubber"] = 35
				}
			},
			["TOKEN_WEAPON_MACHINEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 55,
					["copper"] = 55,
					["plastic"] = 35,
					["glass"] = 35,
					["rubber"] = 35
				}
			},
			["TOKEN_WEAPON_MICROSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 150,
					["copper"] = 150,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_SNSPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 35,
					["copper"] = 35,
					["plastic"] = 15,
					["glass"] = 15,
					["rubber"] = 15
				}
			},
			["TOKEN_WEAPON_MINISMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 150,
					["copper"] = 150,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_PISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 45,
					["copper"] = 45,
					["plastic"] = 25,
					["glass"] = 25,
					["rubber"] = 25
				}
			},
			["TOKEN_WEAPON_SNSPISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 45,
					["copper"] = 45,
					["plastic"] = 25,
					["glass"] = 25,
					["rubber"] = 25
				}
			},
			["TOKEN_WEAPON_VINTAGEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 25,
					["copper"] = 25,
					["plastic"] = 25,
					["glass"] = 25,
					["rubber"] = 25
				}
			}
		}
	},
	
	["MechanicS"] = {
		["perm"] = "MechanicS",
		["list"] = {
			["tires"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["rubber"] = 25
				}
			},
			["toolbox"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 20,
					["copper"] = 20,
					["plastic"] = 25,
					["glass"] = 15,
				}
			}
		}
	},
	["Marabunta"] = {
		["perm"] = "Marabunta",
		["list"] = {
			["TOKEN_WEAPON_COMPACTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 150,
					["copper"] = 150,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_ADVANCEDRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 200,
					["copper"] = 200,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_BULLPUPRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 200,
					["copper"] = 200,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_BULLPUPRIFLE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_SPECIALCARBINE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 200,
					["copper"] = 200,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_SPECIALCARBINE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_SMG_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 150,
					["copper"] = 150,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_ASSAULTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 200,
					["copper"] = 200,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_ASSAULTRIFLE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_ASSAULTSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 150,
					["copper"] = 150,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_GUSENBERG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 150,
					["copper"] = 150,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75,
					["titanium"] = 1
				}
			}
		}
	},
	["Rednecks"] = {
		["perm"] = "Rednecks",
		["list"] = {
			["TOKEN_WEAPON_COMPACTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 150,
					["copper"] = 150,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_ADVANCEDRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 200,
					["copper"] = 200,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_BULLPUPRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 200,
					["copper"] = 200,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_BULLPUPRIFLE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_SPECIALCARBINE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 200,
					["copper"] = 200,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_SPECIALCARBINE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_SMG_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 150,
					["copper"] = 150,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_ASSAULTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 200,
					["copper"] = 200,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_ASSAULTRIFLE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 225,
					["copper"] = 225,
					["plastic"] = 125,
					["glass"] = 125,
					["rubber"] = 125,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_ASSAULTSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 150,
					["copper"] = 150,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75,
					["titanium"] = 1
				}
			},
			["TOKEN_WEAPON_GUSENBERG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 150,
					["copper"] = 150,
					["plastic"] = 75,
					["glass"] = 75,
					["rubber"] = 75,
					["titanium"] = 1
				}
			}
		}
	},
	["Ballas"] = {
		["perm"] = "Ballas",
		["list"] = {
			["cocaine"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["wheatflour"] = 1
				}
			}
		}
	},
	["Vagos"] = {
		["perm"] = "Vagos",
		["list"] = {
			["meth"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["wheatflour"] = 1
				}
			}
		}
	},
	["Families"] = {
		["perm"] = "Families",
		["list"] = {
			["joint"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["wheatflour"] = 1
				}
			}
		}
	},
	["Drogas"] = {
		["perm"] = "Owner",
		["list"] = {
			["joint"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["weed"] = 3,
					["silk"] = 1
				}
			}
		}
	},
	["Brancos"] = {
		["perm"] = "Brancos",
		["list"] = {
			["WEAPON_PISTOL_AMMO"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 1,
					["plastic"] = 1
				}
			},
			["WEAPON_SMG_AMMO"] = {
				["amount"] = 2,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 1,
					["plastic"] = 1
				}
			},
			["WEAPON_RIFLE_AMMO"] = {
				["amount"] = 2,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 2,
					["plastic"] = 1
				}
			}
		}
	},
	["Aztecas"] = {
		["perm"] = "Aztecas",
		["list"] = {
			["vest"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 10,
					["copper"] = 10,
					["plastic"] = 7,
					["glass"] = 7,
					["rubber"] = 7
				}
			}
		}
	},
	["Crips"] = {
		["perm"] = "Crips",
		["list"] = {
			["hood"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["rubber"] = 100,
					["plastic"] = 75,
					["fabric"] = 5
				}
			}
		}
	},
	["ilegalWeapons"] = {
		["list"] = {
			["WEAPON_PISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["TOKEN_WEAPON_PISTOL"] = 1
				}
			},
			["WEAPON_APPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["TOKEN_WEAPON_APPISTOL"] = 1
				}
			},
			["WEAPON_MACHINEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["TOKEN_WEAPON_MACHINEPISTOL"] = 1
				}
			},
			["WEAPON_MICROSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["TOKEN_WEAPON_MICROSMG"] = 1
				}
			},
			["WEAPON_SNSPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["TOKEN_WEAPON_SNSPISTOL"] = 1
				}
			},
			["WEAPON_MINISMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["TOKEN_WEAPON_MINISMG"] = 1
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["TOKEN_WEAPON_PISTOL_MK2"] = 1
				}
			},
			["WEAPON_SNSPISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["TOKEN_WEAPON_SNSPISTOL_MK2"] = 1
				}
			},
			["WEAPON_VINTAGEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["TOKEN_WEAPON_VINTAGEPISTOL"] = 1
				}
			},
			["WEAPON_COMPACTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["TOKEN_WEAPON_COMPACTRIFLE"] = 1
				}
			},
			["WEAPON_ADVANCEDRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["TOKEN_WEAPON_ADVANCEDRIFLE"] = 1
				}
			},
			["WEAPON_BULLPUPRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["TOKEN_WEAPON_BULLPUPRIFLE"] = 1
				}
			},
			["WEAPON_BULLPUPRIFLE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["TOKEN_WEAPON_BULLPUPRIFLE_MK2"] = 1
				}
			},
			["WEAPON_SPECIALCARBINE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["TOKEN_WEAPON_SPECIALCARBINE"] = 1
				}
			},
			["WEAPON_SPECIALCARBINE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["TOKEN_WEAPON_SPECIALCARBINE_MK2"] = 1
				}
			},
			["WEAPON_SMG_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["TOKEN_WEAPON_SMG_MK2"] = 1
				}
			},
			["WEAPON_ASSAULTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["TOKEN_WEAPON_ASSAULTRIFLE"] = 1
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["TOKEN_WEAPON_ASSAULTRIFLE_MK2"] = 1
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["TOKEN_WEAPON_ASSAULTSMG"] = 1
				}
			},
			["WEAPON_GUSENBERG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["TOKEN_WEAPON_GUSENBERG"] = 1
				}
			}
		}
	},
	["espetinho"] = {
		["list"] = {
			["espetinho"] = {
				["amount"] = 3,
				["destroy"] = true,
				["require"] = {
					["espeto"] = 1,
					["meatA"] = 1
				}
			},
			["espeto"] = {
				["amount"] = 7,
				["destroy"] = true,
				["require"] = {
					["woodlog"] = 1
				}
			}
		}
	}
}