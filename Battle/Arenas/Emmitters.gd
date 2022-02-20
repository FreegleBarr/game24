extends Node2D

var up := true

func toggle():
	up = not up
	$BL.emitting = up
	$BR.emitting = up
	$TL.emitting = not up
	$TR.emitting = not up
		
