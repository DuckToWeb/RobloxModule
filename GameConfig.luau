local GameConfig = {}

GameConfig = {
	['Player'] = {
		WalkSpeed = 18
	},

	['Zombie'] = {
		HP = 80,
		Dmg = 9,
		Sped = 16,
		hitbox = Vector3.new(4, 4, 4),
		HitboxDur = 0.9
	},
	
	['Mob3'] = {
		HP = 120,
		Dmg = 5,
		Sped = 19
	},
	
	['ZombieCyber'] = {
		HP = 170,
		Dmg = 18,
		Sped = 7,
		hitbox = Vector3.new(5, 5, 5),
		HitboxDur = 1.1,
		
		Skill1 = {
			GroundSmashDMG = 10,
			ArmSmashDMG = 20,
			
			hitboxGroundSmash = Vector3.new(17, 3, 17),
			HitboxGDDur = 0.2,
			
			hitboxArmSmash = Vector3.new(8, 7, 7),
			HitboxARDur = 0.2,

		}
	},
	
	
	['Sword'] = {
		Dmg = 5,
		Max = 3,
		CooldownSet = 1,
		debounce = 0.4,
		hitbox = Vector3.new(4, 5, 10),
		HitboxDur = 0.2,
		StunDur = 0.7
	},
	
	['Staff'] = {
		Dmg = 10,
		Max = 3,
		CooldownSet = 1.2,
		debounce = 0.4,
		hitbox = Vector3.new(10, 3, 15),
		HitboxDur = 0.2,
		StunDur = 1.2,
		ShockDur = 1.1
	}
}

return GameConfig
