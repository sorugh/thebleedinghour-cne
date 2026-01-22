import haxe.ds.StringMap;

// this is unfinished but it works for the time being
var preloadedCharacters:Array<StringMap<Character>> = [];

function preloadNewCharacter(strumID:Int, charID:Int, newCharName:String) {
	if (preloadedCharacters[strumID].exists(newCharName))
		return;

	var strumLine:StrumLine = strumLines.members[strumID];
	var existingChar:Character = strumLine.characters[charID];
	var newChar:Character = new Character(existingChar.x, existingChar.y, newCharName, existingChar.isPlayer);
	stage.applyCharStuff(newChar, strumLine.data.position == null ? (switch (strumLine.data.type) {
		case 0: "dad";
		case 1: "boyfriend";
		case 2: "girlfriend";
	}) : strumLine.data.position);
	newChar.visible = newChar.active = false;
	newChar.drawComplex(FlxG.camera);
	preloadedCharacters[strumID].set(newCharName, newChar);
}

function postCreate() {
	for (i => strumLine in strumLines.members) {
		preloadedCharacters[i] = new StringMap();
		for (character in strumLine.characters)
			preloadNewCharacter(i, character, character.curCharacter);
	}

	for (event in PlayState.SONG.events) {
		var params:Array<Dynamic> = event.params;
		if (event.name == "Change Character")
			preloadNewCharacter(params[0], params[1], params[2]);
	}
}

function onEvent(event) {
	var params:Array<Dynamic> = event.event.params;
	if (event.event.name == "Change Character") {
		var strumLine:StrumLine = strumLines.members[params[0]];
		var oldChar:Character = strumLine.characters[params[1]];
		var newChar:Character = preloadedCharacters[params[0]][params[2]];

		if (oldChar.curCharacter == newChar.curCharacter)
			return;

		insert(members.indexOf(oldChar), newChar);
		newChar.visible = newChar.active = true;
		remove(oldChar);

		newChar.setPosition(oldChar.x, oldChar.y);
        	if (newChar.hasAnim(oldChar.getAnimName()))
         		newChar.playAnim(oldChar.getAnimName(), true, oldChar.lastAnimContext, false, oldChar.animation?.curAnim?.curFrame);

           	strumLine.characters[params[1]] = newChar;
	}
}
