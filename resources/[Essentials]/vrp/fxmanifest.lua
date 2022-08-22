fx_version "bodacious"
game "gta5"

ui_page "web-side/gui/index.html"

server_scripts {
	"server-side/**/**/*.lua"
}

client_scripts {
	"client-side/**/**/*.lua"
}

shared_scripts {
	"lib/vehicles.lua",
	"lib/itemlist.lua",
	"lib/utils.lua"
}

files {
	"web-side/**/**/*",
	"lib/**/**/*",
}

loadscreen "web-side/loading/index.html"