fx_version 'cerulean'
game 'gta5'

author 'SANDY#6078'
description 'Standalone simple self driving resource'
version '1.0.1'

ui_page 'client/html/index.html'

files {
    'client/html/sounds/*.mp3',
    'client/html/js/*.js',
    'client/html/*.html'
}

shared_scripts {
    'lang/*.json',
    'config.lua',
}

client_scripts {
    'client/functions/cl_fn_main.lua',
    'client/cl_main.lua'
}