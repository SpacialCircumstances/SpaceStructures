package;

import kha.Image;

class LinearImageBuilder
{
	public function new()
	{

	}
	public function generateImage(map: GradientMap, width: Int, height: Int): Image
	{
		var img = Image.createRenderTarget(width, height);
		var g2 = img.g2;
		g2.begin();
		for(i in 0...height)
		{
			g2.color = map.getColor(i / height);
			g2.drawLine(0, i, width, i);
		}
		g2.end();
		return img;
	}
}