-- Resource Metadata
fx_version 'bodacious'
games { 'gta5' }

author 'Pravda'
description 'Blue Marlin Commands'
version '1.0.0'

client_scripts {
    'client/bm_c_commands.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
    'server/bm_s_commands.lua',
}


