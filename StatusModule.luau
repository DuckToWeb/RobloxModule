local StatusModule = {}

local RES = game:GetService("ReplicatedStorage")

function StatusModule.ApplyIframe(plr, dur)
	local char = plr:IsA('Player') and plr.Character or plr
	
	local Hum = char:FindFirstChild('Humanoid')
	if Hum and Hum.Health > 0 then
		local IFRAME = char:FindFirstChild('IFRAME')
		
		if not IFRAME then
			IFRAME = Instance.new('IntValue')
			IFRAME.Name = 'IFRAME'
			IFRAME.Value = 0
			IFRAME.Parent = char
		end
		
		IFRAME.Value += 1
		
		
		task.delay(dur, function()
			IFRAME.Value -= 1
			if IFRAME.Value <= 0 then
				IFRAME:Destroy()
			end
		end)
	end
end

function StatusModule.ApplyStun(plr, dur)
	local char = plr:IsA('Players') and plr.Character or plr

	local Hum = char:FindFirstChild('Humanoid')
	if Hum and Hum.Health > 0 then
		local STUN = char:FindFirstChild('STUN')

		if not STUN then
			STUN = Instance.new('IntValue')
			STUN.Name = 'STUN'
			STUN.Value = 0
			STUN.Parent = char
		end

		STUN.Value += 1


		task.delay(dur, function()
			STUN.Value -= 1
			if STUN.Value <= 0 then
				STUN:Destroy()
			end
		end)
	end
end

function StatusModule.ApplyUsing(plr, dur)
	local char = plr:IsA('Players') and plr.Character or plr

	local Hum = char:FindFirstChild('Humanoid')
	if Hum and Hum.Health > 0 then
		local USING = char:FindFirstChild('USING')

		if not USING then
			USING = Instance.new('IntValue')
			USING.Name = 'USING'
			USING.Value = 0
			USING.Parent = char
		end

		USING.Value += 1


		task.delay(dur, function()
			USING.Value -= 1
			if USING.Value <= 0 then
				USING:Destroy()
			end
		end)
	end
end


function StatusModule.ApplyShock(plr, dur)
	local char = plr:IsA('Players') and plr.Character or plr

	local Hum = char:FindFirstChild('Humanoid')
	local Hrp = char:FindFirstChild('HumanoidRootPart')
	
	if Hrp and Hum and Hum.Health > 0 then
		local SHOCK = char:FindFirstChild('SHOCK')
		local anim = Hum:LoadAnimation(RES:FindFirstChild('Animation'):FindFirstChild('Shock1'))
		


		if not SHOCK then
			SHOCK = Instance.new('IntValue')
			SHOCK.Name = 'USING'
			SHOCK.Value = 0
			SHOCK.Parent = char
		end
		
		local AssestFolder = RES:FindFirstChild('Assets')
		local VFXShock = AssestFolder:FindFirstChild('Electro'):FindFirstChild('ShockVFX'):Clone()
		VFXShock.Parent = Hrp
		
		StatusModule.ApplyStun(char, dur)
		
		local OldSped = Hum.WalkSpeed
		local OldJump = Hum.JumpPower
		
		anim:Play()
		
		Hum.WalkSpeed = 0
		Hum.JumpPower = 0
		
		
		SHOCK.Value += 1


		task.delay(dur, function()
			SHOCK.Value -= 1
			if SHOCK.Value <= 0 then
				SHOCK:Destroy()
				anim:Stop()
				Hum.WalkSpeed = OldSped
				Hum.JumpPower = OldJump
				VFXShock:Destroy()
			end
		end)
	end
end


function StatusModule.ApplyCantMove(plr, dur, sped)
	local char = plr:IsA('Players') and plr.Character or plr

	local Hum = char:FindFirstChild('Humanoid')
	if Hum and Hum.Health > 0 then
		local OldSped = sped

		Hum.WalkSpeed = 0


		task.delay(dur, function()
			Hum.WalkSpeed = OldSped
		end)
	end
end

return StatusModule
