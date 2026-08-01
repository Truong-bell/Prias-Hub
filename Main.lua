-- ============================================================
-- PRIAS HUB – Main Module
-- Owner: @ngu_auuu10 | Channel: @Hiadiz
-- ============================================================

local Config = require(script.Parent.Config)
local T = require(script.Parent.Language)
local CombosData = require(script.Parent.Combos)
local PriasUI = require(script.Parent.UI)
local Combat = require(script.Parent.Combat)
local Visual = require(script.Parent.Visual)
local Movement = require(script.Parent.Movement)
local Misc = require(script.Parent.Misc)

-- ===== CREATE WINDOW =====
local Window = PriasUI:CreateWindow({
    Title = T("title"),
    Width = 420,
    Height = 380,
})

-- ===== HOME TAB =====
local homeTab = Window:GetTab("home")
Window:CreateLabel(homeTab, "◆ PRIAS HUB v1.0")
Window:CreateLabel(homeTab, "Owner: @ngu_auuu10 | Channel: @Hiadiz")
Window:CreateLabel(homeTab, "⚡ TSB Hack Suite")
Window:CreateLabel(homeTab, "---")
Window:CreateLabel(homeTab, "⌂ Home | ⚔ Combat | ◈ Visual")
Window:CreateLabel(homeTab, "▲ Movement | ✦ Misc")

-- ===== COMBAT TAB =====
local combatTab = Window:GetTab("combat")

Window:CreateDropdown(combatTab, T("select_char"), "SelectedChar", CombosData.characters, function(val)
    print("Selected character:", val)
end)

local customCombos = {"M1-1-2-3","1-M1-3-M1-M1-2","M1-2-3-M1-1","2-3-M1-1-4","3M1-2-3-3M1-4","3M1-Uppercut-4M1-Beatdown"}
Window:CreateDropdown(combatTab, T("custom_combo"), "CustomCombo", customCombos)

Window:CreateToggle(combatTab, T("auto_kill"), "AutoKill")
Window:CreateToggle(combatTab, "Auto Combo", "AutoCombo")
Window:CreateToggle(combatTab, T("silent_aim"), "SilentAim")
Window:CreateToggle(combatTab, T("camlock"), "Camlock")
Window:CreateToggle(combatTab, T("auto_block"), "AutoBlock")

-- ===== VISUAL TAB =====
local visualTab = Window:GetTab("visual")
Window:CreateToggle(visualTab, "ESP Box", "ESPBox")
Window:CreateToggle(visualTab, "ESP Health", "ESPHealth")
Window:CreateToggle(visualTab, "ESP Name", "ESPName")
Window:CreateToggle(visualTab, "ESP Distance", "ESPDistance")
Window:CreateToggle(visualTab, "ESP Skeleton", "ESPSkeleton")

-- ===== MOVEMENT TAB =====
local movementTab = Window:GetTab("movement")
Window:CreateToggle(movementTab, "Noclip", "Noclip")
Window:CreateSlider(movementTab, "Speed", "Speed", 0, 100, 16)
Window:CreateToggle(movementTab, "Fly", "Fly")
Window:CreateSlider(movementTab, "Fly Speed", "FlySpeed", 0, 100, 50)
Window:CreateToggle(movementTab, "Orbit", "Orbit")
Window:CreateSlider(movementTab, "Orbit Dist", "OrbitDist", 5, 80, 30)

-- ===== MISC TAB =====
local miscTab = Window:GetTab("misc")
Window:CreateToggle(miscTab, T("respawn"), "AutoRespawn")

-- Teleport
Window:CreateLabel(miscTab, "⟐ Teleport")
local teleRow = Instance.new("Frame")
teleRow.Size = UDim2.new(1,0,0,32)
teleRow.BackgroundTransparency = 1
teleRow.Parent = miscTab

local teleInput = Instance.new("TextBox")
teleInput.Size = UDim2.new(0.5,0,0.7,0)
teleInput.Position = UDim2.new(0,10,0,0.15)
teleInput.BackgroundColor3 = Color3.fromRGB(45,45,55)
teleInput.PlaceholderText = "Player name"
teleInput.Text = ""
teleInput.TextColor3 = Color3.new(1,1,1)
teleInput.Font = Enum.Font.Gotham
teleInput.TextSize = 12
teleInput.Parent = teleRow
local teleInputCorner = Instance.new("UICorner")
teleInputCorner.CornerRadius = UDim.new(0,4)
teleInputCorner.Parent = teleInput

local teleGo = Instance.new("TextButton")
teleGo.Size = UDim2.new(0.3,0,0.7,0)
teleGo.Position = UDim2.new(0.55,0,0.15,0)
teleGo.BackgroundColor3 = Config.Accent
teleGo.Text = "GO"
teleGo.TextColor3 = Color3.new(1,1,1)
teleGo.Font = Enum.Font.GothamBold
teleGo.TextSize = 12
teleGo.AutoButtonColor = false
teleGo.Parent = teleRow
local teleGoCorner = Instance.new("UICorner")
teleGoCorner.CornerRadius = UDim.new(0,4)
teleGoCorner.Parent = teleGo
teleGo.MouseButton1Click:Connect(function()
    local name = teleInput.Text
    Misc:TeleportTo(name)
end)

-- Save/Load
local saveRow = Instance.new("Frame")
saveRow.Size = UDim2.new(1,0,0,32)
saveRow.BackgroundTransparency = 1
saveRow.Parent = miscTab

local saveBtn = Instance.new("TextButton")
saveBtn.Size = UDim2.new(0.4,0,0.7,0)
saveBtn.Position = UDim2.new(0.05,0,0.15,0)
saveBtn.BackgroundColor3 = Config.Accent
saveBtn.Text = T("save")
saveBtn.TextColor3 = Color3.new(1,1,1)
saveBtn.Font = Enum.Font.GothamBold
saveBtn.TextSize = 12
saveBtn.AutoButtonColor = false
saveBtn.Parent = saveRow
local saveBtnCorner = Instance.new("UICorner")
saveBtnCorner.CornerRadius = UDim.new(0,4)
saveBtnCorner.Parent = saveBtn
saveBtn.MouseButton1Click:Connect(function()
    Misc:SaveConfig()
end)

local loadBtn = Instance.new("TextButton")
loadBtn.Size = UDim2.new(0.4,0,0.7,0)
loadBtn.Position = UDim2.new(0.5,0,0.15,0)
loadBtn.BackgroundColor3 = Color3.fromRGB(45,45,55)
loadBtn.Text = T("load")
loadBtn.TextColor3 = Color3.new(1,1,1)
loadBtn.Font = Enum.Font.GothamBold
loadBtn.TextSize = 12
loadBtn.AutoButtonColor = false
loadBtn.Parent = saveRow
local loadBtnCorner = Instance.new("UICorner")
loadBtnCorner.CornerRadius = UDim.new(0,4)
loadBtnCorner.Parent = loadBtn
loadBtn.MouseButton1Click:Connect(function()
    Misc:LoadConfig()
end)

-- ===== START MODULES =====
Combat:Start()
Visual:Start()
Movement:Start()
Misc:StartAutoRespawn()

-- ===== ANTI-AFK =====
task.spawn(function()
    while true do
        task.wait(60)
        pcall(function() VirtualUser:ClickButton2(Vector2.new(1,1)) end)
    end
end)

-- ===== SELECT HOME TAB =====
Window:SelectTab("home")

print("Prias Hub v1.0 loaded successfully!")
