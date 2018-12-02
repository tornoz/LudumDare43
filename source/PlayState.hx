package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxSprite;
using flixel.util.FlxSpriteUtil;
import flixel.FlxSubState;
import minigames.Incense;
import minigames.SacrificeChoice;
import minigames.Sacrifice;
import minigames.Pentagram;
import flixel.addons.plugin.FlxMouseControl;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.system.scaleModes.FillScaleMode;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.math.FlxRandom;


class PlayState extends FlxState
{
	var cage:FlxSprite;
	var incensePot:FlxSprite;
	var pentacle:FlxSprite;
	var incenseSubState:Incense;
	var cageSubState:SacrificeChoice;
	var pentagramSubState:Pentagram;
	var sacrificeSubState:Sacrifice;
	var spellBookSubState:SpellbookSubState;
	var deadAnimal:FlxSprite;

	var incenseMask:FlxSprite;

	var nextSubState:FlxSubState;
	var iconSpellbook:FlxSprite;
	var iconInvoke:FlxSprite;
	var iconReset:FlxSprite;

	var game:Game;

	var glowIncense:FlxSprite;
	var glowPentagram:FlxSprite;
	var glowCage:FlxSprite;


	var burn:FlxSprite;

	var incense:FlxSprite;
	var canvas:FlxSprite;

	var chosenIncense:String;
	var chosenAnimal:String;
	var animalScore:Array<Float>;
	var pentagramScore:Array<Float>;
	var chosenPentagram:String;
	var invocationScore:Array<Float>;

	public static var INCENSE_DURATION = 60.0;
	var insenceTime = 0.0;


	public static var INVOCATION_DURATION = 5.0;
	var invocationTime = 0.0;

	public static var APPARITION_DURATION = 1.0;
	var apparitionTime = 0.0;

	var checkAzazel = false;
	var checkBaphomet = false;
	var checkAbaddon = false;

	var invocation =false;
	var apparition =false;
	var deityInvoked:String;


    var random:FlxRandom;

	var deity:FlxSprite;

	var dialogSubState:DialogSubState;


	override public function create():Void
	{
		game = new Game();

		FlxG.scaleMode = new FillScaleMode();
		var bg = new FlxSprite(0, 0);
		bg.loadGraphic(AssetPaths.bg__png);
		incensePot = new FlxSprite(326, 152);
		incensePot.loadGraphic(AssetPaths.incense__png);
		glowIncense = new FlxSprite(326,152);
		glowIncense.loadGraphic(AssetPaths.glow__png);
		FlxTween.tween(glowIncense, { alpha: 0 }, 1.5, { ease: FlxEase.linear, type: FlxTweenType.PINGPONG } );
		cage = new FlxSprite(535, 166);
		cage.loadGraphic(AssetPaths.cage__png);
		glowCage = new FlxSprite(535,166);
		glowCage.loadGraphic(AssetPaths.glow__png);
		FlxTween.tween(glowCage, { alpha: 0 }, 1.5, { ease: FlxEase.linear, type: FlxTweenType.PINGPONG  } );
		pentacle = new FlxSprite(342, 365);
		pentacle.loadGraphic(AssetPaths.pentacle__png);
		glowPentagram = new FlxSprite(442,450);
		glowPentagram.loadGraphic(AssetPaths.glow__png);
		FlxTween.tween(glowPentagram, { alpha: 0 }, 1.5, { ease: FlxEase.linear , type: FlxTweenType.PINGPONG } );
		iconSpellbook = new FlxSprite(1080, 0);
		iconSpellbook.loadGraphic(AssetPaths.icon_spellbook__png);
		iconInvoke = new FlxSprite(1080, 100);
		iconInvoke.loadGraphic(AssetPaths.icon_invoke__png);
		iconReset = new FlxSprite(1080, 200);
		iconReset.loadGraphic(AssetPaths.button_restart__png);
		burn = new FlxSprite(0, 0);
		burn.loadGraphic(AssetPaths.burn__png);
		//cage.mousePressedCallback = cageClick;
		add(bg);
		add(glowIncense);
		add(incensePot);
		add(cage);
		add(pentacle);
		add(iconSpellbook);
		add(iconInvoke);
		add(iconReset);
		nextSubState = null;
		random = new FlxRandom();
		animalScore = new Array<Float>();
		pentagramScore = new Array<Float>();
		invocationScore = new Array<Float>();

		super.create();
		openSpellbook();
	}

