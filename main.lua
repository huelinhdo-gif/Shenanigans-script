local P, RS, UIS = game:GetService("Players"), game:GetService("RunService"), game:GetService("UserInputService")
local LP = P.LocalPlayer
local Cam = workspace.CurrentCamera

-- Xóa sạch tận gốc mọi giao diện cũ bị kẹt lại
for _, gui in ipairs(LP:WaitForChild("PlayerGui"):GetChildren()) do
    if gui.Name == "ShenanigansHub_V5" or gui.Name == "SukunaHub" then
        gui:Destroy()
    end
end

local Gui = Instance.new("ScreenGui", LP.PlayerGui)
Gui.Name = "ShenanigansHub_V5"
Gui.ResetOnSpawn = false
Gui.DisplayOrder = 999

-- Khung chính tông đỏ đen đậm đặc biệt
local MF = Instance.new("Frame", Gui)
MF.Size, MF.Position, MF.BackgroundColor3, MF.Active, MF.Draggable, MF.BorderSizePixel = UDim2.new(0, 480, 0, 300), UDim2.new(0.5, -240, 0.5, -150), Color3.fromRGB(15, 3, 3), true, true, 0
Instance.new("UICorner", MF).CornerRadius = UDim.new(0, 10)

-- Viền to dày đỏ rực
local US = Instance.new("UIStroke", MF) 
US.Thickness = 5 
US.Color = Color3.fromRGB(255, 20, 20)

-- Nút mở lại Hub ngoài màn hình
local MB = Instance.new("TextButton", Gui)
MB.Size, MB.Position, MB.BackgroundColor3, MB.Text, MB.Font, MB.TextSize, MB.TextColor3, MB.Visible, MB.Active, MB.Draggable = UDim2.new(0, 45, 0, 45), UDim2.new(0, 15, 0, 150), Color3.fromRGB(20, 5, 5), "SKN", Enum.Font.GothamBold, 11, Color3.fromRGB(255,50,50), false, true, true
Instance.new("UICorner", MB).CornerRadius = UDim.new(1, 0)
local MS = Instance.new("UIStroke", MB) MS.Thickness = 3 MS.Color = Color3.fromRGB(255, 20, 20)

-- Thanh tiêu đề
local TB = Instance.new("Frame", MF)
TB.Size, TB.BackgroundColor3, TB.BorderSizePixel = UDim2.new(1, 0, 0, 32), Color3.fromRGB(35, 5, 5), 0
Instance.new("UICorner", TB).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", TB)
Title.Size, Title.Position, Title.Text, Title.Font, Title.TextSize, Title.TextColor3, Title.BackgroundTransparency, Title.TextXAlignment = UDim2.new(0, 220, 1, 0), UDim2.new(0, 12, 0, 0), "SUKUNA HUB | FIXED", Enum.Font.GothamBold, 12, Color3.fromRGB(255, 80, 80), true, Enum.TextXAlignment.Left

local CB = Instance.new("TextButton", TB)
CB.Size, CB.Position, CB.Text, CB.Font, CB.TextSize, CB.TextColor3, CB.BackgroundTransparency = UDim2.new(0, 30, 1, 0), UDim2.new(1, -30, 0, 0), "X", Enum.Font.GothamBold, 13, Color3.fromRGB(220,220,220), true

local MinB = Instance.new("TextButton", TB)
MinB.Size, MinB.Position, MinB.Text, MinB.Font, MinB.TextSize, MinB.TextColor3, MinB.BackgroundTransparency = UDim2.new(0, 30, 1, 0), UDim2.new(1, -60, 0, 0), "-", Enum.Font.GothamBold, 18, Color3.fromRGB(220,220,220), true

MinB.MouseButton1Click:Connect(function() MF.Visible = false MB.Visible = true end)
MB.MouseButton1Click:Connect(function() MF.Visible = true MB.Visible = false end)
CB.MouseButton1Click:Connect(function() Gui:Destroy() end)

