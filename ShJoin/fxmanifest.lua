fx_version 'adamant'
game 'gta5'

client_scripts {
    'client/RageUI/RMenu.lua',
    'client/RageUI/menu/RageUI.lua',
    'client/RageUI/menu/Menu.lua',
    'client/RageUI/menu/MenuController.lua',
    'client/RageUI/components/*.lua',
    'client/RageUI/menu/elements/*.lua',
    'client/RageUI/menu/items/*.lua',
    'client/RageUI/menu/panels/*.lua',
    'client/RageUI/menu/windows/*.lua',
    'client/client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/server.lua'
}