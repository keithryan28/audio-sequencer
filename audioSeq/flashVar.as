package  {
	
	import flash.display.MovieClip;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.LoaderInfo;
	import flash.net.navigateToURL;
	
	
	public class flashVar extends MovieClip {
		
		private var targetURL:URLRequest;
		
		public function flashVar() {
			// constructor code
			
			var urlString:String;
			
			urlString = this.getFlashVarValue("targetURL");
			
			if (urlString != null)
			{
				// Create a new URLRequest object using the value ot the targetURL FlashVar
				targetURL = new URLRequest(urlString);
			}
			else
			{
				// Ok, urlString is null for some strange reason. As a Plan B I am going to
				// create a URLRequest object that will direct the user to lit.ie. Not ideal
				// but it;s something.
				targetURL = new URLRequest("http://www.google.ie");
			}
			
			myBtn.addEventListener(MouseEvent.CLICK, btnHandler);
		}
		
		
		private function getFlashVarValue(varName:String):String
		{
			// This is the variable I am going to use to store the value of the FlashVar
			var value:String = null;
			
			
			var paramObj:Object = this.loaderInfo.parameters;
			
			
			if (paramObj.hasOwnProperty(varName) == true)
			{
				value =  String(paramObj[varName]);
			}
			
			return value;
		}
		
		public function btnHandler(event:MouseEvent):void{
			
			trace("button clicked");
			flash.net.navigateToURL(targetURL, "_blank");
		}
	}
	
}

