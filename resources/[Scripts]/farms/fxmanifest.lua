fx_version 'cerulean'
game 'gta5'
lua54 'yes'

client_scripts {
	"@vrp/lib/utils.lua",
	"client-side/**/**/*",
	"config.lua"
}

server_scripts {
	"@vrp/lib/itemlist.lua",
	"@vrp/lib/utils.lua",
	"server-side/**/**/*",
	"config.lua"
}