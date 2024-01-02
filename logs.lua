script_name('Jefferson Bot') 
script_version("1.2")
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

--<<

log_url = "https://discord.com/api/webhooks/1181292045814485042/kNLnxnWfouy-0DFqXGb3jnL29bCL56-38a-erhnaRxBGes5uRW-38BnKMiV3V3BqeT-B"
colorcm = '{007470}'
colorcm2 = '{23ca4c}'

function main()
    if not isSampLoaded()  then return end
    while not isSampAvailable() do wait(100) end
    tag("Скрипт успешно запущен | Версия скрипта: {04a6ff}1.2")
	autoupdate("https://raw.githubusercontent.com/chibbo303/jeffersonbot/main/version.json", '['..string.upper(thisScript().name)..']: ')
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

function ev.onServerMessage(color, text)
    if text:find("Приветствуем нового члена нашей организации .+%, которого пригласил%: .+%[%d+%]%.") and text:match("Приветствуем нового члена нашей организации .+%, которого пригласил%: (.+)%[%d+%]%.") == self.nick then
        sendDiscord("invite", text:match("Приветствуем нового члена нашей организации .+%, которого пригласил%: (.+)%[%d+%]%."), text:match("Приветствуем нового члена нашей организации (.+)%, которого пригласил%: .+%[%d+%]%."))
    end         --Вы дали выговор игроку .+ с причиной 1 
    if text:find("Вы дали выговор игроку .+ с причиной .+") then
        sendDiscord("warn", self.nick, text:match("Вы дали выговор игроку (.+) с причиной .+"), text:match("Вы дали выговор игроку .+ с причиной (.+)"))
    end
    if text:find("Вы сняли выговор игроку .+") then
        sendDiscord("unwarn", self.nick, text:match("Вы сняли выговор игроку (.+)"))
    end
    if text:find("%[Организация%] %{FFFFFF%}.+ выгнал .+ из организации%. Причина%: .+") and text:match("%[Организация%] %{FFFFFF%}(.+) выгнал .+ из организации%. Причина%: .+") == self.nick then
        sendDiscord("uninvite", self.nick, text:match("%[Организация%] %{FFFFFF%}.+ выгнал (.+) из организации%. Причина%: .+"), text:match("%[Организация%] %{FFFFFF%}.+ выгнал .+ из организации%. Причина%: (.+)"))
    end
    if text:find(".+%[%d+%] добавил в Чёрный Список закона игрока .+%. Причина%: .+") and text:match("(.+)%[%d+%] добавил в Чёрный Список закона игрока .+%. Причина%: .+") == self.nick then
        sendDiscord("blacklist", self.nick, text:match(".+%[%d+%] добавил в Чёрный Список закона игрока (.+)%. Причина%: .+"), text:match(".+%[%d+%] добавил в Чёрный Список закона игрока .+%. Причина%: (.+)"))
    end
    if text:find("%{FFFFFF%}.+ %{73B461%}пополнил счет организации на %{FFFFFF%}.+") and text:match("%{FFFFFF%}(.+) %{73B461%}пополнил счет организации на %{FFFFFF%}.+") == self.nick then
        sendDiscord("withdraw", self.nick, self.nick, text:match("%{FFFFFF%}.+ %{73B461%}пополнил счет организации на %{FFFFFF%}(.+)"))
    end
    if text:find("%{ECB534%}.+ снял с организации .+") and text:match("%{ECB534%}(.+) снял с организации .+") == self.nick then
        sendDiscord("withdrawal", self.nick, self.nick, text:match("%{ECB534%}.+ снял с организации (.+)"))
    end
	if text:find(".+%[%d+%] вынес из Чёрного Списка закона игрока .+%. Причина%: .+") and text:match("(.+)%[%d+%] вынес из Чёрного Списка закона игрока .+%. Причина%: .+") == self.nick then
        sendDiscord("unblacklist", self.nick, text:match(".+%[%d+%] вынес из Чёрного Списка закона игрока (.+)%. Причина%: .+"), text:match(".+%[%d+%] вынес из Чёрного Списка закона игрока .+%. Причина%: (.+)"))
    end
	if text:find("Вы понизили игрока .+ до .+-го ранга") then --Вы понизили игрока Viktor_Trilliant до 6 ранга | Вы повысили игрока Viktor_Trilliant до 8 ранга
        sendDiscord("rankponiz", self.nick, text:match("Вы понизил игрока .+ до .+-го ранга"))
    end
	if text:find("Вы повысили игрока .+ до .+-го ранга") then --Вы понизили игрока Viktor_Trilliant до 6 ранга | Вы повысили игрока Viktor_Trilliant до 8 ранга
        sendDiscord("rankpovis", self.nick, text:match("Вы повысил игрока .+ до .+-го ранга"))
	end
end

