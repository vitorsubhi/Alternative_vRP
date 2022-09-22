fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
	"@vrp/lib/itemlist.lua",
	"@vrp/lib/utils.lua"
}

client_scripts {
	"client-side/**/**/*",
	"config.lua"
}

server_scripts {
	"server-side/**/**/*",
	"config.lua"
}