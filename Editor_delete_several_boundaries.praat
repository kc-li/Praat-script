	cursor1 = Get start of selection
	cursor2 = Get end of selection
	fulltier = Extract entire selected tier
endeditor

select 'fulltier'
part = Extract part: cursor1,cursor2,1
select 'part'

num_of_intervals = Get number of intervals... 1
s# = zero#(num_of_intervals)
for i to num_of_intervals
	s#[i] = Get end time of interval... 1 i
endfor

select 'fulltier'
plus 'part'
Remove

editor
for i to num_of_intervals-1
	Move cursor to: s#[i]
	Remove
endfor