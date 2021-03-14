
dependency 'es_extended'

ui_page "html/ui.html"

files {
  "html/ui.html",
  "html/js/index.js",
  "html/css/style.css",
  "html/css/pistol.png",
  "html/css/tlo.png"
}

client_script {
  '@es_extended/locale.lua',
  'client.lua'
}

server_script {
  '@es_extended/locale.lua',
  'server.lua'
}
