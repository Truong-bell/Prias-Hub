-- ============================================================
-- PRIAS HUB – Loader (Mobile-friendly)
-- Owner: @ngu_auuu10 | Channel: @Hiadiz
-- ============================================================

print("🔮 Loading Prias Hub...")

local BASE_URL = "https://raw.githubusercontent.com/Truong-bell/Prias-Hub/main/"

local modules = {
    "Config",
    "Language",
    "Combos",
    "Executor",
    "UI",
    "Combat",
    "Visual",
    "Movement",
    "Misc",
    "Main",
}

local loaded = {}
local function loadModule(name)
    local url = BASE_URL .. name .. ".lua"
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if success and result then
        loaded[name] = result
        print("✅ Loaded: " .. name)
    else
        warn("❌ Failed to load: " .. name)
    end
end

for _, name in ipairs(modules) do
    loadModule(name)
end

if loaded.Main then
    print("🚀 Prias Hub loaded successfully!")
else
    warn("⚠️ Main module not loaded. Check your internet connection.")
end
