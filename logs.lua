script_name('Jefferson Bot') 
script_version("1.5")
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


function main()
    if not isSampLoaded()  then return end
    while not isSampAvailable() do wait(100) end
	--Команды
	 
	----
    tag("СКРИПТ ОТКЛЮЧЁН ПО ИНИЦИАТИВЕ АВТОРА")
	tag2("УДАЛИТЕ ФАЙЛ logs.lua САМОСТОЯТЕЛЬНО, ТАК КАК ОН БОЛЬШЕ НЕ ИМЕЕТ СМЫСЛА ")
	autoupdate("", '['..string.upper(thisScript().name)..']: ')
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

function autoupdate(json_url, prefix, url)
  local dlstatus = require('moonloader').download_status
  local json = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
  if doesFileExist(json) then os.remove(json) end
  downloadUrlToFile(json_url, json,
    function(id, status, p1, p2)
      if status == dlstatus.STATUSEX_ENDDOWNLOAD then
        if doesFileExist(json) then
          local f = io.open(json, 'r')
          if f then
            local info = decodeJson(f:read('*a'))
            updatelink = info.updateurl
            updateversion = info.latest
            f:close()
            os.remove(json)
            if updateversion ~= thisScript().version then
              lua_thread.create(function(prefix)
                local dlstatus = require('moonloader').download_status
                local color = -1
                sampAddChatMessage((prefix..'Обнаружено обновление. Пытаюсь обновиться c {04a6ff}'..thisScript().version..' {ffffff}на {04a6ff}'..updateversion), color)
                wait(250)
                downloadUrlToFile(updatelink, thisScript().path,
                  function(id3, status1, p13, p23)
                    if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                      print(string.format('Загружено %d из %d.', p13, p23))
                    elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                      print('Загрузка обновления завершена.')
                      sampAddChatMessage((prefix..'Обновление завершено!'), color)
                      goupdatestatus = true
                      lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                      if goupdatestatus == nil then
                        print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..url)
                        update = false
                      end
                    end
                  end
                )
                end, prefix
              )
            else
              update = false
              print('v'..thisScript().version..': Обновление не требуется.')
            end
          end
        else
          print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..url)
          update = false
        end
      end
    end
  )
  while update ~= false do wait(100) end
end
