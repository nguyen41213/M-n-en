local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "BlackScreen"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

------------------------------------------------
-- CREDIT
------------------------------------------------

local label = Instance.new("TextLabel")

label.Parent = gui
label.Size = UDim2.new(0,320,0,55)

label.Position =
	UDim2.new(
		0.5,-160,
		0.22,0
	)

label.BackgroundTransparency = 1

label.RichText = true

label.TextScaled = true

label.Font =
	Enum.Font.GothamBold

label.Text =
'<font color="rgb(120,190,255)">By</font> @n_g_uy_e_n\nFlow để mình có động lực làm script'

label.TextColor3 =
	Color3.new(1,1,1)

task.spawn(function()

	task.wait(2)

	if label then
		label:Destroy()
	end

end)

------------------------------------------------
-- BLACK SCREEN
------------------------------------------------

local black =
	Instance.new("Frame")

black.Parent =
	gui

black.Size =
	UDim2.new(
		1,0,
		1,0
	)

black.BackgroundColor3 =
	Color3.new(
		0,
		0,
		0
	)

black.BorderSizePixel =
	0

-- MỞ SCRIPT KHÔNG ĐEN
local screenEnabled =
	false

black.Visible =
	false

------------------------------------------------
-- BUTTON
------------------------------------------------

local button =
	Instance.new(
		"TextButton"
	)

button.Parent =
	gui

button.Size =
	UDim2.new(
		0,
		96,
		0,
		24
	)

button.Position =
	UDim2.new(
		0.45,
		0,
		0.1,
		0
	)

button.BackgroundColor3 =
	Color3.fromRGB(
		30,
		30,
		30
	)

button.BorderColor3 =
	Color3.new(
		1,
		1,
		1
	)

button.BorderSizePixel =
	1

-- BAN ĐẦU ON
button.Text =
	"ON"

button.TextColor3 =
	Color3.new(
		1,
		1,
		1
	)

button.TextScaled =
	true

button.Font =
	Enum.Font.GothamBold

------------------------------------------------
-- BO NHẸ
------------------------------------------------

local corner =
	Instance.new(
		"UICorner"
	)

corner.Parent =
	button

corner.CornerRadius =
	UDim.new(
		0,
		6
	)

------------------------------------------------
-- TOGGLE
------------------------------------------------

local busy =
	false

button.MouseButton1Click:Connect(function()

	if busy then
		return
	end

	busy =
		true

	screenEnabled =
		not screenEnabled

	black.Visible =
		screenEnabled

	if screenEnabled then

		button.Text =
			"OFF"

	else

		button.Text =
			"ON"

	end

	task.wait(
		0.3
	)

	busy =
		false

end)

------------------------------------------------
-- DRAG
------------------------------------------------

local dragging =
	false

local dragInput

local dragStart

local startPos

button.InputBegan:Connect(function(input)

	if input.UserInputType
	==
	Enum.UserInputType.MouseButton1

	or

	input.UserInputType
	==
	Enum.UserInputType.Touch

	then

		dragging =
			true

		dragInput =
			input

		dragStart =
			input.Position

		startPos =
			button.Position

		input.Changed:Connect(function()

			if input.UserInputState
			==
			Enum.UserInputState.End then

				dragging =
					false

			end

		end)

	end

end)

UIS.InputChanged:Connect(function(input)

	if dragging
	and
	input
	==
	dragInput

	then

		local delta =
			input.Position
			-
			dragStart

		button.Position =
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
