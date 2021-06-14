Type TStarfarerShip
	Field bounds#[] 'checked
	Field center#[] 'checked
	Field collisionRadius#'checked
	Field engineSlots:TStarfarerShipEngine[] 'checked
	Field height# 'checked
	Field width# 'checked
	Field hullId$'checked
	Field hullName$'checked
	Field hullSize$'checked
	Field shieldCenter#[]'checked
	Field shieldRadius#'checked
	Field spriteName$ 'checked
	Field style$'checked
	Field viewOffset# 'checked
	Field weaponSlots:TStarfarerShipWeapon[] 'checked
	Field builtInWeapons:TMap'<String,String>  weapon slot id --> weapon id 'checked
	Field builtInMods$[] 'checked
	Field coversColor$'checked
	Field builtInWings$[]  'checked
	Field moduleAnchor#[]'checked
	
	Method New()
		bounds = New Float[0]
		center = [ 0.0, 0.0 ]
		shieldCenter = [ 0.0, 0.0 ]
		engineSlots = New TStarfarerShipEngine[0]
		weaponSlots = New TStarfarerShipWeapon[0]
		hullId = "new_hull"
		hullName = "New Hull"
		hullSize = "FRIGATE"
		spriteName = "graphics/ships/new_hull.png"
		style = "LOW_TECH"
		builtInWeapons = CreateMap()
		builtInMods = New String[0]
	  	builtInWings = New String[0]
	End Method
	
	Method Clone:TStarfarerShip(dst:TStarfarerShip = Null)
		If Not dst Then dst = New TStarfarerShip
		MemMove(Byte Ptr (dst), Byte Ptr (Self), SizeOf(Self) )
		Return dst
	End Method

	Method getNameOrID$()
	DebugStop
		If hullName <> Null And hullName <> "New Hull"
			Return hullName
		Else
			Return hullId
		EndIf
		Return ""
	End Method	
	
	Method CoerceTypes()
		Fix_Map_TStrings( builtInWeapons )
	EndMethod
		
End Type


