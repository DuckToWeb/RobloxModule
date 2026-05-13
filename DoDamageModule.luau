local DamageModule = {}

function DamageModule.ActiveHit(Target, Amount)
	if Target then
		local Hum = Target:FindFirstChild('Humanoid')
		if Hum and Hum.Health > 0 then
			local DMG = Amount
			Hum.Health -= DMG
			print('Make ' .. DMG .. ' On Target')
		end
	end
end

function DamageModule.ActiveFinalHit(Target, Amount)
	if Target then
		local Hum = Target:FindFirstChild('Humanoid')
		if Hum and Hum.Health > 0 then
			local DMG = Amount * 2
			Hum.Health -= DMG
			print('Make ' .. DMG .. ' On Target')
		end
	end
end




return DamageModule
