
silence = Create Sound from formula: "silence", 1, -0.4, 0.4, 44100, ~0

sound# = zero#(30)
soundnew# = zero#(30)
for i from 1 to 30
	sound#[i] = Create Sound from formula: "beep", 1, -0.05, 0.05, 44100, ~0.7 * sin (2*pi*i*100*x)*exp(-0.5*(x/0.01)^2)
	selectObject: sound#[i]
	plusObject: silence
	soundnew#[i] = Concatenate
endfor

selectObject: soundnew#
Concatenate
Rename: "beep_series"

selectObject: sound#
plusObject:soundnew#
Remove