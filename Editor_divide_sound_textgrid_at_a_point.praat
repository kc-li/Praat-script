# Devide the sound and text grid at the selected point
# By Katrina Li 17/1/2022

point = Get cursor
endeditor

sound = selected("Sound")
if selected("TextGrid")
	textgrid = selected("TextGrid")
endif
selectObject: 'sound'
end = Get end time
sound$ = selected$("Sound")
name1$ = sound$ + "_part1"
name2$ = sound$ + "_part2"

selectObject: 'sound'
Extract part... 0 point "rectangular" 1 0
Rename: name1$
selectObject: 'sound'
Extract part... point end "rectangular" 1 0
Rename: name2$

if textgrid
	selectObject: 'textgrid'
	Extract part... 0 point 0
	Rename: name1$
	selectObject: 'textgrid'
	Extract part... point end 0
	Rename: name2$
endif