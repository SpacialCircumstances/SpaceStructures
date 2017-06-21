package;

import kha.Color;
import kha.math.Random;

class Util
{
	public static function mixColor(col1: Color, col2: Color, f: Float): Color
	{
		var c1a = col1.A * f;
		var c1r = col1.R * f;
		var c1g = col1.G * f;
		var c1b = col1.B * f;
		var f2 = 1 - f;
		var c2a = col2.A * f2;
		var c2r = col2.R * f2;
		var c2b = col2.G * f2;
		var c2g = col2.B * f2;
		var col: Color = Color.fromFloats(c1r + c2r, c1g + c2g, c1b + c2b, c1a + c2a);
		return col;
	}
	public static function randomColor(): Color
	{
		var r = Random.getIn(0, 255);
		var g = Random.getIn(0, 255);
		var b = Random.getIn(0, 255);
		var c = Color.fromBytes(r, g, b);
		return c;
	}

	public static function randomGrayscaleColor(?min = 0): Color
	{
		var n = Random.getIn(min, 255);
		var c = Color.fromBytes(n, n, n);
		return c;
	}

	public static function distance(x1: Float, y1: Float, x2: Float, y2: Float)
	{
		var u = (x1 - x2) * (x1 - x2);
		var v = (y1 - y2) * (y1 - y2);
		var d = Math.sqrt(u + v);
		return d;
	}
}