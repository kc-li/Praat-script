# Editor scirpt for remove multiple boundaries
# You can open this script from a textgrid window, or intall the script as a button
# By Katrina Li (21.05.06) CC BY license 


# 1. Make sure the correct tier is selected (an interval on the target tier is marked in yellow)
# 2. Select the an interval that contained one or multiple boundaries that you want to remove

	cursor1 = Get start of selection
	cursor2 = Get end of selection
	fulltier = Extract entire selected tier
endeditor

select 'fulltier'
part = Extract part: cursor1,cursor2,1
select 'part'

# Get the information of all the markers in the interval
num_of_intervals = Get number of intervals... 1
s# = zero#(num_of_intervals)
for i to num_of_intervals
	s#[i] = Get end time of interval... 1 i
endfor

select 'fulltier'
plus 'part'
Remove

#Remove the boudnary in the editor window
editor
for i to num_of_intervals-1
	Move cursor to: s#[i]
	Remove
endfor



