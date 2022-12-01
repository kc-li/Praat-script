# Extract f0 without time normalization v2m
# This is a modified version for my CantonesePFC project, ignoring interval marking "Vrest"
# Also allowing for adding labels from another layer (group variable)
# Based on the selected pitch file type: PitchTier, Pitch, or PointProcess, and textgrid file you selected in the praat
# This allows you to adjust pitch value manually and then extract the data.
# By Katrina Kechun Li (2020.4.)

form Extract f0 without time normalization
  positive step 20
  comment extract step (unit:ms)
  positive error 2
  comment if the distance between last extracting point and the ending point of an interval is below the number (unit: ms), f0 at ending point will also be extracted
  positive target_tier 3
  positive additional_tier_number 1
  optionmenu pitchfile: 1
    option pitch_tier
	option pitch
    option point_process
  positive min_f0 75
  comment male=75, female=100
  positive max_f0 300
  comment male=300,female=500
endform

textGridID = selected("TextGrid")
if pitchfile == 1
  pitchTierID = selected("PitchTier")
elsif pitchfile == 2
  pitchID = selected("Pitch")
  select 'pitchID'
  Down to PitchTier
  pitchTierID = selected("PitchTier")
else
  pointProcessID = selected("PointProcess")
  select 'pointProcessID'
  To PitchTier... 0.02
  pitchTierID = selected("PitchTier")
endif

select 'textGridID'
nintervals = Get number of intervals... target_tier

interval = 0
writeInfoLine: "label", tab$, "additional_label", tab$, "Interval", tab$, "Time_point", tab$, "Actual_Time", tab$, "f0"
for m from 1 to nintervals
	select 'textGridID'
	label$ = Get label of interval... target_tier m
	if label$ <> "" and label$ <> " " and label$ <> "Vrest"
    start = Get starting point... target_tier m
    end = Get end point... target_tier m
	duration = end - start
    mid = (start + end)/2
    label_additional = Get interval at time: additional_tier_number, mid
    label_additional$ = Get label of interval: additional_tier_number, label_additional
    t = start
    timepoint = 1
    while  t <= end
	  select 'pitchTierID'
      f0 = Get value at time... t
      appendInfoLine: label$, tab$, label_additional$, tab$, 1+interval, tab$, timepoint, tab$, t, tab$,f0
      timepoint = timepoint+1
	  distance = end - t
      t = t + step/1000
    endwhile
	if distance >= error/1000
		select 'pitchTierID'
      	f0 = Get value at time... end
      	appendInfoLine: label$, tab$, label_additional$, tab$, 1+interval, tab$, "end_point", tab$, end, tab$,f0
	endif
    interval = interval +1
  endif
endfor

if pitchfile != 1
	select 'pitchTierID'
	Remove
endif
