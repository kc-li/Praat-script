dir$ = "/Users/kechun/Downloads/"
n = numberOfSelected("Sound")
writeInfoLine: "n=",tab$,n

for i from 1 to n
	s'i' = selected("Sound",'i')
	s'i'$ = selected$("Sound",'i')
	appendInfo: s'i'$,tab$
endfor
appendInfo:newline$
for i from 1 to n
	n$ = s'i'$
	selectObject: "Sound warningtone"
	plus s'i'
	Concatenate
	filename$ = dir$ + n$ + ".wav"
	Save as WAV file: filename$
	appendInfo: filename$,tab$

endfor


