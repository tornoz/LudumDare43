package minigames;

import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.math.FlxPoint;

class MiniGame extends FlxSubState {


    var buttonBack:FlxSprite;
    var back = false;


    var burn:FlxSprite;
    var incenseChoosen:Bool;

	public function new(incenseChoosen:Bool, burn:FlxSprite) {
		super();
        this.incenseChoosen = incenseChoosen;
        this.burn = burn;
	}

    override public function create():Void
	{
		super.create();
        buttonBack = new FlxSprite(924, 620);
		buttonBack.loadGraphic(AssetPaths.button_back__png);
        add(buttonBack);
	}

    override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if(incenseChoosen) {
			burn.x -= (elapsed/PlayState.INCENSE_DURATION)*680.0;
			if(burn.x < 112) {
				close();
			}
		}
		var contactPoint = null;
        #if (desktop || web)
		if(FlxG.mouse.justPressed) {
			contactPoint = new FlxPoint(FlxG.mouse.getScreenPosition().x , FlxG.mouse.getScreenPosition().y );
		}
		#elseif mobile
		if(FlxG.touches.getFirst() != null && FlxG.touches.getFirst().justReleased) {
			contactPoint = new FlxPoint(FlxG.touches.getFirst().x, FlxG.touches.getFirst().y);
		}
		#end

        if(contactPoint != null && contactPoint.x > buttonBack.x && contactPoint.x < (buttonBack.x + buttonBack.graphic.width)
        && contactPoint.y > buttonBack.y && contactPoint.y < (buttonBack.y + buttonBack.graphic.height)) {
            back = true;
            close();
        }

	}

    public function isBack() {
        return back;
    }

}