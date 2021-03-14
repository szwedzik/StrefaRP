local PlayerData = {}
ESX = nil

Citizen.CreateThread(function()
while ESX == nil do
  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
  Citizen.Wait(0)
end
end)
local lockHorizontal = false

Citizen.CreateThread(function() 
  while true do
    N_0xf4f2c0d4ee209e20() 
    Wait(1000)
  end 
end)
RegisterNetEvent('on:clotheshopa')
AddEventHandler('on:clotheshopa', function()
  TriggerEvent('skinchanger:getSkin', function(skin)
    SetNuiFocus( true, true )
    SendNUIMessage({
      czap1 = skin.helmet_1,
      czap2 = skin.helmet_2,
      kosz1 = skin.tshirt_1,
      kosz2 = skin.tshirt_2,
      tors1 = skin.torso_1,
      tors2 = skin.torso_2,
      ram1 = skin.arms,
      ram2 = skin.arms_2,
      spod1 = skin.pants_1,
      spod2 = skin.pants_2,
      but1 = skin.shoes_1,
      but2 = skin.shoes_2,
      deta1 = skin.decals_1,
      deta2 = skin.decals_2,
      dzialaj = true
    })
    end)
end)
RegisterCommand('testujsklepubr', function()
  lockHorizontal = true
  TriggerEvent('skinchanger:getSkin', function(skin)
    SetNuiFocus( true, true )
    SendNUIMessage({
      czap1 = skin.helmet_1,
      czap2 = skin.helmet_2,
      kosz1 = skin.tshirt_1,
      kosz2 = skin.tshirt_2,
      tors1 = skin.torso_1,
      tors2 = skin.torso_2,
      ram1 = skin.arms,
      ram2 = skin.arms_2,
      spod1 = skin.pants_1,
      spod2 = skin.pants_2,
      but1 = skin.shoes_1,
      but2 = skin.shoes_2,
      deta1 = skin.decals_1,
      deta2 = skin.decals_2,
      dzialaj = true
    })
    end)

  local kordy = GetEntityCoords(PlayerPedId())

end, false)
RegisterNUICallback('czapkalewo', function(data, cb) -- PRZESZUKJANIE
print('doszlo')
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.helmet_1
local czapka2 = nil
print(czapka)
if czapka > -1 then
  czapka2 = czapka - 1
end
if czapka == -1 then
  czapka2 = czapka
end
print(czapka2)
local clothesSkin = {
  ['helmet_1'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)
end)

RegisterNUICallback('czapkaprawo', function(data, cb) -- KAJDANKI
print('doszlo')
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.helmet_1
local czapka2 = nil
print(czapka)
if czapka < 134 then
  czapka2 = czapka + 1
end
if czapka == 134 then
  czapka2 = czapka
end
print(czapka2)
local clothesSkin = {
  ['helmet_1'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)
end)

RegisterNUICallback('koszlewo', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.tshirt_1
local czapka2 = nil
print(czapka)
if czapka > 0 then
  czapka2 = czapka - 1
end
if czapka == 0 then
  czapka2 = czapka
end
print(czapka2)
local clothesSkin = {
  ['tshirt_1'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)
cb('ok')
end)

RegisterNUICallback('koszprawo', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.tshirt_1
local czapka2 = nil
print(czapka)
if czapka < 340 then
  czapka2 = czapka + 1
end
if czapka == 340 then
  czapka2 = czapka
end
print(czapka2)
local clothesSkin = {
  ['tshirt_1'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)
cb('ok')
cb('ok')
end)
RegisterNUICallback('torslewo', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.torso_1
local czapka2 = nil
print(czapka)
if czapka > 0 then
  czapka2 = czapka - 1
end
if czapka == 0 then
  czapka2 = czapka
end
print(czapka2)
local clothesSkin = {
  ['torso_1'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)

end)

RegisterNUICallback('torsprawo', function(data, cb)
print('dzialaj torso prawo')
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.torso_1
local czapka2 = nil
print(czapka)
if czapka < 340 then
  czapka2 = czapka + 1
end
if czapka == 340 then
  czapka2 = czapka
end
print(czapka2)
local clothesSkin = {
  ['torso_1'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)

end)
RegisterNUICallback('spodlewo', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.pants_1
local czapka2 = nil
print(czapka)
if czapka > 0 then
  czapka2 = czapka - 1
end
if czapka == 0 then
  czapka2 = czapka
end
print(czapka2)
local clothesSkin = {
  ['pants_1'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)

end)

RegisterNUICallback('spodprawo', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.pants_1
local czapka2 = nil
print(czapka)
if czapka < 340 then
  czapka2 = czapka + 1
end
if czapka == 340 then
  czapka2 = czapka
end
print(czapka2)
local clothesSkin = {
  ['pants_1'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)

end)

RegisterNUICallback('butlew', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.shoes_1
local czapka2 = nil
print(czapka)
if czapka > 0 then
  czapka2 = czapka - 1
end
if czapka == 0 then
  czapka2 = czapka
end
print(czapka2)
local clothesSkin = {
  ['shoes_1'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)
cb('ok')
end)

RegisterNUICallback('butpraw', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.shoes_1
local czapka2 = nil
print(czapka)
if czapka < 340 then
  czapka2 = czapka + 1
end
if czapka == 340 then
  czapka2 = czapka
end
print(czapka2)
local clothesSkin = {
  ['shoes_1'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)

cb('ok')
end)

RegisterNUICallback('czap2lew', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.helmet_2
local czapka2 = nil
print(czapka)
czapka2 = czapka - 1

print(czapka2)
local clothesSkin = {
  ['helmet_2'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
end)
end)

RegisterNUICallback('czap2praw', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.helmet_2
local czapka2 = nil
print(czapka)
czapka2 = czapka + 1

print(czapka2)
local clothesSkin = {
  ['helmet_2'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)
end)

RegisterNUICallback('kosz2lew', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.tshirt_2
local czapka2 = nil
print(czapka)

czapka2 = czapka - 1

print(czapka2)
local clothesSkin = {
  ['tshirt_2'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)
cb('ok')
end)



RegisterNUICallback('kosz2praw', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.tshirt_2
local czapka2 = nil
print(czapka)

czapka2 = czapka + 1

print(czapka2)
local clothesSkin = {
  ['tshirt_2'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)
cb('ok')
end)

RegisterNUICallback('tors2lew', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.torso_2
local czapka2 = nil
print(czapka)

czapka2 = czapka - 1


print(czapka2)
local clothesSkin = {
  ['torso_2'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)

end)
RegisterNUICallback('tors2praw', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.torso_2
local czapka2 = nil
print(czapka)

czapka2 = czapka + 1


print(czapka2)
local clothesSkin = {
  ['torso_2'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)

end)

RegisterNUICallback('spod2lew', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.pants_2
local czapka2 = nil
print(czapka)

czapka2 = czapka - 1


print(czapka2)
local clothesSkin = {
  ['pants_2'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)

end)

RegisterNUICallback('spod2praw', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.pants_2
local czapka2 = nil
print(czapka)

czapka2 = czapka + 1


print(czapka2)
local clothesSkin = {
  ['pants_2'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)

end)
RegisterNUICallback('but2lew', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.shoes_2
local czapka2 = nil
print(czapka)

czapka2 = czapka - 1


print(czapka2)
local clothesSkin = {
  ['shoes_2'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)

end)
RegisterNUICallback('but2praw', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.shoes_2
local czapka2 = nil
print(czapka)

czapka2 = czapka + 1


print(czapka2)
local clothesSkin = {
  ['shoes_2'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)

end)
RegisterNUICallback('deta2lew', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.decals_2
local czapka2 = nil
print(czapka)

czapka2 = czapka - 1


print(czapka2)
local clothesSkin = {
  ['decals_2'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)

end)


RegisterNUICallback('detalew', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.decals_1
local czapka2 = nil
print(czapka)

czapka2 = czapka - 1


print(czapka2)
local clothesSkin = {
  ['decals_1'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)

end)


RegisterNUICallback('detapraw', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.decals_1
local czapka2 = nil
print(czapka)

czapka2 = czapka + 1


print(czapka2)
local clothesSkin = {
  ['decals_1'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)

end)

RegisterNUICallback('deta2praw', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.decals_2
local czapka2 = nil
print(czapka)

czapka2 = czapka + 1


print(czapka2)
local clothesSkin = {
  ['decals_2'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)

end)


RegisterNUICallback('ram2lew', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.arms_2
local czapka2 = nil
print(czapka)

czapka2 = czapka - 1


print(czapka2)
local clothesSkin = {
  ['arms_2'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)

end)

RegisterNUICallback('ramlew', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.arms
local czapka2 = nil
print(czapka)

czapka2 = czapka - 1


print(czapka2)
local clothesSkin = {
  ['arms'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)

end)
RegisterNUICallback('rampraw', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.arms
local czapka2 = nil
print(czapka)

czapka2 = czapka + 1


print(czapka2)
local clothesSkin = {
  ['arms'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)

end)
RegisterNUICallback('ram2praw', function(data, cb)
TriggerEvent('skinchanger:getSkin', function(skin)
local czapka = skin.arms_2
local czapka2 = nil
print(czapka)

czapka2 = czapka + 1


print(czapka2)
local clothesSkin = {
  ['arms_2'] = czapka2
}
TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

end)

end)

RegisterNUICallback('zapisz', function(data, cb)
  SetNuiFocus( false )
  SendNUIMessage({
    dzialaj = false
  })
 ESX.ShowNotification('Zapłacono ~g~50$ ~w~za ubrania')

TriggerServerEvent('payfor:clothesshop', source)

end)



RegisterNUICallback('zamknij', function(data, cb)
SetNuiFocus( false )
SendNUIMessage({
  dzialaj = false
})
end)