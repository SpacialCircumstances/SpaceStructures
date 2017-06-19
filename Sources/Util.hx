package;

import kha.Color;

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
}