-- Resource Metadata
fx_version 'bodacious'
games { 'gta5' }

author 'Pravda'
description 'Blue Marlin Trucker Job'
version '1.0.0'

client_scripts {
    'client/bm_c_trucker_signup.lua',
    'client/bm_c_trucker_truck.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
    'server/bm_s_trucker_signup.lua',
}


