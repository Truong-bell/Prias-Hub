-- ============================================================
-- PRIAS HUB – Visual Module (ESP)
-- Owner: @ngu_auuu10 | Channel: @Hiadiz
-- ============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local Config = require(script.Parent.Config)

local Visual = {}
local espObjects = {}

function Visual:ClearESP()
    for _, v in ipairs(espObjects) do
        pcall(function() v:Remove() end)
    end
    espObjects = {}
end

function Visual:DrawESP()
    self:ClearESP()
    if not (Config.ESPBox or Config.ESPHealth or Config.ESPName or Config.ESPDistance or Config.ESPSkeleton) then
        return
    end
    local cam = workspace.CurrentCamera
    if not cam then return end
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    for _, p in ipairs(Players:GetPlayers()) do
        if p == player then continue end
        local tc = p.Character
        if not tc then continue end
        local th = tc:FindFirstChild("HumanoidRootPart")
        if not th then continue end
        local pos, onScreen = cam:WorldToViewportPoint(th.Position)
        if not onScreen then continue end
        
        if Config.ESPBox then
            local box = Drawing.new("Square")
            box.Size = Vector2.new(36, 54)
            box.Position = Vector2.new(pos.X - 18, pos.Y - 27)
            box.Thickness = 2
            box.Color = Config.Accent
            box.Filled = false
            box.Visible = true
            table.insert(espObjects, box)
        end
        
        if Config.ESPHealth then
            local hum = tc:FindFirstChildOfClass("Humanoid")
            if hum then
                local ratio = hum.Health / hum.MaxHealth
                local w = 32
                local bg = Drawing.new("Line")
                bg.From = Vector2.new(pos.X - w/2, pos.Y - 40)
                bg.To = Vector2.new(pos.X + w/2, pos.Y - 40)
                bg.Thickness = 4
                bg.Color = Color3.fromRGB(30,30,30)
                bg.Visible = true
                table.insert(espObjects, bg)
                local fg = Drawing.new("Line")
                fg.From = Vector2.new(pos.X - w/2, pos.Y - 40)
                fg.To = Vector2.new(pos.X - w/2 + w * ratio, pos.Y - 40)
                fg.Thickness = 4
                fg.Color = Color3.fromRGB(255 * (1 - ratio), 255 * ratio, 0)
                fg.Visible = true
                table.insert(espObjects, fg)
            end
        end
        
        if Config.ESPName then
            local txt = Drawing.new("Text")
            txt.Text = p.Name
            txt.Position = Vector2.new(pos.X, pos.Y - 52)
            txt.Size = 12
            txt.Color = Color3.new(1,1,1)
            txt.Center = true
            txt.Visible = true
            table.insert(espObjects, txt)
        end
        
        if Config.ESPDistance then
            local dist = math.floor((th.Position - hrp.Position).Magnitude)
            local txt = Drawing.new("Text")
            txt.Text = dist .. " studs"
            txt.Position = Vector2.new(pos.X, pos.Y + 20)
            txt.Size = 11
            txt.Color = Color3.fromRGB(255,255,200)
            txt.Center = true
            txt.Visible = true
            table.insert(espObjects, txt)
        end
        
        if Config.ESPSkeleton then
            local head = tc:FindFirstChild("Head")
            if head then
                local rootPos, _ = cam:WorldToViewportPoint(th.Position)
                local headPos, _ = cam:WorldToViewportPoint(head.Position)
                local line = Drawing.new("Line")
                line.From = Vector2.new(rootPos.X, rootPos.Y)
                line.To = Vector2.new(headPos.X, headPos.Y)
                line.Thickness = 1
                line.Color = Color3.fromRGB(255,255,0)
                line.Visible = true
                table.insert(espObjects, line)
            end
        end
    end
end

function Visual:Start()
    RunService.RenderStepped:Connect(function()
        self:DrawESP()
    end)
end

return Visual