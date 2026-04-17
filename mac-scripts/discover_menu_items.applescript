tell application "System Events"
	tell process "Control Center"
		click (first menu bar item of menu bar 1 whose description is "Audio and Video Controls")
		delay 0.8
		tell group 1 of window "Control Center"
			set output to ""
			repeat with i from 1 to 6
				set g to group i
				try
					set lbl to value of static text 1 of g
				on error
					set lbl to "no label"
				end try
				set v to value of checkbox 1 of g
				set output to output & "Group " & i & ": " & lbl & " (value=" & v & ")" & return
			end repeat
			return output
		end tell
	end tell
end tell
