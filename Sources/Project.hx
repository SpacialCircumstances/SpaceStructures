package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Color;
import kha.Image;
import kha.Scaler;
import kha.math.Random;

class Project 
{
	public static inline var screenWidth = 1200;
    public static inline var screenHeight = 900;

	private var backbuffer: Image;
	private var bg: Color;
	private var map: GradientMap;
	private var bgimg: Image;
	private var stars: Image;
	private var builder: LinearImageBuilder;
	public function new() 
	{
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		backbuffer = Image.createRenderTarget(screenWidth, screenHeight);
		bg = Color.Black;
		Random.init(12);
		createImage();
	}

	function update(): Void 
	{
		
	}

	function createImage(): Void
	{
		map = new GradientMap();
		map.clearGradients();
		map.add(new Gradient(1, Color.Black));
		map.add(new Gradient(0, Color.Cyan));
		builder = new LinearImageBuilder();
		bgimg = builder.generateImage(map, 1200, 900);
		stars = Image.createRenderTarget(1200, 900);
		var g2 = stars.g2;
		g2.begin(Color.Transparent);
		g2.color = Color.White;
		for(i in 0...50)
		{
			var x = Random.getFloatIn(0, 1200);
			var y = Random.getFloatIn(0, 400);
			g2.fillRect(x, y, 1, 1);
		}
		g2.end();
	}

	function render(framebuffer: Framebuffer): Void
	{	
		var g = backbuffer.g2;

		g.begin(Color.Black);
		g.drawImage(bgimg, 0, 0);
		g.drawImage(stars, 0, 0);
	    g.end();

    	framebuffer.g2.begin();
    	Scaler.scale(backbuffer, framebuffer, System.screenRotation);
    	framebuffer.g2.end();
	}
}
