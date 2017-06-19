package;

import kha.Color;

class GradientMap
{
	var map: List<Gradient>;
	public function new()
	{
		map = new List<Gradient>();
		fillStd();
	}
	public function add(g: Gradient): Void
	{
		map.add(g);
	}
	public function getColor(f: Float): Color
	{
		if(f < 0 || f > 1)
		{
			return Color.Transparent;
		}
		var low: Gradient = new Gradient(0, Color.Black);
		var high: Gradient = new Gradient(1, Color.White);
		for(g in map)
		{
			if(g.value >= f)
			{
				high = g;
			}
			if(g.value <= f)
			{
				low = g;
			}
		}
		return Util.mixColor(low.color, high.color, f);
	}
	public function clearGradients(): Void
	{
		map.clear();
		fillStd();
	}
	function fillStd()
	{
		map.add(new Gradient(0, Color.Black));
		map.add(new Gradient(1, Color.White));
	}
}