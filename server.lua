---------------------
-- ESX Declaration --
---------------------
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-------------------
-- Event BuyItem --
-------------------
RegisterNetEvent('esx_peds:buyItem')
AddEventHandler('esx_peds:buyItem', function(item, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() < price then TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez d'~r~argent") return end
    if xPlayer.getInventoryItem(item).count + 1 >= xPlayer.getInventoryItem(item).limit and not xPlayer.getInventoryItem(item).limit == -1 then TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez de place dans votre ~r~inventaire") return end
    xPlayer.removeMoney(price)
    xPlayer.addInventoryItem(item, 1)
    TriggerClientEvent('esx:showNotification', source, "Vous venez d'acheter un ~g~"..xPlayer.getInventoryItem(item).label)
end)
