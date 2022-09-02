---dependency "flux" client_script "@flux/client.lua" 
fx_version "bodacious"
game "gta5"

ui_page "web-side/app.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server-side/*"
}

files {
	"web-side/*",
	"web-side/**/*",
	"web-side/**/**/*"
}
