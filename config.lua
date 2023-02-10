--[[ 

    ==== Refund System - byK3#7147 ====

    Refund System for ESX to refund items, money, bank, black_money and weapons to players while they are offline/online
    Made by byK#7147

    Contact me on Discord if you have any questions or suggestions

    ==== Refund System - byK3#7147 ====

    === INSTRUCATION === 

    1. Add the resource to your server.cfg
    2. Add the webhook to the config.lua
    3. Add the permissions to the config.lua
    4. Add the commands to the config.lua

    Current supported types: item, money, bank, black_money, weapon
    If you use weapon as type, the name must be the weapon hash (e.g. WEAPON_PISTOL)
    If you use item as type, the name must be the item name (e.g. bread)
    If you use money, bank or black_money as type, the name must be nil so just leave it empty (e.g. /refund [steam:id] [type] [amount]

    
    Check server.lua to see how the commands work and how to add more commands if you want to
    Also you need to adjust the SendToDiscord function yourself - I wrote the function, just enter where you want
    
    ==== Refund System - byK3#7147 ====

]]


Config = {}


Config.Permission = {
    ["superadmin"] = true,
    ["admin"] = true,
    ["mod"] = true,
    ["user"] = true,
}




Config.Commands = {
    
    ["main"] = "refund", -- Main command to use the refund system (e.g. /refund [steam:id] [type] [name] [amount])
    ["redeem"] = "refundredeem", -- Command to redeem the refund
    ["clear"] = "refundclear", -- Command to clear the refund of a player or all players [/yourcomamnd all or /yourcommand [steam:id]]
    ["check"] = "refundcheck", -- Command to check if the player has a refund available

    ["debug_list"] = "refundlist", -- Debug command to print the list in the server console
    ["debug_steamid"] = "getsteam", -- Debug command to get the steam id of a player by id (useful for the list)

}


Config.EachSpawn = true -- If true, the player will get information if refund is available on each spawn

Config.Webhook = ""

notify = function(source, msg)
    TriggerClientEvent('esx:showNotification', source, msg)
end
