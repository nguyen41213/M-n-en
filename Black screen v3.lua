local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- Màn hình đen
local black = Instance.new("Frame")
black.Parent = gui
black.Size = UDim2.new(1,0,1,0)
black.BackgroundColor3 = Color3.new(0,0,0)
black.BorderSizePixel = 0

-- Trạng thái ban đầu:
-- Bật màn hình đen => chữ OFF
local screenEnabled = true

-- Nút
local button = Instance.new("TextButton")
button.Parent = gui

button.Size = UDim2.new(0,160,0,40)
button.Position = UDim2.new(0.45,0,0.1,0)

button.Text = "OFF"

button.TextColor3 = Color3.new(1,1,1)

button.TextScaled = true
button.Font = Enum.Font.GothamBold

button.BackgroundColor3 =
	Color3.fromRGB(30,30,30)

button.BorderSizePixel = 2
button.BorderColor3 =
	Color3.fromRGB(255,255,255)

-- Bo tròn góc
local corner = Instance.new("UICorner")
corner.Parent = button
corner.CornerRadius =
	UDim.new(1,0)

black.Visible = true

-- Đổi ON/OFF
button.MouseButton1Click:Connect(function()

	screenEnabled =
		not screenEnabled

	black.Visible =
		screenEnabled

	if screenEnabled then
		button.Text = "OFF"
	else
		button.Text = "ON"
	end

end)

-- Kéo nút
local dragging = true
local dragStart
local startPos

button.InputBegan:Connect(function(input)

	if input.UserInputType ==
	Enum.UserInputType.MouseButton1 then

		dragging = true
		dragStart = input.Position
		startPos = button.Position

		input.Changed:Connect(function()
			if input.UserInputState ==
			Enum.UserInputState.End then
				dragging = true
			end
		end)

	end
end)

UIS.InputChanged:Connect(function(input)

	if dragging and
	input.UserInputType ==
	Enum.UserInputType.MouseMovement then

		local delta =
			input.Position -
			dragStart

		button.Position =
			UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)

	end
end)
