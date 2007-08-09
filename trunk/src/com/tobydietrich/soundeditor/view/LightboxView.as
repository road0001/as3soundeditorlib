/***
 * Provides a way to view a complete animation and navigate through the animation
 */
package com.tobydietrich.soundeditor.view
{
   import flash.display.Sprite;
   import com.tobydietrich.soundeditor.controller.LightboxController;
   import flash.events.Event;
   
	import flash.events.MouseEvent;

   public class LightboxView extends Sprite
   {
      private var myLightboxController:LightboxController;
      
      
      private var filmstripContainer:Sprite;
        private var lightboxSprite:Sprite;
		private var cursorSprite:Sprite;      
      
      public function LightboxView(lightboxController:LightboxController)
      {
         myLightboxController = lightboxController;
          
          filmstripContainer = new Sprite();
          filmstripContainer.addChild(filmstrip);
          filmstripContainer.graphics.beginFill(0x333333);
          filmstripContainer.graphics.drawRect(0,0,lightboxWidth, filmstrip.height);
          filmstripContainer.graphics.endFill();
          addChild(filmstripContainer);
          
		 lightboxSprite = new Sprite();
		 lightboxSprite.graphics.beginFill(0xFFFFFF, 0.1);
	     lightboxSprite.graphics.drawRect(0, 0, lightboxWidth, filmstrip.height);
	     lightboxSprite.graphics.endFill();
	     addChild(lightboxSprite);
	     
	     cursorSprite = new Sprite();
         cursorSprite.graphics.beginFill(0xFFFF00);
         cursorSprite.graphics.drawRect(0,0,1,filmstrip.height);
         cursorSprite.graphics.endFill();
         addChild(cursorSprite);
         
         lightboxSprite.addEventListener(MouseEvent.CLICK, eLightboxClick);
         filmstrip.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
         filmstrip.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
         
         lightboxController.addEventListener(Event.CHANGE, eChange);
      }
      
      private function eChange(event:Event):void {
      	var lightboxController:LightboxController = event.target as LightboxController;
      	filmstrip.x = -lightboxController.frameStart;
      	cursorSprite.x = lightboxWidth * lightboxController.cursorPosition;
      	
      }
	private function eLightboxClick(event:MouseEvent):void {
	     lightboxController.cursorPosition = event.localX / lightboxWidth;
	}
	
	private function mouseDownHandler(event:MouseEvent):void {
             filmstrip.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
            filmstrip.startDrag();
        }

        private function mouseUpHandler(event:MouseEvent):void {
            filmstrip.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
            filmstrip.stopDrag();
        }

        private function mouseMoveHandler(event:MouseEvent):void {
            event.updateAfterEvent();
        }
		
		private function get lightboxController():LightboxController {
			return myLightboxController;
		}
      private function get filmstrip():Sprite {
      	return lightboxController.filmstrip;
      }
      
      private function get lightboxWidth():int {
      	return lightboxController.lightboxWidth;
      }
		
		
   }
}