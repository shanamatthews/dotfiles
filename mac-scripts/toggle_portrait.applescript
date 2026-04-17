tell application "System Events"
	tell process "Control Center"
		click (first menu bar item of menu bar 1 whose description is "Audio and Video Controls")
		delay 0.5
		click checkbox 1 of group 2 of group 1 of window "Control Center"
		delay 0.2
		key code 53 -- press Escape to close the menu
	end tell
end tell
