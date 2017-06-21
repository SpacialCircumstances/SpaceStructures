package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Color;
import kha.Image;
import kha.Scaler;
import kha.math.Random;
import kha.input.Mouse;
import hxnoise.Perlin;

class Project 
{
	public static inline var screenWidth = 1200;
    public static inline var screenHeight = 900;

	private var backbuffer: Image;
	private var bg: Color;
	private var map: GradientMap;
	private var bgimg: Image;
	private var stars: Image;
	private var landscape: Image;
	private var sky: Image;
	private var builder: LinearImageBuilder;
	private var skyColor: Color;
	public function new() 
	{
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		Mouse.get().notify(onMouseDown, null, null, null);
		backbuffer = Image.createRenderTarget(screenWidth, screenHeight);
		bg = Color.Black;
		Random.init(Std.random(20000));
		createImage();
	}

	function onMouseDown(x: Int, y: Int, z: Int)
	{
		createImage();
	}

	function update(): Void 
	{
		
	}

	function createImage(): Void
	{
		generateBackground();
		generateStars();
		generateMoons();
		generateLandscape();
	}

	function generateBackground()
	{
		map = new GradientMap();
		map.clearGradients();
		map.add(new Gradient(1, Color.Black));
		skyColor = Util.randomColor();
		map.add(new Gradient(0, skyColor));
		builder = new LinearImageBuilder();
		bgimg = builder.generateImage(map, 1200, 900);
	}

	function generateStars()
	{
		stars = Image.createRenderTarget(1200, 900);
		var g2 = stars.g2;
		g2.begin(Color.Transparent);
		for(i in 0...200)
		{
			g2.color = Util.randomGrayscaleColor(100);
			var x = Random.getFloatIn(0, 1200);
			var y = Random.getFloatIn(0, 600);
			g2.fillRect(x, y, 2, 2);
		}	
		g2.end();
	}

	function generateLandscape()
	{
		landscape = Image.createRenderTarget(1200, 900);
		var g2 = landscape.g2;
		g2.begin(Color.Transparent);
		var perlin = new Perlin();
		//Generate landscape color
		var col: Color = Util.randomColor();
		var mix = Random.getIn(50, 80) / 100;
		g2.color = Util.mixColor(Color.Black, col, mix);
		var seedy = Random.getIn(0, 12345);
		var seedz = Random.getIn(0, 12346);
		var val = Random.getIn(350, 450);
		var offset = Random.getIn(0, 100);
		var p: Float = Random.getIn(100, 230) / 100;
		var f: Float = Random.getIn(80, 180) / 100;
		for(i in 0...1200)
		{
			var v = perlin.OctavePerlin(i / 1200, seedy, seedz, 4, p, f) * val + offset;
			g2.drawLine(i, 900, i, 900 - v);
		}
		g2.end();
	}

	function generateMoons()
	{
		var m = Random.getIn(0, 5);
		sky = Image.createRenderTarget(1200, 900);
		var builder = new NoiseImageBuilder();
		var g2 = sky.g2;
		g2.begin(Color.Transparent);
		for(i in 0...m)
		{
			var xpos = Random.getIn(0, 1200);
			var ypos = Random.getIn(0, 400);
			var radius = Random.getIn(40, 80);
			g2.color = Color.Red;
			var seed = Random.getFloat();
			for(x in 0...1200)
			{
				for(y in 0...900)
				{
					var d = Util.distance(x, y, xpos, ypos);
					if(d <= radius)
					{
						var cn = builder.getColor(x, y, seed);
						var c1 = Util.mixColor(Color.Black, skyColor, (900 - y) / 900);
						g2.color = Util.mixColor(cn, c1, f(d, 1 / (1.4 * radius)));
						g2.fillRect(x, y, 1, 1);
					}
				}
			}
		}
		g2.end();
	}

	function f(d: Float, factor: Float)
	{
		var s = 0.12;
		var a = 1;
		var result = s + a * Math.exp(-factor * d);
		return result;
	}

	function render(framebuffer: Framebuffer): Void
	{	
		var g = backbuffer.g2;

		g.begin(Color.Black);
		g.drawImage(bgimg, 0, 0);
		g.drawImage(stars, 0, 0);
		g.drawImage(sky, 0, 0);
		g.drawImage(landscape, 0, 0);
	    g.end();

    	framebuffer.g2.begin();
    	Scaler.scale(backbuffer, framebuffer, System.screenRotation);
    	framebuffer.g2.end();
	}

}