-- Menu chọn tính năng bên trái
local SB = Instance.new("Frame", MF)
SB.Size, SB.Position, SB.BackgroundColor3, SB.BorderSizePixel = UDim2.new(0, 115, 1, -32), UDim2.new(0, 0, 0, 32), Color3.fromRGB(22, 4, 4), 0
local SL = Instance.new("UIListLayout", SB) SL.Padding = UDim.new(0, 4) SL.SortOrder = Enum.SortOrder.LayoutOrder
local SP = Instance.new("UIPadding", SB) SP.PaddingTop, SP.PaddingLeft, SP.PaddingRight = UDim.new(0, 6), UDim.new(0, 6), UDim.new(0, 6)

-- Khung hiển thị nội dung bên phải (Đã fix màu nền tối, không bị xám nữa)
local CF = Instance.new("Frame", MF)
CF.Size, CF.Position, CF.BackgroundColor3, CF.BorderSizePixel = UDim2.new(1, -115, 1, -36), UDim2.new(0, 115, 0, 34), Color3.fromRGB(25, 6, 6), 0

local function CTB(name)
	local b = Instance.new("TextButton", SB)
	b.Size, b.Text, b.Font, b.TextSize, b.TextColor3, b.BackgroundColor3, b.BorderSizePixel = UDim2.new(1, 0, 0, 26), name, Enum.Font.GothamMedium, 10, Color3.fromRGB(200,200,200), Color3.fromRGB(40, 8, 8), 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
	return b
end

local PBtn, UBtn, LBtn, EBtn, BBtn, MBtn, RBtn = CTB("Players"), CTB("ULT"), CTB("Lock On"), CTB("ESP Target"), CTB("Auto Block"), CTB("Misc / Fly"), CTB("🔄 Refresh")

local function CSC()
	local s = Instance.new("ScrollingFrame", CF)
	s.Size, s.BackgroundTransparency, s.ScrollBarThickness, s.Visible = UDim2.new(1, -6, 1, 0), true, 3, false
	local l = Instance.new("UIListLayout", s) l.Padding = UDim.new(0, 5) l.SortOrder = Enum.SortOrder.LayoutOrder
	l:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() s.CanvasSize = UDim2.new(0, 0, 0, l.AbsoluteContentSize.Y) end)
	return s
end

local PSc, USc, LSc, ESc, BSc, MSc = CSC(), CSC(), CSC(), CSC(), CSC(), CSC()
USc.Visible = true

local function ST(ab, as)
	for _, btn in ipairs({PBtn, UBtn, LBtn, EBtn, BBtn, MBtn}) do btn.BackgroundColor3 = Color3.fromRGB(40, 8, 8) btn.TextColor3 = Color3.fromRGB(200,200,200) end
	for _, sc in ipairs({PSc, USc, LSc, ESc, BSc, MSc}) do sc.Visible = false end
	ab.BackgroundColor3 = Color3.fromRGB(180, 20, 20) ab.TextColor3 = Color3.new(1,1,1) as.Visible = true
end

PBtn.MouseButton1Click:Connect(function() ST(PBtn, PSc) end)
UBtn.MouseButton1Click:Connect(function() ST(UBtn, USc) end)
LBtn.MouseButton1Click:Connect(function() ST(LBtn, LSc) end)
EBtn.MouseButton1Click:Connect(function() ST(EBtn, ESc) end)
BBtn.MouseButton1Click:Connect(function() ST(BBtn, BSc) end)
MBtn.MouseButton1Click:Connect(function() ST(MBtn, MSc) end)

local TargetModel, LockOnTargetModel = nil, nil
local Flying, FlySpeed, BBV, BBG, Noclip, InfJump = false, 50, nil, nil, false, false
local ESP_P, ESP_S = false, false

