-- ============================================================
-- PRIAS HUB – Language Module (Load from GitHub)
-- Owner: @ngu_auuu10 | Channel: @Hiadiz
-- ============================================================

local Config = require(script.Parent.Config)
local HttpService = game:GetService("HttpService")

local Languages = {}

local BASE_URL = "https://raw.githubusercontent.com/Truong-bell/Prias-Hub/main/languages/"

local function loadLanguage(lang)
    local success, data = pcall(function()
        local jsonString = game:HttpGet(BASE_URL .. lang .. ".json")
        return HttpService:JSONDecode(jsonString)
    end)
    if success and data then
        Languages[lang] = data
        return true
    else
        warn("Failed to load language: " .. lang)
        return false
    end
end

loadLanguage("vi")
loadLanguage("en")

local function T(key)
    local langData = Languages[Config.Language] or Languages["vi"]
    if not langData then
        return key
    end
    return langData[key] or key
end

function T:Reload()
    loadLanguage("vi")
    loadLanguage("en")
    if Config.Language ~= "vi" and Config.Language ~= "en" then
        loadLanguage(Config.Language)
    end
end

return T
