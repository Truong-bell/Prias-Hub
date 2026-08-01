-- ============================================================
-- PRIAS HUB – Language Module (Load from JSON)
-- Owner: @ngu_auuu10 | Channel: @Hiadiz
-- ============================================================

local Config = require(script.Parent.Config)
local HttpService = game:GetService("HttpService")

-- Cache for loaded languages
local Languages = {}

-- Function to load a language file (JSON)
local function loadLanguage(lang)
    local success, data = pcall(function()
        local jsonString = readfile("PriasHub/languages/" .. lang .. ".json")
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

-- Load default languages
loadLanguage("vi")
loadLanguage("en")

-- Fallback to Vietnamese if selected language not loaded
local function T(key)
    local langData = Languages[Config.Language] or Languages["vi"]
    if not langData then
        -- If no language loaded at all, return key itself
        return key
    end
    return langData[key] or key
end

-- Expose function to reload languages (if needed)
function T:Reload()
    loadLanguage("vi")
    loadLanguage("en")
    if Config.Language ~= "vi" and Config.Language ~= "en" then
        loadLanguage(Config.Language)
    end
end

return T