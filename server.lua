AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    loadDatabase()
    SendToDiscord(65280, '**REFUND SYSTEM**', 'Refund System started - file loaded')
end)

list = {}

loadDatabase = function()
    local file = json.decode(LoadResourceFile(GetCurrentResourceName(), "list.json")) or {}

    list = file

end


saveDatabase = function()
    SaveResourceFile(GetCurrentResourceName(), 'list.json', json.encode(list), -1)
end

ESX.RegisterServerCallback('getGroup:data', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()

    if Config.Permission[group] then
        print ('Permission granted')
    end
end)

isAdmin = function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()

    if Config.Permission[group] then
        return true
    else
        return false
    end
end

RegisterCommand('refund', function(source, args, rawCommand)
    if isAdmin(source) then
        local target = args[1]
        local type = args[2]
        local name = args[3]
        local amount = args[4]

        print ('Refund started')

        if string.sub(target, 1, 6) ~= 'steam:' and string.sub(target, 1, 9) ~= 'license:' then
            print ('Invalid target')
            return
        else
            print ('Target: ' .. target)
        end

        if type ~= 'item' and type ~= 'money' and type ~= 'bank' and type ~= 'black_money' and type ~= 'weapon' then
            print ('Invalid type')
            return
        else
            print ('Type: ' .. type)
        end

        if type == 'item' then
            if name == nil then
                print ('Invalid name')
                return
            else
                print ('Name: ' .. name)
            end
        end

        if type == 'money' or type == 'bank' or type == 'black_money' then
            amount = args[3]
            name = nil
        end

        if type == 'weapon' then
            if name == nil then
                print ('Invalid name')
                return
            else
                print ('Name: ' .. name)
            end
        end


        if amount == nil or not tonumber(amount) or tonumber(amount) <= 0 then
            print ('Invalid amount')
            return
        else
            print ('Amount: ' .. amount)
        end


        local data = {
            target = target,
            type = type,
            name = name,
            amount = amount
        }

        table.insert(list, data)
        saveDatabase()
    end
end, false)


ESX.RegisterServerCallback('checkrefund:data', function(source, cb)
    checkRefund(source)
end)


checkRefund = function(source)
    for k,v in ipairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, 6) == "steam:" or string.sub(v, 1, 9) == "license:" then
            identifier = v
            break
        end
    end

    local license = identifier

    for i = 1, #list do
        if list[i].target == license then
            notify(source, 'You have a refund waiting for you, type ' .. Config.Commands.redeem .. ' to get it')
            return
        end
    end

end

RegisterCommand(Config.Commands.check, function(source, args, rawCommand)
    checkRefund(source)
end, false)


RegisterCommand(Config.Commands.redeem, function(source, args, rawCommand)
    getRefund(source)
end, false)




getRefund = function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    for k,v in ipairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, 6) == "steam:" or string.sub(v, 1, 9) == "license:" then
            identifier = v
            break
        end
    end

    local license = identifier

    for i = 1, #list do
        if list[i].target == license then
            if list[i].type == 'item' then
                xPlayer.addInventoryItem(list[i].name, list[i].amount)
            elseif list[i].type == 'money' then
                xPlayer.addMoney(list[i].amount)
            elseif list[i].type == 'bank' then
                xPlayer.addAccountMoney('bank', list[i].amount)
            elseif list[i].type == 'black_money' then
                xPlayer.addAccountMoney('black_money', list[i].amount)
            elseif list[i].type == 'weapon' then
                xPlayer.addWeapon(list[i].name, list[i].amount)
            end
            table.remove(list, i)
            saveDatabase()

            notify(source, 'You have redeemed your refund')
        end
    end

    notify(source, 'You have no refund')
    return
end

RegisterCommand(Config.Commands.redeem, function(source, args, rawCommand)
    getRefund(source)
end, false)



RegisterCommand(Config.Commands.clear, function(source, args, rawCommand)
    if isAdmin(source) then
        local target = args[1]

        if target == 'all' then
            list = {}
            saveDatabase()
            notify(source, 'Refund list cleared')
        else
            for i = 1, #list do
                if list[i].target == target then
                    table.remove(list, i)
                    saveDatabase()
                    notify (source, 'Refund of:  ' .. target .. ' cleared')
                end
            end
        end
    end
end, false)


RegisterCommand(Config.Commands.debug_list, function(source, args, rawCommand)
    if isAdmin(source) then
        print(json.encode(list))
    end
end, false)


RegisterCommand(Config.Commands.debug_steamid , function(source, args, rawCommand)
    local idargs = args[1]

    for k,v in ipairs(GetPlayerIdentifiers(idargs))do
        if string.sub(v, 1, 6) == "steam:" then
            identifier = v
            break
        end
    end

    if identifier == nil then
        print ('Steam not found')
    else
        print ('Steam ID is: ' .. identifier)
    end
end, false)



SendToDiscord = function(color, title, msg)
    local embed = {
        { -- 16711680 = red, 65280 = green, 16776960 = yellow, 255 = white (default)
            ["color"] = color,
            ["title"] = title,
            ["description"] = msg,
            ["footer"] = {
                ["text"] = os.date("%c") .. " | Refund System | from: byK3",
            },
        }
    }
    local data = {
        ["username"] = "Refund",
        ["embeds"] = embed
    }
    PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode(data), { ['Content-Type'] = 'application/json' })
end