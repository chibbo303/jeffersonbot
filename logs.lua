script_name('Jefferson Bot') 
script_version("1.4")
script_properties("work-in-pause")

require 'lib.sampfuncs'
require 'lib.moonloader'

local ev = require 'lib.samp.events'
local vkeys = require 'vkeys'
local ffi = require 'ffi'
local copas = require 'copas'
local lanes = require('lanes').configure()
local http = require 'copas.http'
local requests = require('requests')
local effil = require"effil"
local cjson = require"cjson"
local rkeys = require 'rkeys'

local encoding = require 'encoding'
encoding.default = 'CP1251'
local u8 = encoding.UTF8

-- >> Tags

    function tagerr(arg)
        sampAddChatMessage(("{04a6ff}[ Jefferson Bot | Ошибка ]: {FFFFFF}%s"):format(arg), 0x04a6ff)
    end

    function tagq(arg)
        sampAddChatMessage(("{04a6ff}[ Jefferson Bot | Информация ]: {FFFFFF}%s"):format(arg), 0x04a6ff)
    end

    function tag(arg)
        sampAddChatMessage(("{04a6ff}[ Jefferson Bot ]: {FFFFFF}%s"):format(arg), 0x04a6ff)
    end
	
	function tag2(arg)
        sampAddChatMessage(("{04a6ff}[ Jefferson Bot ]: {FFFFFF}%s"):format(arg), 0x04a6ff)
    end

--<<

log_url = ""

colorcm = '{04a6ff}'
colorcm2 = '{04a6ff}'
nazvanie = 'Jefferson Bot'

function main()
    if not isSampLoaded()  then return end
    while not isSampAvailable() do wait(100) end
	--Команды
	 
	----
    tag("Скрипт отключён по инициативе автора")
	tag2("Файл больше не действителен и может быть удалён")
	autoupdate("URL", '['..string.upper(thisScript().name)..']: ')
    while true do
        wait(0)
        id = select(2, sampGetPlayerIdByCharHandle(playerPed))
        self = {
            nick = sampGetPlayerNickname(id),
            score = sampGetPlayerScore(id),
            color = sampGetPlayerColor(id),
            ping = sampGetPlayerPing(id),
            gameState = sampGetGamestate()
        }
    end
end
