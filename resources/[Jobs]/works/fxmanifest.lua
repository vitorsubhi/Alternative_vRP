fx_version "bodacious"
game "gta5"

ui_page "web-side/index.html"

shared_script {"@vrp/lib/utils.lua"}

client_scripts {
	"config.lua",
	"client-side/**/**/*.lua"
}

server_scripts {
	"@vrp/lib/itemlist.lua",
	"config.lua",
	"server-side/**/**/*.lua"
}

files {
	"web-side/**/*"
}