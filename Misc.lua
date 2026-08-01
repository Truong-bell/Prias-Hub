-- ============================================================
-- PRIAS HUB – Misc Module (Teleport, Auto Respawn, Save/Load)
-- Owner: @ngu_auuu10 | Channel: @Hiadiz
-- ============================================================

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer
local Config = require(script.Parent.Config)

local Misc = {}

function Misc:TeleportTo(name)
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Name == name and p ~= player then
            local c = p.Character
            if c and c:FindFirstChild("HumanoidRootPart") then
                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = c.HumanoidRootPart.CFrame
                    return true
                end
            end
        end
    end
    return false
end

function Misc:TeleportToMouse()
    local mouse = player:GetMouse()
    if mouse and mouse.Hit then
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(mouse.Hit.Position)
            return true
        end
    end
    return false
end

function Misc:StartAutoRespawn()
    task.spawn(function()
        while true do
            task.wait(1)
            if not Config.AutoRespawn then continue end
            local char = player.Character
            if not char or (char:FindFirstChildOfClass("Humanoid") and char.Humanoid.Health <= 0) then
                pcall(function()
                    VirtualUser:ClickButton2(Vector2.new(1,1))
                end)
            end
        end
    end)
end

function Misc:SaveConfig()
    if writefile then
        local data = {}
        for k, v in pairs(Config) do
            if typeof(v) == "Color3" then
                data[k] = {v.R*255, v.G*255, v.B*255}
            else
                data[k] = v
            end
        end
        writefile("PriasHub_Config.json", HttpService:JSONEncode(data))
        return true
    end
    return false
end

function Misc:LoadConfig()
    if readfile then
        local raw = readfile("PriasHub_Config.json")
        if raw then
            local data = HttpService:JSONDecode(raw)
            for k, v in pairs(data) do
                if k == "Theme" or k == "Accent" or k == "Accent2" then
                    Config[k] = Color3.fromRGB(v[1], v[2], v[3])
                else
                    Config[k] = v
                end
            end
            return true
        end
    end
    return false
end

return Misc