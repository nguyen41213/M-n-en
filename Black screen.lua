local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "BlackScreenGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Màn hình đen
local black = Instance.new("Frame")
black.Size = UDim2.new(1,0,1,0)
black.BackgroundColor3 = Color3.fromRGB(0,0,0)
black.BorderSizePixel = 0
black.Parent = gui

-- Nút ON/OFF
local button = Instance.new("TextButton")
button.Parent = gui

-- gần ~2cm x 0.5cm (tương đối)
button.Size = UDim2.new(0.12,0,0.045,0)

button.Position = UDim2.new(0.45,0,0.1,0)

button.Text = "ON | OFF"
button.TextColor3 = Color3.new(1,1,1)

button.BackgroundColor3 = Color3.fromRGB(40,40,40)

button.TextScaled = true
button.BorderSizePixel = 2
button.AutoButtonColor = true

local enabled = true

button.MouseButton1Click:Connect(function()

	if enabled then
		black.Visible = false
		button.BackgroundColor3 =
			Color3.fromRGB(90,90,90)
	else
		black.Visible = true
		button.BackgroundColor3 =
			Color3.fromRGB(40,40,40)
	end

	enabled = not enabled
end)

-- Kéo nút
local dragging = false
local dragStart
local startPos

button.InputBegan:Connect(function(input)
	if input.UserInputType ==
		Enum.UserInputType.MouseButton1
	then
		dragging = true
		dragStart = input.Position
		startPos = button.Position

		input.Changed:Connect(function()
			if input.UserInputState ==
				Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)

	if dragging and
		input.UserInputType ==
		Enum.UserInputType.MouseMovement
	then

		local delta =
			input.Position - dragStart

		button.Position =
			UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,

				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
	end
end)
