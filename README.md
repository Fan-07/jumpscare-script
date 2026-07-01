jumpscare-script
jumpscare script allowing for cooldown, time that the image stays on screen, how much of the screen covers and allat

Basic

Basic jumpscare script, touch a part and an image pops up on screen. no sound or shakes.


1.Create a part in workspace and rename it "TouchPart" (can have any name you want, if this name is already occupied just refer to the comments in the code)
2.Under StarterGui, create a ScreenGui and rename it "JumpscareGUI"
3.Add a LocalScript inside the JumpscareGUI and import the script provided (it can be a normal script but that would mean the jumpscare appears for everyone when the part is touched)
4.Also inside the JumpscareGUI, insert an ImageLabel (don't rename it). You can use any image you want with the image's asset id
5.Refer to code comments, you'll understand



Intermediate

Jumpscare script with cooldown, sound, and screen shake added on touch


1.Create a part in workspace and rename it "TouchPart" (can have any name you want, if this name is already occupied just refer to the comments in the code)
2.Under StarterGui, create a ScreenGui and rename it "JumpscareGUI"
3.Add a LocalScript inside the JumpscareGUI and import the script provided (it can be a normal script but that would mean the jumpscare appears for everyone when the part is touched)
4.Also inside the JumpscareGUI, insert an ImageLabel (don't rename it). You can use any image you want with the image's asset id
5.Inside the JumpscareGUI (or wherever your LocalScript lives), add a Sound object and rename it "JumpscareSound" n drop in any sound id you want
6.Refer to code comments



Kinda Advanced

Jumpscare script allowing for cooldown, time that the image stays on screen, how much of the screen it covers, random sound/image pools, screen shake, FOV punch, character freeze, and blur/color


1.Create a part in workspace and rename it "TouchPart" (can have any name you want, if this name is already occupied just refer to the comments in the code)
2.Under StarterGui, create a ScreenGui and rename it "JumpscareGUI"
3.Add a LocalScript inside the JumpscareGUI and import the script provided (it can be a normal script but that would mean the jumpscare appears for everyone when the part is touched)
4.Also inside the JumpscareGUI, insert an ImageLabel (don't rename it). You can use any image you want with the image's asset id
5.Add one or more Sound objects (rename the first one "JumpscareSound1", add more like "JumpscareSound2" etc if you want variety) and drop in the sound ids you want
6.In the script, add your image asset ids to the imagePool table so it can pick randomly between them
7.Adjust the tunables at the top of the script (shakeDuration, shakeIntensity, fovPunch, freezeDuration, blurSize, vignetteColor) to control cooldown feel, how strong the shake/zoom is, and how long the 8.player gets locked in place
9.js Refer to code comments vro
