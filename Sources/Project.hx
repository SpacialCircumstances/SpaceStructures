package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Color;
import kha.Image;
import kha.Scaler;

class Project 
{
	public static inline var screenWidth = 1200;
    public static inline var screenHeight = 900;

	private var backbuffer: Image;
	private var bg: Color;
	private var map: GradientMap;
	private var bgimg: Image;
	private var builder: LinearImageBuilder;
	public function new() 
	{
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		backbuffer = Image.createRenderTarget(screenWidth, screenHeight);
		map = new GradientMap();
		map.clearGradients();
		map.add(new Gradient(1, Color.Black));
		map.add(new Gradient(0, Color.Cyan));
		builder = new LinearImageBuilder();
		bgimg = builder.generateImage(map, 1200, 900);
		bg = Color.Black;
	}

	function update(): Void 
	{
		
	}

	function render(framebuffer: Framebuffer): Void
	{	
		var g = backbuffer.g2;

		g.begin(Color.Black);
		g.drawImage(bgimg, 0, 0);
	    g.end();

    	framebuffer.g2.begin();
    	Scaler.scale(backbuffer, framebuffer, System.screenRotation);
    	framebuffer.g2.end();
	}
}
