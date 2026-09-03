local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- GUI CREATION
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShenanigansHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 460, 0, 280)
MainFrame.Position = UDim2.new(0.5, -230, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame

-- MINI BUTTON (Mở lại khi ẩn GUI)
local MiniBtn = Instance.new("TextButton")
MiniBtn.Size = UDim2.new(0, 45, 0, 45)
MiniBtn.Position = UDim2.new(0, 15, 0, 150)
MiniBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
MiniBtn.Text = "SHEN"
MiniBtn.Font = Enum.Font.GothamBold
MiniBtn.TextSize = 11
MiniBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniBtn.Visible = false
MiniBtn.Active = true
MiniBtn.Draggable = true
MiniBtn.Parent = ScreenGui

Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(1, 0)
local MiniStroke = Instance.new("UIStroke")
MiniStroke.Thickness = 2
MiniStroke.Parent = MiniBtn

-- TOPBAR
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 32)
TopBar.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "Shenanigans | Fixed v2"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 1, 0)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 13
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Parent = TopBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 30, 1, 0)
MinimizeBtn.Position = UDim2.new(1, -60, 0, 0)
MinimizeBtn.Text = "-"
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 18
MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Parent = TopBar

-- SIDEBAR & NAVIGATION
local SideBar = Instance.new("Frame")
SideBar.Size = UDim2.new(0, 110, 1, -32)
SideBar.Position = UDim2.new(0, 0, 0, 32)
SideBar.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
SideBar.BorderSizePixel = 0
SideBar.Parent = MainFrame

local SideLayout = Instance.new("UIListLayout", SideBar)
SideLayout.Padding = UDim.new(0, 4)
SideLayout.SortOrder = Enum.SortOrder.LayoutOrder

local SidePadding = Instance.new("UIPadding", SideBar)
SidePadding.PaddingTop = UDim.new(0, 6)
SidePadding.PaddingLeft = UDim.new(0, 4)
SidePadding.PaddingRight = UDim.new(0, 4)

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -115, 1, -36)
ContentFrame.Position = UDim2.new(0, 115, 0, 34)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

local function CreateTabBtn(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 26)
    btn.Text = name
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 11
    btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
    btn.BorderSizePixel = 0
    btn.Parent = SideBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    return btn
end

local PlayerTabBtn = CreateTabBtn("Players")
local DummyTabBtn = CreateTabBtn("Dummies")
local LockOnTabBtn = CreateTabBtn("Lock On")
local FlyTabBtn = CreateTabBtn("Fly")
local RefreshBtn = CreateTabBtn("🔄 Refresh")
RefreshBtn.BackgroundColor3 = Color3.fromRGB(35, 50, 75)
RefreshBtn.TextColor3 = Color3.fromRGB(150, 200, 255)

local function CreateScrollList()
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -6, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 3
    scroll.Visible = false
    scroll.Parent = ContentFrame

    local list = Instance.new("UIListLayout", scroll)
    list.Padding = UDim.new(0, 5)
    list.SortOrder = Enum.SortOrder.LayoutOrder

    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y)
    end)
    return scroll
end

local PlayerScroll = CreateScrollList()
local DummyScroll = CreateScrollList()
local LockOnScroll = CreateScrollList()
local FlyScroll = CreateScrollList()
PlayerScroll.Visible = true

local function SwitchTab(activeBtn, activeScroll)
    PlayerTabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
    DummyTabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
    LockOnTabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
    FlyTabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 28)

    PlayerScroll.Visible = false
    DummyScroll.Visible = false
    LockOnScroll.Visible = false
    FlyScroll.Visible = false

    activeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    activeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    activeScroll.Visible = true
end

PlayerTabBtn.MouseButton1Click:Connect(function() SwitchTab(PlayerTabBtn, PlayerScroll) end)
DummyTabBtn.MouseButton1Click:Connect(function() SwitchTab(DummyTabBtn, DummyScroll) end)
LockOnTabBtn.MouseButton1Click:Connect(function() SwitchTab(LockOnTabBtn, LockOnScroll) end)
FlyTabBtn.MouseButton1Click:Connect(function() SwitchTab(FlyTabBtn, FlyScroll) end)

-- GLOBAL VARIABLES & LOGIC
local TargetModel = nil
local LockOnTargetModel = nil
local ActiveTeleportBtn = nil
local ActiveLockBtn = nil

local Flying = false
local FlySpeed = 50
local BodyVel = nil

local function StopTeleport()
    TargetModel = nil
    if ActiveTeleportBtn then
        ActiveTeleportBtn.Text = "OFF"
        ActiveTeleportBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
        ActiveTeleportBtn = nil
    end
end

