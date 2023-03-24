#!!This script is for a specific project so you might not find it useful for your purpose
# Manipulate duration and pitch in an accurate way
# Prepare the manipulation object beforehand, so that you could check the stylization
# Select textgrid & manipulation

# choose increase rate

name_duration = 1.5
boundary_duration = 1.5
name_pitch = 20
boundary_pitch = -20


textgrid = selected("TextGrid")
textgrid_name$ = selected$("TextGrid")
manipulation = selected("Manipulation")

selectObject: manipulation
durationtier = Extract duration tier

selectObject: manipulation
pitchtier = Extract pitch tier

selectObject: manipulation
pitchtier_original = Extract pitch tier

# Processing textgrid files and get duration point
selectObject: textgrid
start = Get start time
end = Get end time

dn1$ = Get label of point: 1,1
if dn1$ = "n1"
  dn1 = Get time of point... 1 1
else
	writeInfoLine: Check tier1 n1 please!
endif

dn2$ = Get label of point: 1,2
if dn2$ = "n2"
  dn2 = Get time of point... 1 2
else
  writeInfoLine: Check tier1 n2 please!
endif

pn1$ = Get label of point: 2,1
if pn1$ = "n1"
  pn1 = Get time of point... 2 1
else
	writeInfoLine: Check tier2 n1 please!
endif

pn2$ = Get label of point: 2,2
if pn2$ = "n2"
  pn2 = Get time of point... 2 2
else
	writeInfoLine: Check tier2 n2 please!
endif

#######################
db1$ = Get label of point: 1,3
if db1$ = "b1"
  db1 = Get time of point... 1 3
else
	writeInfoLine: Check tier1 b1 please!
endif

db2$ = Get label of point: 1,4
if db2$ = "b2"
  db2 = Get time of point... 1 4
else
	writeInfoLine: Check tier1 b2 please!
endif

pb1$ = Get label of point: 2,3
if pb1$ = "b1"
  pb1 = Get time of point... 2 3
else
	writeInfoLine: Check tier2 b1 please!
endif

pb2$ = Get label of point: 2,4
if pb2$ = "b2"
  pb2 = Get time of point... 2 4
else
	writeInfoLine: Check tier2 b2 please!
endif

pb02$ = Get label of point: 2,5
if pb02$ = "b02"
  pb02 = Get time of point... 2 5
else
	writeInfoLine: Check tier2 b02 please!
endif

# Process duration tier
selectObject: durationtier
Remove points between... start end
Add point... dn1-0.0001 1.0
Add point... dn1 name_duration
Add point... dn2 name_duration
Add point... dn2+0.0001 1.0

Add point... db1-0.0001 1.0
Add point... db1 boundary_duration
Add point... db2 boundary_duration
Add point... db2+0.0001 1.0

selectObject: pitchtier
Shift frequencies... pn1 pn2 name_pitch Hertz
Shift frequencies... pb2 pb02 boundary_pitch Hertz

# Note that duration and pitch are modified differently on name and boundary

#Publish resynthesis
selectObject: durationtier
plusObject: manipulation
Replace duration tier
selectObject: manipulation
plusObject: pitchtier
Replace pitch tier
selectObject: manipulation
Get resynthesis (overlap-add)

# assign name
name_duration$ = string$(name_duration)
boundary_duration$ = string$(boundary_duration)
name_pitch$ = string$(name_pitch)
boundary_pitch$ = string$(boundary_pitch)
name$ = textgrid_name$ + "+n" + "D" + name_duration$ + "P" + name_pitch$ + "+b" + "D" + boundary_duration$ + "P" + boundary_pitch$
Rename: name$

selectObject: manipulation
plusObject: pitchtier_original
Replace pitch tier

# Remove
selectObject: durationtier
plusObject: pitchtier
plusObject: pitchtier_original
Remove
