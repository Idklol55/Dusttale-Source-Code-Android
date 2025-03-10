package android;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxSpriteGroup;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.ui.FlxButton;
import flixel.FlxSprite;

class FlxHitbox extends FlxSpriteGroup
{
	public var hitbox:FlxSpriteGroup;

	public var buttonLeft:FlxButton;
	public var buttonDown:FlxButton;
	public var buttonUp:FlxButton;
	public var buttonRight:FlxButton;
	public var buttonSpace:FlxButton;

	public var orgType:HitboxType = NORMAL;
	public var orgAlpha:Float = 0.75;
	public var orgAntialiasing:Bool = true;
	
	public function new(type:HitboxType = NORMAL, ?alphaAlt:Float = 0.75, ?antialiasingAlt:Bool = true)
	{
		super();

		orgType = type;
		orgAlpha = alphaAlt;
		orgAntialiasing = antialiasingAlt;

		buttonLeft = new FlxButton(0, 0);
		buttonDown = new FlxButton(0, 0);
		buttonUp = new FlxButton(0, 0);
		buttonRight = new FlxButton(0, 0);
		buttonSpace = new FlxButton(0, 0);

		hitbox = new FlxSpriteGroup();

		var hitbox_hint:FlxSprite = new FlxSprite(0, 0);

		switch (orgType){
			case NORMAL:
				hitbox_hint.loadGraphic(Paths.image('androidcontrols/hitbox/normal_hint'));

				hitbox.add(add(buttonLeft = createhitbox(0, 0, "left")));
				hitbox.add(add(buttonDown = createhitbox(320, 0, "down")));
				hitbox.add(add(buttonUp = createhitbox(640, 0, "up")));
				hitbox.add(add(buttonRight = createhitbox(960, 0, "right")));
			case FIVE:
				hitbox_hint.loadGraphic(Paths.image('androidcontrols/hitbox/five_hint'));

				hitbox.add(add(buttonLeft = createhitbox(0, 0, "left"))); 
				hitbox.add(add(buttonDown = createhitbox(320, 0, "down")));
				hitbox.add(add(buttonUp = createhitbox(640, 0, "up")));    
				hitbox.add(add(buttonRight = createhitbox(960, 0, "right")));
				hitbox.add(add(buttonSpace = createhitbox(0, 480, "space"))); 
			case FIVE_UP:
				hitbox_hint.loadGraphic(Paths.image('androidcontrols/hitbox/five-up_hint'));

				hitbox.add(add(buttonLeft = createhitbox(0, 240, "left")));
				hitbox.add(add(buttonDown = createhitbox(320, 240, "down")));
				hitbox.add(add(buttonUp = createhitbox(640, 240, "up")));
				hitbox.add(add(buttonRight = createhitbox(960, 240, "right")));
				hitbox.add(add(buttonSpace = createhitbox(0, 0, "space")));
		}

		hitbox_hint.antialiasing = orgAntialiasing;
		hitbox_hint.alpha = orgAlpha;
		add(hitbox_hint);
	}

	public function createhitbox(x:Float = 0, y:Float = 0, frames:String) 
	{
		var button = new FlxButton(x, y);
		button.loadGraphic(FlxGraphic.fromFrame(getFrames().getByName(frames)));
		button.antialiasing = orgAntialiasing;
		button.alpha = 0;// sorry but I can't hard lock the hitbox alpha
		button.onDown.callback = function (){FlxTween.num(0, 0.75, 0.075, {ease:FlxEase.circInOut}, function(alpha:Float){ button.alpha = alpha;});};
		button.onUp.callback = function (){FlxTween.num(0.75, 0, 0.1, {ease:FlxEase.circInOut}, function(alpha:Float){ button.alpha = alpha;});}
		button.onOut.callback = function (){FlxTween.num(button.alpha, 0, 0.2, {ease:FlxEase.circInOut}, function(alpha:Float){ button.alpha = alpha;});}
		return button;
	}

	public function getFrames():FlxAtlasFrames
	{
		return switch (orgType){
			case NORMAL:
				Paths.getSparrowAtlas('androidcontrols/hitbox/normal');
			case FIVE:
				Paths.getSparrowAtlas('androidcontrols/hitbox/five');
			case FIVE_UP:
				Paths.getSparrowAtlas('androidcontrols/hitbox/five-up');
		}
	}

	override public function destroy():Void
	{
		super.destroy();

		buttonLeft = null;
		buttonDown = null;
		buttonUp = null;
		buttonRight = null;
		buttonSpace = null;
	}
}

enum HitboxType {
	NORMAL;
	FIVE;
	FIVE_UP;
}
