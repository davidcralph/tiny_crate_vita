extends Sprite

func _ready():
	if Shared.is_level_select or TouchScreen.visible:
		visible = false
	
	Pause.connect("pause", self, "pause")
	Pause.connect("unpause", self, "unpause")

func pause():
	visible = false

func unpause():
	visible = true
