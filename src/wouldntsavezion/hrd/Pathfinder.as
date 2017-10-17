package wouldntsavezion.hrd {
	import wouldntsavezion.hrd.PathfinderNode;
	
	public class Pathfinder {
		public static var world:Array = new Array();
		
        public static function FindPath(Start:PathfinderNode, End:PathfinderNode, useH:Boolean, maxDepth:uint):Array {
            var Open:Array = new Array();
			var Best:PathfinderNode = null;
			var i:uint = 0;
            Open.push(Start);
            while (Open.length > 0) {
                Open.sort(SortByF);
                var A:PathfinderNode = Open[0];
                if (A == End || A.D + 1 >= maxDepth){
					Best = A;
					break;
				}
                Open.shift();
                i = A.Children.length;
                while (i-- > 0) {
					A.Children[i].G = A.G + A.Children[i].W;
					var newF:int = (useH) ? A.Children[i].G + GetH(A.Children[i], End) : A.Children[i].G;
					if(A.Children[i].Closed) continue;
					if(Open.indexOf(A.Children[i]) != -1 && A.Children[i].F <= newF) continue;
					A.Children[i].F = newF;
					A.Children[i].P = A;
					A.Children[i].D = A.D + 1;
					Open.push(A.Children[i]);
                }
                A.Closed = true;
            }
            var Path:Array = new Array();
            var N:PathfinderNode = Best;
            while(N != null) {
                Path.push(N);
                N = N.P;
            }
            Path.reverse();
            for(i = 0; i < world.length; i++) {
                world[i].P = null;
            }
            return Path;
        }
		
		public static function SortByF(A:PathfinderNode, B:PathfinderNode):int { 
			return (A.F < B.F) ? -1 : (B.F < A.F) ? 1 : 0;
		}
		
        public static function GetH(Node:PathfinderNode, TargetNode:PathfinderNode):int {
            return Math.sqrt((TargetNode.X - Node.X) * (TargetNode.X - Node.X) + (TargetNode.Y - Node.Y) * (TargetNode.Y - Node.Y));
        }
		
		public static function GetNodeAt(X:int, Y:int):PathfinderNode {
            var i:int = world.length;
            while(i-- > 0) {
                if(world[i].X == X && world[i].Y == Y) return world[i];
            }
            return null;
        }
		
		public static function GenerateGrid(sizeX:uint, sizeY:uint):Array {
            var grid:Array = new Array();
			var i:int = 0;
			var j:int = 0;
			var n:PathfinderNode = new PathfinderNode();
			
            i = sizeY;
            while(i-- > 0) {
                j = sizeX;
                while(j-- > 0) {
                    n = new PathfinderNode();
                    n.X = j;
                    n.Y = i;
                    n.W = 1;
                    n.Children = new Array();
                    grid.push(n);
                }
            }
            i = sizeY;
            while(i-- > 0) {
                j = sizeX;
                while(j-- > 0) {
                    n = grid[i * sizeX + j];
                    var np:int = i * sizeX + j;
					if (np + sizeX < sizeY * sizeX && grid[np + sizeX] != null){ 
						n.Children.push(grid[np + sizeX]) 
					}
					
                    if (j != 0 && grid[np - 1] != null){ 
						n.Children.push(grid[np - 1]) 
					}
					
					if (np - sizeX >= 0 && grid[np - sizeX] != null){ 
						n.Children.push(grid[np - sizeX]) 
					}
					
					if (j != sizeX - 1 && grid[np + 1] != null){ 
						n.Children.push(grid[np + 1]) 
					}
                }
            }
            return grid;
        }
	}
}