fx_version "bodacious"
game "gta5"

ui_page "web-side/index.html"

shared_scripts {
	"@vrp/lib/itemlist.lua",
	"@vrp/lib/utils.lua"
}

client_scripts {
	"client-side/*"
}

server_scripts {
	"server-side/*"
}

files {
	"web-side/*"
}