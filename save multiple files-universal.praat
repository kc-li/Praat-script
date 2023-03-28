# This variation can save all the selected file, of the type sound and textgrid.
# Other non-recognised types will be saved without a correct suffix
# Allow users to choose a directory, and quit if not chosen
# Updated by Katrina Li (2021.06.14)

#Allow user to choose directory
foldername$ = chooseDirectory$: "Choose a directory"

if foldername$ == ""
	exitScript: "not directory is chosen"
endif

dir$ = foldername$ + "/"

n = numberOfSelected()
writeInfoLine: "n=",tab$,n

# We need to generate all the filenames in the first step, with all files "selected". Once we select individual files, we can no longer refer back to the chunk.
for i from 1 to n
	s'i' = selected('i')
	s'i'$ = selected$('i')
	appendInfo: s'i'$,newline$
endfor
appendInfo: newline$
for i from 1 to n
	select s'i'
	type$ = extractWord$(s'i'$,"")
	name$ = extractWord$(s'i'$," ")
	appendInfo: type$,newline$,name$,newline$
	if type$ = "Sound"
		filename$ = dir$+name$+".wav"
		Save as WAV file: filename$
		appendInfo: filename$, newline$
	elsif type$ = "TextGrid"
		filename$ = dir$+name$+".TextGrid"
		Save as text file: filename$
		appendInfo: filename$, newline$
	else
		filename$ = dir$+name$+"."+type$
		Save as text file: filename$
		appendInfo: filename$, newline$	
	endif
endfor
	
