
'instaquit module
Global esc_held% = False
Global esc_press_ts% = MilliSecs()
Global esc_held_progress_bar_show_time_required% = 180
Global instaquit_time_required% = 1000

'-----------------------

Function escape_key_update()
	If esc_held And (MilliSecs() - esc_press_ts) >= instaquit_time_required
		EmitEvent CreateEvent(EVENT_WINDOWCLOSE, mainWindow)
	End If
	'escape key state
	If EventID() = EVENT_KEYDOWN And EventData() = KEY_ESCAPE
		If Not esc_held
			esc_press_ts = MilliSecs()
		End If
		esc_held = True
	Else If EventID() = EVENT_KEYUP And EventData() = KEY_ESCAPE
		esc_held = False
	End If
End Function

Function draw_instaquit_progress( scr_w%, scr_h% )
	If (KeyDown( KEY_ESCAPE ) Or KeyDown( KEY_HOME )) ..
	And esc_held And (MilliSecs() - esc_press_ts) >= esc_held_progress_bar_show_time_required
		'draw black transparent screen overlay
		SetOrigin( 0, 0 )
		SetRotation( 0 )
		SetScale( 1, 1 )
		Local alpha_multiplier# = time_alpha_pct( esc_press_ts + esc_held_progress_bar_show_time_required, esc_held_progress_bar_show_time_required )
		SetAlpha( 0.75 * alpha_multiplier )
		SetColor( 0, 0, 0 )
		DrawRect( 0,0, scr_w,scr_h )
		'draw progress bar
		SetAlpha( 1.0 * alpha_multiplier )
		SetColor( 255, 255, 255 )
		Local margin% = scr_w/4
		draw_percentage_bar( margin, scr_h/2 - FONT.Height() - 5, scr_w - 2*margin, 50, Float( MilliSecs() - esc_press_ts ) / Float( instaquit_time_required - 50 ),,,,,,, 2 )
	End If
End Function

Function time_alpha_pct#( ts%, time%, in% = True ) 'either fading IN or OUT
	Local ms% = MilliSecs()
	If in 'fade in
		If (ms - ts) <= time
			Return (Float(ms - ts) / Float(time))
		Else
			Return 1.0
		End If
	Else 'fade out
		If (ms - ts) <= time
			Return (1.0 - (Float(ms - ts) / Float(time)))
		Else
			Return 0.0
		End If
	End If
End Function

Function draw_percentage_bar( ..
x#, y#, w#, h#, ..
pct#, ..
a# = 1.0, r% = 255, g% = 255, b% = 255, ..
borders% = True, snap_to_pixels% = True, ..
line_width# = 1.0 )
	'truncate
	If snap_to_pixels
		x = Floor( x )
		y = Floor( y )
		w = Floor( w )
		h = Floor( h )
		line_width = Floor( line_width )
	End If
	'normalize
	If pct > 1.0
		pct = 1.0
	Else If pct < 0.0
		pct = 0.0
	End If
	SetAlpha( a )
	SetColor( 0, 0, 0 )
	SetScale( 1, 1 )
	SetRotation( 0 )
	DrawRect( x, y, w, h )
	SetAlpha( a )
	SetColor( r, g, b )
	
	If borders
		DrawRectLines( x, y, w, h, line_width )
		DrawRect( x + 2.0*line_width, y + 2.0*line_width, pct*(w - 4.0*line_width), h - 4.0*line_width )
	Else 'Not borders
		DrawRect( x, y, pct*w, h )
	End If
End Function
