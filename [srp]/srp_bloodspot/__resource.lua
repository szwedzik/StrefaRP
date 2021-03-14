resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts { 
	'client.lua',
	'config.lua'
}

server_scripts {

  '@mysql-async/lib/MySQL.lua',
  'server.lua',
  'config.lua'
}

dependencies {
  'essentialmode',
  'srp_notify'
}

ui_page "nui/ui.html"

files {
	"nui/ui.html",
	"nui/clear.png",
	"nui/blood.png",
	"nui/top.png",
	"nui/glass.png",
	"nui/background.png",
	
	"nui/js/samples.js",
	
	
	"nui/css/all.min.css", 
	"nui/css/solid.min.css", 
	"nui/css/regular.min.css", 
	"nui/css/brands.min.css", 
	"nui/css/fontawesome.min.css", 
	
	
	--fonts
	
	"nui/webfonts/fa-brands-400.eot",
	"nui/webfonts/fa-brands-400.svg",
	"nui/webfonts/fa-brands-400.ttf",
	"nui/webfonts/fa-brands-400.woff",
	"nui/webfonts/fa-brands-400.woff2",
	"nui/webfonts/fa-regular-400.eot",
	"nui/webfonts/fa-regular-400.svg",
	"nui/webfonts/fa-regular-400.ttf",
	"nui/webfonts/fa-regular-400.woff",
	"nui/webfonts/fa-regular-400.woff2",
	"nui/webfonts/fa-solid-900.eot",
	"nui/webfonts/fa-solid-900.svg",
	"nui/webfonts/fa-solid-900.ttf",
	"nui/webfonts/fa-solid-900.woff",
	"nui/webfonts/fa-solid-900.woff2",
}