--[[
BY : HAWAKTEAM
Channel Files : https://t.me/lllEll2
]]
local function keko_Matrix(data)
    local msg = data.message_
    redis = (loadfile "./File_Libs/redis.lua")()
    database = Redis.connect('127.0.0.1', 6379)
    sudos = dofile('sudo.lua')
    HTTPS = require("ssl.https")
    JSON = (loadfile  "./File_Libs/dkjson.lua")()
    bot_id_keko = {string.match(token, "^(%d+)(:)(.*)")}
    bot_id = tonumber(bot_id_keko[1])
    msg = data.message_
    text = msg.content_.text_
    function getUser(user_id, cb)
    tdcli_function ({
    ID = "GetUser",
    user_id_ = user_id
    }, cb, nil)
    end
    local function send(chat_id, reply_to_message_id, disable_notification, text, disable_web_page_preview, parse_mode)
    local TextParseMode = {ID = "TextParseModeMarkdown"}
    tdcli_function ({
    ID = "SendMessage",
    chat_id_ = chat_id,
    reply_to_message_id_ = reply_to_message_id,
    disable_notification_ = disable_notification,
    from_background_ = 1,
    reply_markup_ = nil,
    input_message_content_ = {
    ID = "InputMessageText",
    text_ = text,
    disable_web_page_preview_ = disable_web_page_preview,
    clear_draft_ = 0,
    entities_ = {},
    parse_mode_ = TextParseMode,
    },
    }, dl_cb, nil)
    end
    bot = dofile('./File_Libs/utils.lua')
    function is_vip(msg)
    user_id = msg.sender_user_id_
    chat_id = msg.chat_id_
    local var = false
    local mod = database:sismember('Matrix:'..bot_id..'mods:'..chat_id, user_id)  
    local admin = database:sismember('Matrix:'..bot_id..'admins:', user_id)  
    local owner = database:sismember('Matrix:'..bot_id..'owners:'..chat_id, user_id)
    local creator = database:sismember('Matrix:'..bot_id..'creator:'..chat_id, user_id)  
    local vip = database:sismember('Matrix:'..bot_id..'vip'..chat_id, user_id)
    if mod then var = true end
    if owner then var = true end
    if creator then var = true end
    if admin then var = true end
    if vip then var = true end
    for k,v in pairs(sudo_users) do
    if user_id == v then
    var = true end end
    local keko_add_sudo = redis:get('Matrix:'..bot_id..'sudoo'..user_id..'')
    if keko_add_sudo then var = true end
    return var 
    end
    -----------------------------
    if text and text == "تفعيل تاك الادمنيه" and database:sismember('Matrix:'..bot_id..'creator:'..msg.chat_id_, msg.sender_user_id_) then 
    database:set("Matrix:tag:admin:"..bot_id..msg.chat_id_,"Matrix")
    send(msg.chat_id_, msg.id_, 1, "⚠️┇تم تفعيل تاك الادمنيه", 1, 'html')
    end
    if text and text == "تعطيل تاك الادمنيه" and database:sismember('Matrix:'..bot_id..'creator:'..msg.chat_id_, msg.sender_user_id_) then 
    database:del("Matrix:tag:admin:"..bot_id..msg.chat_id_)
    send(msg.chat_id_, msg.id_, 1, "⚠️┇تم تعطيل تاك الادمنيه", 1, 'html')
    end
    if (text and ( text == 'صيح الادمنيه' or text == "تاك للادمنيه" or text == "وين الادمنيه") and (is_vip(msg) or database:get("Matrix:tag:admin:"..bot_id..msg.chat_id_))) then 
    function cb(t1,t2)
    function kekko(u1,u2)
    local id_send = msg.sender_user_id_
    if u2.username_ then 
    id_send = "@"..u2.username_
    end
    local new_text = "⚠️┇المستخدم ([ "..id_send .." ]) يصيحكم .\n\n"
    i = 0
    for k,v in pairs(t2.members_) do
    if bot_id ~= v.user_id_ then 
    i = i + 1
    local user_info = database:hgetall('Matrix:'..bot_id..'user:'..v.user_id_)
    if user_info and user_info.username then
    new_text = new_text .. i .. " ┇ [@"..user_info.username.."] \n"
    else 
    new_text = new_text .. i .. " ┇ `"..v.user_id_.."` \n"
    end
    end
    end
    send(msg.chat_id_, msg.id_, 1, new_text, 1, 'Matrix')
    end
    getUser(msg.sender_user_id_, kekko)
    end
    bot.channel_get_admins(msg.chat_id_,cb)
    end   
    end
    return {
    keko_Matrix = keko_Matrix,
    }
    --[[
    BY : HAWAKTEAM
    Channel Files : https://t.me/lllEll2
    ]]
    