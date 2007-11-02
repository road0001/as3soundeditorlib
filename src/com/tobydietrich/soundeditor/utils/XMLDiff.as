package com.tobydietrich.soundeditor.utils
{
	public class XMLDiff
	{
		public static function diff(curr:XML, prev:XML = null):XML {
			return <diff>{innerDiff(curr, prev)}</diff>;
		}
		
		private static function innerDiff(curr:XML, prev:XML):XML {
			if(prev == null) {
				return <added>{curr}</added>;
			} else if(curr == null) {
				return <removed>{prev}</removed>;
			} else if(curr == prev) {
				return null;
			} else {
				var changed:XML = <{curr.localName()} />;
				for each(var e:XML in curr.attributes()) {
					if(e.name() == "name" || prev.attribute(e.name()) != e) {
						changed.@[e.name()] = e;
					}
				}
				for each(e in prev.attributes()) {
					if(e != null && curr.attribute(e.name()) == null) {
						changed.@[e.name()]="DELETED";
					}
				}
				
				for each(e in curr.children()) {
					changed.appendChild(innerDiff(e, getIndexChild(prev, e.childIndex())));
				}
				return changed;
			}
			
			
		}
		private static function getIndexChild(p:XML, n:int):XML {
				var i:int = 0; 
				for each(var e:XML in p.*) {
					if(i == n) 
					{
						return e;
					}
					i++;
				}
				return null;
			}
	}
}