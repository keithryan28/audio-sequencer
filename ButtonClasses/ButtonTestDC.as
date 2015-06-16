package 
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;


	public class ButtonTestDC extends MovieClip
	{


		public function ButtonTestDC()
		{
			// constructor code
			myButton.addEventListener(MouseEvent.CLICK, handleClick);
			buttonA.addEventListener(MouseEvent.CLICK, handleClicka);
		}
		
		public function handleClick(e:MouseEvent):void
		{
			myButton.doYourStuff();
		}
		
		public function handleClicka(e:MouseEvent):void
		{
			buttonA.sayHi();
		}
	}

}