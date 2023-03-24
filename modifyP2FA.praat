# Facilitate the double check of the boundaries
# It opens the "_checked.TextGrid" and extract tier 4-7 to display with sound
# It allow you to free modify, and when finished, saved with the P2FA tiers, and save the new file to folder
# By Katrina Li 21/2/2023

# Future implementation: Allow only open selected
# target$ = "A3"

# Open the files 
textgriddir$ = "textgrid_checked/trial/"
sounddir$ = "sound_original"

# Loop thorugh all the files in a folder
textgridstrings = Create Strings as file list: "list", textgriddir$ + "/*.TextGrid"
if textgridstrings
  	numberOfFiles = Get number of strings
	n = 0
  	writeInfoLine: "There are ", numberOfFiles, " Files."
    for ifile to numberOfFiles
        selectObject: textgridstrings
    	textgridName$ = Get string: ifile
		textgridID = Read from file: textgriddir$ + "/" + textgridName$
        textgridName_current$ = selected$("TextGrid")
		appendInfoLine: "Current file is ", textgridName$
        # Set up a copy textgrid, keep tiers 1,2,3,4
        select 'textgridID'
        textgridID_old = Copy: textgridName_current$ + "_old"
        Remove tier: 7
        Remove tier: 6
        Remove tier: 5
        # Set up a copy textgrid, Only keep tiers 5,6,7
        select 'textgridID'
        textgridID_check = Copy: textgridName_current$ + "_check"
        # When remove a series of tiers, it's important to do this from the bottom to top (for the tier number will change!)
        Remove tier: 4
        Remove tier: 3
        Remove tier: 2
        Remove tier: 1


        # Combine with sound and open
		soundName$ = textgridName$ - "_checked.TextGrid" + ".wav"
    	soundID = Read from file: sounddir$ + "/" + soundName$
        select 'textgridID_check'
		plus 'soundID'
		View & Edit

        #Begin pause: allow the user to freely change
        # Begin pause
		repeat
			beginPause("Check boundaries")
            comment("File 'textgridName_current$'(file number 'ifile' of 'numberOfFiles')")
            clicked = endPause("Skip","Save",1)
            if clicked = 1
                appendInfoLine: textgridName$, " skipped!"
            elif clicked = 2
                select 'textgridID_old'
                plus 'textgridID_check'
                newtextgridID = Merge
                Rename: textgridName_current$
                Save as text file: textgriddir$ + textgridName$
            endif
        until clicked = 1 or clicked = 2

        # Keep the new files, but delete the rest
        select 'textgridID'
        plus 'textgridID_old'
        plus 'textgridID_check'
        Remove
    endfor
endif


# Read only the last few textgrid, to avoid bias, but still save to the original ones when finish