package;

import kha.Color;
import hxnoise.Perlin;

class NoiseImageBuilder
{
	public function new()
	{
		perlin = new Perlin();
	}
	var perlin: Perlin;
	public function getColor(x: Int, y: Int, seed: Float): Color
	{
		var v = perlin.OctavePerlin(x / 80, y / 80, seed, 6, 0.9, 0.3);
		return Color.fromFloats(v, v, v);
	}
}