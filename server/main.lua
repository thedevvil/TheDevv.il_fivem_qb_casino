local QBCore = exports['qb-core']:GetCoreObject()

local ItemList = {
    ["casinochips"] = 1,
}

RegisterNetEvent('qb-casino:server:sell', function()
    local src = source
    local price = 0
    local Player = QBCore.Functions.GetPlayer(src)
    local xItem = Player.Functions.GetItemByName("casinochips")
    if xItem ~= nil then
        for k, v in pairs(Player.PlayerData.items) do
            if Player.PlayerData.items[k] ~= nil then
                if ItemList[Player.PlayerData.items[k].name] ~= nil then
                    price = 200 * Player.PlayerData.items[k].amount
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)

        Player.Functions.AddMoney("cash", price, "sold-casino-chips")
            TriggerClientEvent('QBCore:Notify', src, "Kazandığın para $"..price)
            TriggerEvent('um-customlog',"casino","Casino Chip","black","Kazandı: $"..price,src)
                end
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Chipe sahip değilsin..")
    end
end)


function SetExports()
exports["qb-blackjack"]:SetGetChipsCallback(function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    local Chips = Player.Functions.GetItemByName("casinochips")

    if Chips ~= nil then
        Chips = Chips
    end

    return TriggerClientEvent('QBCore:Notify', src, "Chipin yok..")
end)

    exports["qb-blackjack"]:SetTakeChipsCallback(function(source, amount)
        local Player = QBCore.Functions.GetPlayer(source)

        if Player ~= nil then
            Player.Functions.RemoveItem("casinochips", amount)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['casinochips'], "remove")
            TriggerEvent("qb-log:server:CreateLog", "casino", "Chips", "yellow", "**"..GetPlayerName(source) .. "** koymak $"..amount.." masada")
        end
    end)

    exports["qb-blackjack"]:SetGiveChipsCallback(function(source, amount)
        local Player = QBCore.Functions.GetPlayer(source)

        if Player ~= nil then
            Player.Functions.AddItem("casinochips", amount)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['casinochips'], "add")
            TriggerEvent("qb-log:server:CreateLog", "casino", "Chips", "red", "**"..GetPlayerName(source) .. "** got $"..amount.." masa masasından çifte kazandı")
        end
    end)
end

AddEventHandler("onResourceStart", function(resourceName)
	if ("qb-blackjack" == resourceName) then
        Citizen.Wait(1000)
        SetExports()
    end
end)

SetExports()
