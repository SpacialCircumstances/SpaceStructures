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
		//Find lowest Gradient
		var low: Gradient;
		var d: Float = f;
		for(g in map)
		{
			if(g.value == f)
			{
				return g.color;
			}
			else
			{
				if(f - g.value =< d)
				{
					d = f - g.value;
					low = g;
				}
			}
		}
		return low.color;
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