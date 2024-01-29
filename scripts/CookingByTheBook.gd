extends Sprite2D

var clicked_node

@onready var theegg = $ingredients/egg;
@onready var themilk = $ingredients/milk;
@onready var theflour = $ingredients/flour;
@onready var thebean = $Others/Beancoffee;
@onready var theeed = $Others/Eed;

@onready var thebowl = $Others/bowl;

var bowlState = 0
var bowlItems = []

var overstate = "notcooked"

# Called when the node enters the scene tree for the first time.
func _ready():

	theegg.play("default")
	themilk.play("default")
	theflour.play("default")
	
	$Others/bowl.play("empty")
	
	$oven.play("default")
	pass
	
	
func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and clicked_node	:
		clicked_node.position = get_global_mouse_position()
		#create_duplicate_node(clicked_node)
		$Cookingboard/actionhappening.text = "Using " + clicked_node.name + "..."
	else:
		$Cookingboard/actionhappening.text = "Idle"


func create_duplicate_node(original_node):
	var duplicate_node = original_node.duplicate()
	duplicate_node.position = get_global_mouse_position()
	get_parent().add_child(duplicate_node)

func _on_egg_2d_mouse_entered():
	clicked_node = theegg

func _on_flour_2d_mouse_entered():
	clicked_node = theflour

func _on_milk_2d_mouse_entered():
	clicked_node = themilk

func _on_bean_2d_mouse_entered():
	clicked_node = thebean
	pass # Replace with function body.


func _on_eed_2d_mouse_entered():
	clicked_node = theeed
	pass # Replace with function body.


func _on_bowl_area_entered(area):
	var item = area.get_parent()
	print(item.name + " entered")
	if (item.name != "oven"):
		bowlState = bowlState + 1
		bowlItems.append(item)
		if (bowlState == 1):
			$Others/bowl.play("stageone")
		if (bowlState == 2):
			$Others/bowl.play("stagetwo")
		if (bowlState == 3):
			$Others/bowl.play("stagethree")
		clicked_node = null
		item.queue_free()


func _on_bowl_2d_mouse_entered():
	if (bowlState == 3):
		clicked_node = thebowl;
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	var item = area.get_parent()
	print(item.name)
	
	if (item.name == "bowl"):
		await get_tree().create_timer(1.0).timeout
		clicked_node = null
		item.queue_free()
		
		$oven.play("ovenful")
		
		await get_tree().create_timer(3.0).timeout
		$oven.play("ovenend")
		
		overstate = "cooked"



func _on_oven_2d_mouse_entered():
	if(overstate == "cooked"):
		pass
	pass # Replace with function body.
