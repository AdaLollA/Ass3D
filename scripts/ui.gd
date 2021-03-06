extends Control

func hide_all_windows():
	for w in $Windows.get_children():
		w.visible = false

func untoggle_all_buttons_except(button: String):
	for b in $Buttons.get_children():
		if button not in b.name:
			b.button_pressed = false

func _on_work_toggled(button_pressed):
	if button_pressed:
		untoggle_all_buttons_except('Work')
	hide_all_windows()
	$Windows/Work.visible = button_pressed

func _on_architect_toggled(button_pressed):
	if button_pressed:
		untoggle_all_buttons_except('Architect')
	hide_all_windows()
	$Windows/Architect.visible = button_pressed

func _on_hide_ui_toggled(button_pressed):
	$Resources.visible = !button_pressed
	$Pawns.visible = !button_pressed
	$Info.visible = !button_pressed
	$Buttons/Work.visible = !button_pressed
	$Buttons/Architect.visible = !button_pressed
	$Windows.visible = !button_pressed
	
	if button_pressed:
		$Buttons/HideUI.text = '^'
	else:
		$Buttons/HideUI.text = 'v'
