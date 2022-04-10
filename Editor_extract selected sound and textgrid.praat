# Editor script: Extract the selected period of sound&textgrid, and if there is a lablel, change the name of both

start = Get start of selection
end = Get end of selection
label$ = Get label of interval

sound = Extract selected sound (time from 0)
textgrid = Extract selected TextGrid (time from 0)

endeditor

if label$ <> ""
  select 'sound'
  Rename: label$
  select 'textgrid'
  Rename: label$
endif
