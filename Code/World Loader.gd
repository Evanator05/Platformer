extends StaticBody2D
export var scene_file = "Enter Scene File"
var enabled = false
onready var scene = load(scene_file)
onready var mapdata = scene.instance()




func _on_Loader_body_entered(body):
	if body.is_in_group("Player"):
		if not enabled:
			add_child(mapdata)
			enabled = true
	pass # Replace with function body.


func _on_Unloader_body_entered(body):
	if body.is_in_group("Player"):
		if enabled:
			remove_child(mapdata)
			enabled = false
	pass # Replace with function body.
