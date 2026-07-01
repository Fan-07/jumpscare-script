local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

local part = workspace:WaitForChild("TouchPart") -- the part that triggers the jumpscare when touched
local image = script.Parent:WaitForChild("ImageLabel") -- your imagelabel
local sound = script.Parent:WaitForChild("JumpscareSound") -- put a sound instance here, name it whatever and update this, or set sound ID at runtime

local cooldown = false

-- screenshake
local shakeDuration = 0.5   -- how long the camera shakes for
local shakeIntensity = 0.15 -- how strong the shake is (in studs, roughly)

local function screenShake(duration, intensity)
	local startTime = tick()
	local originalCFrame = camera.CFrame

	local connection
	connection = game:GetService("RunService").RenderStepped:Connect(function()
		local elapsed = tick() - startTime
		if elapsed >= duration then
			connection:Disconnect()
			return
		end

		-- random offset that decays over time
		local falloff = 1 - (elapsed / duration)
		local offsetX = (math.random() - 0.5) * intensity * falloff
		local offsetY = (math.random() - 0.5) * intensity * falloff
		local offsetZ = (math.random() - 0.5) * intensity * falloff

		camera.CFrame = camera.CFrame * CFrame.new(offsetX, offsetY, offsetZ)
	end)
end

part.Touched:Connect(function(hit)
	if cooldown then return end
	if hit.Parent ~= player.Character then return end
	cooldown = true

	image.ImageTransparency = 0

	-- play sound (freely choose the sound's properties in the Explorer)
	-- or override Sound/olume/playbackSpeed here before :Play())
	sound:Play()

	screenShake(shakeDuration, shakeIntensity)

	task.wait(0.5) -- delay after touching before image appears

	for i = 0, 1, 0.1 do
		image.ImageTransparency = i
		task.wait(0.02) -- how long the jumpscare stays on screen
	end

	task.wait(15) -- cooldown before it can activate again
	cooldown = false
end)
