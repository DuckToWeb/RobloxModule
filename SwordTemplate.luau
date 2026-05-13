local RES = game:GetService("ReplicatedStorage")
local DE = game:GetService("Debris")

local Gameconfig = require(RES:FindFirstChild('Module'):FindFirstChild('GameConfig'))
local Utils = require(RES:FindFirstChild('Module'):FindFirstChild('Utils'):FindFirstChild('UtilsManager'))

local HitBoxSize = Gameconfig.Sword.hitbox
local HitboxDur = Gameconfig.Sword.HitboxDur
local M1Debounce = Gameconfig.Sword.debounce
local M1StunDur = Gameconfig.Sword.StunDur

local SwordTemplate = {}
SwordTemplate.__index = SwordTemplate

function SwordTemplate.new(dmg)
	local self = setmetatable({}, SwordTemplate)
	self.Dmg = dmg
	
	return self
end

function SwordTemplate:Attack(plr, Count)
	local Char = plr.Character
	local Hum = Char:FindFirstChild('Humanoid')
	local Hrp = Char:FindFirstChild('HumanoidRootPart')
	
	local Connect

	if Char and Hrp and Hum and Hum.Health > 0 then
		local HitGroup = {}
		local Hitbox = Instance.new('Part')
		Hitbox.Size = HitBoxSize
		Hitbox.Transparency = 1
		Hitbox.Color = Color3.new(1)
		Hitbox.CanCollide = false
		Hitbox.Anchored = false
		Hitbox.Massless = true
		Hitbox.Parent = workspace
		Hitbox.CFrame = Hrp.CFrame * CFrame.new(0, 0, -3)

		local Weld = Instance.new('WeldConstraint')
		Weld.Parent = Hrp
		Weld.Part0 = Hrp
		Weld.Part1 = Hitbox
		Utils.AllUtil.Status.ApplyUsing(plr, M1Debounce)
		Utils.AllUtil.Knock.M1Click(plr)


		Connect = Hitbox.Touched:Connect(function(hit)
			local TargetChar = hit.Parent
			local Humtar = TargetChar:FindFirstChild('Humanoid')
			
			
			if TargetChar:FindFirstChild('IFRAME') then return end
			if TargetChar ~= Char and Humtar and Humtar.Health > 0 and not HitGroup[TargetChar] then
				HitGroup[TargetChar] = true
				
				if Count < 3 then
					Utils.AllUtil.DoDamage.ActiveHit(TargetChar, self.Dmg)
					Utils.AllUtil.Knock.M1Knock(plr, TargetChar)
				else
					Utils.AllUtil.DoDamage.ActiveFinalHit(TargetChar, self.Dmg)
					Utils.AllUtil.Knock.M1FinalKnock(plr, TargetChar)
				end
				Utils.AllUtil.Animation.GetHit(TargetChar)
				Utils.AllUtil.Status.ApplyStun(TargetChar, M1StunDur)
				Utils.AllUtil.Effect.NormalHit(TargetChar)
				
			end
		end)
		DE:AddItem(Hitbox, HitboxDur)
		DE:AddItem(Weld, HitboxDur)
		task.delay(HitboxDur, function()
			Connect:Disconnect()
		end)
	end
end

return SwordTemplate
