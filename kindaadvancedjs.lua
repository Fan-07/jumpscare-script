local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local part = workspace:WaitForChild("TouchPart") -- the part that triggers scare
local imageLabel = script.Parent:WaitForChild("ImageLabel")

-- pools, add however many u want
local soundPool = {
	script.Parent:WaitForChild("JumpscareSound1"),
	-- script.Parent:WaitForChild("JumpscareSound2"),
}
local imagePool = {
	"rbxassetid://0000000000", -- swap w/ ur image ids
	-- "rbxassetid://1111111111",
}

local cooldown = false

local shakeDuration = 0.5
local shakeIntensity = 0.2
local fovPunch = 15        -- how much fov shrinks (zoom efect)
local freezeDuration = 0.6 -- how long char is lockd in place
local blurSize = 18
local vignetteColor = Color3.fromRGB(150, 0, 0)

-- shakes the camera
local function screenShake(duration, intensity)
	local startTime = tick()
	local connection
	connection = RunService.RenderStepped:Connect(function()
		local elapsed = tick() - startTime
		if elapsed >= duration then
			connection:Disconnect()
			return
		end
		local falloff = 1 - (elapsed / duration)
		local ox = (math.random() - 0.5) * intensity * falloff
		local oy = (math.random() - 0.5) * intensity * falloff
		local oz = (math.random() - 0.5) * intensity * falloff
		camera.CFrame = camera.CFrame * CFrame.new(ox, oy, oz)
	end)
end

-- quick zoom-in punch on the fov then to mormal
local function fovPunchEffect()
	local originalFOV = camera.FieldOfView
	local tweenIn = TweenService:Create(camera, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {FieldOfView = originalFOV - fovPunch})
	local tweenOut = TweenService:Create(camera, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {FieldOfView = originalFOV})
	tweenIn:Play()
	tweenIn.Completed:Connect(function()
		tweenOut:Play()
	end)
end

-- locks char in place so they cant just walk it off mid scare
local function freezeCharacter(duration)
	local character = player.Character
	if not character then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	local originalWalkSpeed = humanoid.WalkSpeed
	local originalJumpPower = humanoid.JumpPower

	humanoid.WalkSpeed = 0
	humanoid.JumpPower = 0

	task.wait(duration)

	humanoid.WalkSpeed = originalWalkSpeed
	humanoid.JumpPower = originalJumpPower
end

-- adds blur + red tint 4 extra impact, then fades/cleans it up after
local function applyPostProcessing(duration)
	local blur = Instance.new("BlurEffect")
	blur.Size = 0
	blur.Parent = Lighting

	local colorCorrect = Instance.new("ColorCorrectionEffect")
	colorCorrect.TintColor = Color3.new(1, 1, 1)
	colorCorrect.Saturation = 0
	colorCorrect.Parent = Lighting

	local blurTweenIn = TweenService:Create(blur, TweenInfo.new(0.1), {Size = blurSize})
	local colorTweenIn = TweenService:Create(colorCorrect, TweenInfo.new(0.15), {TintColor = vignetteColor, Saturation = -0.4})

	blurTweenIn:Play()
	colorTweenIn:Play()

	task.wait(duration)

	local blurTweenOut = TweenService:Create(blur, TweenInfo.new(0.5), {Size = 0})
	local colorTweenOut = TweenService:Create(colorCorrect, TweenInfo.new(0.5), {TintColor = Color3.new(1, 1, 1), Saturation = 0})

	blurTweenOut:Play()
	colorTweenOut:Play()

	blurTweenOut.Completed:Connect(function()
		blur:Destroy()
	end)
	colorTweenOut.Completed:Connect(function()
		colorCorrect:Destroy()
	end)
end

local function gitPunchIn(label)
	local originalSize = label.Size
	local overshoot = UDim2.new(originalSize.X.Scale * 1.15, 0, originalSize.Y.Scale * 1.15, 0)

	label.Size = UDim2.new(originalSize.X.Scale * 0.7, 0, originalSize.Y.Scale * 0.7, 0)

	local tweenUp = TweenService:Create(label, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = overshoot})
	local tweenSettle = TweenService:Create(label, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = originalSize})

	tweenUp:Play()
	tweenUp.Completed:Connect(function()
		tweenSettle:Play()
	end)
end

part.Touched:Connect(function(hit)
	if cooldown then return end
	if hit.Parent ~= player.Character then return end
	cooldown = true

-- pick random pool sound
	local sound = soundPool[math.random(1, #soundPool)]
	local imageId = imagePool[math.random(1, #imagePool)]
	imageLabel.Image = imageId

	imageLabel.ImageTransparency = 0
	gitPunchIn(imageLabel)

	sound:Play()
	screenShake(shakeDuration, shakeIntensity)
	fovPunchEffect()

--scary timing not blocked
	task.spawn(freezeCharacter, freezeDuration)
	task.spawn(applyPostProcessing, 0.8)

	task.wait(0.5) -- delay after touch b4 image fully appears

	for i = 0, 1, 0.1 do
		imageLabel.ImageTransparency = i
		task.wait(0.02) -- how long teh jumpscare stayz on screan
	end

	task.wait(15) -- cooldown b4 it can activate again set high for high
	cooldown = false
end)
