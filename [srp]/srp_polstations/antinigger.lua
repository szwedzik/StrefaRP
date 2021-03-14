-- Working for Lynx 8.0 Pre-release build # 17619
-- DO NOT EDIT THESE FILES!
RegisterServerEvent('antilynx8:anticheat')
AddEventHandler('antilynx8:anticheat', function(meme, memename)
    --TriggerEvent('_chat:messageEntered', "Anti Lynx", { 141, 211, 255 }, "Kicked Player ID: "..meme.." "..memename)
    TriggerEvent("srp_anticheat:AutoBan", source)
    --DropPlayer(source,"PlayerID: "..meme ..' Anti Lynx Protection Enabled!')
end)