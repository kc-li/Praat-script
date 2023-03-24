# Reorganize files in order: Step 1 (or can be used independently)
# From original recording & annotation to individual ones
# Textgrid compulsory, sound files optional
# Textgrids are 'exploded', sub-tiers are maintained
# No silence interval added
# By Katrina Kechun Li (2020.7.19)
# Update on 2021.9.27: Now check the content of "temp" directory first, and if not empty, it will ask you to delete the files in the folder first.

form Explode TextGrid...
  integer Tier 1
  boolean Preserve_times 0
endform

# Change the directory here:
# dir$ = ""

###################
# Specify the path that you want to save the exploded individual files
dir$ = ""
###################


sound = numberOfSelected("Sound")
if sound
  sound = selected("Sound")
endif

textgrid = selected("TextGrid")

# Check if the diretory is empty, and if not, exit the script
strings = Create Strings as file list: "list", dir$ + "/*.TextGrid"
num_of_strings = Get number of strings
if num_of_strings > 0
  exitScript: "Delete all the files in the folder first"
endif

selectObject: textgrid
interval = Is interval tier: tier
if !interval
  exit Not an interval tier
endif

intervals = Get number of intervals: tier
n = 0
for i to intervals
  selectObject: textgrid
  start = Get start point: tier, i
  end = Get end point: tier, i
  label$ = Get label of interval: tier, i
  if label$ <> "" and startsWith(label$,"$") = 0
	n = n+1
    textgrid[n] = Extract part: start, end, preserve_times
	  Rename: label$

	  if sound
	    selectObject: sound
	    sound[n] = Extract part: start, end, "rectangular", 1, preserve_times
	    Rename: label$
	  endif
  endif
endfor

nocheck selectObject: undefined
for i from 1 to n
	plusObject: textgrid[i]
	plusObject: sound[i]
endfor

# Other non-recognised types will be saved with the type suffix
m = numberOfSelected()
writeInfoLine: "m=",tab$,m

# We need to generate all the filenames in the first step, with all files "selected". Once we select individual files, we can no longer refer back to the chunk.
for i from 1 to m
	s'i' = selected('i')
	s'i'$ = selected$('i')
	appendInfo: s'i'$,newline$
endfor

appendInfo: newline$
for i from 1 to m
	select s'i'
	type$ = extractWord$(s'i'$,"")
	name$ = extractWord$(s'i'$," ")
		if type$ = "Sound"
			filename$ = dir$+name$+".wav"
			Save as WAV file: filename$
			appendInfo: filename$, newline$
		elsif type$ = "TextGrid"
			filename$ = dir$+name$+".TextGrid"
			Save as text file: filename$
			appendInfo: filename$, newline$
		else
			filename$ = dir$+name$
			Save as text file: filename$
			appendInfo: filename$, newline$
		endif
endfor

nocheck selectObject: undefined
for i from 1 to n
	plusObject: textgrid[i]
	plusObject: sound[i]
endfor
Remove
