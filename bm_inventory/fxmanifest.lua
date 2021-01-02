-- Resource Metadata
fx_version 'bodacious'
games { 'gta5' }

author 'Pravda'
description 'Blue Marlin Inventory'
version '1.0.0'

client_scripts {
    'client/bm_c_inventory.lua',
}

ui_page('client/html/index.html')

files {
    'client/html/index.html',
    'client/html/inventory.js',
    'client/html/style.css',
    'client/html/fonts/Poppins-Bold.ttf',
    'client/html/fonts/Poppins-Medium.ttf',
    'client/html/fonts/pricedown.ttf',
    'client/html/images/item-1-null.png',
    'client/html/images/item-2-null.png',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
    'server/bm_s_inventory.lua',
}


