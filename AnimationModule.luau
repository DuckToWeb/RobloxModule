local AnimationModule = {}

local RES = game:GetService('ReplicatedStorage')

function AnimationModule.REAnimation(char)
	local SC = char:FindFirstChild('Animate')
	local hum = char:FindFirstChild('Humanoid')
	
	if SC and hum then
		AnimationModule.StopAllAnimation(char)
		SC.Enabled = false
		task.wait(0.1)
		SC.Enabled = true

		local CurSpeed = hum.WalkSpeed
		hum.WalkSpeed = 0
		task.wait(0.02)
		hum.WalkSpeed = CurSpeed

		print('Reset Animation')
	else
		warn('It Not Character Form AnimationModule |  REAnim')
	end
end

function AnimationModule.StopAllAnimation(char)
	if char then
		for _, v in pairs(char:FindFirstChild('Humanoid'):GetPlayingAnimationTracks()) do
			v:Stop()
		end
	else
		warn('It Not Character Form AnimationModule | StopAllAnim')
	end
end

function AnimationModule.GetHit(char)
	local Hum = char:FindFirstChild('Humanoid')
	
	local AnimGetHit1 = RES:FindFirstChild('Animation'):FindFirstChild('GetHit1')
	local AnimGetHit2 = RES:FindFirstChild('Animation'):FindFirstChild('GetHit2')
	
	local AnimGetHitGroup = {AnimGetHit1, AnimGetHit2}

	
	if Hum and Hum.Health > 0 then
		local RandomAnim = AnimGetHitGroup[math.random(1, #AnimGetHitGroup)]
		local AnimToPlay = Hum:LoadAnimation(RandomAnim)
		AnimToPlay:Play()
	else
		print('Target is Deaded')
	end
end


function AnimationModule.ChangeAnim(char, SET)
	
	local SC = char:FindFirstChild('Animate')

	if SC then
		local Set = {
			['Base'] = {
				Run = 'rbxassetid://73929123650576',
				Idle = 'rbxassetid://79182661883789',
			},

			['Electro'] = {
				Run = 'rbxassetid://95350921287378',
				Idle = 'rbxassetid://87147668251664',
			},
		}

		if Set[SET] then
			print('Change Animation Sets to ' .. SET)
		
			SC.idle.Animation1.AnimationId = Set[SET].Idle
			SC.walk.WalkAnim.AnimationId = Set[SET].Run
			AnimationModule.REAnimation(char)
			
		else
			warn('Not Found Animation Set That Name ' .. SET)

		end
	else
		warn('It Not Character Form AnimationModule |  Change Set Anim')
	end 
end


return AnimationModule
