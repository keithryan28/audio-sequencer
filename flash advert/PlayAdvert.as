package  {
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.*;
	/*import fl.controls.Button;*/
	
	public class PlayAdvert extends MovieClip {
		
		private var imageLoader:Loader;
		private var imageCount:int;
		private var myTimer:Timer;
		/*private var myBtn:Button = new Button ();*/
		
		/*myBtn.label = "lit";*/
		
		/*private var lit:URLRequest = new URLRequest("http://www.lit.ie");
		navigateToURL(lit, "_target");*/
		
		
		public function PlayAdvert() {
			// constructor code
		 
			imageLoader = new Loader();
			imageCount = 1;

			loadImage();
			
			trace(imageCount);
			
			myTimer = new Timer(1500, 2);
			myTimer.addEventListener(TimerEvent.TIMER, timerHandler);
			myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, loopTimer);
			myTimer.start();
			
			
			
			
		}
		private function loadImage():void
		{   
			
			var imgReq:URLRequest = new URLRequest ("img/img"+imageCount+".jpg");
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imgLoaded);
			
			imageLoader.load(imgReq);
		}
		
		private function imgLoaded(event:Event):void
		{
			addChildAt(imageLoader, 0);
		}
		private function timerHandler(event:TimerEvent):void
		{	
			imageCount++;
			trace(imageCount);
			loadImage();
			
		}
		private function loopTimer(event:TimerEvent):void
		{
			imageCount = 0;
			trace("timer is complete");
			myTimer.reset();
			/*myTimer.delay = 5000;*/
			myTimer.start();
			
		}
		
		
	}
	
}
