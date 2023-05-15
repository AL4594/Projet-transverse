extends CanvasLayer

signal transitioned





func _ready():
	transition() # Replace with function body.


func transition():
	$AnimationPlayer.play("fade_to_black")
	print("Fading to black")
	


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		emit_signal("transitioned")

	if anim_name == "fade_to_normal":
		print("Finished fading")
	
	
	
	$AnimationPlayer.play("fade_to_normal")
	
