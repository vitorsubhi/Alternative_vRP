fx_version "bodacious"
game "gta5"

dependencies {
    "PolyZone"
}

ui_page "web-side/index.html"

shared_scripts {
	"@vrp/lib/utils.lua"
}

client_scripts {
	"@PolyZone/client.lua",
	"@PolyZone/BoxZone.lua",
	"@PolyZone/EntityZone.lua",
	"@PolyZone/CircleZone.lua",
	"@PolyZone/ComboZone.lua",
	"client-side/*"
}

server_scripts {
	"server-side/*"
}



files {
	"web-side/*"
}