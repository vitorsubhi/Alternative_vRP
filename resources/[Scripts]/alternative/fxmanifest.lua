fx_version "bodacious"
game "gta5"

ui_page "web-side/index.html"

files {
	"web-side/index.html"
}

client_scripts {
	"@vrp/lib/utils.lua",
	"client-side/NativeUI/NativeUI.lua",
	"client-side/*.lua",
	"metas-side/**/**/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server-side/*.lua"
}

data_file "FIVEM_LOVES_YOU_4B38E96CC036038F" "metas-side/events/*.meta"
data_file "WEAPONINFO_FILE_PATCH" "metas-side/*.meta"