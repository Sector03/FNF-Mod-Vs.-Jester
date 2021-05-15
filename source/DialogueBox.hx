package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	var portraitLeftjester:FlxSprite;
	var portraitLeftjesterstargaze:FlxSprite;
	var portraitRightbfgetreal:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'rehearsal' | 'rehearsal-duo':
				FlxG.sound.playMusic(Paths.music('presongrehearsal'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'jester' | 'jester-duo':
				FlxG.sound.playMusic(Paths.music('presongjester'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'bell-buster' | 'bell-buster-duo':
				FlxG.sound.playMusic(Paths.music('presongbellbuster'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}


		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
		
		portraitLeftjester = new FlxSprite(-20, 40);
		portraitLeftjester.frames = Paths.getSparrowAtlas('cutscene/jester');
		portraitLeftjester.animation.addByPrefix('enter', 'PORTRAIT', 24, false);
		portraitLeftjester.updateHitbox();
		portraitLeftjester.scrollFactor.set();
		add(portraitLeftjester);
		portraitLeftjester.visible = false;

		portraitLeftjesterstargaze = new FlxSprite(-20, 40);
		portraitLeftjesterstargaze.frames = Paths.getSparrowAtlas('cutscene/jesterstargaze');
		portraitLeftjesterstargaze.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeftjesterstargaze.updateHitbox();
		portraitLeftjesterstargaze.scrollFactor.set();
		add(portraitLeftjesterstargaze);
		portraitLeftjesterstargaze.visible = false;

		portraitRightbfgetreal = new FlxSprite(0, 25);
		portraitRightbfgetreal.frames = Paths.getSparrowAtlas('cutscene/portraitboyfriend');
		portraitRightbfgetreal.animation.addByPrefix('enter', 'bfPORTRAIT', 24, false);
		portraitRightbfgetreal.updateHitbox();
		portraitRightbfgetreal.scrollFactor.set();
		add(portraitRightbfgetreal);
		portraitRightbfgetreal.visible = false;


		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
				
				box.animation.play('normalOpen');
				box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
				box.updateHitbox();
				add(box);

				handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
				add(handSelect);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);


				box.animation.play('normalOpen');
				box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
				box.updateHitbox();
				add(box);

				handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
				add(handSelect);
			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

				box.animation.play('normalOpen');
				box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
				box.updateHitbox();
				add(box);

				handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
				add(handSelect);
			case 'rehearsal':
				hasDialog = true;
				box = new FlxSprite(25, 375);
				box.frames = Paths.getSparrowAtlas('cutscene/speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByPrefix('normal', 'speech bubble normal', 24, true);

				add(box);
				box.animation.play('normalOpen');
			case 'jester':
				hasDialog = true;
				box = new FlxSprite(25, 375);
				box.frames = Paths.getSparrowAtlas('cutscene/speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByPrefix('normal', 'speech bubble normal', 24, true);

				add(box);
				box.animation.play('normalOpen');
			case 'bell-buster':
				hasDialog = true;
				box = new FlxSprite(25, 375);
				box.frames = Paths.getSparrowAtlas('cutscene/speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByPrefix('normal', 'speech bubble normal', 24, true);

				add(box);
				box.animation.play('normalOpen');
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;

		if (!talkingRight)
		{
			// box.flipX = true;
		}

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
			dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
			dropText.font = 'Pixel Arial 11 Bold';
			dropText.color = 0xFFD89494;
			add(dropText);

			swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
			swagDialogue.font = 'Pixel Arial 11 Bold';
			swagDialogue.color = 0xFF3F2021;
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
			add(swagDialogue);

			case 'roses':
			dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
			dropText.font = 'Pixel Arial 11 Bold';
			dropText.color = 0xFFD89494;
			add(dropText);

			swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
			swagDialogue.font = 'Pixel Arial 11 Bold';
			swagDialogue.color = 0xFF3F2021;
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
			add(swagDialogue);

			case 'thorns':
			dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
			dropText.font = 'Pixel Arial 11 Bold';
			dropText.color = 0xFFD89494;
			add(dropText);

			swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
			swagDialogue.font = 'Pixel Arial 11 Bold';
			swagDialogue.color = 0xFF3F2021;
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
			add(swagDialogue);

			case 'rehearsal':
			dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
			dropText.font = 'VCR OSD Mono';
			dropText.size = 42;
			dropText.color = 0xFFEC51ED;
			add(dropText);

			swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
			swagDialogue.font = 'VCR OSD Mono';
			swagDialogue.size = 42;
			swagDialogue.color = 0xFF451C58;
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('JESTERSPEAK'), 0.6)];
			add(swagDialogue);
			
			case 'jester':
			dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
			dropText.font = 'VCR OSD Mono';
			dropText.size = 42;
			dropText.color = 0xFFEC51ED;
			add(dropText);

			swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
			swagDialogue.font = 'VCR OSD Mono';
			swagDialogue.size = 42;
			swagDialogue.color = 0xFF451C58;
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('JESTERSPEAK'), 0.6)];
			add(swagDialogue);

			case 'bell-buster':
			dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
			dropText.font = 'VCR OSD Mono';
			dropText.size = 42;
			dropText.color = 0xFFEC51ED;
			add(dropText);

			swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
			swagDialogue.font = 'VCR OSD Mono';
			swagDialogue.size = 42;
			swagDialogue.color = 0xFF451C58;
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('JESTERSPEAK'), 0.6)];
			add(swagDialogue);
		}


		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					if (PlayState.SONG.song.toLowerCase() == 'rehearsal' || PlayState.SONG.song.toLowerCase() == 'jester')
						FlxG.sound.music.fadeOut(2.2, 0);

					if (PlayState.SONG.song.toLowerCase() == 'bell-buster')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						portraitLeftjester.visible = false;
						portraitLeftjesterstargaze.visible = false;
						portraitRightbfgetreal.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				portraitLeftjester.visible =false;
				portraitLeftjesterstargaze.visible =false;
				portraitRightbfgetreal.visible =false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf':
				portraitLeft.visible = false;
				portraitLeftjester.visible =false;
				portraitLeftjesterstargaze.visible =false;
				portraitRightbfgetreal.visible =false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'bfgetreal':
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('BOYFRIENDSPEAK'), 0.6)];
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitLeftjester.visible =false;
				portraitLeftjesterstargaze.visible =false;
				if (!portraitRightbfgetreal.visible)
				{
					portraitRightbfgetreal.visible = true;
					portraitRightbfgetreal.animation.play('enter');
				}
			case 'jester':
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('JESTERSPEAK'), 0.6)];
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitLeftjesterstargaze.visible =false;
				portraitRightbfgetreal.visible =false;
				if (!portraitLeftjester.visible)
				{
					portraitLeftjester.visible = true;
					portraitLeftjester.animation.play('enter');
				}
			case 'jesterstargaze':
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('JESTERSPEAK'), 0.6)];
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitLeftjester.visible =false;
				portraitRightbfgetreal.visible =false;
				if (!portraitLeftjester.visible)
				{
					portraitLeftjesterstargaze.visible = true;
					portraitLeftjesterstargaze.animation.play('enter');
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}