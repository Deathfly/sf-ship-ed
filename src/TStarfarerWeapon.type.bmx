Type TStarfarerWeapon
	Field id$
	Field specClass$
	Field type_$
	Field size$
	Field displayArcRadius#
	Field turretSprite$
	Field turretUnderSprite$
	Field turretGunSprite$
	Field turretGlowSprite$
	Field hardpointSprite$
	Field hardpointUnderSprite$
	Field hardpointGunSprite$
	Field hardpointGlowSprite$
	Field numFrames%
	Field frameRate#
	Field visualRecoil#
	Field renderHints$[]
	Field fringeColor%[]
	Field coreColor%[]
	Field glowColor%[]
	Field darkCore%
	Field convergeOnPoint%
	Field width#
	Field height#
	Field textureType:Object 'String, String[]
	Field textureScrollSpeed#
	Field pixelsPerTexel#
	Field turretOffsets#[]
	Field turretAngleOffsets#[]
	Field hardpointOffsets#[]
	Field hardpointAngleOffsets#[]
	Field barrelMode$
	Field animationType$
	Field interruptibleBurst%
	Field muzzleFlashSpec:TStarfarerWeaponMuzzleFlashSpec
	Field smokeSpec:TStarfarerWeaponSmokeSpec
	Field projectileSpecId$
	Field pierceSet$[]
	Field autocharge%
	Field requiresFullCharge%
	Field fireSoundOne$
	Field fireSoundTwo$

	Method New()
	End Method
EndType
