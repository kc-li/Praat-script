
# Extract text from all textgrids in a folder
#####################3
# Specify path here #
folder$ = ""
# Specify the tier where you want to extract the content
target_tier = 1
#####################


strings = Create Strings as file list: "list", folder$ + "/*.TextGrid"
numberOfFiles = Get number of strings

for ifile to numberOfFiles
	selectObject:strings
	filename$ = Get string: ifile
	file = Read from file: folder$ + "/" + fileName$
	textfile$ = folder$ + filename$ - "TextGrid" + "txt"
	
	select file
	nintervals = Get number of intervals... target_tier
	for m from 1 to nintervals
		label$ = Get label of interval... duration_tier m
		if label$ <> "" and label$ <> " "
			appendFileLine: textfile$, label$
		endif
	endfor
endfor