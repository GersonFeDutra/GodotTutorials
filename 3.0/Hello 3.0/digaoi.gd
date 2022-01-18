extends Panel


func on_button_pressed():
    get_node("Label").text = "%14.s" % "Valeu!"


func _ready():
    get_node("Button").connect("pressed", self, "on_button_pressed")
