package minigames;

import flixel.addons.display.FlxExtendedSprite;
import flixel.FlxSprite;
using flixel.util.FlxSpriteUtil;
import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.util.FlxColor;

class Pentagram extends MiniGame {



    var pentacle:FlxPoint;
    var canvas:FlxSprite;
    var lineStyle:LineStyle = { color: FlxColor.BLACK, thickness: 3 };
    var drawStyle:DrawStyle = { smoothing: true };

    var drawColor:FlxColor;

    var buttonOk:FlxSprite;
    var buttonClear:FlxSprite;

    var isDraw = true;

    var targetDrawing1:FlxSprite;
    var targetDrawing2:FlxSprite;
    var targetDrawing3:FlxSprite;

    var selectedPentagram:String;
    var scorePentagram = 0.0;
    var text:FlxSprite;


    var textTime:Float = 0;
    static var textDuration:Float = 1.0;

    

    static var sliceDuration:Float = 1.0;
    var drawn = false;

    override public function create():Void
	{
		super.create();
		
        
        var pentacle = new FlxSprite(0, 0);
		pentacle.loadGraphic(AssetPaths.pentacle_big__png);

        drawColor = FlxColor.PINK;
        canvas = new FlxSprite();
        canvas.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);

        buttonOk = new FlxSprite(924, 420);
        buttonClear = new FlxSprite(924, 520);
		buttonOk.loadGraphic(AssetPaths.button_ok__png);
		buttonClear.loadGraphic(AssetPaths.button_clear__png);
        targetDrawing1 = new FlxSprite(0,0);
		targetDrawing1.loadGraphic(AssetPaths.star__png);
        targetDrawing2 = new FlxSprite(0,0);
		targetDrawing2.loadGraphic(AssetPaths.star2__png);
        targetDrawing3 = new FlxSprite(0,0);
		targetDrawing3.loadGraphic(AssetPaths.star3__png);
    
        text = new FlxSprite(262, 284);
        text.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);
        add(pentacle);
        add(canvas);
        add(buttonOk);
        add(buttonClear);
        add(text);
        FlxG.watch.addMouse();

	}

    
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        if(!drawn) {
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
            if(contactPoint != null) { 
                if(contactPoint.x > buttonOk.x && contactPoint.x < (buttonOk.x + buttonOk.graphic.width)
                && contactPoint.y > buttonOk.y && contactPoint.y < (buttonOk.y + buttonOk.graphic.height)) {
                    clickOk();
                    return;
                }
                else if(contactPoint.x > buttonClear.x && contactPoint.x < (buttonClear.x + buttonClear.graphic.width)
                && contactPoint.y > buttonClear.y && contactPoint.y < (buttonClear.y + buttonClear.graphic.height)) {
                    clickClear();
                }
                
                
            }

		    #if (desktop || web)
                if(FlxG.mouse.pressed) {
                    canvas.drawEllipse(FlxG.mouse.getWorldPosition().x-13, FlxG.mouse.getWorldPosition().y-13, 26,26,drawColor);
                }
            #elseif mobile
                if(FlxG.touches.getFirst() != null && FlxG.touches.getFirst().pressed) {
                    canvas.drawEllipse(FlxG.touches.getFirst().x - 13, FlxG.touches.getFirst().y - 13, 26,26,drawColor);
                }
            #end
        } else {
            textTime -= elapsed;
            text.alpha = textTime;
            if(textTime <= 0) {
                close();
            }
        }
        
    }

    public function clickOk() { 
        drawn = true;
        var canvasPixel:Int = 0;
        var targetPixel1:Int = 0;
        var targetPixel2:Int = 0;
        var targetPixel3:Int = 0;
        var score1:Float = 0.0;
        var score2:Float = 0.0;
        var score3:Float = 0.0;
        var totalPossible1 = 0;
        var totalPossible2 = 0;
        var totalPossible3 = 0;

        for(ix in 0...canvas.graphic.width) {
            for(iy in 0...canvas.graphic.height) {
                canvasPixel = canvas.pixels.getPixel32(ix, iy);
                targetPixel1 = targetDrawing1.pixels.getPixel32(ix, iy);
                targetPixel2 = targetDrawing2.pixels.getPixel32(ix, iy);
                targetPixel3 = targetDrawing3.pixels.getPixel32(ix, iy);

                if(targetPixel1 != 0) {
                    totalPossible1 += 4;
                }
                if(targetPixel2 != 0) {
                    totalPossible2 += 4;
                }
                if(targetPixel3 != 0) {
                    totalPossible3 += 4;
                }
                
                score1 += checkPixel(canvasPixel, targetPixel1);
                score2 += checkPixel(canvasPixel, targetPixel2);
                score3 += checkPixel(canvasPixel, targetPixel3);
            }
        }

        score1 = score1/totalPossible1;
        score2 = score2/totalPossible2;
        score3 = score3/totalPossible3;

        if(score1 > score2 && score1 > score3) {
            selectedPentagram = Ritual.STAR_1;
            scorePentagram = score1;
        } else if (score2 > score1 && score2 > score3) {
            selectedPentagram = Ritual.STAR_2;
            scorePentagram = score2;
        }else if (score3 > score1 && score3 > score2) {
            selectedPentagram = Ritual.STAR_3;
            scorePentagram = score3;
        }
        
        text.fill(FlxColor.TRANSPARENT);
        text.alpha = 1.0;
        textTime = textDuration;
        FlxG.camera.shake(0.01, 0.2);
        if(scorePentagram >= 0.5) {
            text.loadGraphic(AssetPaths.perfect__png);
        } else if (scorePentagram >= 0.4) {
            text.loadGraphic(AssetPaths.nice__png);
        }else if (scorePentagram > 0.3) {
            text.loadGraphic(AssetPaths.ok__png);
        } else if(scorePentagram < 0.3) {
            text.loadGraphic(AssetPaths.bad__png);
        }
    }

    public function checkPixel(drawing:Int, target:Int):Int {
        if(drawing != 0 && target != 0) {
            return 4;
        } else if(drawing != 0 && target == 0) {
            return -3;
        } else if(drawing == 0 && target != 0) {
            return -1;
        } else {
            return 0;
        }
    }

    public function clickClear() {
        canvas.fill(FlxColor.TRANSPARENT);
    }

    public function getSelectedPentagram():String {
        return selectedPentagram;
    }

    public function getScorePentagram():Float {
        return scorePentagram;
    }
    public function getCanvas():FlxSprite {
        return canvas;
    }

}