local function GetRH(m)
	if not m or not m.Parent then return nil, nil end
	return m:FindFirstChild("HumanoidRootPart") or m:FindFirstChild("Torso") or m:FindFirstChild("UpperTorso") or m.PrimaryPart, m:FindFirstChildOfClass("Humanoid")
end

local function CreateToggle(sc, txt, cb)
	local c = Instance.new("Frame", sc) c.Size, c.BackgroundColor3 = UDim2.new(1, -4, 0, 34), Color3.fromRGB(35, 8, 8)
	Instance.new("UICorner", c).CornerRadius = UDim.new(0, 5)
	local l = Instance.new("TextLabel", c) l.Size, l.Position, l.Text, l.Font, l.TextSize, l.TextColor3, l.BackgroundTransparency, l.TextXAlignment = UDim2.new(1, -65, 1, 0), UDim2.new(0, 8, 0, 0), txt, Enum.Font.GothamBold, 11, Color3.new(1,1,1), true, Enum.TextXAlignment.Left
	local b = Instance.new("TextButton", c) b.Size, b.Position, b.Text, b.Font, b.TextSize, b.BackgroundColor3 = UDim2.new(0, 48, 0, 20), UDim2.new(1, -54, 0.5, -10), "OFF", Enum.Font.GothamBold, 10, Color3.fromRGB(180, 40, 40)
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
	local st = false
	b.MouseButton1Click:Connect(function() st = not st b.Text = st and "ON" or "OFF" b.BackgroundColor3 = st and Color3.fromRGB(0, 160, 60) or Color3.fromRGB(180, 40, 40) cb(st) end)
end

CreateToggle(ESc, "ESP Player", function(s) ESP_P = s end)
CreateToggle(ESc, "Khoảng Cách Studs", function(s) ESP_S = s end)
CreateToggle(MSc, "Enable Fly", function(s) Flying = s if s then local c = LP.Character if c then local r, h = GetRH(c) if r and h then BBV, BBG = Instance.new("BodyVelocity", r), Instance.new("BodyGyro", r) BBV.MaxForce, BBG.MaxTorque = Vector3.new(1e9,1e9,1e9), Vector3.new(1e9,1e9,1e9) h.PlatformStand = true end end else if BBV then BBV:Destroy() end if BBG then BBG:Destroy() end local c = LP.Character if c then local h = c:FindFirstChildOfClass("Humanoid") if h then h.PlatformStand = false end end end end)
CreateToggle(MSc, "Noclip", function(s) Noclip = s end)
CreateToggle(MSc, "Inf Jump", function(s) InfJump = s end)

UIS.JumpRequest:Connect(function()
	if InfJump then local c = LP.Character if c then local h = c:FindFirstChildOfClass("Humanoid") if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end end
end)