local function StopLockOn()
    LockOnTargetModel = nil
    if ActiveLockBtn then
        ActiveLockBtn.Text = "OFF"
        ActiveLockBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
        ActiveLockBtn = nil
    end
end

local function GetCharParts(model)
    if not model or not model.Parent then return nil, nil end
    local hum = model:FindFirstChildOfClass("Humanoid")
    local root = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Torso") or model.PrimaryPart
    return root, hum
end

-- FLY SYSTEM
local function StartFly()
    local char = LocalPlayer.Character
    if not char then return end
    local root, hum = GetCharParts(char)
    if not root or not hum then return end

    hum.PlatformStand = true

    if root:FindFirstChild("FlyVelocity") then root.FlyVelocity:Destroy() end
    BodyVel = Instance.new("BodyVelocity")
    BodyVel.Name = "FlyVelocity"
    BodyVel.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    BodyVel.Velocity = Vector3.zero
    BodyVel.Parent = root
end

local function StopFly()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand = false end
        local root = char:FindFirstChild("HumanoidRootPart")
        if root and root:FindFirstChild("FlyVelocity") then
            root.FlyVelocity:Destroy()
        end
    end
    BodyVel = nil
end

-- MAIN LOOP
RunService.RenderStepped:Connect(function()
    local hue = (tick() % 3) / 3
    local color = Color3.fromHSV(hue, 0.7, 1)
    UIStroke.Color = color
    MiniStroke.Color = color
    Title.TextColor3 = color

    local myChar = LocalPlayer.Character
    local myRoot, myHum = GetCharParts(myChar)

    if myRoot then
        -- 1. TELEPORT RA SAU LƯNG
        if TargetModel then
            local tRoot, tHum = GetCharParts(TargetModel)
            if tRoot and tHum and tHum.Health > 0 then
                myRoot.CFrame = tRoot.CFrame * CFrame.new(0, 0, 3)
            else
                StopTeleport()
            end
        end

        -- 2. LOCK ON
        if LockOnTargetModel then
            local lRoot, lHum = GetCharParts(LockOnTargetModel)
            if lRoot and lHum and lHum.Health > 0 then
                local targetPos = lRoot.Position
                myRoot.CFrame = CFrame.new(myRoot.Position, Vector3.new(targetPos.X, myRoot.Position.Y, targetPos.Z))
            else
                StopLockOn()
            end
        end

        -- 3. FLY LOGIC
        if Flying and BodyVel then
            local moveDir = Vector3.zero

            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end

            if myHum and myHum.MoveDirection.Magnitude > 0 then
                moveDir = Camera.CFrame:VectorToWorldSpace(myHum.MoveDirection)
            end

            if moveDir.Magnitude > 0 then
                BodyVel.Velocity = moveDir.Unit * FlySpeed
            else
                BodyVel.Velocity = Vector3.zero
            end
        end
    end
end)

-- TAO ITEM TRONG LIST
local function CreateCard(scroll, textName, modelObj, isLockTab)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -4, 0, 32)
    card.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
    card.BorderSizePixel = 0
    card.Parent = scroll
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 5)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -65, 1, 0)
    lbl.Position = UDim2.new(0, 8, 0, 0)
    lbl.Text = textName
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 11
    lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    lbl.BackgroundTransparency = 1
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = card

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 48, 0, 20)
    btn.Position = UDim2.new(1, -54, 0.5, -10)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.BorderSizePixel = 0
    btn.Parent = card
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

    local isON = isLockTab and (LockOnTargetModel == modelObj) or (TargetModel == modelObj)
    if isON then
        btn.Text = "ON"
        btn.BackgroundColor3 = Color3.fromRGB(0, 180, 70)
        if isLockTab then ActiveLockBtn = btn else ActiveTeleportBtn = btn end
    else
        btn.Text = "OFF"
        btn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    end

    btn.MouseButton1Click:Connect(function()
        if isLockTab then
            if LockOnTargetModel == modelObj then
                StopLockOn()
            else
                StopLockOn()
                LockOnTargetModel = modelObj
                ActiveLockBtn = btn
                btn.Text = "ON"
                btn.BackgroundColor3 = Color3.fromRGB(0, 180, 70)
            end
        else
            if TargetModel == modelObj then
                StopTeleport()
            else
                StopTeleport()
                TargetModel = modelObj
                ActiveTeleportBtn = btn
                btn.Text = "ON"
                btn.BackgroundColor3 = Color3.fromRGB(0, 180, 70)
            end
        end
    end)
end

