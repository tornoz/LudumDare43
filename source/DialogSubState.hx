package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.FlxSubState;
import flixel.text.FlxText;
class DialogSubState extends FlxSubState {

    var message:FlxText;

    var texts:Array<String>;
    var index = 0;
    public function new(texts:Array<String>) {
        super();
        this.texts = texts;
    }

     override public function create():Void
	{
		var bg = new FlxSprite(0, 0);
		bg.loadGraphic(AssetPaths.dialog__png);
        add(bg);
        addText(64,451, 1135, this.texts[0], 15);


	}


    override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		var contactPoint = null;
        #if (desktop || web)
		if(FlxG.mouse.justPressed) {
			nextText();
		}
		#elseif mobile
		if(FlxG.touches.getFirst() != null && FlxG.touches.getFirst().justReleased) {
			nextText();
		}
		#end
	}

    public function nextText() {
        remove(message);
        message.destroy();
        index ++;
        if(index >= texts.length ) {
            close();
        }
        addText(64,451, 1135, this.texts[index], 15);
        
    }

    private function addText(x:Int, y:Int, width: Int, text:String, size:Int) {
        message = new FlxText(x,y, width, text, size);
        message.borderColor = FlxColor.BLACK;
        message.borderSize = 3;
        message.borderStyle = flixel.text.FlxTextBorderStyle.OUTLINE;
        add(message);
    }


}