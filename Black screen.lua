local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("BlackScreen") then
	playerGui.BlackScreen:Destroy()
end

------------------------------------------------
-- GUI
------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Name = "BlackScreen"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

------------------------------------------------
-- CREDIT
------------------------------------------------

local label = Instance.new("TextLabel")

label.Parent = gui
label.Size = UDim2.new(0.5,0,0.2,0)
label.Position = UDim2.new(0.25,0,0.2,0)

label.BackgroundTransparency = 1
label.RichText = true
label.TextScaled = true
label.Font = Enum.Font.GothamBold

label.Text =
'<font color="rgb(120,190,255)">By</font> @n_g_uy_e_n\nFlow để mình có động lực làm script'

label.TextColor3 = Color3.new(1,1,1)

task.delay(5,function()

	if label then
		label:Destroy()
	end

end)

------------------------------------------------
-- BLACK SCREEN
------------------------------------------------

local black = Instance.new("Frame")

black.Parent = gui
black.Size = UDim2.new(1,0,1,0)

black.BackgroundColor3 =
	Color3.new(0,0,0)

black.BorderSizePixel = 0

black.Visible = false

------------------------------------------------
-- BUTTON
------------------------------------------------

local button =
	Instance.new("TextButton")

button.Parent = gui

button.Size =
	UDim2.new(0,100,0,30)

button.Position =
	UDim2.new(0.45,0,0.1,0)

button.BackgroundColor3 =
	Color3.fromRGB(30,30,30)

button.Text = "ON"

button.TextColor3 =
	Color3.new(1,1,1)

button.TextScaled = true

button.Font =
	Enum.Font.GothamBold

local corner =
	Instance.new("UICorner")

corner.Parent = button

corner.CornerRadius =
	UDim.new(0,6)

------------------------------------------------
-- TIME FPS
------------------------------------------------

local info =
	Instance.new("TextLabel")

info.Parent = gui

info.Size =
	UDim2.new(0,90,0,35)

info.Position =
	UDim2.new(0,10,1,-45)

info.BackgroundColor3 =
	Color3.fromRGB(20,20,20)

info.BackgroundTransparency =
	0.2

info.TextColor3 =
	Color3.new(1,1,1)

info.TextScaled = true

info.Font =
	Enum.Font.GothamBold

local infoCorner =
	Instance.new("UICorner")

infoCorner.Parent = info

infoCorner.CornerRadius =
	UDim.new(0,6)

------------------------------------------------
-- FPS TIMER
------------------------------------------------

local start =
	os.clock()

local frames = 0
local fps = 0
local last = os.clock()

RunService.RenderStepped:Connect(function()

	frames += 1

	local now =
		os.clock()

	if now-last >= 1 then

		fps =
			frames

		frames =
			0

		last =
			now

	end

	local sec =
		math.floor(
			now-start
		)

	local m =
		math.floor(
			(sec%3600)/60
		)

	local s =
		sec%60

	info.Text =
		string.format(
			"%02d:%02d\nFPS:%d",
			m,
			s,
			fps
		)

end)

------------------------------------------------
-- ON OFF
------------------------------------------------

local enabled =
	false

local busy =
	false

button.MouseButton1Click:Connect(function()

	if busy then
		return
	end

	busy = true

	enabled =
		not enabled

	black.Visible =
		enabled

	if enabled then
		button.Text =
			"OFF"
	else
		button.Text =
			"ON"
	end

	task.wait(0.2)

	busy = false

end)

------------------------------------------------
-- DRAG FUNCTION
------------------------------------------------

local function drag(ui)

	local dragging =
		false

	local dragStart
	local startPos

	ui.InputBegan:Connect(function(input)

		if input.UserInputType ==
		Enum.UserInputType.MouseButton1

		or

		input.UserInputType ==
		Enum.UserInputType.Touch then

			dragging =
				true

			dragStart =
				input.Position

			startPos =
				ui.Position

		end

	end)

	ui.InputEnded:Connect(function(input)

		if input.UserInputType ==
		Enum.UserInputType.MouseButton1

		or

		input.UserInputType ==
		Enum.UserInputType.Touch then

			dragging =
				false

		end

	end)

	UIS.InputChanged:Connect(function(input)

		if dragging

		and

		(
			input.UserInputType ==
			Enum.UserInputType.MouseMovement

			or

			input.UserInputType ==
			Enum.UserInputType.Touch
		)

		then

			local delta =
				input.Position
				-
				dragStart

			ui.Position =
				UDim2.new(

					startPos.X.Scale,

					startPos.X.Offset
					+
					delta.X,

					startPos.Y.Scale,

					startPos.Y.Offset
					+
					delta.Y

				)

		end

	end)

end

drag(button)
drag(info)
