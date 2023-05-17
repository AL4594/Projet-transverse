extends Area2D




func _ready():
	pass

func _process(delta):
	
	if get_overlapping_bodies().size() > 0:
		next_level()
			#$AnimationPlayer.play("Open")
			#get_overlapping_bodies()[0].play_walk_in_animation() # 0 will be our player
			
func next_level():
	if get_tree().get_current_scene().get_name() == "res://Level_debug.tscn":
		get_tree().change_scene("res://icedmap.tscn")
	else:
		get_tree().change_scene("res://icedmap_solo.tscn")
	
