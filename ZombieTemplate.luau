local PFI = game:GetService("PathfindingService")
local RES = game:GetService("ReplicatedStorage")
local PLAYER = game:GetService("Players")
local DE = game:GetService("Debris")

local GameConfig = require(RES:FindFirstChild('Module'):FindFirstChild('GameConfig'))
local Utils = require(RES:FindFirstChild('Module'):FindFirstChild('Utils'):FindFirstChild('UtilsManager'))

local AnimationWalk1 = RES:FindFirstChild('Animation'):FindFirstChild('Monster'):FindFirstChild('Zombie'):FindFirstChild('Walking')
local AnimationWalk2 = RES:FindFirstChild('Animation'):FindFirstChild('Monster'):FindFirstChild('Zombie'):FindFirstChild('Walking2')
local AnimationAttack = RES:FindFirstChild('Animation'):FindFirstChild('Monster'):FindFirstChild('Hit')
local AnimationWalkGroup = {AnimationWalk1, AnimationWalk2}

local ZombieSped = GameConfig.Zombie.Sped
local HitboxSize = GameConfig.Zombie.hitbox
local ZombieHP = GameConfig.Zombie.HP
local ZombieDmg = GameConfig.Zombie.Dmg
local ZombieHitboxDur = GameConfig.Zombie.HitboxDur

local ZbmTemPlate = {}
ZbmTemPlate.__index = ZbmTemPlate



local WalkAnim = nil
local HitAnim =nil


function ZbmTemPlate.new(who)
	local self = setmetatable({}, ZbmTemPlate)
	self.Char = who
	self.IsAttacking = false
	
	
	local Hum = self.Char:FindFirstChild('Humanoid')
	Hum.MaxHealth = ZombieHP
	Hum.Health = Hum.MaxHealth
	Hum.WalkSpeed = ZombieSped
	
	local RandomWalkAnimation = AnimationWalkGroup[math.random(1, #AnimationWalkGroup)]
	WalkAnim = Hum:LoadAnimation(RandomWalkAnimation)
	HitAnim = Hum:LoadAnimation(AnimationAttack)
	
	return self
end


function ZbmTemPlate:Active()
	local Hum = self.Char:FindFirstChild('Humanoid')
	local Hrp = self.Char:FindFirstChild('HumanoidRootPart')
	
	

	
	
	


	local path = PFI:CreatePath({
		AgentRadius = 10
	})
	
	for _, i in pairs(PLAYER:GetPlayers()) do
		if i.Character:FindFirstChild('HumanoidRootPart') and Hum.Health > 0 then
			local Root = i.Character:FindFirstChild('HumanoidRootPart') 
			local Mag = (Hrp.Position - Root.Position).Magnitude
			if Mag <= 100 and Mag > 10 then
				if self.Char:FindFirstChild('STUN') then return end
				
				
				path:ComputeAsync(Hrp.Position, Root.Position)
				
				
				
				if path.Status == Enum.PathStatus.Success then
					local Waypoints = path:GetWaypoints()
					
					for _, wy in pairs(Waypoints) do
						Hum:MoveTo(wy.Position)
					end
				end
			elseif Mag <= 4 then
				if not self.IsAttacking and not self.Char:FindFirstChild('STUN') then
					self.IsAttacking = true
					local HitGroup = {}
					local Hitbox = Instance.new('Part')
					Hitbox.Size = HitboxSize
					Hitbox.Transparency = 0.5
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
					local Connect

					HitAnim:Play()
					Hrp.CFrame = CFrame.lookAt(Hrp.Position, Root.Position)
					Connect = Hitbox.Touched:Connect(function(hit)
						local TargetChar = hit.Parent
						local Humtar = TargetChar:FindFirstChild('Humanoid')

						if TargetChar ~= self.Char and PLAYER:GetPlayerFromCharacter(TargetChar) and Humtar and Humtar.Health > 0 and not HitGroup[TargetChar] then
							HitGroup[TargetChar] = true
							Utils.AllUtil.DoDamage.ActiveHit(TargetChar, ZombieDmg)

						end
					end)
					DE:AddItem(Hitbox, ZombieHitboxDur)
					DE:AddItem(Weld, ZombieHitboxDur)
					task.delay(ZombieHitboxDur, function()
						Connect:Disconnect()
						self.IsAttacking = false
					end)
				end
			end
		end
	end
	
	Hum.Running:Connect(function(speed)
		if speed > 0 and Hum.Health > 0 then
			if not WalkAnim.IsPlaying then
				WalkAnim:Play()
			end
		else
			WalkAnim:Stop()
		end
	end)
end

return ZbmTemPlate
