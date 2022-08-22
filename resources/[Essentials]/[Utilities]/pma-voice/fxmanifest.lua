fx_version "cerulean"
game "gta5"
lua54 "yes"

ui_page "web-side/index.html"
shared_scripts {
	"shared/*.lua"
}

client_scripts {
	"client-side/**/**/*.lua"
}

server_scripts {
	"server-side/**/**/*.lua"
}

files {
	"web-side/ogg/*.ogg",
	"web-side/css/*.css",
	"web-side/js/*.js",
	"web-side/index.html"
}