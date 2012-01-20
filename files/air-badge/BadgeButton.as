package  {
	
	// imports
	import flash.display.Loader;
	import flash.display.SimpleButton;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	public class BadgeButton extends MovieClip {
	
		// adobe air loaded object
		private var _air : Object;
		
		private const AIR_SWF:String = "http://airdownload.adobe.com/air/browserapi/air.swf";
		private const AIR_SWF_URL : String = "http://airdownload.adobe.com/air/browserapi/air.swf";
		
		private const APP_URL:String = "http://www.facebookdesktop.com/download.php?src=badge";
		private const APP_ID:String = "com.facebookdesktop.app";
		
		private const APP_RUNTIME:String = "1";
		private const AIR_VERSION:String = "1.5";
		
		private var downloadMsg : String = "Download now, it's free!";
		private var installingMsg : String = "Installing...";
		private var launchMsg : String = "Launch Facebook Desktop!";
		private var notAvailableMsg : String = "";
		private var installAirTooMsg : String = "";
//		private var notAvailableMsg : String = "Unfortunately Adobe® AIR™ is not available for your system.";
//		private var installAirTooMsg : String = "In order to run Facebook Desktop, this installer will also setup Adobe® AIR™";
		
		public function BadgeButton()	{
			
			super();
			
			this.installMsg.mouseEnabled = false;
			this.installMsg.text = downloadMsg;
			
			this.additionalMsg.mouseEnabled = false;
			this.additionalMsg.text = "";
			
			installButton.addEventListener(MouseEvent.CLICK, onMouseClickEvent);
			
			var ld : Loader = new Loader();
			
			ld.contentLoaderInfo.addEventListener(Event.COMPLETE, airSwfLoaded);
			ld.load(new URLRequest(AIR_SWF));
		}
		
		
		public function onMouseClickEvent(event:Event) : void {		
			switch(_air.getStatus()) {
				case 'available':
					this.installMsg.text = installingMsg;

					try {
						_air.installApplication(this.APP_URL, this.AIR_VERSION);
					} catch (e : Error) {
						
					}
					break;
					
				case 'installed':
					checkApp();
					break;
			}
		}
		
		
		
		private function airSwfLoaded(e : Event) : void {
			_air = e.target.content;
			// air installation status
			switch(_air.getStatus()) {
				// if air can be installed on this system
				case 'available':
					// install AIR & application
					this.additionalMsg.text = installAirTooMsg;
					this.installMsg.text = downloadMsg;
					break;
				// if air can't be installed on this system
				case 'unavailable':
					this.additionalMsg.text = notAvailableMsg;
					break;
				// if air is already installed on this system
				case 'installed':
					// check if app is installed
					checkApp();
					break;
			}
		}
		
		private function launchApp(e : MouseEvent) : void {
			_air.launchApplication(this.APP_ID, "", new Array());
		}
		
		private function checkApp() : void {
			_air.getApplicationVersion(this.APP_ID, "", checkAppCallback);
		}
		
		private function installApp(e : MouseEvent) : void {
			_air.installApplication(this.APP_URL, this.AIR_VERSION);
		}
		
		private function checkAppCallback(version : String):void {
			
			// app is not installed
			if (version == null) {
				this.installMsg.text = downloadMsg;
				installButton.removeEventListener(MouseEvent.CLICK, onMouseClickEvent);
				installButton.addEventListener(MouseEvent.CLICK, installApp);
				return;
			}
			
			// app is installed
			this.installMsg.text = launchMsg;
			installButton.addEventListener(MouseEvent.CLICK, launchApp);
		}
	}
}