-- TAB FLY INTERFACE
local function SetupFlyUI()
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -4, 0, 36)
    card.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
    card.Parent = FlyScroll
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 5)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -65, 1, 0)
    lbl.Position = UDim2.new(0, 8, 0, 0)
    lbl.Text = "Enable Fly (Bay)"
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 11
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.BackgroundTransparency = 1
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = card

    local flyToggle = Instance.new("TextButton")
    flyToggle.Size = UDim2.new(0, 48, 0, 20)
    flyToggle.Position = UDim2.new(1, -54, 0.5, -10)
    flyToggle.Text = "OFF"
    flyToggle.Font = Enum.Font.GothamBold
    flyToggle.TextSize = 10
    flyToggle.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    flyToggle.Parent = card
    Instance.new("UICorner", flyToggle).CornerRadius = UDim.new(0, 4)

    flyToggle.MouseButton1Click:Connect(function()
        Flying = not Flying
        if Flying then
            flyToggle.Text = "ON"
            flyToggle.BackgroundColor3 = Color3.fromRGB(0, 180, 70)
            StartFly()
        else
            flyToggle.Text = "OFF"
            flyToggle.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
            StopFly()
        end
    end)

    local card2 = Instance.new("Frame")
    card2.Size = UDim2.new(1, -4, 0, 36)
    card2.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
    card2.Parent = FlyScroll
    Instance.new("UICorner", card2).CornerRadius = UDim.new(0, 5)

    local lbl2 = Instance.new("TextLabel")
    lbl2.Size = UDim2.new(1, -75, 1, 0)
    lbl2.Position = UDim2.new(0, 8, 0, 0)
    lbl2.Text = "Fly Speed:"
    lbl2.Font = Enum.Font.GothamMedium
    lbl2.TextSize = 11
    lbl2.TextColor3 = Color3.fromRGB(200, 200, 200)
    lbl2.BackgroundTransparency = 1
    lbl2.TextXAlignment = Enum.TextXAlignment.Left
    lbl2.Parent = card2

    local speedBox = Instance.new("TextBox")
    speedBox.Size = UDim2.new(0, 55, 0, 22)
    speedBox.Position = UDim2.new(1, -62, 0.5, -11)
    speedBox.Text = tostring(FlySpeed)
    speedBox.Font = Enum.Font.GothamBold
    speedBox.TextSize = 11
    speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    speedBox.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    speedBox.Parent = card2
    Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0, 4)

    speedBox.FocusLost:Connect(function()
        local val = tonumber(speedBox.Text)
        if val and val > 0 then FlySpeed = val else speedBox.Text = tostring(FlySpeed) end
    end)
end

SetupFlyUI()

-- QUÉT DUMMY VÀ PLAYERS
local function ScanDummies()
    for _, child in ipairs(PlayerScroll:GetChildren()) do if child:IsA("Frame") then child:Destroy() end end
    for _, child in ipairs(DummyScroll:GetChildren()) do if child:IsA("Frame") then child:Destroy() end end
    for _, child in ipairs(LockOnScroll:GetChildren()) do if child:IsA("Frame") then child:Destroy() end end

    -- Load Players
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local fullName = p.DisplayName .. " (@" .. p.Name .. ")"
            CreateCard(PlayerScroll, fullName, p.Character, false)
            CreateCard(LockOnScroll, "[P] " .. fullName, p.Character, true)
        end
    end

    -- Load Dummies / Mobs
    local cached = {}
    local function CheckAndAdd(obj)
        if obj:IsA("Model") and obj ~= LocalPlayer.Character and not cached[obj] then
            local r, h = GetCharParts(obj)
            if r and h and not Players:GetPlayerFromCharacter(obj) then
                cached[obj] = true
                CreateCard(DummyScroll, obj.Name, obj, false)
                CreateCard(LockOnScroll, "[D] " .. obj.Name, obj, true)
            end
        end
    end

    for _, obj in ipairs(workspace:GetChildren()) do CheckAndAdd(obj) end
    for _, f in ipairs(workspace:GetChildren()) do
        if f:IsA("Folder") or f:IsA("Model") then
            for _, sub in ipairs(f:GetChildren()) do CheckAndAdd(sub) end
        end
    end
end

RefreshBtn.MouseButton1Click:Connect(ScanDummies)

-- MINIMIZE & CLOSE CONTROL
local function ToggleGUI()
    MainFrame.Visible = not MainFrame.Visible
    MiniBtn.Visible = not MainFrame.Visible
end

MinimizeBtn.MouseButton1Click:Connect(ToggleGUI)
MiniBtn.MouseButton1Click:Connect(ToggleGUI)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MiniBtn.Visible = false
    if Flying then Flying = false; StopFly() end
    StopTeleport()
    StopLockOn()
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.X then
        ToggleGUI()
    end
end)

Players.PlayerAdded:Connect(ScanDummies)
Players.PlayerRemoving:Connect(ScanDummies)

ScanDummies()
