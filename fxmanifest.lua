--[[ 

    ==== Refund System - byK3#7147 ====

    Refund System for ESX to refund items, money, bank, black_money and weapons to players while they are offline/online
    Made by byK#7147

    Contact me on Discord if you have any questions or suggestions

    ==== Refund System - byK3#7147 ====

    Check config.lua for instructions

]]

fx_version 'cerulean'
author 'byK3- byK3#7147'
description 'Refund System for ESX to refund items, money, bank, black_money and weapons to players while they are offline/online'
version '1.0.0'


game 'gta5'

shared_script '@es_extended/imports.lua' -- Import ESX functions and objects to the resource, do not remove this line

client_scripts {
    'config.lua',
    'client.lua',
}

server_scripts {
    'config.lua',
    'server.lua',
}

file 'list.json' -- This is the file where the refunds are stored
