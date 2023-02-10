# refundsystem
  ==== Refund System - byK3#7147 ====

    Refund System for ESX to refund items, money, bank, black_money and weapons to players while they are offline/online
    Made by byK#7147

    Contact me on Discord if you have any questions or suggestions



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