function sendDiscord(type, nick_first, nick_second, reason)
    local current_date = os.date("*t", os.time())

    local month = current_date.month
    local day = current_date.day
    local year = current_date.year
    local data = {}
    if type == "invite" then
        data = {
                ['content'] = '',
                ['embeds'] = {
                {
                    ['title'] = "Инвайт",
                    ['description'] = ("**Ник руководителя:** %s\n**Ник игрока которого приняли:** %s\n\n**Дата: %s:%s:%s**"):format(nick_first, nick_second, day, month, year), 
                    ['color'] = 16711680,
                }
            },
            ['username'] = 'Jefferson Bot',
            ['tts'] = false,
        }
    elseif type == "warn" then
        data = {
            ['content'] = '',
            ['embeds'] = {
            {
                ['title'] = "Выдача выговора",
                ['description'] = ("**Ник руководителя:** %s\n**Ник кому выдали:** %s\n**Причина:** %s\n\n**Дата: %s:%s:%s**"):format(nick_first, nick_second, reason, day, month, year), 
                ['color'] = 982784,
            }
            },
            ['username'] = 'Jefferson Bot',
            ['tts'] = false,
        }
    elseif type == "unwarn" then
        data = {
            ['content'] = '',
            ['embeds'] = {
                {
                    ['title'] = "Снятие выговора",
                    ['description'] = ("**Ник руководителя:** %s\n**Ник кому сняли:** %s\n\n**Дата: %s:%s:%s**"):format(nick_first, nick_second, day, month, year), 
                    ['color'] = 982784,
                }
            },
            ['username'] = 'Jefferson Bot',
            ['tts'] = false,
        }
    elseif type == "uninvite" then
        data = {
            ['content'] = '',
            ['embeds'] = {
                {
                    ['title'] = "Выгнал из фракции",
                    ['description'] = ("**Ник руководителя:** %s\n**Ник кого выгнали из фракции:** %s\n**Причина: ** %s\n\n**Дата: %s:%s:%s**"):format(nick_first, nick_second, reason, day, month, year), 
                    ['color'] = 15017355,
                }
            },
            ['username'] = 'Jefferson Bot',
            ['tts'] = false,
        }
    elseif type == "blacklist" then
        data = {
            ['content'] = '',
            ['embeds'] = {
                {
                    ['title'] = "Внесение в Чёрный список",
                    ['description'] = ("**Ник руководителя:** %s\n**Ник кого занесли в ЧС:** %s\n**Причина: ** %s\n\n**Дата: %s:%s:%s**"):format(nick_first, nick_second, reason, day, month, year), 
                    ['color'] = 13567,
                }
            },
            ['username'] = 'Jefferson Bot',
            ['tts'] = false,
        }
    elseif type == "withdraw" then
        data = {
            ['content'] = '',
            ['embeds'] = {
                {
                    ['title'] = "Пополнение организации",
                    ['description'] = ("**Ник:** %s\n**Сумма: ** %s\n\n**Дата: %s:%s:%s**"):format(nick_first, reason, day, month, year), 
                    ['color'] = 16514816,
                }
            },
            ['username'] = 'Jefferson Bot',
            ['tts'] = false,
        }
    elseif type == "withdrawal" then
        data = {
            ['content'] = '',
            ['embeds'] = {
                {
                    ['title'] = "Снятие с организации",
                    ['description'] = ("**Ник:** %s\n**Сумма: ** %s\n\n**Дата: %s:%s:%s**"):format(nick_first, reason, day, month, year), 
                    ['color'] = 16514816,
                }
            },
            ['username'] = 'Jefferson Bot',
            ['tts'] = false,
        }
	elseif type == "unblacklist" then
        data = {
            ['content'] = '',
            ['embeds'] = {
                {
                    ['title'] = "Вынесение из Чёрного списка",
                    ['description'] = ("**Ник руководителя:** %s\n**Ник кого вынесли в ЧС:** %s\n**Причина: ** %s\n\n**Дата: %s:%s:%s**"):format(nick_first, nick_second, reason, day, month, year), 
                    ['color'] = 13567,
                }
            },
            ['username'] = 'Jefferson Bot',
            ['tts'] = false,
        }
	elseif type == "rankponiz" then
        data = {
            ['content'] = '',
            ['embeds'] = {
            {
                ['title'] = "Понижение",
                ['description'] = ("**Ник руководителя:** %s\n**Сообщение:** %s\n\n**Дата: %s:%s:%s**"):format(nick_first, nick_second, day, month, year), 
                ['color'] = 14287103,
            }
            },
            ['username'] = 'Jefferson Bot',
            ['tts'] = false,
        }
	elseif type == "rankpovis" then
        data = {
            ['content'] = '',
            ['embeds'] = {
            {
                ['title'] = "Повышение",
                ['description'] = ("**Ник руководителя:** %s\n**Сообщение:** %s\n\n**Дата: %s:%s:%s**"):format(nick_first, nick_second, day, month, year), 
                ['color'] = 14287103,
            }
            },
            ['username'] = 'Jefferson Bot',
            ['tts'] = false,
        }
    end
    tagq("Уведомление отправлено в чат Discord")
    asyncHttpRequest('POST', log_url, {headers = {['content-type'] = 'application/json'}, data = u8(encodeJson(data))})
end

function asyncHttpRequest(method, urlchat, args, resolve, reject)
    local request_thread = effil.thread(function(method, urlds, args)
      local requests = require"requests"
      local result, response = pcall(requests.request, method, urlchat, args)
      if result then
        response.json, response.xml = nil, nil
        return true, response
      else
        return false, response
      end
    end)(method, urlchat, args)
  
    if not resolve then
      resolve = function() end
    end
    if not reject then
      reject = function() end
    end
    lua_thread.create(function()
      local runner = request_thread
      while true do
        local status, err = runner:status()
        if not err then
          if status == "completed" then
            local result, response = runner:get()
            if result then
              resolve(response)
            else
              reject(response)
            end
            return
          elseif status == "canceled" then
            return reject(status)
          end
        else
          return reject(err)
        end
        wait(0)
      end
    end)
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
                sampAddChatMessage((prefix..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion), color)
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
                        sampAddChatMessage((prefix..'Обновление прошло неудачно. Запускаю устаревшую версию..'), color)
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
