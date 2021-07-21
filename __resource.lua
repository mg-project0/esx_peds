resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependencies {
  'es_extended'
}

client_scripts {
  "src/RMenu.lua",
  "src/menu/RageUI.lua",
  "src/menu/Menu.lua",
  "src/menu/MenuController.lua",
  "src/components/*.lua",
  "src/menu/elements/*.lua",
  "src/menu/items/*.lua",
  "src/menu/panels/*.lua",
  "src/menu/windows/*.lua",

  'config.lua',
  'client.lua'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',

  'config.lua',
  'server.lua'
}

