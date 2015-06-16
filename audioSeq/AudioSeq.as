package 
{

	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.events.MouseEvent;
	import flash.media.SoundChannel;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.media.SoundTransform;
	import fl.events.SliderEvent;
	import fl.controls.TextInput;
	import flash.media.SoundMixer;
	import flash.media.Microphone;
	import flash.utils.ByteArray;
	import flash.events.SampleDataEvent;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.net.navigateToURL;



	public class AudioSeq extends MovieClip
	{

		//embed sounds needed

		[Embed(source = "sounds/drum1.mp3")]
		public var soundClass1:Class;
		public var drumSound:Sound = new soundClass1() as Sound;


		[Embed(source = "sounds/hat1.mp3")]
		public var soundClass3:Class;
		public var hatSound:Sound = new soundClass3() as Sound;

		[Embed(source = "sounds/clap1.mp3")]
		public var soundClass2:Class;
		public var clapSound:Sound = new soundClass2() as Sound;


		[Embed(source = "sounds/snare1.mp3")]
		public var soundClass4:Class;
		public var snareSound:Sound = new soundClass4() as Sound;

		[Embed(source = "sounds/scratch1.mp3")]
		public var soundClass5:Class;
		public var scratchSound1:Sound = new soundClass5() as Sound;

		[Embed(source = "sounds/scratch2.mp3")]
		public var soundClass6:Class;
		public var scratchSound2:Sound = new soundClass6() as Sound;

		[Embed(source = "sounds/trance.mp3")]
		public var soundClass7:Class;
		public var tranceSound:Sound = new soundClass7() as Sound;

		[Embed(source = "sounds/melody.mp3")]
		public var soundClass8:Class;
		public var melodySound:Sound = new soundClass8() as Sound;

		//create array to hold sounds needed
		public var soundArray1:Array = new Array();
		public var soundArray2:Array = new Array();
		public var soundArray3:Array = new Array();
		public var soundArray4:Array = new Array();
		public var soundArray5:Array = new Array();
		public var soundArray6:Array = new Array();
		public var soundArray7:Array = new Array();
		public var soundArray8:Array = new Array();
		public var soundArray9:Array = new Array();
		public var soundArray10:Array = new Array();
		public var soundArray11:Array = new Array();
		public var soundArray12:Array = new Array();
		public var soundArray13:Array = new Array();
		public var soundArray14:Array = new Array();
		public var soundArray15:Array = new Array();
		public var soundArray16:Array = new Array();

		// creating a global soundchannel object so I can access it in functions and add 
		// a volume control at a later stage
		public var soundCh:SoundChannel;
		public var melodyCh:SoundChannel;
		//variable for checking soundchannel position
		//public var trackTime:Number = 0;


		// two objects for connecting the volume slider to the global volume 
		public var trans:SoundTransform = new SoundTransform ();
		public var soundMixer:SoundMixer;

		//create a variable to increment when the timer goes off to enable 
		//me to target each array with every timer event
		public var timerCount:int = 1;
		//main timer for tracking play through the arrays
		//set to go off 16 times at 400ms, this is timed to suit the melody I created
		public var timer:Timer = new Timer(400,16);

		public var countBoo:Boolean;
		
		
		// variables for the mic recording
		public var mic:Microphone;
		public var soundBytes:ByteArray;
		public var sound:Sound;
		public var channel:SoundChannel;
		public var recChannel:SoundChannel;
		public var recTrack:Sound;
		
		//variables for xml
		
		//variables to hold an instance of the clas xml
		public var myXML:XML;
		
		//create an instance of the urlloaderclass to load my xml file
		public var myLoader:URLLoader = new URLLoader();
		
		//created globally so there's always a reference to it
		public var xmlImage:Loader = new Loader();
		
		//variable for holding the value of the melody switch button
		public var switchBoo:Boolean;
		
		public function AudioSeq()
		{
			// constructor code
			
			//eventListener on the container of all the sequencer buttons
			container.addEventListener(MouseEvent.CLICK, loadSound);

			// eventlisteners for the main control buttons
			playBtn.addEventListener(MouseEvent.CLICK, starTimer);
			pauseBtn.addEventListener(MouseEvent.CLICK, pauseHandler);
			stopBtn.addEventListener(MouseEvent.CLICK, stopHandler);
			loopOffBtn.addEventListener(MouseEvent.CLICK, loopOffHandler);
			loopOnBtn.addEventListener(MouseEvent.CLICK, loopOnHandler);
			recBtn.addEventListener(MouseEvent.CLICK, recordHandler);
			recordOn.addEventListener(MouseEvent.CLICK, recOnHandler);
			myVol.addEventListener(SliderEvent.THUMB_DRAG, volumeChange);
			samContainer.addEventListener(MouseEvent.CLICK, sampleConHandler);

			// listens for the timerHandler function every time the timer goes off;
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			
			
			//make playhead invisible on initial run
			playhead.visible = false;
			// hide Btns at runtime, made visible when Btns overlapping are clicked pressed
			loopOnBtn.visible = false;
			recordOn.visible = false;
			
			//control the melody onOff switch
			onOff.addEventListener(MouseEvent.CLICK, onOffHandler);
			//control the scale of the reset button when pressed
			reset.addEventListener(MouseEvent.MOUSE_DOWN, resetDownHandler);
			reset.addEventListener(MouseEvent.MOUSE_UP, resetUpHandler);
			
			//load xml file into the loader variable and when it's complete call processXML 
			//function, this loads in my logo containing a HTML link to my site
			myLoader.load(new URLRequest("image.xml"));
			myLoader.addEventListener(Event.COMPLETE, processXML);
			//trace(myLoader);
			
		}
		//this function gets called when there's a mouseclick on the main buttons of the step 
		//sequencer, except the play, pause and rec etc.
		//when the button is clicked it changes the alpha and then depending on the alpha of the btn
		//either inserts or removes a sound from a certain array. This method is repeated for
		//all the tep seq btns.
		//I'm aware that this is a large duplication of code and I did research the split string method
		//but couldn't manage to get it going.
		function loadSound(event:MouseEvent):void
		{			//row1
			if (event.target.name == "drum_1")
			{

				if (container.drum_1.alpha == 1)
				{
					container.drum_1.alpha = 0;
					soundArray1.push(drumSound);
					//myStr = event.target.name;
				}
				else if (container.drum_1.alpha == 0)
				{
					container.drum_1.alpha = 1;
			// The plan was to loop through the array for the hatsound and remove it if the alpha
			// is 0, but I found this shorthand code to do the same on stackoverflow.		
					soundArray1.splice(soundArray1.indexOf(drumSound), 1);
				}
			}
			if (event.target.name == "hat_1")
			{

				if (container.hat_1.alpha == 1)
				{
					container.hat_1.alpha = 0;
					soundArray1.push(hatSound);
				}
				else if (container.hat_1.alpha == 0)
				{
					container.hat_1.alpha = 1;
			
					soundArray1.splice(soundArray1.indexOf(hatSound), 1);
				}
			}

			if (event.target.name == "snare_1")
			{

				if (container.snare_1.alpha == 1)
				{
					container.snare_1.alpha = 0;
					soundArray1.push(snareSound);
				}
				else if (container.snare_1.alpha == 0)
				{
					container.snare_1.alpha = 1;
					soundArray1.splice(soundArray1.indexOf(snareSound), 1);
				}
			}

			if (event.target.name == "clap_1")
			{

				if (container.clap_1.alpha == 1)
				{
					container.clap_1.alpha = 0;
					soundArray1.push(clapSound);
				}
				else if (container.clap_1.alpha == 0)
				{
					container.clap_1.alpha = 1;
					soundArray1.splice(soundArray1.indexOf(clapSound), 1);
				}
			}

			if (event.target.name == "scratch_1")
			{

				if (container.scratch_1.alpha == 1)
				{
					container.scratch_1.alpha = 0;
					soundArray1.push(scratchSound1);
				}
				else if (container.scratch_1.alpha == 0)
				{
					container.scratch_1.alpha = 1;
					soundArray1.splice(soundArray1.indexOf(scratchSound1), 1);
				}
			}

			if (event.target.name == "bass_1")
			{

				if (container.bass_1.alpha == 1)
				{
					container.bass_1.alpha = 0;
					soundArray1.push(tranceSound);
				}
				else if (container.bass_1.alpha == 0)
				{
					container.bass_1.alpha = 1;
					soundArray1.splice(soundArray1.indexOf(tranceSound), 1);
				}
			}

			//row 2


			if (event.target.name == "drum_2")
			{

				if (container.drum_2.alpha == 1)
				{
					container.drum_2.alpha = 0;
					soundArray2.push(drumSound);
				}
				else if (container.drum_2.alpha == 0)
				{
					container.drum_2.alpha = 1;
					soundArray2.splice(soundArray2.indexOf(drumSound), 1);
				}
			}


			if (event.target.name == "hat_2")
			{

				if (container.hat_2.alpha == 1)
				{
					container.hat_2.alpha = 0;
					soundArray2.push(hatSound);
				}
				else if (container.hat_2.alpha == 0)
				{
					container.hat_2.alpha = 1;
					soundArray2.splice(soundArray1.indexOf(hatSound), 1);
				}
			}

			if (event.target.name == "snare_2")
			{

				if (container.snare_2.alpha == 1)
				{
					container.snare_2.alpha = 0;
					soundArray2.push(snareSound);
				}
				else if (container.snare_2.alpha == 0)
				{
					container.snare_2.alpha = 1;
					soundArray2.splice(soundArray2.indexOf(snareSound), 1);
				}
			}



			if (event.target.name == "clap_2")
			{

				if (container.clap_2.alpha == 1)
				{
					container.clap_2.alpha = 0;
					soundArray2.push(clapSound);
				}
				else if (container.clap_2.alpha == 0)
				{
					container.clap_2.alpha = 1;
					soundArray2.splice(soundArray2.indexOf(clapSound), 1);
				}
			}

			if (event.target.name == "scratch_2")
			{

				if (container.scratch_2.alpha == 1)
				{
					container.scratch_2.alpha = 0;
					soundArray2.push(scratchSound1);
				}
				else if (container.scratch_2.alpha == 0)
				{
					container.scratch_2.alpha = 1;
					soundArray2.splice(soundArray2.indexOf(scratchSound1), 1);
				}
			}


			if (event.target.name == "bass_2")
			{

				if (container.bass_2.alpha == 1)
				{
					container.bass_2.alpha = 0;
					soundArray2.push(tranceSound);
				}
				else if (container.bass_2.alpha == 0)
				{
					container.bass_2.alpha = 1;
					soundArray2.splice(soundArray2.indexOf(tranceSound), 1);
				}
			}

			//row 3


			if (event.target.name == "drum_3")
			{

				if (container.drum_3.alpha == 1)
				{
					container.drum_3.alpha = 0;
					soundArray3.push(drumSound);
				}
				else if (container.drum_3.alpha == 0)
				{
					container.drum_3.alpha = 1;
					soundArray3.splice(soundArray3.indexOf(drumSound), 1);
				}
			}


			if (event.target.name == "hat_3")
			{

				if (container.hat_3.alpha == 1)
				{
					container.hat_3.alpha = 0;
					soundArray3.push(hatSound);
				}
				else if (container.hat_3.alpha == 0)
				{
					container.hat_3.alpha = 1;
					soundArray3.splice(soundArray3.indexOf(hatSound), 1);
				}
			}

			if (event.target.name == "snare_3")
			{

				if (container.snare_3.alpha == 1)
				{
					container.snare_3.alpha = 0;
					soundArray3.push(snareSound);
				}
				else if (container.snare_3.alpha == 0)
				{
					container.snare_3.alpha = 1;
					soundArray3.splice(soundArray3.indexOf(snareSound), 1);
				}
			}



			if (event.target.name == "clap_3")
			{

				if (container.clap_3.alpha == 1)
				{
					container.clap_3.alpha = 0;
					soundArray3.push(clapSound);
				}
				else if (container.clap_3.alpha == 0)
				{
					container.clap_3.alpha = 1;
					soundArray3.splice(soundArray3.indexOf(clapSound), 1);
				}
			}

			if (event.target.name == "scratch_3")
			{

				if (container.scratch_3.alpha == 1)
				{
					container.scratch_3.alpha = 0;
					soundArray3.push(scratchSound1);
				}
				else if (container.scratch_3.alpha == 0)
				{
					container.scratch_3.alpha = 1;
					soundArray3.splice(soundArray3.indexOf(scratchSound1), 1);
				}
			}


			if (event.target.name == "bass_3")
			{

				if (container.bass_3.alpha == 1)
				{
					container.bass_3.alpha = 0;
					soundArray3.push(tranceSound);
				}
				else if (container.bass_3.alpha == 0)
				{
					container.bass_3.alpha = 1;
					soundArray3.splice(soundArray3.indexOf(tranceSound), 1);
				}
			}

			// row 4  ///////////////////////////////////////////////////////////////////
			/////////////////////////////////////////////////////////////////////////////
			/////////////////////////////////////////////////////////////////////////////

			if (event.target.name == "drum_4")
			{

				if (container.drum_4.alpha == 1)
				{
					container.drum_4.alpha = 0;
					soundArray4.push(drumSound);
				}
				else if (container.drum_4.alpha == 0)
				{
					container.drum_4.alpha = 1;
					soundArray4.splice(soundArray4.indexOf(drumSound), 1);
				}
			}


			if (event.target.name == "hat_4")
			{

				if (container.hat_4.alpha == 1)
				{
					container.hat_4.alpha = 0;
					soundArray4.push(hatSound);
				}
				else if (container.hat_4.alpha == 0)
				{
					container.hat_4.alpha = 1;
					soundArray4.splice(soundArray4.indexOf(hatSound), 1);
				}
			}

			if (event.target.name == "snare_4")
			{

				if (container.snare_4.alpha == 1)
				{
					container.snare_4.alpha = 0;
					soundArray4.push(snareSound);
				}
				else if (container.snare_4.alpha == 0)
				{
					container.snare_4.alpha = 1;
					soundArray4.splice(soundArray4.indexOf(snareSound), 1);
				}
			}



			if (event.target.name == "clap_4")
			{

				if (container.clap_4.alpha == 1)
				{
					container.clap_4.alpha = 0;
					soundArray4.push(clapSound);
				}
				else if (container.clap_4.alpha == 0)
				{
					container.clap_4.alpha = 1;
					soundArray4.splice(soundArray4.indexOf(clapSound), 1);
				}
			}

			if (event.target.name == "scratch_4")
			{

				if (container.scratch_4.alpha == 1)
				{
					container.scratch_4.alpha = 0;
					soundArray4.push(scratchSound1);
				}
				else if (container.scratch_4.alpha == 0)
				{
					container.scratch_4.alpha = 1;
					soundArray4.splice(soundArray4.indexOf(scratchSound1), 1);
				}
			}


			if (event.target.name == "bass_4")
			{

				if (container.bass_4.alpha == 1)
				{
					container.bass_4.alpha = 0;
					soundArray4.push(tranceSound);
				}
				else if (container.bass_4.alpha == 0)
				{
					container.bass_4.alpha = 1;
					soundArray4.splice(soundArray4.indexOf(tranceSound), 1);
				}
			}

			//row 5

			if (event.target.name == "drum_5")
			{

				if (container.drum_5.alpha == 1)
				{
					container.drum_5.alpha = 0;
					soundArray5.push(drumSound);
				}
				else if (container.drum_5.alpha == 0)
				{
					container.drum_5.alpha = 1;
					soundArray5.splice(soundArray5.indexOf(drumSound), 1);
				}
			}


			if (event.target.name == "hat_5")
			{

				if (container.hat_5.alpha == 1)
				{
					container.hat_5.alpha = 0;
					soundArray5.push(hatSound);
				}
				else if (container.hat_5.alpha == 0)
				{
					container.hat_5.alpha = 1;
					soundArray5.splice(soundArray5.indexOf(hatSound), 1);
				}
			}

			if (event.target.name == "snare_5")
			{

				if (container.snare_5.alpha == 1)
				{
					container.snare_5.alpha = 0;
					soundArray5.push(snareSound);
				}
				else if (container.snare_5.alpha == 0)
				{
					container.snare_5.alpha = 1;
					soundArray5.splice(soundArray5.indexOf(snareSound), 1);
				}
			}



			if (event.target.name == "clap_5")
			{

				if (container.clap_5.alpha == 1)
				{
					container.clap_5.alpha = 0;
					soundArray5.push(clapSound);
				}
				else if (container.clap_5.alpha == 0)
				{
					container.clap_5.alpha = 1;
					soundArray5.splice(soundArray5.indexOf(clapSound), 1);
				}
			}

			if (event.target.name == "scratch_5")
			{

				if (container.scratch_5.alpha == 1)
				{
					container.scratch_5.alpha = 0;
					soundArray5.push(scratchSound1);
				}
				else if (container.scratch_5.alpha == 0)
				{
					container.scratch_5.alpha = 1;
					soundArray5.splice(soundArray5.indexOf(scratchSound1), 1);
				}
			}


			if (event.target.name == "bass_5")
			{

				if (container.bass_5.alpha == 1)
				{
					container.bass_5.alpha = 0;
					soundArray5.push(tranceSound);
				}
				else if (container.bass_5.alpha == 0)
				{
					container.bass_5.alpha = 1;
					soundArray5.splice(soundArray5.indexOf(tranceSound), 1);
				}
			}

			//row 6 
			if (event.target.name == "drum_6")
			{

				if (container.drum_6.alpha == 1)
				{
					container.drum_6.alpha = 0;
					soundArray6.push(drumSound);
				}
				else if (container.drum_6.alpha == 0)
				{
					container.drum_6.alpha = 1;
					soundArray6.splice(soundArray6.indexOf(drumSound), 1);
				}
			}


			if (event.target.name == "hat_6")
			{

				if (container.hat_6.alpha == 1)
				{
					container.hat_6.alpha = 0;
					soundArray6.push(hatSound);
				}
				else if (container.hat_6.alpha == 0)
				{
					container.hat_6.alpha = 1;
					soundArray6.splice(soundArray6.indexOf(hatSound), 1);
				}
			}

			if (event.target.name == "snare_6")
			{

				if (container.snare_6.alpha == 1)
				{
					container.snare_6.alpha = 0;
					soundArray6.push(snareSound);
				}
				else if (container.snare_6.alpha == 0)
				{
					container.snare_6.alpha = 1;
					soundArray6.splice(soundArray6.indexOf(snareSound), 1);
				}
			}



			if (event.target.name == "clap_6")
			{

				if (container.clap_6.alpha == 1)
				{
					container.clap_6.alpha = 0;
					soundArray6.push(clapSound);
				}
				else if (container.clap_6.alpha == 0)
				{
					container.clap_6.alpha = 1;
					soundArray6.splice(soundArray6.indexOf(clapSound), 1);
				}
			}

			if (event.target.name == "scratch_6")
			{

				if (container.scratch_6.alpha == 1)
				{
					container.scratch_6.alpha = 0;
					soundArray6.push(scratchSound1);
				}
				else if (container.scratch_6.alpha == 0)
				{
					container.scratch_6.alpha = 1;
					soundArray6.splice(soundArray6.indexOf(scratchSound1), 1);
				}
			}

			if (event.target.name == "bass_6")
			{

				if (container.bass_6.alpha == 1)
				{
					container.bass_6.alpha = 0;
					soundArray6.push(tranceSound);
				}
				else if (container.bass_6.alpha == 0)
				{
					container.bass_6.alpha = 1;
					soundArray6.splice(soundArray6.indexOf(tranceSound), 1);
				}
			}

			//row 7

			if (event.target.name == "drum_7")
			{

				if (container.drum_7.alpha == 1)
				{
					container.drum_7.alpha = 0;
					soundArray7.push(drumSound);
				}
				else if (container.drum_7.alpha == 0)
				{
					container.drum_7.alpha = 1;
					soundArray7.splice(soundArray7.indexOf(drumSound), 1);
				}
			}


			if (event.target.name == "hat_7")
			{

				if (container.hat_7.alpha == 1)
				{
					container.hat_7.alpha = 0;
					soundArray7.push(hatSound);
				}
				else if (container.hat_7.alpha == 0)
				{
					container.hat_7.alpha = 1;
					soundArray7.splice(soundArray7.indexOf(hatSound), 1);
				}
			}

			if (event.target.name == "snare_7")
			{

				if (container.snare_7.alpha == 1)
				{
					container.snare_7.alpha = 0;
					soundArray7.push(snareSound);
				}
				else if (container.snare_7.alpha == 0)
				{
					container.snare_7.alpha = 1;
					soundArray7.splice(soundArray7.indexOf(snareSound), 1);
				}
			}



			if (event.target.name == "clap_7")
			{

				if (container.clap_7.alpha == 1)
				{
					container.clap_7.alpha = 0;
					soundArray7.push(clapSound);
				}
				else if (container.clap_7.alpha == 0)
				{
					container.clap_7.alpha = 1;
					soundArray7.splice(soundArray7.indexOf(clapSound), 1);
				}
			}

			if (event.target.name == "scratch_7")
			{

				if (container.scratch_7.alpha == 1)
				{
					container.scratch_7.alpha = 0;
					soundArray7.push(scratchSound1);
				}
				else if (container.scratch_7.alpha == 0)
				{
					container.scratch_7.alpha = 1;
					soundArray7.splice(soundArray7.indexOf(scratchSound1), 1);
				}
			}



			if (event.target.name == "bass_7")
			{

				if (container.bass_7.alpha == 1)
				{
					container.bass_7.alpha = 0;
					soundArray7.push(tranceSound);
				}
				else if (container.bass_7.alpha == 0)
				{
					container.bass_7.alpha = 1;
					soundArray7.splice(soundArray7.indexOf(tranceSound), 1);
				}
			}

			//row 8

			if (event.target.name == "drum_8")
			{

				if (container.drum_8.alpha == 1)
				{
					container.drum_8.alpha = 0;
					soundArray8.push(drumSound);
				}
				else if (container.drum_8.alpha == 0)
				{
					container.drum_8.alpha = 1;
					soundArray8.splice(soundArray8.indexOf(drumSound), 1);
				}
			}


			if (event.target.name == "hat_8")
			{

				if (container.hat_8.alpha == 1)
				{
					container.hat_8.alpha = 0;
					soundArray8.push(hatSound);
				}
				else if (container.hat_8.alpha == 0)
				{
					container.hat_8.alpha = 1;
					soundArray8.splice(soundArray8.indexOf(hatSound), 1);
				}
			}

			if (event.target.name == "snare_8")
			{

				if (container.snare_8.alpha == 1)
				{
					container.snare_8.alpha = 0;
					soundArray8.push(snareSound);
				}
				else if (container.snare_8.alpha == 0)
				{
					container.snare_8.alpha = 1;
					soundArray8.splice(soundArray8.indexOf(snareSound), 1);
				}
			}



			if (event.target.name == "clap_8")
			{

				if (container.clap_8.alpha == 1)
				{
					container.clap_8.alpha = 0;
					soundArray8.push(clapSound);
				}
				else if (container.clap_8.alpha == 0)
				{
					container.clap_8.alpha = 1;
					soundArray8.splice(soundArray8.indexOf(clapSound), 1);
				}
			}

			if (event.target.name == "scratch_8")
			{

				if (container.scratch_8.alpha == 1)
				{
					container.scratch_8.alpha = 0;
					soundArray8.push(scratchSound1);
				}
				else if (container.scratch_8.alpha == 0)
				{
					container.scratch_8.alpha = 1;
					soundArray8.splice(soundArray8.indexOf(scratchSound1), 1);
				}
			}


			if (event.target.name == "bass_8")
			{

				if (container.bass_8.alpha == 1)
				{
					container.bass_8.alpha = 0;
					soundArray8.push(tranceSound);
				}
				else if (container.bass_8.alpha == 0)
				{
					container.bass_8.alpha = 1;
					soundArray8.splice(soundArray8.indexOf(tranceSound), 1);
				}
			}

			//row 9

			if (event.target.name == "drum_9")
			{

				if (container.drum_9.alpha == 1)
				{
					container.drum_9.alpha = 0;
					soundArray9.push(drumSound);
				}
				else if (container.drum_9.alpha == 0)
				{
					container.drum_9.alpha = 1;
					soundArray9.splice(soundArray9.indexOf(drumSound), 1);
				}
			}


			if (event.target.name == "hat_9")
			{

				if (container.hat_9.alpha == 1)
				{
					container.hat_9.alpha = 0;
					soundArray9.push(hatSound);
				}
				else if (container.hat_9.alpha == 0)
				{
					container.hat_9.alpha = 1;
					soundArray9.splice(soundArray9.indexOf(hatSound), 1);
				}
			}

			if (event.target.name == "snare_9")
			{

				if (container.snare_9.alpha == 1)
				{
					container.snare_9.alpha = 0;
					soundArray9.push(snareSound);
				}
				else if (container.snare_9.alpha == 0)
				{
					container.snare_9.alpha = 1;
					soundArray9.splice(soundArray9.indexOf(snareSound), 1);
				}
			}



			if (event.target.name == "clap_9")
			{

				if (container.clap_9.alpha == 1)
				{
					container.clap_9.alpha = 0;
					soundArray9.push(clapSound);
				}
				else if (container.clap_9.alpha == 0)
				{
					container.clap_9.alpha = 1;
					soundArray9.splice(soundArray9.indexOf(clapSound), 1);
				}
			}

			if (event.target.name == "scratch_9")
			{

				if (container.scratch_9.alpha == 1)
				{
					container.scratch_9.alpha = 0;
					soundArray9.push(scratchSound1);
				}
				else if (container.scratch_9.alpha == 0)
				{
					container.scratch_9.alpha = 1;
					soundArray9.splice(soundArray9.indexOf(scratchSound1), 1);
				}
			}


			if (event.target.name == "bass_9")
			{

				if (container.bass_9.alpha == 1)
				{
					container.bass_9.alpha = 0;
					soundArray9.push(tranceSound);
				}
				else if (container.bass_9.alpha == 0)
				{
					container.bass_9.alpha = 1;
					soundArray9.splice(soundArray9.indexOf(tranceSound), 1);
				}
			}

			//row10
			if (event.target.name == "drum_10")
			{

				if (container.drum_10.alpha == 1)
				{
					container.drum_10.alpha = 0;
					soundArray10.push(drumSound);
					/*myStr = event.target.name;
					trace(myStr);*/
					trace("drum_10 pressed");
				}
				else if (container.drum_10.alpha == 0)
				{
					container.drum_10.alpha = 1;
					soundArray10.splice(soundArray10.indexOf(drumSound), 1);
				}
			}

			if (event.target.name == "hat_10")
			{

				if (container.hat_10.alpha == 1)
				{
					container.hat_10.alpha = 0;
					soundArray10.push(hatSound);
				}
				else if (container.hat_10.alpha == 0)
				{
					container.hat_10.alpha = 1;
					soundArray10.splice(soundArray10.indexOf(hatSound), 1);
				}
			}

			if (event.target.name == "snare_10")
			{

				if (container.snare_10.alpha == 1)
				{
					container.snare_10.alpha = 0;
					soundArray10.push(snareSound);
				}
				else if (container.snare_10.alpha == 0)
				{
					container.snare_10.alpha = 1;
					soundArray10.splice(soundArray10.indexOf(snareSound), 1);
				}
			}

			if (event.target.name == "clap_10")
			{

				if (container.clap_10.alpha == 1)
				{
					container.clap_10.alpha = 0;
					soundArray10.push(clapSound);
				}
				else if (container.clap_10.alpha == 0)
				{
					container.clap_10.alpha = 1;
					soundArray10.splice(soundArray10.indexOf(clapSound), 1);
				}
			}

			if (event.target.name == "scratch_10")
			{

				if (container.scratch_10.alpha == 1)
				{
					container.scratch_10.alpha = 0;
					soundArray10.push(scratchSound1);
				}
				else if (container.scratch_10.alpha == 0)
				{
					container.scratch_10.alpha = 1;
					soundArray10.splice(soundArray10.indexOf(scratchSound1), 1);
				}
			}

			if (event.target.name == "bass_10")
			{

				if (container.bass_10.alpha == 1)
				{
					container.bass_10.alpha = 0;
					soundArray10.push(tranceSound);
				}
				else if (container.bass_10.alpha == 0)
				{
					container.bass_10.alpha = 1;
					soundArray10.splice(soundArray10.indexOf(tranceSound), 1);
				}
			}

			//row11
			if (event.target.name == "drum_11")
			{

				if (container.drum_11.alpha == 1)
				{
					container.drum_11.alpha = 0;
					soundArray11.push(drumSound);
					/*myStr = event.target.name;
					trace(myStr);*/
					trace("drum_11 pressed");
				}
				else if (container.drum_11.alpha == 0)
				{
					container.drum_11.alpha = 1;
					soundArray11.splice(soundArray11.indexOf(drumSound), 1);
				}
			}

			if (event.target.name == "hat_11")
			{

				if (container.hat_11.alpha == 1)
				{
					container.hat_11.alpha = 0;
					soundArray11.push(hatSound);
				}
				else if (container.hat_11.alpha == 0)
				{
					container.hat_11.alpha = 1;
					soundArray11.splice(soundArray11.indexOf(hatSound), 1);
				}
			}

			if (event.target.name == "snare_11")
			{

				if (container.snare_11.alpha == 1)
				{
					container.snare_11.alpha = 0;
					soundArray11.push(snareSound);
				}
				else if (container.snare_11.alpha == 0)
				{
					container.snare_11.alpha = 1;
					soundArray11.splice(soundArray11.indexOf(snareSound), 1);
				}
			}

			if (event.target.name == "clap_11")
			{

				if (container.clap_11.alpha == 1)
				{
					container.clap_11.alpha = 0;
					soundArray11.push(clapSound);
				}
				else if (container.clap_11.alpha == 0)
				{
					container.clap_11.alpha = 1;
					soundArray11.splice(soundArray11.indexOf(clapSound), 1);
				}
			}

			if (event.target.name == "scratch_11")
			{

				if (container.scratch_11.alpha == 1)
				{
					container.scratch_11.alpha = 0;
					soundArray11.push(scratchSound1);
				}
				else if (container.scratch_11.alpha == 0)
				{
					container.scratch_11.alpha = 1;
					soundArray11.splice(soundArray11.indexOf(scratchSound1), 1);
				}
			}

			if (event.target.name == "bass_11")
			{

				if (container.bass_11.alpha == 1)
				{
					container.bass_11.alpha = 0;
					soundArray11.push(tranceSound);
				}
				else if (container.bass_11.alpha == 0)
				{
					container.bass_11.alpha = 1;
					soundArray11.splice(soundArray11.indexOf(tranceSound), 1);
				}
			}


			//row12
			if (event.target.name == "drum_12")
			{

				if (container.drum_12.alpha == 1)
				{
					container.drum_12.alpha = 0;
					soundArray12.push(drumSound);
					/*myStr = event.target.name;
					trace(myStr);*/
					trace("drum_12 pressed");
				}
				else if (container.drum_12.alpha == 0)
				{
					container.drum_12.alpha = 1;
					soundArray12.splice(soundArray12.indexOf(drumSound), 1);
				}
			}

			if (event.target.name == "hat_12")
			{

				if (container.hat_12.alpha == 1)
				{
					container.hat_12.alpha = 0;
					soundArray12.push(hatSound);
				}
				else if (container.hat_12.alpha == 0)
				{
					container.hat_12.alpha = 1;
					soundArray12.splice(soundArray12.indexOf(hatSound), 1);
				}
			}

			if (event.target.name == "snare_12")
			{

				if (container.snare_12.alpha == 1)
				{
					container.snare_12.alpha = 0;
					soundArray12.push(snareSound);
				}
				else if (container.snare_12.alpha == 0)
				{
					container.snare_12.alpha = 1;
					soundArray12.splice(soundArray12.indexOf(snareSound), 1);
				}
			}

			if (event.target.name == "clap_12")
			{

				if (container.clap_12.alpha == 1)
				{
					container.clap_12.alpha = 0;
					soundArray12.push(clapSound);
				}
				else if (container.clap_12.alpha == 0)
				{
					container.clap_12.alpha = 1;
					soundArray12.splice(soundArray12.indexOf(clapSound), 1);
				}
			}

			if (event.target.name == "scratch_12")
			{

				if (container.scratch_12.alpha == 1)
				{
					container.scratch_12.alpha = 0;
					soundArray12.push(scratchSound1);
				}
				else if (container.scratch_12.alpha == 0)
				{
					container.scratch_12.alpha = 1;
					soundArray12.splice(soundArray12.indexOf(scratchSound1), 1);
				}
			}

			if (event.target.name == "bass_12")
			{

				if (container.bass_12.alpha == 1)
				{
					container.bass_12.alpha = 0;
					soundArray12.push(tranceSound);
				}
				else if (container.bass_12.alpha == 0)
				{
					container.bass_12.alpha = 1;
					soundArray12.splice(soundArray12.indexOf(tranceSound), 1);
				}
			}

			//row13
			if (event.target.name == "drum_13")
			{

				if (container.drum_13.alpha == 1)
				{
					container.drum_13.alpha = 0;
					soundArray13.push(drumSound);
					/*myStr = event.target.name;
					trace(myStr);*/
					trace("drum_13 pressed");
				}
				else if (container.drum_13.alpha == 0)
				{
					container.drum_13.alpha = 1;
					soundArray13.splice(soundArray13.indexOf(drumSound), 1);
				}
			}

			if (event.target.name == "hat_13")
			{

				if (container.hat_13.alpha == 1)
				{
					container.hat_13.alpha = 0;
					soundArray13.push(hatSound);
				}
				else if (container.hat_13.alpha == 0)
				{
					container.hat_13.alpha = 1;
					soundArray13.splice(soundArray13.indexOf(hatSound), 1);
				}
			}

			if (event.target.name == "snare_13")
			{

				if (container.snare_13.alpha == 1)
				{
					container.snare_13.alpha = 0;
					soundArray13.push(snareSound);
				}
				else if (container.snare_13.alpha == 0)
				{
					container.snare_13.alpha = 1;
					soundArray13.splice(soundArray13.indexOf(snareSound), 1);
				}
			}

			if (event.target.name == "clap_13")
			{

				if (container.clap_13.alpha == 1)
				{
					container.clap_13.alpha = 0;
					soundArray13.push(clapSound);
				}
				else if (container.clap_13.alpha == 0)
				{
					container.clap_13.alpha = 1;
					soundArray13.splice(soundArray13.indexOf(clapSound), 1);
				}
			}

			if (event.target.name == "scratch_13")
			{

				if (container.scratch_13.alpha == 1)
				{
					container.scratch_13.alpha = 0;
					soundArray13.push(scratchSound1);
				}
				else if (container.scratch_13.alpha == 0)
				{
					container.scratch_13.alpha = 1;
					soundArray13.splice(soundArray13.indexOf(scratchSound1), 1);
				}
			}

			if (event.target.name == "bass_13")
			{

				if (container.bass_13.alpha == 1)
				{
					container.bass_13.alpha = 0;
					soundArray13.push(tranceSound);
				}
				else if (container.bass_13.alpha == 0)
				{
					container.bass_13.alpha = 1;
					soundArray13.splice(soundArray13.indexOf(tranceSound), 1);
				}
			}

			//row14
			if (event.target.name == "drum_14")
			{

				if (container.drum_14.alpha == 1)
				{
					container.drum_14.alpha = 0;
					soundArray14.push(drumSound);
					/*myStr = event.target.name;
					trace(myStr);*/
					trace("drum_14 pressed");
				}
				else if (container.drum_14.alpha == 0)
				{
					container.drum_14.alpha = 1;
					soundArray14.splice(soundArray14.indexOf(drumSound), 1);
				}
			}

			if (event.target.name == "hat_14")
			{

				if (container.hat_14.alpha == 1)
				{
					container.hat_14.alpha = 0;
					soundArray14.push(hatSound);
				}
				else if (container.hat_14.alpha == 0)
				{
					container.hat_14.alpha = 1;
					soundArray14.splice(soundArray14.indexOf(hatSound), 1);
				}
			}

			if (event.target.name == "snare_14")
			{

				if (container.snare_14.alpha == 1)
				{
					container.snare_14.alpha = 0;
					soundArray14.push(snareSound);
				}
				else if (container.snare_14.alpha == 0)
				{
					container.snare_14.alpha = 1;
					soundArray14.splice(soundArray14.indexOf(snareSound), 1);
				}
			}

			if (event.target.name == "clap_14")
			{

				if (container.clap_14.alpha == 1)
				{
					container.clap_14.alpha = 0;
					soundArray14.push(clapSound);
				}
				else if (container.clap_14.alpha == 0)
				{
					container.clap_14.alpha = 1;
					soundArray14.splice(soundArray14.indexOf(clapSound), 1);
				}
			}

			if (event.target.name == "scratch_14")
			{

				if (container.scratch_14.alpha == 1)
				{
					container.scratch_14.alpha = 0;
					soundArray14.push(scratchSound1);
				}
				else if (container.scratch_14.alpha == 0)
				{
					container.scratch_14.alpha = 1;
					soundArray14.splice(soundArray14.indexOf(scratchSound1), 1);
				}
			}

			if (event.target.name == "bass_14")
			{

				if (container.bass_14.alpha == 1)
				{
					container.bass_14.alpha = 0;
					soundArray14.push(tranceSound);
				}
				else if (container.bass_14.alpha == 0)
				{
					container.bass_14.alpha = 1;
					soundArray14.splice(soundArray14.indexOf(tranceSound), 1);
				}
			}

			//row15
			if (event.target.name == "drum_15")
			{

				if (container.drum_15.alpha == 1)
				{
					container.drum_15.alpha = 0;
					soundArray15.push(drumSound);
					/*myStr = event.target.name;
					trace(myStr);*/
					trace("drum_15 pressed");
				}
				else if (container.drum_15.alpha == 0)
				{
					container.drum_15.alpha = 1;
					soundArray15.splice(soundArray15.indexOf(drumSound), 1);
				}
			}

			if (event.target.name == "hat_15")
			{

				if (container.hat_15.alpha == 1)
				{
					container.hat_15.alpha = 0;
					soundArray15.push(hatSound);
				}
				else if (container.hat_15.alpha == 0)
				{
					container.hat_15.alpha = 1;
					soundArray15.splice(soundArray15.indexOf(hatSound), 1);
				}
			}

			if (event.target.name == "snare_15")
			{

				if (container.snare_15.alpha == 1)
				{
					container.snare_15.alpha = 0;
					soundArray15.push(snareSound);
				}
				else if (container.snare_15.alpha == 0)
				{
					container.snare_15.alpha = 1;
					soundArray15.splice(soundArray15.indexOf(snareSound), 1);
				}
			}

			if (event.target.name == "clap_15")
			{

				if (container.clap_15.alpha == 1)
				{
					container.clap_15.alpha = 0;
					soundArray15.push(clapSound);
				}
				else if (container.clap_15.alpha == 0)
				{
					container.clap_15.alpha = 1;
					soundArray15.splice(soundArray15.indexOf(clapSound), 1);
				}
			}

			if (event.target.name == "scratch_15")
			{

				if (container.scratch_15.alpha == 1)
				{
					container.scratch_15.alpha = 0;
					soundArray15.push(scratchSound1);
				}
				else if (container.scratch_15.alpha == 0)
				{
					container.scratch_15.alpha = 1;
					soundArray15.splice(soundArray15.indexOf(scratchSound1), 1);
				}
			}

			if (event.target.name == "bass_15")
			{

				if (container.bass_15.alpha == 1)
				{
					container.bass_15.alpha = 0;
					soundArray15.push(tranceSound);
				}
				else if (container.bass_15.alpha == 0)
				{
					container.bass_15.alpha = 1;
					soundArray15.splice(soundArray15.indexOf(tranceSound), 1);
				}
			}


			//row16
			if (event.target.name == "drum_16")
			{

				if (container.drum_16.alpha == 1)
				{
					container.drum_16.alpha = 0;
					soundArray16.push(drumSound);
					/*myStr = event.target.name;
					trace(myStr);*/
					trace("drum_16 pressed");
				}
				else if (container.drum_16.alpha == 0)
				{
					container.drum_16.alpha = 1;
					soundArray16.splice(soundArray16.indexOf(drumSound), 1);
				}
			}

			if (event.target.name == "hat_16")
			{

				if (container.hat_16.alpha == 1)
				{
					container.hat_16.alpha = 0;
					soundArray16.push(hatSound);
				}
				else if (container.hat_16.alpha == 0)
				{
					container.hat_16.alpha = 1;
					soundArray16.splice(soundArray16.indexOf(hatSound), 1);
				}
			}

			if (event.target.name == "snare_16")
			{

				if (container.snare_16.alpha == 1)
				{
					container.snare_16.alpha = 0;
					soundArray16.push(snareSound);
				}
				else if (container.snare_16.alpha == 0)
				{
					container.snare_16.alpha = 1;
					soundArray16.splice(soundArray16.indexOf(snareSound), 1);
				}
			}

			if (event.target.name == "clap_16")
			{

				if (container.clap_16.alpha == 1)
				{
					container.clap_16.alpha = 0;
					soundArray16.push(clapSound);
				}
				else if (container.clap_16.alpha == 0)
				{
					container.clap_16.alpha = 1;
					soundArray16.splice(soundArray16.indexOf(clapSound), 1);
				}
			}

			if (event.target.name == "scratch_16")
			{

				if (container.scratch_16.alpha == 1)
				{
					container.scratch_16.alpha = 0;
					soundArray16.push(scratchSound1);
				}
				else if (container.scratch_16.alpha == 0)
				{
					container.scratch_16.alpha = 1;
					soundArray16.splice(soundArray16.indexOf(scratchSound1), 1);
				}
			}

			if (event.target.name == "bass_16")
			{

				if (container.bass_16.alpha == 1)
				{
					container.bass_16.alpha = 0;
					soundArray16.push(tranceSound);
				}
				else if (container.bass_16.alpha == 0)
				{
					container.bass_16.alpha = 1;
					soundArray16.splice(soundArray16.indexOf(tranceSound), 1);
				}
			}

		}

//////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
//process the xml file
		//this function is called when myLoader variable's event.COMPLETE is ready
		public function processXML(event:Event):void
			{
				//pass the xml data into the myXML variable
				myXML = new XML(event.target.data);
				//trace(myXML.image[0].@url);
				
				//set imageURL equal the image in the xml file by using its path to locate it
				var imageUrl = myXML.image[0].@url;
				
				//pass the imageURL into the loadedImg variable which has the URLRequest class 
				var loadedImg:URLRequest = new URLRequest(imageUrl);
				//pass loadedsImg into the globally created var xmlImage & add to stage
				xmlImage.load(loadedImg);
				xmlImage.x = 1070;
				xmlImage.y = 500;
				this.addChild(xmlImage);
				
				//add html link to my website on the xmlImage var
				xmlImage.addEventListener(MouseEvent.CLICK, goToUrl);
				
			}

	    // this function gets called everytime the timer goes off ,it checks to see what number
		// the timercount variable is on and then goes through the corresponding array and plays the sounds 
		// in the array by passing them into the soundCh variable and also moving the playhead.
		// it increments onto the following step using timerCount++
		
		function timerHandler(event:TimerEvent):void
		{

			trace(timerCount);

			if (timerCount == 1)
			{
				//using the exact playhead.x position as i created the background image 
				//without aligning the whites to a grid, otherwise I'd have incremented the
				//red playhead by a set amount everytime the timer went off.
				playhead.x = 263;
				playhead.y = 47;

				//make playhead visible for the start of sequence
				playhead.visible = true;

				//each array is being looped through is connected to the timerCount variable and
				//by placing each step into a different array I can play all the sounds together.
			for (var i:String in soundArray1)
			{
					soundCh = soundArray1[i].play();
			}
			}
			else if (timerCount == 2)
			{
				playhead.x = 324;
				for (var o:String in soundArray2)
				{
					soundCh = soundArray2[o].play();
				}
			}
			else if (timerCount == 3)
			{
				playhead.x = 390;
				for (var p:String in soundArray3)
				{
					soundCh = soundArray3[p].play();
				}
			}
			else if (timerCount == 4)
			{
				playhead.x = 450;
				for (var a:String in soundArray4)
				{
					soundCh = soundArray4[a].play();
				}
			}
			else if (timerCount == 5)
			{
				playhead.x = 510;
				for (var s:String in soundArray5)
				{
					soundCh = soundArray5[s].play();
				}
			}
			else if (timerCount == 6)
			{
				playhead.x = 577;
				for (var d:String in soundArray6)
				{
					var soundCh6:SoundChannel = soundArray6[d].play();
				}
			}
			else if (timerCount == 7)
			{
				playhead.x = 640;
				for (var f:String in soundArray7)
				{
					soundCh = soundArray7[f].play();
				}
			}
			else if (timerCount == 8)
			{
				playhead.x = 703;
				for (var g:String in soundArray8)
				{
					soundCh = soundArray8[g].play();
				}
			}
			else if (timerCount == 9)
			{
				playhead.x = 763;
				for (var h:String in soundArray9)
				{
					soundCh = soundArray9[h].play();
				}
			}
			else if (timerCount == 10)
			{
				playhead.x = 823;
				for (var j:String in soundArray10)
				{
					soundCh = soundArray10[j].play();
				}
			}
			else if (timerCount == 11)
			{
				playhead.x = 890;
				for (var k:String in soundArray11)
				{
					soundCh = soundArray11[k].play();
				}
			}
			else if (timerCount == 12)
			{
				playhead.x = 950;
				for (var l:String in soundArray12)
				{
					soundCh = soundArray12[l].play();
				}
			}
			else if (timerCount == 13)
			{
				playhead.x = 1015;
				for (var c:String in soundArray13)
				{
					soundCh = soundArray13[c].play();
				}
			}
			else if (timerCount == 14)
			{
				playhead.x = 1075;
				for (var v:String in soundArray14)
				{
					soundCh = soundArray14[v].play();
				}
			}
			else if (timerCount == 15)
			{
				playhead.x = 1135;
				for (var b:String in soundArray15)
				{
					soundCh = soundArray15[b].play();
				}
			}
			else if (timerCount == 16)
			{
				playhead.x = 1203;
				for (var n:String in soundArray16)
				{
					soundCh = soundArray16[n].play();
				}

			}
			//increment the timer variable to move the play onto the next array loop
			timerCount++;


			//check to see what position the timercount is at. this stops the timer once
			//it's greater than 16 and sets the boolean to false if the loopbtn is clicked, 
			//I had to include multiple checks in the if statement to enable the melody to be 
			//turned on and off either during play or to allow it to loop along with the 
			//timer.
			if (timerCount > 16)
			{
				timerCount = 1;
				timer.reset();
				countBoo = false;
				trace(countBoo);

				trace("timer is complete");
				if (countBoo == false && loopOffBtn.visible == false && onOff.x == 70)
				{

					timer.reset();
					timer.start();
					melodyCh = melodySound.play();
					trace("countBoo = false && loopOffBtn = false && onOff.x = 70");

				}
				else if(countBoo == false && loopOffBtn.visible == false && onOff.x == 120){
					timer.reset();
					timer.start();
					soundCh.stop();
					//melodyCh.stop();
				}
			}

		}
		//trans is a soundtransform object I'm using to control the volume globally. 
		//set the trans.volume = myVol value(myVol being the instance of slider)
		public function volumeChange(event:SliderEvent):void
		{
			trans.volume = myVol.value;
			SoundMixer.soundTransform = trans;

			trace("volume slider value ="+ myVol.value);
			//covert to string to display in the input box
			volText.text = myVol.value.toString();
		}
		//function called on the play button click. It starts the timer and also checks the
		//state of the boolean on the melody onoff button to see if it's needed to start.
		function starTimer(event:MouseEvent):void
		{
			timer.start();
			if(switchBoo == false){
			melodyCh = melodySound.play();
			}
			else if(switchBoo == true){
				melodyCh.stop();
				
			}
			if(soundBytes != null){
				//playRecording();
			}
			//playRecording();



		}
		
		
		//function for the pause button which stops the timer. I thought I'd have to capture the
		//position of the timer but it starts up where it stops, so there was no need for it to be
		//saved in a variable.
		//I also stop the melody sound channel. I tried implementing the channel.position on this channel
		//without success, so I settled for just stopping it, which means when restarted it begins from
		//the beginning of the melody again. I tried using the same soundchannel for everything
		//but issues arose with trying to stop the sound so I had to create a seperate channel for
		//the melody
		function pauseHandler(event:MouseEvent):void
		{
			trace("pauseBtn pressed");
			timer.stop();
			melodyCh.stop();
			//trackTime = melodyCh.position;

		}
		//function for the stop button. Here I stop the timer and reset it. I make the playhead
		//invisible and reset the timercount variable to 1, to enable the user to go right back
		//to the start of the timelime.
		//I've included another if statement to check the position of the melody sound channel
		//when the stop is hit. With out this if statement I was getting a null object error
		//because when the stop was hit while there was no sound buttons selected it was trying 
		//to stop the sound channel which didn't contain anything.
		function stopHandler(event:MouseEvent):void
		{
			
			trace("stop btn pressed");
			//stop timer
			timer.stop();
			//reset timer
			timer.reset();
			//make playhead invisible as its not in any 
			playhead.visible = false;
			timerCount = 1;
			
			if(melodyCh.position !=0){
			//soundCh.stop();
			melodyCh.stop();
			}
			else if(melodyCh.position !=0 && soundCh.position !=0){
				soundCh.stop();
			melodyCh.stop();
			}
			
			
		}
		//loop button function which hides the top button onClick and reveals the on underneath
		function loopOffHandler(event:MouseEvent):void
		{
			trace("loopOffBtn pressed");
			loopOffBtn.visible = false;
			loopOnBtn.visible = true;

		}
		//loop button function which hides the top button onClick and reveals the on underneath
		function loopOnHandler(event:MouseEvent):void
		{
			loopOffBtn.visible = true;
			loopOnBtn.visible = false;
		}

		// playing the sounds of each track from the orange tabs beside each the track name
		function sampleConHandler(event:MouseEvent):void
		{
			if (event.target.name == "drumSam")
			{
				soundCh = drumSound.play();
			}
			else if (event.target.name == "hatSam")
			{
				soundCh = hatSound.play();
			}
			else if (event.target.name == "snareSam")
			{
				soundCh = snareSound.play();
			}
			else if (event.target.name == "clapSam")
			{
				soundCh = clapSound.play();
			}
			else if (event.target.name == "scratchSam")
			{
				soundCh = scratchSound1.play();
			}
			else if (event.target.name == "bassSam")
			{
				soundCh = tranceSound.play();
			}
		}
		
		
		//controlling the melody onOff switch by checking the x position of the onOff movieClip
		//it's in here that I switch the boolean which is checked in the startTimer function line 1941
		function onOffHandler(event:MouseEvent):void
		{
			if(onOff.x == 70){
				onOff.x =120;
				switchBoo = true;
			}
			else if(onOff.x ==120){
				onOff.x = 70;
				switchBoo = false;
			}
			
			
		}
		// function for the onclick link to my website, this function is called in the xmlProcess
		//function when the mouseclick is placed on the xmlImage variable. I had the website 
		// variable  global but switched it into this function as it's not something I need other than
		// in this function.
		function goToUrl(event:MouseEvent):void{
		   var website:URLRequest = new URLRequest("http://www.keithryan.ie");
			navigateToURL(website, "_blank");
		}
		
		// emptying all the arrays and setting alpha back to original state
		//this enables the user to quickly start from the beginning without turning off and on
		function resetDownHandler(event:MouseEvent):void{
			trace("reset button clicked");
			//scale the button down when pressed 
			reset.scaleX = reset.scaleY = 0.8;
			
			//loop through the 16 arrays and remove the sounds from each one using the splice method
			for (var i:int =0; i< soundArray1.length; i++){
				
					soundArray1.splice(0);
			}
			
			for (var o:int =0; o< soundArray2.length; o++){
				
					soundArray2.splice(0);
			}
			
			for (var p:int =0; p< soundArray3.length; p++){
				
					soundArray3.splice(0);
			}
			
			for (var a:int =0; a< soundArray4.length; a++){
				
					soundArray4.splice(0);
			}
			
			for (var s:int =0; s< soundArray5.length; s++){
				
					soundArray5.splice(0);
			}
			for (var d:int =0; d< soundArray6.length; d++){
				
					soundArray6.splice(0);
			}
			for (var f:int =0; f< soundArray7.length; f++){
				
					soundArray7.splice(0);
			}
			for (var g:int =0; g< soundArray8.length; g++){
				
					soundArray8.splice(0);
			}
			for (var h:int =0; h< soundArray9.length; h++){
				
					soundArray9.splice(0);
			}
			for (var j:int =0; j< soundArray10.length; j++){
				
					soundArray10.splice(0);
			}
			for (var k:int =0; k< soundArray11.length; k++){
				
					soundArray11.splice(0);
			}
			for (var l:int =0; l< soundArray12.length; l++){
				
					soundArray12.splice(0);
			}
			for (var c:int =0; c< soundArray13.length; c++){
				
					soundArray13.splice(0);
			}
			for (var v:int =0; v< soundArray14.length; v++){
				
					soundArray14.splice(0);
			}
			for (var n:int =0; n< soundArray15.length; n++){
				
					soundArray15.splice(0);
			}
			for (var b:int =0; b< soundArray16.length; b++){
				
					soundArray16.splice(0);
			}
			
			//loop through the container's children and change the alpha to a value of 1 on all container children
			if( container.numChildren > 0 )
             for( var ii:int ; ii < container.numChildren ; ++ii ){
				 
				 container.getChildAt(ii).alpha = 1;
			 }
			
		}
		
		//reset the button to its natural size
		function resetUpHandler(event:MouseEvent):void{
			reset.scaleX = reset.scaleY = 1;;
			
		}
		//switch the state of the buttons the overlay each other and start recording. 
		//I couldn't get the record function working so I've had to comment out any references
		//to the record functions that feature in on any buttons in the app.
		function recordHandler(event:MouseEvent):void
		{
			trace("record button pressed");
			recBtn.visible = false;
			recordOn.visible = true;
			//startRecording();
		}
		
		function recOnHandler(event:MouseEvent):void{
			recBtn.visible = true;
			recordOn.visible = false;
			//stopRecording();
		}

		function startRecording():Boolean
		{
		if (Microphone.isSupported)
		{
		 mic = Microphone.getMicrophone();
		 mic.setSilenceLevel(0, 4000);
		 mic.gain = 50;
		 mic.rate = 44;
		 mic.addEventListener(SampleDataEvent.SAMPLE_DATA, micSampleDataHandler);
		 return true;
		 }
		 
		 else
		 {
		 return false;
		 }
		}
		
		
		function micSampleDataHandler(event:SampleDataEvent):void
		{
		while (event.data.bytesAvailable)
		{
		var sample:Number = event.data.readFloat();
		soundBytes.writeFloat(sample);
		}
		}
		
		
		function stopRecording():Boolean
		{
		 if (Microphone.isSupported)
		 {
		 mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, micSampleDataHandler);
		 soundBytes.position = 0;
		 return true;
		}
		
		 else
		 {
		 return false;
		 }
		
		}
		
		
		function playRecording():void
		{
		recBtn.addEventListener(SampleDataEvent.SAMPLE_DATA, playbackSampleHandler);
		recChannel = recTrack.play();
		recChannel.addEventListener(Event.SOUND_COMPLETE, playbackComplete);
		}
		
		
		function playbackSampleHandler(event:SampleDataEvent):void
		{
		 for (var i:int = 0; i < 8192 && soundBytes.bytesAvailable > 0; i++)
		 {
		var sample:Number = soundBytes.readFloat();
		event.data.writeFloat(sample);
		event.data.writeFloat(sample); 
		 }
		
		}
		
		
		function clearRecording():void
		{
		
		this.soundBytes = new ByteArray();
		
		}
		
		function playbackComplete(event:Event):void
		{
		  trace("playback is complete");
		}


	}

}