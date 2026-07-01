local player = game.Players.LocalPlayer
local part = workspace:WaitForChild("TouchPart") -- the name of the part (in workspace) that jumpscares when touched (can have any name but make sure no other parts are named the same)

local image = script.Parent:WaitForChild("ImageLabel") -- name after your actual imagelabel

local cooldown = false

part.Touched:Connect(function(hit)
	if cooldown then return end
	if hit.Parent ~= player.Character then return end

	cooldown = true

	image.ImageTransparency = 0

	task.wait(0.5) --the time after which jukpscare appears in seconds afder touching the part

	for i = 0, 1, 0.1 do
		image.ImageTransparency = i
		task.wait(0.02) --the time the jumpscare (image) stays on the screen
	end

	task.wait(15) -- basically the cooldown b4 the jumpscare can activate again
	cooldown = false
end)
