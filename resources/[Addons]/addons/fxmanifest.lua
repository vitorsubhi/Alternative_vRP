fx_version 'adamant'
game 'gta5'

this_is_a_map 'yes'

client_script {
	"client/**/**/*.lua"
}

files {
	'stream/**/**/*.ytyp',
	'metas/**/**/*.meta',
    'data/**/**/*.*',
	"xml/**/**/*.xml",
	"audio/**/**",
	"audio/**/**/*.awc"
}

data_file "INTERIOR_PROXY_ORDER_FILE" "metas/[Maps]/**/**/*.meta"
data_file "PED_METADATA_FILE" "metas/[Peds]/**/**/*.meta"
data_file 'SHOP_PED_APPAREL_META_FILE' 'metas/[Clothes]/*.meta'

data_file 'WEAPONINFO_FILE' 'metas/[WEAPONS]/**/**/weapons.meta'
data_file 'WEAPON_METADATA_FILE' 'metas/[WEAPONS]/**/**/weaponarchetypes.meta'
data_file 'WEAPON_SHOP_INFO' 'metas/[WEAPONS]/**/**/shop_weapon.meta'
data_file 'WEAPON_ANIMATIONS_FILE' 'metas/[WEAPONS]/**/**/weaponanimations.meta'
data_file 'CONTENT_UNLOCKING_META_FILE' 'metas/[WEAPONS]/**/**/contentunlocks.meta'
data_file 'LOADOUTS_FILE' 'metas/[WEAPONS]/**/**/loadouts.meta'
data_file 'PED_PERSONALITY_FILE' 'metas/[WEAPONS]/**/**/pedpersonality.meta'

data_file "AUDIO_WAVEPACK" "audio/**/**/dlc_lfasound"
data_file "AUDIO_GAMEDATA" "audio/**/**/lfasound_game.dat"
data_file "AUDIO_SOUNDDATA" "audio/**/**/lfasound_sounds.dat"

data_file 'DLC_ITYP_REQUEST' 'stream/[Maps]/**/**/*.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/[Props]/**/**/*.ytyp'

data_file 'HANDLING_FILE' 'data/**/**/handling.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/**/**/vehiclelayouts.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/**/**/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/**/**/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/**/**/carvariations.meta'