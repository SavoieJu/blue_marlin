-- Resource Metadata
fx_version 'bodacious'
games { 'gta5' }

author 'Pravda'
description 'Blue Marlin Create Character'
version '1.0.0'

client_scripts {
    'client/bm_c_createCharacter.lua',
}

ui_page('client/html/index.html')

files {
    'client/html/index.html',
    'client/html/createChar.js',
    'client/html/style.css',
    'client/html/fonts/Poppins-Bold.ttf',
    'client/html/fonts/Poppins-Medium.ttf',
    'client/html/fonts/pricedown.ttf',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
    'server/bm_s_createCharacter.lua',
}


