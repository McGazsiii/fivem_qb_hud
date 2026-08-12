fx_version 'adamant'
game 'gta5'
version '1.2.4'
author 'https://github.com/Delarmuss'
description 'Status hud by delarmuss'

client_scripts {
	'client.lua',
	'config.lua'
}
server_scripts {
	'server.lua',
	'@oxmysql/lib/MySQL.lua'
}
shared_scripts {
	'@qb-core/shared/locale.lua',
}
ui_page'ui/ui.html'
files{
	"ui/css/*.css",
	"ui/font/*.ttf",
	"ui/img/*.svg",
	"ui/js/*.js",
	"ui/*.html"
}