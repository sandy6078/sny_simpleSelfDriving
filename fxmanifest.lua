fx_version 'cerulean'
game 'gta5'

name 'sny_simpleSelfDriving'
author 'SANDY#6078'
url 'https://github.com/sandy6078/sny_simpleSelfDriving'
description 'Standalone simple self driving resource'
version '1.1.1'

ui_page 'client/html/index.html'

files {
    'client/html/sounds/*.mp3',
    'client/html/js/*.js',
    'client/html/*.html'
}

shared_scripts {
    'lang/*.json',
    'config.lua',
    'shared/functions/sh_fn_main.lua',
}

client_scripts {
    'client/functions/cl_fn_main.lua',
    'client/cl_main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/functions/sv_fn_common.lua',
    'server/objects/sv_obj_vehicle.lua',
    'server/functions/sv_fn_main.lua',
    'server/sv_main.lua',
    'server/functions/sv_fn_export.lua'
}

dependencies {
	'oxmysql'
}