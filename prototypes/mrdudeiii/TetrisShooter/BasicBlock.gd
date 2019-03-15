extends KinematicBody2D

var mul = 4
var toClear = []

func check_clear():
	for i in $ClearArea.get_children():
		if i.name == "Three":
			mul = 3
		i.set_deferred("disabled", false)
		yield($ClearArea, "body_entered")
		i.set_deferred("disabled", true)
	yield(get_tree().create_timer(0.2), "timeout")
	do_clear()
	
	# need to check bigger clears after this

func log_clears(body):
	var area = $ClearArea
	if area.get_overlapping_bodies().size() == mul * mul:
		for i in area.get_overlapping_bodies():
			if not i in toClear:
				toClear.append(i)
		print(toClear)
	
func do_clear():
	print(toClear)
	if toClear.size() > 0:
		for i in toClear:
			print("ready to delete " + i.name)
			i.queue_free()
