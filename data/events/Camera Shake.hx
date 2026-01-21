using StringTools;

function onEvent(event) {
	var params:Array<Dynamic> = event.event.params;
	if (event.event.name == "Camera Shake")
		for (i in params[0].split(","))
			Reflect.getProperty(PlayState.instance, i.trim()).shake(params[2], params[1] * (Conductor.stepCrochet * 0.001));
}
