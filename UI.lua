-- ============================================================
-- PRIAS HUB – UI Framework (WindUI-style)
-- Owner: @ngu_auuu10 | Channel: @Hiadiz
-- ============================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local Config = _G.Config
local T = _G.Language

local PriasUI = {}
PriasUI.__index = PriasUI

function PriasUI:CreateWindow(opts)
    local Window = {}
    setmetatable(Window, PriasUI)
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "PriasHub"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.Parent = player:WaitForChild("PlayerGui")
    
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, opts.Width or 420, 0, opts.Height or 380)
    main.Position = UDim2.new(0.5, -main.Size.X.Offset/2, 0.5, -main.Size.Y.Offset/2)
    main.BackgroundColor3 = Config.Theme
    main.BorderSizePixel = 0
    main.ClipsDescendants = true
    main.Parent = gui
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = main
    
    local shadow = Instance.new("Frame")
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, -5, 0, -5)
    shadow.BackgroundColor3 = Color3.fromRGB(0,0,0)
    shadow.BackgroundTransparency = 0.7
    shadow.BorderSizePixel = 0
    shadow.Parent = main
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 16)
    shadowCorner.Parent = shadow
    
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 38)
    header.BackgroundColor3 = Color3.fromRGB(25,25,35)
    header.BorderSizePixel = 0
    header.Parent = main
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 12)
    headerCorner.Parent = header
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.6,0,1,0)
    title.Position = UDim2.new(0,12,0,0)
    title.BackgroundTransparency = 1
    title.Text = T("title") .. " v1.0"
    title.TextColor3 = Color3.fromRGB(220,220,230)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header
    
    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(0,28,0,28)
    minBtn.Position = UDim2.new(1,-68,0,5)
    minBtn.BackgroundColor3 = Color3.fromRGB(50,50,60)
    minBtn.Text = "▽"
    minBtn.TextColor3 = Color3.new(1,1,1)
    minBtn.Font = Enum.Font.GothamBold
    minBtn.TextSize = 16
    minBtn.Parent = header
    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(0,6)
    minCorner.Parent = minBtn
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0,28,0,28)
    closeBtn.Position = UDim2.new(1,-36,0,5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200,60,60)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.new(1,1,1)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 14
    closeBtn.Parent = header
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0,6)
    closeCorner.Parent = closeBtn
    
    local popup = Instance.new("TextButton")
    popup.Size = UDim2.new(0,48,0,48)
    popup.Position = UDim2.new(0.9,-24,0.9,-24)
    popup.BackgroundColor3 = Config.Accent
    popup.Text = "✧"
    popup.TextColor3 = Color3.new(1,1,1)
    popup.Font = Enum.Font.GothamBold
    popup.TextSize = 22
    popup.Visible = false
    popup.Parent = gui
    local popupCorner = Instance.new("UICorner")
    popupCorner.CornerRadius = UDim.new(0,24)
    popupCorner.Parent = popup
    
    minBtn.MouseButton1Click:Connect(function()
        main.Visible = false
        popup.Visible = true
    end)
    popup.MouseButton1Click:Connect(function()
        main.Visible = true
        popup.Visible = false
    end)
    closeBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
        Window._destroyed = true
    end)
    
    local dragMain = false
    local dragStart, startPos
    main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragMain = true
            dragStart = input.Position
            startPos = main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragMain and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragMain = false
        end
    end)
    
    local content = Instance.new("ScrollingFrame")
    content.Size = UDim2.new(1,-12,1,-100)
    content.Position = UDim2.new(0,6,0,44)
    content.BackgroundTransparency = 1
    content.CanvasSize = UDim2.new(0,0,0,0)
    content.AutomaticCanvasSize = Enum.AutomaticSize.X
    content.ScrollBarThickness = 3
    content.ScrollBarImageColor3 = Color3.fromRGB(60,60,70)
    content.Parent = main
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.FillDirection = Enum.FillDirection.Horizontal
    contentLayout.Padding = UDim.new(0,8)
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Parent = content
    
    local tabBar = Instance.new("Frame")
    tabBar.Size = UDim2.new(1,-12,0,36)
    tabBar.Position = UDim2.new(0,6,1,-42)
    tabBar.BackgroundColor3 = Color3.fromRGB(20,20,30)
    tabBar.BorderSizePixel = 0
    tabBar.Parent = main
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0,10)
    tabCorner.Parent = tabBar
    
    local tabs = {"home","combat","visual","movement","misc"}
    local tabButtons = {}
    local tabFrames = {}
    local selectedTab = "home"
    
    for i, name in ipairs(tabs) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1/#tabs,-4,1,-4)
        btn.Position = UDim2.new((i-1)/#tabs + 0.02,0,0,2)
        btn.BackgroundColor3 = (i==1) and Config.Accent or Color3.fromRGB(35,35,45)
        btn.Text = T(name)
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        btn.AutoButtonColor = false
        btn.Parent = tabBar
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0,6)
        btnCorner.Parent = btn
        tabButtons[name] = btn
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0,400,1,0)
        frame.BackgroundTransparency = 1
        frame.Visible = (i==1)
        frame.Parent = content
        tabFrames[name] = frame
        local frameLayout = Instance.new("UIListLayout")
        frameLayout.FillDirection = Enum.FillDirection.Vertical
        frameLayout.Padding = UDim.new(0,6)
        frameLayout.SortOrder = Enum.SortOrder.LayoutOrder
        frameLayout.Parent = frame
    end
    
    function Window:SelectTab(name)
        selectedTab = name
        for k, btn in pairs(tabButtons) do
            btn.BackgroundColor3 = (k==name) and Config.Accent or Color3.fromRGB(35,35,45)
            tabFrames[k].Visible = (k==name)
        end
    end
    
    for k, btn in pairs(tabButtons) do
        btn.MouseButton1Click:Connect(function() Window:SelectTab(k) end)
    end
    
    function Window:GetTab(name)
        return tabFrames[name]
    end
    
    function Window:Destroy()
        gui:Destroy()
        Window._destroyed = true
    end
    
    function Window:CreateToggle(parent, label, configKey, callback)
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1,0,0,32)
        row.BackgroundColor3 = Color3.fromRGB(30,30,40)
        row.BorderSizePixel = 0
        row.Parent = parent
        local rowCorner = Instance.new("UICorner")
        rowCorner.CornerRadius = UDim.new(0,8)
        rowCorner.Parent = row
        
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0.6,0,1,0)
        lbl.Position = UDim2.new(0,10,0,0)
        lbl.BackgroundTransparency = 1
        lbl.Text = label
        lbl.TextColor3 = Color3.fromRGB(210,210,220)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = row
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0,44,0,22)
        btn.Position = UDim2.new(0.82,0,0,5)
        local state = Config[configKey] == true
        btn.BackgroundColor3 = state and Config.Accent or Color3.fromRGB(55,55,65)
        btn.Text = state and T("on") or T("off")
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 10
        btn.AutoButtonColor = false
        btn.Parent = row
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0,4)
        btnCorner.Parent = btn
        
        if callback then
            btn.MouseButton1Click:Connect(function()
                local new = not Config[configKey]
                Config[configKey] = new
                btn.BackgroundColor3 = new and Config.Accent or Color3.fromRGB(55,55,65)
                btn.Text = new and T("on") or T("off")
                callback(new)
            end)
        end
        return btn
    end
    
    function Window:CreateSlider(parent, label, configKey, min, max, default, callback)
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1,0,0,44)
        row.BackgroundColor3 = Color3.fromRGB(30,30,40)
        row.BorderSizePixel = 0
        row.Parent = parent
        local rowCorner = Instance.new("UICorner")
        rowCorner.CornerRadius = UDim.new(0,8)
        rowCorner.Parent = row
        
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0.5,0,0,18)
        lbl.Position = UDim2.new(0,10,0,0)
        lbl.BackgroundTransparency = 1
        lbl.Text = label
        lbl.TextColor3 = Color3.fromRGB(210,210,220)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = row
        
        local val = Instance.new("TextLabel")
        val.Size = UDim2.new(0.3,0,0,18)
        val.Position = UDim2.new(0.7,0,0,0)
        val.BackgroundTransparency = 1
        val.Text = tostring(default)
        val.TextColor3 = Config.Accent
        val.Font = Enum.Font.GothamBold
        val.TextSize = 13
        val.TextXAlignment = Enum.TextXAlignment.Right
        val.Parent = row
        
        local slider = Instance.new("Frame")
        slider.Size = UDim2.new(0.85,0,0,4)
        slider.Position = UDim2.new(0,6,0,26)
        slider.BackgroundColor3 = Color3.fromRGB(45,45,55)
        slider.Parent = row
        local sliderCorner = Instance.new("UICorner")
        sliderCorner.CornerRadius = UDim.new(0,2)
        sliderCorner.Parent = slider
        
        local fill = Instance.new("Frame")
        local ratio = (default - min) / (max - min)
        fill.Size = UDim2.new(ratio,0,1,0)
        fill.BackgroundColor3 = Config.Accent
        fill.BorderSizePixel = 0
        fill.Parent = slider
        
        local drag = Instance.new("TextButton")
        drag.Size = UDim2.new(0,14,0,14)
        drag.Position = UDim2.new(ratio,-7,-0.5,0)
        drag.BackgroundColor3 = Color3.fromRGB(255,255,255)
        drag.Text = ""
        drag.Parent = slider
        local dragCorner = Instance.new("UICorner")
        dragCorner.CornerRadius = UDim.new(0,7)
        dragCorner.Parent = drag
        
        local dragging = false
        drag.MouseButton1Down:Connect(function() dragging = true end)
        drag.MouseButton1Up:Connect(function() dragging = false end)
        drag.Touch:Connect(function() dragging = true end)
        drag.TouchEnded:Connect(function() dragging = false end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local absX = slider.AbsolutePosition.X
                local absW = slider.AbsoluteSize.X
                if absW <= 0 then return end
                local x = math.clamp((input.Position.X - absX) / absW, 0, 1)
                local v = math.floor(min + x * (max - min) + 0.5)
                fill.Size = UDim2.new(x,0,1,0)
                drag.Position = UDim2.new(x,-7,-0.5,0)
                val.Text = tostring(v)
                Config[configKey] = v
                if callback then callback(v) end
            end
        end)
    end
    
    function Window:CreateDropdown(parent, label, configKey, items, callback)
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1,0,0,32)
        row.BackgroundColor3 = Color3.fromRGB(30,30,40)
        row.BorderSizePixel = 0
        row.Parent = parent
        local rowCorner = Instance.new("UICorner")
        rowCorner.CornerRadius = UDim.new(0,8)
        rowCorner.Parent = row
        
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0.4,0,1,0)
        lbl.Position = UDim2.new(0,10,0,0)
        lbl.BackgroundTransparency = 1
        lbl.Text = label
        lbl.TextColor3 = Color3.fromRGB(210,210,220)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = row
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.5,0,0.7,0)
        btn.Position = UDim2.new(0.42,0,0.15,0)
        btn.BackgroundColor3 = Color3.fromRGB(45,45,55)
        btn.Text = tostring(Config[configKey] or items[1])
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 12
        btn.AutoButtonColor = false
        btn.Parent = row
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0,4)
        btnCorner.Parent = btn
        
        local idx = 1
        for i, v in ipairs(items) do
            if v == Config[configKey] then idx = i; break end
        end
        
        btn.MouseButton1Click:Connect(function()
            idx = idx % #items + 1
            local val = items[idx]
            Config[configKey] = val
            btn.Text = tostring(val)
            if callback then callback(val) end
        end)
    end
    
    function Window:CreateLabel(parent, text)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1,0,0,24)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = Color3.fromRGB(180,180,190)
        lbl.Font = Enum.Font.Gotham
        lbl.TextSize = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Center
        lbl.Parent = parent
        return lbl
    end
    
    Window._gui = gui
    Window._main = main
    Window._tabFrames = tabFrames
    Window._selectedTab = selectedTab
    
    return Window
end

return PriasUI
