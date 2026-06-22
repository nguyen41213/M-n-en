repeat task.wait() until game:IsLoaded()

local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local RunService=game:GetService("RunService")
local Lighting=game:GetService("Lighting")

local player=Players.LocalPlayer
local guiParent=player:WaitForChild("PlayerGui")

if guiParent:FindFirstChild("BlackScreen") then
	guiParent.BlackScreen:Destroy()
end

pcall(function()
	if setfpscap then
		setfpscap(45)
	end
end)

------------------------------------------------
-- LOW GRAPHIC
------------------------------------------------

local function clean(v)

	if v:IsA("BasePart") then

		v.Material=
			Enum.Material.SmoothPlastic

		v.Reflectance=0

		v.CastShadow=false

	elseif
	v:IsA("Texture")
	or
	v:IsA("Decal")

	then

		v.Transparency=1

	elseif

	v:IsA("ParticleEmitter")
	or
	v:IsA("Trail")
	or
	v:IsA("Smoke")
	or
	v:IsA("Sparkles")

	then

		v.Enabled=false

	end

end

local function LowGraphic()

	local Terrain=
	workspace:FindFirstChildOfClass(
		"Terrain"
	)

	pcall(function()

		settings().Rendering.QualityLevel=1

		if Terrain then

			Terrain.WaterWaveSize=0
			Terrain.WaterWaveSpeed=0
			Terrain.WaterReflectance=0
			Terrain.WaterTransparency=0

		end

		Lighting.GlobalShadows=false
		Lighting.FogEnd=9e9
		Lighting.Brightness=2

	end)

	if workspace:FindFirstChild(
		"Clouds"
	)

	then

		workspace.Clouds:Destroy()

	end

	for _,
	v in pairs(
		Lighting:GetChildren()
	)

	do

		if v:IsA(
			"PostEffect"
		)

		then

			v.Enabled=false

		end

	end

	for i,v in pairs(
		workspace:GetDescendants()
	)

	do

		clean(v)

		if i%300==0 then
			task.wait()
		end

	end

	workspace.DescendantAdded:Connect(function(v)

		task.wait()

		clean(v)

	end)

end

LowGraphic()

------------------------------------------------
-- GUI
------------------------------------------------

local gui=
Instance.new("ScreenGui")

gui.Name="BlackScreen"

gui.Parent=guiParent

gui.ResetOnSpawn=false

gui.IgnoreGuiInset=true

------------------------------------------------
-- CREDIT
------------------------------------------------

local label=
Instance.new(
"TextLabel"
)

label.Parent=gui

label.Size=
UDim2.new(
0.5,
0,
0.2,
0
)

label.Position=
UDim2.new(
0.25,
0,
0.2,
0
)

label.BackgroundTransparency=1

label.RichText=true

label.TextScaled=true

label.Font=
Enum.Font.GothamBold

label.Text=
'<font color="rgb(120,190,255)">By</font> @n_g_uy_e_n\nFlow để mình có động lực làm script'

task.delay(5,function()

	if label then
		label:Destroy()
	end

end)

------------------------------------------------
-- BLACK
------------------------------------------------

local black=
Instance.new(
"Frame"
)

black.Parent=gui

black.Size=
UDim2.new(
1,
0,
1,
0
)

black.BackgroundColor3=
Color3.new()

black.BorderSizePixel=0

black.Visible=false

------------------------------------------------
-- BUTTON
------------------------------------------------

local button=
Instance.new(
"TextButton"
)

button.Parent=gui

button.Size=
UDim2.new(
0,
96,
0,
24
)

button.Position=
UDim2.new(
0.45,
0,
0.1,
0
)

button.Text="ON"

button.TextScaled=true

button.TextColor3=
Color3.new(
1,
1,
1
)

button.BackgroundColor3=
Color3.fromRGB(
30,
30,
30
)

button.Font=
Enum.Font.GothamBold

Instance.new(
"UICorner",
button
).CornerRadius=
UDim.new(
0,
6
)

------------------------------------------------
-- INFO
------------------------------------------------

local info=
Instance.new(
"TextLabel"
)

info.Parent=gui

info.Size=
UDim2.new(
0,
120,
0,
40
)

info.Position=
UDim2.new(
0,
10,
1,
-50
)

info.TextScaled=true

info.BackgroundColor3=
Color3.fromRGB(
20,
20,
20
)

info.TextColor3=
Color3.new(
1,
1,
1
)

Instance.new(
"UICorner",
info
).CornerRadius=
UDim.new(
0,
6
)

------------------------------------------------
-- FPS
------------------------------------------------

local start=
os.clock()

local fps=0

local frames=0

local last=os.clock()

RunService.RenderStepped:Connect(function()

	frames+=1

	local now=
	os.clock()

	if now-last>=1 then

		fps=frames

		frames=0

		last=now

	end

	local total=
	math.floor(
		now-start
	)

	local h=
	math.floor(
		total/3600
	)

	local m=
	math.floor(
		(total%3600)/60
	)

	local s=
	total%60

	info.Text=
	string.format(
		"%02d:%02d:%02d\nFPS:%d",
		h,
		m,
		s,
		fps
	)

end)

------------------------------------------------
-- ON OFF
------------------------------------------------

local enabled=false

button.MouseButton1Click:Connect(function()

	enabled=
	not enabled

	black.Visible=
	enabled

	button.Text=
	enabled
	and
	"OFF"
	or
	"ON"

end)

------------------------------------------------
-- DRAG
------------------------------------------------

local function drag(ui)

	local hold=false
	local start
	local pos

	ui.InputBegan:Connect(function(i)

		if i.UserInputType==
		Enum.UserInputType.Touch

		or

		i.UserInputType==
		Enum.UserInputType.MouseButton1

		then

			hold=true

			start=i.Position

			pos=ui.Position

		end

	end)

	ui.InputEnded:Connect(function()

		hold=false

	end)

	UIS.InputChanged:Connect(function(i)

		if hold then

			local d=
			i.Position-start

			ui.Position=
			UDim2.new(

				pos.X.Scale,

				pos.X.Offset+d.X,

				pos.Y.Scale,

				pos.Y.Offset+d.Y

			)

		end

	end)

end

drag(button)
drag(info)