RS.RenderStepped:Connect(function()
	local mc = LP.Character local mr, mh = GetRH(mc)
	if Noclip and mc then for _, p in ipairs(mc:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
	if mr then
		if TargetModel then local tr, th = GetRH(TargetModel) if tr and (not th or th.Health > 0) then mr.CFrame = tr.CFrame * CFrame.new(0, 0, 3) else TargetModel = nil end end
		if LockOnTargetModel then local lr, lh = GetRH(LockOnTargetModel) if lr and (not lh or lh.Health > 0) then mr.CFrame = CFrame.new(mr.Position, Vector3.new(lr.Position.X, mr.Position.Y, lr.Position.Z)) else LockOnTargetModel = nil end end
		if Flying and BBV and BBG then
			BBG.CFrame = Cam.CFrame
			local d = Vector3.zero
			if UIS:IsKeyDown(Enum.KeyCode.W) then d += Cam.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.S) then d -= Cam.CFrame.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.A) then d -= Cam.CFrame.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.D) then d += Cam.CFrame.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.Space) then d += Vector3.new(0,1,0) end
			if mh and mh.MoveDirection.Magnitude > 0 then d = Cam.CFrame:VectorToWorldSpace(mh.MoveDirection) end
			BBV.Velocity = d * FlySpeed
		end
	end
	for _, p in ipairs(P:GetPlayers()) do
		if p ~= LP and p.Character then
			local pr, ph = GetRH(p.Character)
			if pr then
				local eb = pr:FindFirstChild("TargetPlayerESP")
				if ESP_P then
					if not eb then
						eb = Instance.new("BillboardGui", pr) eb.Name, eb.Size, eb.StudsOffset, eb.AlwaysOnTop = "TargetPlayerESP", UDim2.new(0, 200, 0, 40), Vector3.new(0, 3.5, 0), true
						local nl = Instance.new("TextLabel", eb) nl.Name, nl.Size, nl.BackgroundTransparency, nl.Font, nl.TextSize = "NameLabel", UDim2.new(1,0,0.5,0), true, Enum.Font.GothamBold, 13
						local dl = Instance.new("TextLabel", eb) dl.Name, dl.Size, dl.Position, dl.BackgroundTransparency, dl.Font, dl.TextSize = "DistLabel", UDim2.new(1,0,0.5,0), UDim2.new(0,0,0.5,0), true, Enum.Font.GothamMedium, 11
					end
					eb.NameLabel.Text = p.DisplayName.." (@"..p.Name..")" eb.NameLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
					if ESP_S and mr then eb.DistLabel.Text = math.floor((mr.Position - pr.Position).Magnitude).." Studs" eb.DistLabel.TextColor3 = Color3.new(1,1,1) eb.DistLabel.Visible = true else eb.DistLabel.Visible = false end
				elseif eb then eb:Destroy() end
			end
		end
	end
end)

local function Populate()
	for _, c in ipairs(PSc:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
	for _, c in ipairs(LSc:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
	for _, p in ipairs(P:GetPlayers()) do
		if p ~= LP and p.Character then
			for _, isL in ipairs({false, true}) do
				local sc = isL and LSc or PSc
				local c = Instance.new("Frame", sc) c.Size, c.BackgroundColor3 = UDim2.new(1, -4, 0, 32), Color3.fromRGB(35, 8, 8)
				Instance.new("UICorner", c).CornerRadius = UDim.new(0, 5)
				local l = Instance.new("TextLabel", c) l.Size, l.Position, l.Text, l.Font, l.TextSize, l.TextColor3, l.BackgroundTransparency, l.TextXAlignment = UDim2.new(1, -65, 1, 0), UDim2.new(0, 8, 0, 0), p.DisplayName, Enum.Font.Gotham, 11, Color3.fromRGB(220,220,220), true, Enum.TextXAlignment.Left
				local b = Instance.new("TextButton", c) b.Size, b.Position, b.Text, b.Font, b.TextSize, b.BackgroundColor3 = UDim2.new(0, 48, 0, 20), UDim2.new(1, -54, 0.5, -10), "OFF", Enum.Font.GothamBold, 10, Color3.fromRGB(180, 40, 40)
				Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
				local mo = p.Character
				b.MouseButton1Click:Connect(function()
					if isL then
						LockOnTargetModel = (LockOnTargetModel == mo) and nil or mo
						b.Text, b.BackgroundColor3 = LockOnTargetModel == mo and "ON" or "OFF", LockOnTargetModel == mo and Color3.fromRGB(0, 160, 60) or Color3.fromRGB(180, 40, 40)
					else
						TargetModel = (TargetModel == mo) and nil or mo
						b.Text, b.BackgroundColor3 = TargetModel == mo and "ON" or "OFF", TargetModel == mo and Color3.fromRGB(0, 160, 60) or Color3.fromRGB(180, 40, 40)
					end
				end)
			end
		end
	end
end

RBtn.MouseButton1Click:Connect(Populate)
P.PlayerAdded:Connect(Populate)
P.PlayerRemoving:Connect(Populate)
Populate()
