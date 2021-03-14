-- https://wiki.fivem.net/wiki/Resource_manifest

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Identity'

version '1.0.3'

client_script 'client/main.lua'

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"@es_extended/locale.lua",
	"server/main.lua"
}

ui_page 'html/index.html'

files {
'html/script.js',
'html/index.html',
'html/cursor.png',
'html/css/animate.css',
'html/css/style.css',
'html/img/ladne_bg_4k.jpg',
'html/js/bootstrap-notify.min.js',
'html/js/inputmask.js',
'html/js/main.js',
'html/js/particles.json',
'html/js/particles.min.js',
'html/dist/min/jquery.inputmask.bundle.min.js',
'html/dist/min/inputmask/inputmask.date.extensions.min.js',
'html/dist/min/inputmask/inputmask.extensions.min.js',
'html/dist/min/inputmask/inputmask.min.js',
'html/dist/min/inputmask/inputmask.numeric.extensions.min.js',
'html/dist/min/inputmask/inputmask.phone.extensions.min.js',
'html/dist/min/inputmask/inputmask.regex.extensions.min.js',
'html/dist/min/inputmask/jquery.inputmask.min.js',
'html/dist/min/inputmask/dependencyLibs/inputmask.dependencyLib.jqlite.min.js',
'html/dist/min/inputmask/dependencyLibs/inputmask.dependencyLib.jquery.min.js',
'html/dist/min/inputmask/dependencyLibs/inputmask.dependencyLib.min.js',
'html/dist/min/inputmask/global/document.min.js',
'html/dist/min/inputmask/global/window.min.js',
'html/dist/min/inputmask/phone-codes/phone-be.min.js',
'html/dist/min/inputmask/phone-codes/phone-nl.min.js',
'html/dist/min/inputmask/phone-codes/phone-ru.min.js',
'html/dist/min/inputmask/phone-codes/phone-uk.min.js',
'html/dist/min/inputmask/phone-codes/phone.min.js'
}
