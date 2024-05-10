fx_version 'adamant'
game 'gta5'
lua54 'yes'

author 'aintjb'
description 'JB Scripts | Discord link: https://discord.gg/ZyNuMCBeMh'

client_script 'client.lua'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}

shared_script {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua'
}