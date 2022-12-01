# Version 1
# Extraction parameters: inensity, duration
# By Katrina Li (2021.1.19)
# ----
# Version 2
# Based on selected sound & textgrid files
# f0&intesnsity&duration from the segment tier, duration of the corresponding syllable, as well as all the labels
# pointprocess optional
# Suitable for the three-tier system of Cantonese project (2021.3.16)
# Allow using sound name as the name for new files
# ---
# Version 3
# Introduce normalised f0
# ---
# Version 4 (2022.1.19)
# Fix bugs when there is no point process file
# ---
# Version 5 (2022.4.26)
# Incoporate default settings on f0 (male vs. female)

form Extract f0 statistics from labelled intervals of selected tiers
	positive sentence_tier 1
	positive syllable_tier 2
	positive segment_tier 3
	boolean pointprocess 0
	positive npoints 10
	optionmenu f0setting: 1
		option Male
		option Female
		option Custom
	positive minf0 100
	comment male=75, female=100
	positive maxf0 600
	comment male=300,female=600
	boolean name_from_sound 1
	comment otherwise, specify the name of the files
    word filename S1dia1n.txt
	word dir data_chengdu/
endform



textGridID = selected("TextGrid")
soundID = selected("Sound")
soundname$ = selected$("Sound")

if name_from_sound
	filename$ = soundname$+".txt"
endif

resultsfile$ = dir$ + filename$
if fileReadable(resultsfile$)
  deleteFile: resultsfile$
endif

writeFileLine: resultsfile$,  "seg_lab", tab$, "syl_lab", tab$, "sen_lab", tab$, "seg_dur", tab$, "syl_dur", tab$, "f0mean", tab$, "f0min", tab$, "f0max", tab$, "f0min_point", tab$, "f0max_point", tab$, "intmean", tab$,
... "intmin", tab$, "intmax", tab$, "f0_1", tab$, "f0_2", tab$, "f0_3",tab$, "f0_4", tab$, "f0_5", tab$, "f0_6", tab$, "f0_7", tab$, "f0_8", tab$, "f0_9", tab$, "f0_10"

if f0setting == 1
	min_f0 = 75
	max_f0 = 300
elsif f0setting == 2
	min_f0 = 100
	max_f0 = 600
else
	min_f0 = minf0
	max_f0 = maxf0
endif
	

if pointprocess
	pointprocessID = selected("PointProcess")
	select 'pointprocessID'
	To PitchTier... 0.02
	pitchtierID = selected("PitchTier")
	select 'pitchtierID'
	To Pitch... 0.02 min_f0 max_f0
	pitchID = selected("Pitch")
else
	select 'soundID'
	To Pitch... 0.02 min_f0 max_f0
	pitchID = selected("Pitch")
endif

select 'soundID'
Scale peak... 0.99
To Intensity... min_f0 0.01 1
intensityID = selected("Intensity")

select 'textGridID'
nintervals = Get number of intervals... segment_tier

interval = 0

for m from 1 to nintervals
	select 'textGridID'
	seg_lab$ = Get label of interval... segment_tier m
	if seg_lab$ <> "" and seg_lab$ <> " "
		start = Get starting point... segment_tier m
		end = Get end point... segment_tier m
		mid = (start + end)/2
		seg_dur = end - start

		syllable_interval = Get interval at time: syllable_tier, mid
		syl_lab$ = Get label of interval: syllable_tier, syllable_interval

		syllable_start = Get starting point... syllable_tier syllable_interval
		syllable_end = Get end point... syllable_tier syllable_interval
		syl_dur = syllable_end - syllable_start

		sentence_interval = Get interval at time: sentence_tier, mid
		sen_lab$ = Get label of interval: sentence_tier, sentence_interval

		select 'pitchID'
		if pointprocess
			f0mean = Get mean... start end Hertz
			f0min = Get minimum... start end Hertz Parabolic
			f0max = Get maximum... start end Hertz Parabolic
			f0min_time = Get time of minimum... start end Hertz Parabolic
			f0min_point = (f0min_time-start)/seg_dur
			f0max_time = Get time of maximum... start end Hertz Parabolic
			f0max_point = (f0max_time-start)/seg_dur
		else
			f0mean = Get mean: start, end, "Hertz"
			f0min = Get minimum... start end Hertz Parabolic
			f0max = Get maximum... start end Hertz Parabolic
			f0min_time = Get time of minimum... start end Hertz Parabolic
			f0min_point = (f0min_time-start)/seg_dur
			f0max_time = Get time of maximum... start end Hertz Parabolic
			f0max_point = (f0max_time-start)/seg_dur
		endif

   		select 'intensityID'
   		intmean = Get mean: start, end, "dB"
		intmin = Get minimum: start, end, "Parabolic"
		intmax = Get maximum: start, end, "Parabolic"

		# extract normalised f0
		f0s# = zero#(npoints)
		for x from 1 to npoints
			normtime = start + seg_dur*(x-1)/(npoints-1)
			select 'pitchID'
			f0s#[x] = Get value at time... normtime "Hertz" linear
		endfor

		appendFileLine: resultsfile$, seg_lab$, tab$, syl_lab$, tab$, sen_lab$, tab$, seg_dur, tab$, syl_dur, tab$, f0mean, tab$, f0min, tab$, f0max, tab$, f0min_point, tab$, f0max_point, tab$,
		... intmean, tab$, intmin, tab$, intmax, tab$, f0s#[1], tab$, f0s#[2], tab$, f0s#[3], tab$, f0s#[4], tab$, f0s#[5], tab$, f0s#[6], tab$, f0s#[7], tab$, f0s#[8], tab$, f0s#[9], tab$, f0s#[10]
		interval = interval + 1
	endif
endfor

select 'pitchID'
plus 'intensityID'
if pointprocess
	plus 'pitchtierID'
endif
Remove
