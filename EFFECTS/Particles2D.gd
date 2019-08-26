extends CPUParticles2D

func _timeout():
	queue_free()

func _on_Timer_timeout():
	_timeout();

func _on_Timer_ready():
	$Timer.wait_time = self.get_lifetime();
	$Timer.start()