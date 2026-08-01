-- ============================================================
-- PRIAS HUB – Combat Module
-- Owner: @ngu_auuu10 | Channel: @Hiadiz
-- ============================================================

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Config = require(script.Parent.Config)
local Executor = require(script.Parent.Executor)
local CombosData = require(script.Parent.Combos)
local clickM1 = Executor.clickM1
local pressKey = Executor.pressKey
local executeCombo = Executor.executeCombo

local Combat = {}

function Combat:Start()
    -- Auto Combo
    task.spawn(function()
        while true do
            task.wait(0.3)
            if not Config.AutoCombo then continue end
            local target = nil
            local dist = math.huge
            local char = player.Character
            if not char then task.wait(0.5) continue end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then task.wait(0.5) continue end
            for _, p in ipairs(Players:GetPlayers()) do
                if p == player then continue end
                local c = p.Character
                if c and c:FindFirstChild("HumanoidRootPart") then
                    local d = (c.HumanoidRootPart.Position - hrp.Position).Magnitude
                    if d < dist then dist = d; target = p end
                end
            end
            if target then
                local comboList
                if Config.CustomCombo ~= "" then
                    comboList = {Config.CustomCombo}
                else
                    comboList = CombosData.combos[Config.SelectedChar] or CombosData.combos.Saitama
                end
                local seq = comboList[math.random(1, #comboList)]
                executeCombo(seq)
            end
        end
    end)
    
    -- Auto Kill
    task.spawn(function()
        while true do
            task.wait(0.2)
            if not Config.AutoKill then continue end
            local target = nil
            local dist = math.huge
            local char = player.Character
            if not char then task.wait(0.5) continue end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then task.wait(0.5) continue end
            for _, p in ipairs(Players:GetPlayers()) do
                if p == player then continue end
                local c = p.Character
                if c and c:FindFirstChild("HumanoidRootPart") then
                    local d = (c.HumanoidRootPart.Position - hrp.Position).Magnitude
                    if d < dist then dist = d; target = p end
                end
            end
            if target and target.Character then
                local targetHrp = target.Character:FindFirstChild("HumanoidRootPart")
                if targetHrp then
                    local flySpeed = 60
                    if dist > 8 then
                        hrp.CFrame = hrp.CFrame + (targetHrp.Position - hrp.Position).Unit * flySpeed * 0.2
                        hrp.Velocity = Vector3.new(0,0,0)
                    end
                    if dist < 10 then
                        for i = 1, 3 do
                            if not Config.AutoKill then break end
                            clickM1()
                            task.wait(0.1)
                            local skill = math.random(1, 4)
                            pressKey(tostring(skill))
                            task.wait(0.1)
                        end
                    end
                end
            end
        end
    end)
    
    -- Silent Aim
    task.spawn(function()
        while true do
            task.wait(0.05)
            if not Config.SilentAim then continue end
            local target = nil
            local dist = math.huge
            local cam = workspace.CurrentCamera
            if not cam then task.wait(0.5) continue end
            for _, p in ipairs(Players:GetPlayers()) do
                if p == player then continue end
                local c = p.Character
                if c and c:FindFirstChild("HumanoidRootPart") then
                    local d = (c.HumanoidRootPart.Position - cam.CFrame.Position).Magnitude
                    if d < dist then dist = d; target = p end
                end
            end
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                cam.CFrame = CFrame.new(cam.CFrame.Position, target.Character.HumanoidRootPart.Position)
            end
        end
    end)
    
    -- Camlock
    task.spawn(function()
        while true do
            task.wait(0.03)
            if not Config.Camlock then continue end
            local target = nil
            local dist = math.huge
            local cam = workspace.CurrentCamera
            if not cam then task.wait(0.5) continue end
            for _, p in ipairs(Players:GetPlayers()) do
                if p == player then continue end
                local c = p.Character
                if c and c:FindFirstChild("HumanoidRootPart") then
                    local d = (c.HumanoidRootPart.Position - cam.CFrame.Position).Magnitude
                    if d < dist then dist = d; target = p end
                end
            end
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                cam.CFrame = cam.CFrame:Lerp(
                    CFrame.new(cam.CFrame.Position, target.Character.HumanoidRootPart.Position),
                    0.15
                )
            end
        end
    end)
    
    -- Auto Block (basic)
    task.spawn(function()
        while true do
            task.wait(0.1)
            if not Config.AutoBlock then continue end
            local char = player.Character
            if not char then continue end
            local isAttacking = false
            for _, p in ipairs(Players:GetPlayers()) do
                if p == player then continue end
                local c = p.Character
                if c then
                    local animator = c:FindFirstChildOfClass("Animator")
                    if animator then
                        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                            if track and track.Name and (track.Name:lower():find("attack") or track.Name:lower():find("skill")) then
                                isAttacking = true
                                break
                            end
                        end
                    end
                end
                if isAttacking then break end
            end
            if isAttacking then
                pressKey("Q")
            end
        end
    end)
end

return Combat