import funkin.backend.system.Flags;
import funkin.backend.assets.ModsFolder;
import sys.io.File;
import lime.graphics.Image;

var currentModPath:String = ModsFolder.modsPath + "/" + ModsFolder.currentModFolder;

function new()
	Flags.VERSION_MESSAGE = Flags.MOD_NAME + "\nv" + Flags.customFlags["MOD_PORT_VERSION"];

function destroy()
	window.setIcon(Image.fromBytes(File.getBytes(currentModPath + '/images/base-icon.png')));
