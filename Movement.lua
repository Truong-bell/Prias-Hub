-- ============================================================
-- PRIAS HUB – Movement Module
-- Owner: @ngu_auuu10 | Channel: @Hiadiz
-- ============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local Config = require(script.Parent.Config)

local Movement = {}
local origCollision = {}

function Movement:Start()
    RunService.RenderStepped:Connect(function()
        local char = player.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end
        
        -- Noclip
        if Config.Noclip then
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") and not origCollision[p] then
                    origCollision[p] = p.CanCollide
                    p.CanCollide = false
                end
            end
        else
            for p, v in pairs(origCollision) do
                if p and p:IsA("BasePart") then p.CanCollide = v end
            end
            origCollision = {}
        end
        
        -- Speed
        hum.WalkSpeed = Config.Speed
        
        -- Fly
        if Config.Fly and not Config.Orbit then
            hrp.Velocity = Vector3.new(hrp.Velocity.X, Config.FlySpeed, hrp.Velocity.Z)
        end
        
        -- Orbit
        if Config.Orbit then
            local target = nil
            local targetName = Config.OrbitTarget or "None"
            if targetName ~= "None" and targetName ~= "" then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p.Name == targetName then target = p; break end
                end
            end
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                local pos = target.Character.HumanoidRootPart.Position
                local angle = tick() * 0.7
                hrp.CFrame = CFrame.new(
                    pos + Vector3.new(math.cos(angle) * Config.OrbitDist, 5, math.sin(angle) * Config.OrbitDist),
                    pos
                )
            else
                Config.Orbit = false
                -- Auto-turn off orbit toggle via UI later
            end
        end
    end)
end

return Movement