package  {
	
	import flash.display.SimpleButton;
	
	
	public class SpecialButton extends SimpleButton {
		
		
		public function SpecialButton() {
			// constructor code
		}
		
		public function doYourStuff()
		{
			if (this.alpha == 1)
			{
				this.alpha = 0.5;
			}
			else
			{
				this.alpha = 1;
			}
		}
	}
	
}
