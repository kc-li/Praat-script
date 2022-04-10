# Editor script: Delete selected sound & textgrid

selectstart = Get start of selection
selectend = Get end of selection
endeditor

sound = selected("Sound")
soundname$ = selected$("Sound")
textgrid = selected("TextGrid")

selectObject: sound
start = Get start time
end = Get end time
selectObject: sound
part1sound = Extract part: start, selectstart, "rectangular", 1, "no"
selectObject: sound
part2sound = Extract part: selectend, end, "rectangular", 1, "no"

selectObject: part1sound
plusObject: part2sound
Concatenate
Rename: soundname$

selectObject: part1sound
plusObject: part2sound
Remove

selectObject: textgrid
part1text = Extract part: start, selectstart, "no"
part2text = Extract part: selectend, end, "no"

selectObject: part1text
plusObject: part2text
Concatenate
Renmae: soundname$

selectObject: 'part1text'
plusObject: 'part2text'
Remove
