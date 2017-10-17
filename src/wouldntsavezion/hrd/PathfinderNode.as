package wouldntsavezion.hrd {
	public class PathfinderNode {
		public var F:int;
		public var G:int;
		public var P:PathfinderNode;
		public var Children:Array;
		public var W:Number;
		public var X:int;
		public var Y:int;
		public var D:uint;
		public var Closed:Boolean;
		
		public function PathfinderNode(_F:int = 0, _G:int = 1, _P:PathfinderNode = null, _Children:Array = null, _W:Number = 1, _X:int = 0, _Y:int = 0, _D:int = 0, _Closed:Boolean = false){
			_Children = (_Children == null) ? [] : _Children;
			F = _F;
			G = _G;
			P = _P;
			Children = _Children;
			W = _W;
			X = _X;
			Y = _Y;
			D = _D;
			Closed = _Closed;
		}
	}
}