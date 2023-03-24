# Reorganize files in order: Step 2
# This makes use of the inbuilt function of folders to arrange the order
# The dir has to keep the same as Step 1
# Follow the previous script, Textgrid compulsory, sound optional, but in reality often both are used
# By Katrina Kechun Li (2020.7.19)

form Reorganize into...
  word Renameas S1dia
  comment S1dia, S1diaN, S1diaN1, S1diaNQ, S1diaNQ1, S1pair, S1word
endform

###############################
# Specify the path that the individual files are saved to
dir$ = ""
###############################
#-------------- Sound part------------------#
strings = Create Strings as file list: "list", dir$ + "/*.wav"
if strings
	numberOfFiles = Get number of strings
	n=0
	for ifile to numberOfFiles
   		selectObject: strings
    	fileName$ = Get string: ifile
    	Read from file: dir$ + "/" + fileName$
		n = n+1
		sound[n] = selected("Sound")
	endfor

	nocheck selectObject: undefined
	for i from 1 to numberOfFiles
		plusObject: sound[i]
	endfor
	Concatenate
	Rename: renameas$

	nocheck selectObject: undefined
	for i from 1 to numberOfFiles
		plusObject: sound[i]
	endfor
	plusObject: strings
	Remove
endif
writeInfoLine: numberOfFiles, " sounds concatenated."
#-----------TextGrid part------------#
strings = Create Strings as file list: "list", dir$ + "/*.TextGrid"
numberOfFiles = Get number of strings
n=0
for ifile to numberOfFiles
    selectObject: strings
    fileName$ = Get string: ifile
    Read from file: dir$ + "/" + fileName$
	n = n+1
	textgrid[n] = selected("TextGrid")
endfor

nocheck selectObject: undefined
for i from 1 to numberOfFiles
	plusObject: textgrid[i]
endfor
Concatenate
Rename: renameas$
appendInfoLine: numberOfFiles, " textgrids concatenated."


nocheck selectObject: undefined
for i from 1 to numberOfFiles
	plusObject: textgrid[i]
endfor
plusObject: strings
Remove
