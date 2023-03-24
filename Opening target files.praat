# Praat script for opening selected files
# This is specifically designed for the P2FA workflow
form
    text Filenames S1diaA1,S1diaA2
    comment S1dia1nC1,S3dia1C1, separated by comma but no space
    choice textgrid: 1
        button textgrid_checked
        button textgird_pitch
endform

sounddirectory$ = "sound_original/"
soundsuffix$ = ".wav"
if textgrid = 1
    textdirectory$ = "textgrid_checked/processed"
    textsuffix$ = "_checked.TextGrid"
else
    textdirectory$ = "textgrid_pitch/"
    textsuffix$ = ".wav_pitch.TextGrid"
endif

writeInfoLine: length(filenames$)
comma = index(filenames$,",")
rcomma = rindex(filenames$, ",")
if comma != 0 
    repeat
        current_file$ = left$(filenames$,comma-1)
	appendInfoLine: current_file$
        Read from file: textdirectory$ + current_file$ + textsuffix$
        Read from file: sounddirectory$ + current_file$ + soundsuffix$
        filenames$ = right$(filenames$, rcomma)
	appendInfoLine: filenames$
        comma = index(filenames$, ",")
	rcomma = rindex(filenames$, ",")
    until comma = 0
	# Read the last file
	Read from file: textdirectory$ + filenames$ + textsuffix$
    Read from file: sounddirectory$ + filenames$ + soundsuffix$
else
    Read from file: textdirectory$ + filenames$ + textsuffix$
    Read from file: sounddirectory$ + filenames$ + soundsuffix$
endif