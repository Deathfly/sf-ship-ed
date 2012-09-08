
Type TModalWeapon Extends TSubroutine
	'images
	Field turret_img:TImage
	Field turretUnder_img:TImage
	Field turretGun_img:TImage
	Field turretGlow_img:TImage
	Field hardpoint_img:TImage
	Field hardpointUnder_img:TImage
	Field hardpointGun_img:TImage
	Field hardpointGlow_img:TImage
	Field display_mode$
	'animated images
	Field turret_img_seq:TImage[]
	Field hardpoint_img_seq:TImage[]
	Field img_seq_i%
	Field img_seq_i_ts%

	Method Activate( ed:TEditor, data:TData, sprite:TSprite )
		data.update_weapon()
		display_mode = "turret"
		load_weapon_images( data )
	EndMethod

	Method Update( ed:TEditor, data:TData, sprite:TSprite )
		' multi-frame framecounter advance
		If  data.weapon.numFrames > 1 ..
		And (millisecs() - img_seq_i_ts) > Int(Double(1000)/data.weapon.frameRate)
			img_seq_i :+ 1
			If img_seq_i >= data.weapon.numFrames Then img_seq_i = 0
			img_seq_i_ts = millisecs()
		EndIf
	EndMethod

	Method Draw( ed:TEditor, data:TData, sprite:TSprite )
		Select display_mode
			Case "turret"
				If data.weapon.numFrames <= 1
					draw_weapon( turret_img, turretUnder_img, turretGun_img, turretGlow_img, sprite )
				Else ' data.weapon.numFrames > 1
					draw_weapon( turret_img_seq[img_seq_i], turretUnder_img, turretGun_img, turretGlow_img, sprite )
				EndIf
			Case "hardpoint"
				If data.weapon.numFrames <= 1
					draw_weapon( hardpoint_img, hardpointUnder_img, hardpointGun_img, hardpointGlow_img, sprite )
				Else ' data.weapon.numFrames > 1
					draw_weapon( hardpoint_img_seq[img_seq_i], hardpointUnder_img, hardpointGun_img, hardpointGlow_img, sprite )
				EndIf
		EndSelect
	EndMethod

	Method Save( ed:TEditor, data:TData, sprite:TSprite )
		Local path$ = RequestFile( "SAVE Weapon Data", "wpn", True, APP.weapon_dir + data.weapon.id+".weapon" )
		FlushKeys()
		If path
			APP.weapon_dir = ExtractDir( path )+"/"
			APP.save()
			SaveString( data.json_str_weapon, path )
		End If
	EndMethod

	Method Load( ed:TEditor, data:TData, sprite:TSprite )
		Local path$ = RequestFile( "LOAD Weapon Data", "wpn", False, APP.weapon_dir )
		FlushKeys()
		If FileType( path ) <> FILETYPE_FILE Then Return
		APP.weapon_dir = ExtractDir( path )+"/"
		APP.save()
		Local json_str_weapon$ = LoadString( path )
		data.decode_weapon( json_str_weapon )
		data.update_weapon()
	EndMethod


	Method draw_weapon( main_img:TImage, under_img:TImage, gun_img:TImage, glow_img:TImage, sprite:TSprite )
		SetRotation( 90 )
		SetScale( sprite.scale, sprite.scale )
		SetAlpha( 1 )
		SetColor( 255, 255, 255 )
		'///
		If main_img  Then DrawImage( main_img,  W_MID + sprite.pan_x + sprite.zpan_x, H_MID + sprite.pan_y + sprite.zpan_y )
		If under_img Then DrawImage( under_img, W_MID + sprite.pan_x + sprite.zpan_x, H_MID + sprite.pan_y + sprite.zpan_y )
		If gun_img   Then DrawImage( gun_img,   W_MID + sprite.pan_x + sprite.zpan_x, H_MID + sprite.pan_y + sprite.zpan_y )
		If glow_img  Then DrawImage( glow_img,  W_MID + sprite.pan_x + sprite.zpan_x, H_MID + sprite.pan_y + sprite.zpan_y )
	EndMethod

	Method load_weapon_images( data:TData )
		Local img_path$ = Null
		If data.weapon.numFrames <= 1
			'Single-frame turret/hardpoint
			If data.weapon.turretSprite
				img_path = resource_search( data.weapon.turretSprite )
				If img_path Then turret_img = LoadImage( img_path, 0 )
			EndIf
			If data.weapon.hardpointSprite
				img_path = resource_search( data.weapon.hardpointSprite )
				If img_path Then hardpoint_img = LoadImage( img_path, 0 )
			EndIf
		Else 'data.weapon.numFrames > 1
			'Multi-frame turret/hardpoint
			If data.weapon.turretSprite
				img_path = resource_search( data.weapon.turretSprite )
				If img_path Then turret_img_seq = load_image_sequence( img_path, data.weapon.numFrames )
			EndIf
			If data.weapon.hardpointSprite
				img_path = resource_search( data.weapon.hardpointSprite )
				If img_path Then hardpoint_img_seq = load_image_sequence( img_path, data.weapon.numFrames )
			EndIf
		EndIf
		'Supporting images
		If data.weapon.turretUnderSprite
			img_path = resource_search( data.weapon.turretUnderSprite )
			If img_path Then turretUnder_img = LoadImage( img_path, 0 )
		EndIf
		If data.weapon.turretGunSprite
			img_path = resource_search( data.weapon.turretGunSprite )
			If img_path Then turretGun_img = LoadImage( img_path, 0 )
		EndIf
		If data.weapon.turretGlowSprite
			img_path = resource_search( data.weapon.turretGlowSprite )
			If img_path Then turretGlow_img = LoadImage( img_path, 0 )
		EndIf
		If data.weapon.hardpointUnderSprite
			img_path = resource_search( data.weapon.hardpointUnderSprite )
			If img_path Then hardpointUnder_img = LoadImage( img_path, 0 )
		EndIf
		If data.weapon.hardpointGunSprite
			img_path = resource_search( data.weapon.hardpointGunSprite )
			If img_path Then hardpointGun_img = LoadImage( img_path, 0 )
		EndIf
		If data.weapon.hardpointGlowSprite
			img_path = resource_search( data.weapon.hardpointGlowSprite )
			If img_path Then hardpointGlow_img = LoadImage( img_path, 0 )
		EndIf
	EndMethod

	Method load_image_sequence:TImage[]( img_0_path$, count% )
		If img_0_path = Null Then Return Null
		Local zero_pad_length% = 2
		Local num_idx% = img_0_path.FindLast( zero_pad(0,zero_pad_length) )
		If num_idx = -1 Then Return Null
		Local img_path_prefix$ = img_0_path[..num_idx]
		Local extension$ = ExtractExt( img_0_path )
		Local img_seq:TImage[] = New TImage[ count ]
		Local img_seq_path$
		For Local i% = 0 Until count
			img_seq_path = img_path_prefix+zero_pad(i,zero_pad_length)+"."+extension
			img_seq[i] = LoadImage( img_seq_path, 0 )
		Next
		Return img_seq
	EndMethod

EndType
