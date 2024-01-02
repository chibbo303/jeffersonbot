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
        sampAddChatMessage(("{04a6ff}[ Jefferson Bot | ������ ]: {FFFFFF}%s"):format(arg), 0x04a6ff)
    end

    function tagq(arg)
        sampAddChatMessage(("{04a6ff}[ Jefferson Bot | ���������� ]: {FFFFFF}%s"):format(arg), 0x04a6ff)
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
    tag("������ ������� ������� | ������ �������: {04a6ff}1.2")
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
    if text:find("������������ ������ ����� ����� ����������� .+%, �������� ���������%: .+%[%d+%]%.") and text:match("������������ ������ ����� ����� ����������� .+%, �������� ���������%: (.+)%[%d+%]%.") == self.nick then
        sendDiscord("invite", text:match("������������ ������ ����� ����� ����������� .+%, �������� ���������%: (.+)%[%d+%]%."), text:match("������������ ������ ����� ����� ����������� (.+)%, �������� ���������%: .+%[%d+%]%."))
    end         --�� ���� ������� ������ .+ � �������� 1 
    if text:find("�� ���� ������� ������ .+ � �������� .+") then
        sendDiscord("warn", self.nick, text:match("�� ���� ������� ������ (.+) � �������� .+"), text:match("�� ���� ������� ������ .+ � �������� (.+)"))
    end
    if text:find("�� ����� ������� ������ .+") then
        sendDiscord("unwarn", self.nick, text:match("�� ����� ������� ������ (.+)"))
    end
    if text:find("%[�����������%] %{FFFFFF%}.+ ������ .+ �� �����������%. �������%: .+") and text:match("%[�����������%] %{FFFFFF%}(.+) ������ .+ �� �����������%. �������%: .+") == self.nick then
        sendDiscord("uninvite", self.nick, text:match("%[�����������%] %{FFFFFF%}.+ ������ (.+) �� �����������%. �������%: .+"), text:match("%[�����������%] %{FFFFFF%}.+ ������ .+ �� �����������%. �������%: (.+)"))
    end
    if text:find(".+%[%d+%] ������� � ׸���� ������ ������ ������ .+%. �������%: .+") and text:match("(.+)%[%d+%] ������� � ׸���� ������ ������ ������ .+%. �������%: .+") == self.nick then
        sendDiscord("blacklist", self.nick, text:match(".+%[%d+%] ������� � ׸���� ������ ������ ������ (.+)%. �������%: .+"), text:match(".+%[%d+%] ������� � ׸���� ������ ������ ������ .+%. �������%: (.+)"))
    end
    if text:find("%{FFFFFF%}.+ %{73B461%}�������� ���� ����������� �� %{FFFFFF%}.+") and text:match("%{FFFFFF%}(.+) %{73B461%}�������� ���� ����������� �� %{FFFFFF%}.+") == self.nick then
        sendDiscord("withdraw", self.nick, self.nick, text:match("%{FFFFFF%}.+ %{73B461%}�������� ���� ����������� �� %{FFFFFF%}(.+)"))
    end
    if text:find("%{ECB534%}.+ ���� � ����������� .+") and text:match("%{ECB534%}(.+) ���� � ����������� .+") == self.nick then
        sendDiscord("withdrawal", self.nick, self.nick, text:match("%{ECB534%}.+ ���� � ����������� (.+)"))
    end
	if text:find(".+%[%d+%] ����� �� ׸����� ������ ������ ������ .+%. �������%: .+") and text:match("(.+)%[%d+%] ����� �� ׸����� ������ ������ ������ .+%. �������%: .+") == self.nick then
        sendDiscord("unblacklist", self.nick, text:match(".+%[%d+%] ����� �� ׸����� ������ ������ ������ (.+)%. �������%: .+"), text:match(".+%[%d+%] ����� �� ׸����� ������ ������ ������ .+%. �������%: (.+)"))
    end
	if text:find("�� �������� ������ .+ �� .+-�� �����") then --�� �������� ������ Viktor_Trilliant �� 6 ����� | �� �������� ������ Viktor_Trilliant �� 8 �����
        sendDiscord("rankponiz", self.nick, text:match("�� ������� ������ .+ �� .+-�� �����"))
    end
	if text:find("�� �������� ������ .+ �� .+-�� �����") then --�� �������� ������ Viktor_Trilliant �� 6 ����� | �� �������� ������ Viktor_Trilliant �� 8 �����
        sendDiscord("rankpovis", self.nick, text:match("�� ������� ������ .+ �� .+-�� �����"))
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
                    ['title'] = "������",
                    ['description'] = ("**��� ������������:** %s\n**��� ������ �������� �������:** %s\n\n**����: %s:%s:%s**"):format(nick_first, nick_second, day, month, year), 
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
                ['title'] = "������ ��������",
                ['description'] = ("**��� ������������:** %s\n**��� ���� ������:** %s\n**�������:** %s\n\n**����: %s:%s:%s**"):format(nick_first, nick_second, reason, day, month, year), 
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
                    ['title'] = "������ ��������",
                    ['description'] = ("**��� ������������:** %s\n**��� ���� �����:** %s\n\n**����: %s:%s:%s**"):format(nick_first, nick_second, day, month, year), 
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
                    ['title'] = "������ �� �������",
                    ['description'] = ("**��� ������������:** %s\n**��� ���� ������� �� �������:** %s\n**�������: ** %s\n\n**����: %s:%s:%s**"):format(nick_first, nick_second, reason, day, month, year), 
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
                    ['title'] = "�������� � ׸���� ������",
                    ['description'] = ("**��� ������������:** %s\n**��� ���� ������� � ��:** %s\n**�������: ** %s\n\n**����: %s:%s:%s**"):format(nick_first, nick_second, reason, day, month, year), 
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
                    ['title'] = "���������� �����������",
                    ['description'] = ("**���:** %s\n**�����: ** %s\n\n**����: %s:%s:%s**"):format(nick_first, reason, day, month, year), 
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
                    ['title'] = "������ � �����������",
                    ['description'] = ("**���:** %s\n**�����: ** %s\n\n**����: %s:%s:%s**"):format(nick_first, reason, day, month, year), 
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
                    ['title'] = "��������� �� ׸����� ������",
                    ['description'] = ("**��� ������������:** %s\n**��� ���� ������� � ��:** %s\n**�������: ** %s\n\n**����: %s:%s:%s**"):format(nick_first, nick_second, reason, day, month, year), 
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
                ['title'] = "���������",
                ['description'] = ("**��� ������������:** %s\n**���������:** %s\n\n**����: %s:%s:%s**"):format(nick_first, nick_second, day, month, year), 
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
                ['title'] = "���������",
                ['description'] = ("**��� ������������:** %s\n**���������:** %s\n\n**����: %s:%s:%s**"):format(nick_first, nick_second, day, month, year), 
                ['color'] = 14287103,
            }
            },
            ['username'] = 'Jefferson Bot',
            ['tts'] = false,
        }
    end
    tagq("����������� ���������� � ��� Discord")
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
                sampAddChatMessage((prefix..'���������� ����������. ������� ���������� c '..thisScript().version..' �� '..updateversion), color)
                wait(250)
                downloadUrlToFile(updatelink, thisScript().path,
                  function(id3, status1, p13, p23)
                    if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                      print(string.format('��������� %d �� %d.', p13, p23))
                    elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                      print('�������� ���������� ���������.')
                      sampAddChatMessage((prefix..'���������� ���������!'), color)
                      goupdatestatus = true
                      lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                      if goupdatestatus == nil then
                        sampAddChatMessage((prefix..'���������� ������ ��������. �������� ���������� ������..'), color)
                        update = false
                      end
                    end
                  end
                )
                end, prefix
              )
            else
              update = false
              print('v'..thisScript().version..': ���������� �� ���������.')
            end
          end
        else
          print('v'..thisScript().version..': �� ���� ��������� ����������. ��������� ��� ��������� �������������� �� '..url)
          update = false
        end
      end
    end
  )
  while update ~= false do wait(100) end
end
