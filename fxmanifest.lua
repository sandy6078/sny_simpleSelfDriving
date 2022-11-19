fx_version 'cerulean'
game 'gta5'

author 'SANDY#6078'
description 'Standalone simple self driving resource'
version '1.0.0'

shared_scripts {
    'lang/*.json',
    'config.lua',
    'shared/functions/sh_fn_main.lua'
}

client_scripts {
    'client/functions/cl_fn_main.lua',
    'client/cl_main.lua'
}

server_scripts {
    'server/functions/sv_fn_main.lua',
    'server/sv_main.lua'
}