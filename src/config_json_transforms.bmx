Function config_json_transforms()
  json.error_level = 1
  json.ext_logging_fn = DebugLogFile
  json.formatted = True
  json.formatted_array = True
  json.empty_container_as_null = False
  json.precision = 6
  'Application
  json.add_transform( "stringify_settings", "$hide_vanilla_data", json.XJ_CONVERT, "boolean" )
  json.add_transform( "stringify_settings", "$json_object_output_in_alphabet_order", json.XJ_CONVERT, "boolean" )
  json.add_transform( "stringify_settings", "$fluxmod_limit_override", json.XJ_CONVERT, "boolean" )
  json.add_transform( "stringify_settings", "$UTF8_support", json.XJ_CONVERT, "boolean" )
  json.add_transform( "stringify_settings", "$performance_mode", json.XJ_CONVERT, "boolean" )

  'TStarfarerShip
  json.add_transform( "stringify_ship", "$builtInWeapons:object", json.XJ_DELETE,, predicate_omit_if_empty_object )
  json.add_transform( "stringify_ship" , "$builtInMods:array" , json.XJ_DELETE , , predicate_omit_if_empty_array )
  json.add_transform( "stringify_ship" , "$builtInWings:array" , json.XJ_DELETE , , predicate_omit_if_empty_array )
  json.add_transform( "stringify_ship", "$moduleAnchor:array", json.XJ_DELETE,, predicate_omit_if_empty_array )
  json.add_transform( "stringify_ship", "$moduleAnchor:string", json.XJ_DELETE,, predicate_omit_if_empty_string )
  json.add_transform( "stringify_ship", "$coversColor:string" , json.XJ_DELETE , , predicate_omit_if_empty_string )

  'TStarfarerShipWeapon
  json.add_transform( "parse_ship", "$weaponSlots:array/:object/$type:string", json.XJ_RENAME, "type_" )
  json.add_transform( "stringify_ship", "$weaponSlots:array/:object/$type_:string", json.XJ_RENAME, "type" )
  json.add_transform( "stringify_ship" , "$weaponSlots:array/:object/$position:array" , json.XJ_DELETE , , predicate_omit_position )
  json.add_transform( "stringify_ship", "$weaponSlots:array/:object/$renderOrderMod:number", json.XJ_DELETE,, predicate_omit_if_equals_zero )

  'TStarfarerCustomEngineStyleSpec
  json.add_transform( "parse_ship", "$engineSlots:array/:object/$styleSpec:object/$type:string", json.XJ_RENAME, "type_" )
  json.add_transform( "stringify_ship", "$engineSlots:array/:object/$styleSpec:object/$type_:string", json.XJ_RENAME, "type" )
  json.add_transform( "stringify_ship", "$engineSlots:array/:object/$styleSpec:object", json.XJ_DELETE,, predicate_omit_styleSpec )
  json.add_transform( "stringify_ship", "$engineSlots:array/:object/$styleId:string", json.XJ_DELETE,, predicate_omit_styleId )

  'TStarfarerVariant
  json.add_transform( "stringify_variant" , "$goalVariant" , json.XJ_CONVERT , "boolean" )
  json.add_transform( "stringify_variant" , "$modules:object", json.XJ_DELETE,, predicate_omit_if_empty_object )

  'TStarfarerSkin
  json.add_transform( "parse_skin", "$weaponSlotChanges:object/:object/$type:string", json.XJ_RENAME, "type_" )
  json.add_transform( "stringify_skin", "$weaponSlotChanges:object/:object/$type_:string", json.XJ_RENAME, "type" )
  json.add_transform( "stringify_skin", "$restoreToBaseHull", json.XJ_CONVERT, "boolean" )
  json.add_transform( "stringify_skin", "$hullDesignation:string", json.XJ_DELETE,, predicate_omit_if_empty_string )
  json.add_transform( "stringify_skin", "$coversColor:string", json.XJ_DELETE,, predicate_omit_if_empty_string )
  json.add_transform( "stringify_skin", "$weaponSlotChanges:object/:object/$type_:string", json.XJ_RENAME, "type" )
  json.add_transform( "stringify_skin", "$baseValue:number", json.XJ_DELETE,, predicate_omit_if_equals_zero )
  json.add_transform( "stringify_skin", "$baseValueMult:number", json.XJ_DELETE,, predicate_omit_if_equals_zero )
  json.add_transform( "stringify_skin", "$fleetPoints:number", json.XJ_DELETE,, predicate_omit_if_equals_zero )
  json.add_transform( "stringify_skin", "$ordnancePoints:number", json.XJ_DELETE,, predicate_omit_if_equals_zero )
  json.add_transform( "stringify_skin", "$descriptionId:string", json.XJ_DELETE,, predicate_omit_if_empty_string )
  json.add_transform( "stringify_skin", "$descriptionPrefix:string", json.XJ_DELETE,, predicate_omit_if_empty_string )
  json.add_transform( "stringify_skin", "$systemId:string", json.XJ_DELETE,, predicate_omit_if_empty_string )
  json.add_transform( "stringify_skin", "$removeHints:array", json.XJ_DELETE,, predicate_omit_if_empty_array )
  json.add_transform( "stringify_skin", "$addHints:array", json.XJ_DELETE,, predicate_omit_if_empty_array )
  json.add_transform( "stringify_skin", "$removeBuiltInMods:array", json.XJ_DELETE,, predicate_omit_if_empty_array )
  json.add_transform( "stringify_skin", "$builtInMods:array", json.XJ_DELETE,, predicate_omit_if_empty_array )
  json.add_transform( "stringify_skin", "$removeWeaponSlots:array", json.XJ_DELETE,, predicate_omit_if_empty_array )
  json.add_transform( "stringify_skin", "$weaponSlotChanges:object", json.XJ_DELETE,, predicate_omit_if_empty_object )
  json.add_transform( "stringify_skin", "$removeBuiltInWeapons:array", json.XJ_DELETE,, predicate_omit_if_empty_array )
  json.add_transform( "stringify_skin", "$builtInWeapons:object", json.XJ_DELETE,, predicate_omit_if_empty_object )
  json.add_transform( "stringify_skin", "$removeEngineSlots:array", json.XJ_DELETE,, predicate_omit_if_empty_array )
  json.add_transform( "stringify_skin", "$engineSlotChanges:object", json.XJ_DELETE,, predicate_omit_if_empty_object )
  'TStarfarerSkin - omit unchanged fields in X_SlotChanges by detecting poisoned default values
  json.add_transform( "stringify_skin", "$engineSlotChanges/:object/$location:array", json.XJ_DELETE,, predicate_omit_if_empty_array )
  json.add_transform( "stringify_skin", "$engineSlotChanges/:object/$length:number", json.XJ_DELETE,, predicate_omit_if_equals_FLOAT_MAX )
  json.add_transform( "stringify_skin", "$engineSlotChanges/:object/$width:number", json.XJ_DELETE,, predicate_omit_if_equals_FLOAT_MAX )
  json.add_transform( "stringify_skin", "$engineSlotChanges/:object/$angle:number", json.XJ_DELETE,, predicate_omit_if_equals_FLOAT_MAX )
  json.add_transform( "stringify_skin", "$engineSlotChanges/:object/$style:string", json.XJ_DELETE,, predicate_omit_if_empty_string )
  json.add_transform( "stringify_skin", "$engineSlotChanges/:object/$styleId:string", json.XJ_DELETE,, predicate_omit_if_empty_string )
  json.add_transform( "stringify_skin", "$engineSlotChanges/:object/$styleSpec:object", json.XJ_DELETE,, predicate_omit_if_empty_object )
  json.add_transform( "stringify_skin", "$engineSlotChanges/:object/$contrailSize:number", json.XJ_DELETE,, predicate_omit_if_equals_FLOAT_MAX )
  'TStarfarerShipWeaponChange (for deep type coercion within skin parsing)
  json.add_transform( "parse_skin_weapon", "$type:string", json.XJ_RENAME, "type_" )
  json.add_transform( "stringify_skin_weapon", "$type_:string", json.XJ_RENAME, "type" )
  'TStarfarerCustomEngineStyleSpec
  json.add_transform( "parse_custom_engine_style", "$type:string", json.XJ_RENAME, "type_" )
  json.add_transform( "stringify_custom_engine_style", "$type_:string", json.XJ_RENAME, "type" )

  'TStarfarerWeapon
  json.add_transform( "parse_weapon", "$type:string", json.XJ_RENAME, "type_" )
  json.add_transform( "stringify_weapon", "$type_:string", json.XJ_RENAME, "type" )
  'TStarfarerWeapon for the booleans!
  json.add_transform( "stringify_weapon", "$animateWhileFiring", json.XJ_CONVERT, "boolean" )
  json.add_transform( "stringify_weapon", "$alwaysAnimate", json.XJ_CONVERT, "boolean" )
  json.add_transform( "stringify_weapon", "$renderBelowAllWeapons", json.XJ_CONVERT, "boolean" )
  json.add_transform( "stringify_weapon", "$showDamageWhenDecorative", json.XJ_CONVERT, "boolean" )
  json.add_transform( "stringify_weapon", "$separateRecoilForLinkedBarrels", json.XJ_CONVERT, "boolean" )
  json.add_transform( "stringify_weapon", "$interruptibleBurst", json.XJ_CONVERT, "boolean" )
  json.add_transform( "stringify_weapon", "$autocharge", json.XJ_CONVERT, "boolean" )
  json.add_transform( "stringify_weapon", "$requiresFullCharge", json.XJ_CONVERT, "boolean" )
  json.add_transform( "stringify_weapon", "$beamFireOnlyOnFullCharge", json.XJ_CONVERT, "boolean" )
  json.add_transform( "stringify_weapon", "$convergeOnPoint", json.XJ_CONVERT, "boolean" )
  json.add_transform( "stringify_weapon" , "$darkCore" , json.XJ_CONVERT , "boolean" )
  json.add_transform( "stringify_weapon" , "$noShieldImpactSounds" , json.XJ_CONVERT , "boolean" )
  json.add_transform( "stringify_weapon" , "$noNonShieldImpactSounds" , json.XJ_CONVERT , "boolean" )
  json.add_transform( "stringify_weapon" , "$noImpactSounds" , json.XJ_CONVERT , "boolean" )
  json.add_transform( "stringify_weapon" , "$unaffectedByProjectileSpeedBonuses" , json.XJ_CONVERT , "boolean" ) '0.95 New
  'TStarfarerWeapon specClass <> beam
  json.add_transform( "stringify_weapon", "$fringeColor", json.XJ_DELETE,, predicate_omit_if_not_specClass_beam )
  json.add_transform( "stringify_weapon", "$coreColor", json.XJ_DELETE,, predicate_omit_if_not_specClass_beam )
  json.add_transform( "stringify_weapon", "$beamEffect:string", json.XJ_DELETE,, predicate_omit_if_not_specClass_beam )
  json.add_transform( "stringify_weapon", "$beamFireOnlyOnFullCharge", json.XJ_DELETE,, predicate_omit_if_not_specClass_beam )
  json.add_transform( "stringify_weapon", "$convergeOnPoint", json.XJ_DELETE,, predicate_omit_if_not_specClass_beam )
  json.add_transform( "stringify_weapon", "$width:number", json.XJ_DELETE,, predicate_omit_if_not_specClass_beam )
  json.add_transform( "stringify_weapon", "$textureScrollSpeed:number", json.XJ_DELETE,, predicate_omit_if_not_specClass_beam )
  json.add_transform( "stringify_weapon", "$pixelsPerTexel:number", json.XJ_DELETE,, predicate_omit_if_not_specClass_beam )
  json.add_transform( "stringify_weapon", "$hitGlowRadius:number", json.XJ_DELETE,, predicate_omit_if_not_specClass_beam )
  json.add_transform( "stringify_weapon", "$darkCore", json.XJ_DELETE,, predicate_omit_if_not_specClass_beam )
  json.add_transform( "stringify_weapon", "$collisionClass:string", json.XJ_DELETE,, predicate_omit_if_not_specClass_beam )
  json.add_transform( "stringify_weapon", "$collisionClassByFighter:string", json.XJ_DELETE,, predicate_omit_if_not_specClass_beam )
  json.add_transform( "stringify_weapon", "$pierceSet:array", json.XJ_DELETE,, predicate_omit_if_not_specClass_beam )
  'TStarfarerWeapon specClass <> projectile
  json.add_transform( "stringify_weapon", "$projectileSpecId:string", json.XJ_DELETE,, predicate_omit_if_not_specClass_projectile )
  json.add_transform( "stringify_weapon", "$barrelMode:string", json.XJ_DELETE,, predicate_omit_if_not_specClass_projectile )
  json.add_transform( "stringify_weapon", "$animationType:string", json.XJ_DELETE,, predicate_omit_if_not_specClass_projectile )
  json.add_transform( "stringify_weapon", "$visualRecoil", json.XJ_DELETE,, predicate_omit_if_not_specClass_projectile )
  json.add_transform( "stringify_weapon", "$separateRecoilForLinkedBarrels", json.XJ_DELETE,, predicate_omit_if_not_specClass_projectile )
  json.add_transform( "stringify_weapon", "$interruptibleBurst", json.XJ_DELETE,, predicate_omit_if_not_specClass_projectile )
  json.add_transform( "stringify_weapon", "$autocharge", json.XJ_DELETE,, predicate_omit_if_not_specClass_projectile )
  json.add_transform( "stringify_weapon", "$requiresFullCharge", json.XJ_DELETE,, predicate_omit_if_not_specClass_projectile )
  json.add_transform( "stringify_weapon", "$muzzleFlashSpec:object", json.XJ_DELETE,, predicate_omit_if_not_specClass_projectile )
  json.add_transform( "stringify_weapon", "$smokeSpec:object", json.XJ_DELETE,, predicate_omit_if_not_specClass_projectile )
  'TStarfarerWeapon -can be removed if it is default
  ' string with default = ""
  json.add_transform( "stringify_weapon", "$turretUnderSprite:string", json.XJ_DELETE,, predicate_omit_if_empty_string )
  json.add_transform( "stringify_weapon", "$turretGunSprite:string", json.XJ_DELETE,, predicate_omit_if_empty_string )
  json.add_transform( "stringify_weapon", "$turretGlowSprite:string", json.XJ_DELETE,, predicate_omit_if_empty_string )
  json.add_transform( "stringify_weapon", "$hardpointUnderSprite:string", json.XJ_DELETE,, predicate_omit_if_empty_string )
  json.add_transform( "stringify_weapon", "$hardpointGunSprite:string", json.XJ_DELETE,, predicate_omit_if_empty_string )
  json.add_transform( "stringify_weapon", "$hardpointGlowSprite:string", json.XJ_DELETE,, predicate_omit_if_empty_string )
  json.add_transform( "stringify_weapon", "$everyFrameEffect:string", json.XJ_DELETE,, predicate_omit_if_empty_string )
  json.add_transform( "stringify_weapon", "$beamEffect:string", json.XJ_DELETE,, predicate_omit_if_empty_string )
  json.add_transform( "stringify_weapon", "$fireSoundOne:string", json.XJ_DELETE,, predicate_omit_if_empty_string )
  json.add_transform( "stringify_weapon", "$fireSoundTwo:string", json.XJ_DELETE,, predicate_omit_if_empty_string )
  json.add_transform( "stringify_weapon", "$mountTypeOverride:string", json.XJ_DELETE,, predicate_omit_if_empty_string ) '0.95 new
  ' number
  json.add_transform( "stringify_weapon", "$numFrames:number", json.XJ_DELETE,, predicate_omit_if_single_frame )
  json.add_transform( "stringify_weapon", "$frameRate:number", json.XJ_DELETE,, predicate_omit_if_single_frame )
  json.add_transform( "stringify_weapon", "$visualRecoil:number", json.XJ_DELETE,, predicate_omit_if_equals_zero)
  json.add_transform( "stringify_weapon", "$displayArcRadius:number", json.XJ_DELETE,, predicate_omit_if_equals_zero)
  json.add_transform( "stringify_weapon", "$darkFringeIter:number", json.XJ_DELETE,, predicate_omit_if_equals_zero)'0.95 new
  json.add_transform( "stringify_weapon", "$darkCoreIter:number", json.XJ_DELETE,, predicate_omit_if_equals_zero)'0.95 new
  json.add_transform( "stringify_weapon", "$coreWidthMult:number", json.XJ_DELETE,, predicate_omit_if_equals_zero)'0.95 new
  ' array
  json.add_transform( "stringify_weapon", "$pierceSet:array", json.XJ_DELETE,, predicate_omit_if_empty_array )
  json.add_transform( "stringify_weapon", "$renderHints:array", json.XJ_DELETE,, predicate_omit_if_empty_array )
  ' object
  json.add_transform( "stringify_weapon", "$muzzleFlashSpec:object", json.XJ_DELETE,, predicate_omit_if_no_muzzle_flash )
  json.add_transform( "stringify_weapon", "$smokeSpec:object", json.XJ_DELETE,, predicate_omit_if_no_smoke )
  json.add_transform( "stringify_weapon", "$glowColor", json.XJ_DELETE,, predicate_omit_if_no_glow )
  ' booleans
  json.add_transform( "stringify_weapon", "$convergeOnPoint", json.XJ_DELETE,, predicate_omit_if_boolean_equals_FALSE)
  json.add_transform( "stringify_weapon", "$darkCore", json.XJ_DELETE,, predicate_omit_if_boolean_equals_FALSE )
  json.add_transform( "stringify_weapon", "$separateRecoilForLinkedBarrels", json.XJ_DELETE,, predicate_omit_if_boolean_equals_FALSE )
  json.add_transform( "stringify_weapon", "$interruptibleBurst", json.XJ_DELETE,, predicate_omit_if_boolean_equals_FALSE )
  json.add_transform( "stringify_weapon", "$autocharge", json.XJ_DELETE,, predicate_omit_if_boolean_equals_FALSE )
  json.add_transform( "stringify_weapon", "$renderBelowAllWeapons", json.XJ_DELETE,, predicate_omit_if_boolean_equals_FALSE )
  json.add_transform( "stringify_weapon", "$beamFireOnlyOnFullCharge", json.XJ_DELETE,, predicate_omit_if_boolean_equals_FALSE )
  json.add_transform( "stringify_weapon", "$showDamageWhenDecorative", json.XJ_DELETE,, predicate_omit_if_boolean_equals_FALSE )
  json.add_transform( "stringify_weapon", "$noImpactSounds", json.XJ_DELETE,, predicate_omit_if_boolean_equals_FALSE )
  json.add_transform( "stringify_weapon", "$noShieldImpactSounds", json.XJ_DELETE,, predicate_omit_if_boolean_equals_FALSE )
  json.add_transform( "stringify_weapon", "$noNonShieldImpactSounds", json.XJ_DELETE,, predicate_omit_if_boolean_equals_FALSE )
  json.add_transform( "stringify_weapon", "$requiresFullCharge", json.XJ_DELETE,, predicate_omit_if_boolean_equals_TRUE )
  json.add_transform( "stringify_weapon", "$animateWhileFiring", json.XJ_DELETE,, predicate_omit_if_boolean_equals_TRUE )
  json.add_transform( "stringify_weapon", "$alwaysAnimate", json.XJ_DELETE,, predicate_omit_if_boolean_equals_TRUE )
  json.add_transform( "stringify_weapon", "$unaffectedByProjectileSpeedBonuses", json.XJ_DELETE,, predicate_omit_if_boolean_equals_TRUE ) '0.95 new
  ' unknow things
  json.add_transform( "stringify_weapon", "$specialWeaponGlowWidth:number", json.XJ_DELETE,, predicate_omit_if_equals_zero )
  json.add_transform( "stringify_weapon", "$specialWeaponGlowHeight:number", json.XJ_DELETE,, predicate_omit_if_equals_zero )
EndFunction