	override public function update(elapsed:Float):Void
	{
		

		
		if(apparition) {
			super.update(elapsed);
			apparitionTime -= elapsed;
			if(apparitionTime < 0) {
				apparition = false;
				switch(deityInvoked) {
					case "azazel":
					if(checkAzazel) {
						addDialog(
							[
								"Do you dare invoke me AGAIN, mortal?",
								"This time, you will perish!",
							], gameOver);
					} else {
						var message = "Your performance wasn't very good. But I'm feeling nice today so I'll allow you to live and invoke the other demons";
						if(invocationScore[invocationScore.length-1] > 100) {
							message = "Your performance was acceptable. I'll allow you to live and invoke the other demons";
						} else if(invocationScore[invocationScore.length-1] < 0) {
							message = "Your performance was terrible. I hope you have more luck in invoking the other demons so you can make up for this one";
						}
						addDialog(
							[
								"Do you dare invoke me, mortal?",
								"That's pretty rude of you, I was working out as you can see.",
								message
							], postAzazel);
					}
					case "baphomet":
					if(checkBaphomet) {
						addDialog(
							[
								"Do you dare invoke me AGAIN, mortal?",
								"This time, you will perish!",
							], gameOver);
					} else {
						var message = "Your performance wasn't very good. But I'm feeling nice today so I'll allow you to live and invoke the other demons";
						if(invocationScore[invocationScore.length-1] > 150) {
							message = "Your performance was acceptable. I'll allow you to live and invoke the other demons";
						} else if(invocationScore[invocationScore.length-1] < 0) {
							message = "Your performance was terrible. I hope you have more luck in invoking the other demons so you can make up for this one";
						}
						addDialog(
							[
								"W... What?",
								"Devil blessed, do you have any notion of timezones? Do you know what time is it in my circle of Hell?!",
								"Yeah, I thought so, be more carefull next time.",
								message
							], postBaphomet);
					}
					case "abaddon":
					if(checkAbaddon) {
						addDialog(
							[
								"Do you dare invoke me AGAIN, mortal?",
								"This time, you will perish!",
							], gameOver);
					} else {
						var message = "Your performance wasn't very good. But I'm feeling nice today so I'll allow you to live and invoke the other demons";
						if(invocationScore[invocationScore.length-1] > 150) {
							message = "Your performance was acceptable. I'll allow you to live and invoke the other demons";
						} else if(invocationScore[invocationScore.length-1] < 0) {
							message = "Your performance was terrible. I hope you have more luck in invoking the other demons so you can make up for this one";
						}
						addDialog(
							[
								"And then I told the imp...",
								"What the heaven? Can you knock before invoking?",
								message
							], postAbaddon);
					}
					case "dog":
						
						addDialog(
							[
								"Waf?",
							], reset);
					case "cthullu":
						
						addDialog(
							[
								"Fhtagn?",
							], gameOver);
					case "satan":
						var score = 0;
						for(incatationSc in invocationScore) {
							score+= Std.int(incatationSc);
						}
						var winState = new WinState(score);
						FlxG.switchState(winState);
				}
			}
		}
		else if(invocation) {
			super.update(elapsed);
			invocationTime -= elapsed;
			if(invocationTime < 0) {

				apparitionTime = APPARITION_DURATION;
				FlxG.camera.shake(0.01, 0.2);
				FlxG.camera.flash(FlxColor.RED, 0.1);
				deity = new FlxSprite(411,390);
				switch(deityInvoked) {
					case "azazel":
						deity.loadGraphic(AssetPaths.azazel__png);
					case "baphomet":
						deity.loadGraphic(AssetPaths.baphomet__png);
					case "abaddon":
						deity.loadGraphic(AssetPaths.abaddon__png);
					case "cthullu":
						deity.loadGraphic(AssetPaths.cthullu__png);
					case "dog":
						deity.loadGraphic(AssetPaths.dog__png);
				}
				add(deity);
				invocation = false;
				apparition = true;

			} else {
				if(random.int(0,100) == 0) {
					var thunder = new FlxSprite(0,0);
					var thunderSprite = random.int(0,2);
					switch(thunderSprite) {
						case 0:
							thunder.loadGraphic(AssetPaths.thunder1__png);
						case 1:
							thunder.loadGraphic(AssetPaths.thunder2__png);
						case 2:
							thunder.loadGraphic(AssetPaths.thunder3__png);
					}
					

					FlxTween.tween(thunder, { alpha: 0 }, 1.5, { ease: FlxEase.linear} );
					add(thunder);

					FlxG.camera.shake(0.01, 0.2);
					FlxG.camera.flash(FlxColor.WHITE, 0.1);
				}
			}
			return;
		}
		if(chosenIncense != null) {
			insenceTime -= elapsed;
			burn.x -= (elapsed/INCENSE_DURATION)*680.0;
			if(burn.x < 112) {
				addDialog(
							[
								"The incense has burnt out, click to restart",
							], reset);
			}
		}
		if(nextSubState != null && this.subState == null) {		
			nextSubState = null;
			openSubState(this.sacrificeSubState);
			return;
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

		if(contactPoint != null) {
			if(contactPoint.x > incensePot.x && contactPoint.x < (incensePot.x + incensePot.graphic.width)
				&& contactPoint.y > incensePot.y && contactPoint.y < (incensePot.y + incensePot.graphic.height) && chosenIncense == null) {
					incensePotClick();
				}
				else if(contactPoint.x > cage.x && contactPoint.x < (cage.x + cage.graphic.width)
				&& contactPoint.y > cage.y && contactPoint.y < (cage.y + cage.graphic.height) && chosenAnimal== null && chosenIncense != null) {
					cageClick();
				}else if(contactPoint.x > pentacle.x && contactPoint.x < (pentacle.x + pentacle.graphic.width)
				&& contactPoint.y > pentacle.y && contactPoint.y < (pentacle.y + pentacle.graphic.height) && chosenPentagram == null && chosenIncense != null) {
					pentacleClick();
				}else if(contactPoint.x > iconSpellbook.x && contactPoint.x < (iconSpellbook.x + iconSpellbook.graphic.width)
				&& contactPoint.y > iconSpellbook.y && contactPoint.y < (iconSpellbook.y + iconSpellbook.graphic.height)) {
					openSpellbook();
				}else if(contactPoint.x > iconInvoke.x && contactPoint.x < (iconInvoke.x + iconInvoke.graphic.width)
				&& contactPoint.y > iconInvoke.y && contactPoint.y < (iconInvoke.y + iconInvoke.graphic.height)) {
					invoke();
				}else if(contactPoint.x > iconReset.x && contactPoint.x < (iconReset.x + iconReset.graphic.width)
				&& contactPoint.y > iconReset.y && contactPoint.y < (iconReset.y + iconReset.graphic.height)) {
					reset();
				}
		}

		super.update(elapsed);
	}

	public function postAzazel() {
		softReset();
		checkAzazel = true;
		remove(deity);
	}
	public function postAbaddon() {
		softReset();
		checkAbaddon = true;
		remove(deity);
	}
	public function postBaphomet() {
		softReset();
		checkBaphomet = true;
		remove(deity);
	}

	public function gameOver() {
		var gameOverState = new GameOverState();
		FlxG.switchState(gameOverState);
	}

	public function softReset() {
		if(chosenIncense != null) {
			chosenIncense = null;
			remove(incense);
			remove(burn);
			add(glowIncense);

			remove(glowCage);
			remove(glowPentagram);
		}		
		if(chosenAnimal != null) {
			chosenAnimal = null;
			remove(deadAnimal);
		}
		if(chosenPentagram != null) {
			chosenPentagram = null;
			remove(canvas);
		}
		
	}

	public function reset() {
			remove(deity);
		if(chosenIncense != null) {
			chosenIncense = null;
			remove(incense);
			remove(burn);
			add(glowIncense);

			remove(glowCage);
			remove(glowPentagram);
		}		
		if(chosenAnimal != null) {
			animalScore.pop();
			chosenAnimal = null;
			remove(deadAnimal);
		}
		if(chosenPentagram != null) {
			pentagramScore.pop();
			chosenPentagram = null;
			remove(canvas);
		}
		
	}

	public function addDialog(text:Array<String>, callback:Void -> Void) {
		dialogSubState = new DialogSubState(text);
		dialogSubState.closeCallback = callback;
		openSubState(this.dialogSubState);
	}

	public function incensePotClick():Void {
		incenseSubState = new Incense(false, null);
		incenseSubState.closeCallback = incenseChosen;
		openSubState(this.incenseSubState);
	}

	public function incenseChosen() {
		if(!incenseSubState.isBack()) {
			remove(glowIncense);
			insenceTime = INCENSE_DURATION;
			burn.x = 780;
			burn.y = 12;
			chosenIncense = incenseSubState.getChoosenIncense();
			incense = new FlxSprite(0, 0);
			switch(chosenIncense) {
				case Ritual.INCENSE_GREEN:
					incense.loadGraphic(AssetPaths.incense_green__png);
				case Ritual.INCENSE_PURPLE:
					incense.loadGraphic(AssetPaths.incense_purple__png);
				case Ritual.INCENSE_BLUE:
					incense.loadGraphic(AssetPaths.incense_blue__png);
			}
			add(incense);
			add(burn);
			add(glowCage);
			add(glowPentagram);
		}
	}

	public function openSpellbook() {

		spellBookSubState = new SpellbookSubState(game, (chosenIncense != null), burn);
		openSubState(this.spellBookSubState);
	};
	public function invoke() {

		invocationScore.push((pentagramScore[pentagramScore.length-1]*150.0 + 150-animalScore[animalScore.length-1]));
		if(game.getAzazel().getIncense() == chosenIncense 
		&& game.getAzazel().getAnimal() == chosenAnimal
		&& chosenPentagram == null) {

			deityInvoked = "azazel";
		} else if(game.getAbaddon().getIncense() == chosenIncense 
		&& game.getAbaddon().getAnimal() == chosenAnimal
		&& game.getAbaddon().getPentagram() == chosenPentagram) {
			deityInvoked = "abaddon";
		} else if(game.getBaphomet().getIncense() == chosenIncense 
		&& game.getBaphomet().getAnimal() == chosenAnimal
		&& game.getBaphomet().getPentagram() == chosenPentagram) {

			deityInvoked = "baphomet";
		} else if(game.getSatan().getIncense() == chosenIncense 
		&& game.getSatan().getAnimal() == chosenAnimal
		&& game.getSatan().getPentagram() == chosenPentagram
		&& checkAzazel && checkAbaddon && checkBaphomet) {

			deityInvoked = "satan";
		} else {
			var num = random.int(0,1);
			if(num == 0) {
				deityInvoked = "cthullu";
			} else {
				deityInvoked = "dog";
			}
		}
		invocationTime = INVOCATION_DURATION;
		invocation = true;
	}


	public function cageClick():Void {
		chosenAnimal = null;
		cageSubState = new SacrificeChoice((chosenIncense != null), burn);
		cageSubState.closeCallback = animalChosen;
		openSubState(this.cageSubState);
	}
	public function pentacleClick():Void {
		pentagramSubState = new Pentagram((chosenIncense != null), burn);
		pentagramSubState.closeCallback = pentacleDrawn;
		openSubState(this.pentagramSubState);
	}

	public function pentacleDrawn():Void {
		if(!pentagramSubState.isBack()) {
			chosenPentagram = pentagramSubState.getSelectedPentagram();
			pentagramScore.push(pentagramSubState.getScorePentagram());
			remove(glowPentagram);
			canvas = pentagramSubState.getCanvas().clone();
			canvas.setGraphicSize(Std.int(canvas.width/1.84),Std.int(canvas.height/1.84));
			canvas.x -= 25;
			canvas.y += 180;
			add(canvas);
		}
	}

	public function animalChosen() {
		if(!cageSubState.isBack()) {
			chosenAnimal = cageSubState.getChoosenAnimal();

			sacrificeSubState = new Sacrifice((chosenIncense != null), burn);
			sacrificeSubState.closeCallback = animalSacrificied;
			sacrificeSubState.setChosenAnimal(chosenAnimal);
			nextSubState = sacrificeSubState;
		} else {
			chosenAnimal = null;
		}

	}

	public function animalSacrificied() {
		if(!sacrificeSubState.isBack()) {
			deadAnimal = new FlxSprite(443, 453);

			remove(glowCage);
			animalScore.push(sacrificeSubState.getSacrificeScore());
			switch(chosenAnimal) {
				case "mouse":
					deadAnimal.loadGraphic(AssetPaths.mouse_dead__png);
				case "crow":
					deadAnimal.loadGraphic(AssetPaths.crow_dead__png);
				case "sheep":
					deadAnimal.loadGraphic(AssetPaths.sheep_dead__png);
			}
			add(deadAnimal);
		} else {
			chosenAnimal = null;
		}
		
	}
}
