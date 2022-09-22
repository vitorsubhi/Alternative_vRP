---dependency "flux" client_script "@flux/client.lua" 
fx_version "bodacious"
game "gta5"

ui_page "web-side/app.html"

shared_scripts {
	"@vrp/lib/utils.lua"
}

client_scripts {
	"client-side/*"
}

server_scripts {
	"server-side/*"
}

files {
	"web-side/*",
	"web-side/**/*",
	"web-side/**/**/*"
}
