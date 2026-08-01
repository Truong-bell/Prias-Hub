-- ============================================================
-- PRIAS HUB – Executor Compatibility Module
-- Owner: @ngu_auuu10 | Channel: @Hiadiz
-- ============================================================

local player = game.Players.LocalPlayer

local function clickM1()
    if syn and syn.input and syn.input.SendMouseButtonEvent then
        syn.input:SendMouseButtonEvent(1, true)
    elseif keypress then
        keypress(0x01)
    elseif mouse1click then
        mouse1click()
    elseif VirtualUser and VirtualUser.ClickButton1 then
        VirtualUser:ClickButton1()
    else
        local mouse = player:GetMouse()
        if mouse and mouse.Target and mouse.Target:IsA("ClickDetector") then
            mouse.Target:FireClick()
        end
    end
end

local function pressKey(key)
    if key == "M1" then clickM1(); return end
    local map = {
        ["1"] = Enum.KeyCode.One,
        ["2"] = Enum.KeyCode.Two,
        ["3"] = Enum.KeyCode.Three,
        ["4"] = Enum.KeyCode.Four,
        ["Q"] = Enum.KeyCode.Q,
        ["q"] = Enum.KeyCode.Q,
        ["Space"] = Enum.KeyCode.Space,
    }
    local code = map[tostring(key)]
    if not code then return end
    if syn and syn.input and syn.input.SendKeyEvent then
        syn.input:SendKeyEvent(code, true)
        task.wait(0.05)
        syn.input:SendKeyEvent(code, false)
    elseif keypress and keyrelease then
        pcall(function()
            keypress(code)
            task.wait(0.05)
            keyrelease(code)
        end)
    else
        pcall(function()
            VirtualUser:PressKey(code)
            task.wait(0.05)
            VirtualUser:ReleaseKey(code)
        end)
    end
end

local function executeCombo(str)
    if not str or str == "" then return end
    for part in string.gmatch(str, "[^%-%s]+") do
        if part == "M1" or part == "m1" then
            clickM1()
        elseif part == "M1x2" or part == "2M1" then
            clickM1(); task.wait(0.06); clickM1()
        elseif part == "M1x3" or part == "3M1" then
            clickM1(); task.wait(0.06); clickM1(); task.wait(0.06); clickM1()
        elseif part == "M1x4" or part == "4M1" then
            for i = 1, 4 do clickM1(); task.wait(0.06) end
        elseif part == "Downsmash" or part == "downsmash" then
            clickM1(); task.wait(0.1); clickM1()
        elseif part == "Uppercut" or part == "uppercut" then
            clickM1(); task.wait(0.1)
        elseif part == "SideDash" or part == "sidedash" or part == "Dash" or part == "dash" or part == "ForwardDash" or part == "Backdash" then
            pressKey("Q")
        elseif part == "Jump" or part == "jump" then
            pressKey("Space")
        elseif tonumber(part) then
            pressKey(part)
        end
        task.wait(0.08)
    end
end

return { clickM1 = clickM1, pressKey = pressKey, executeCombo = executeCombo }