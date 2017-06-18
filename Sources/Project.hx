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
	public function new() 
	{
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		backbuffer = Image.createRenderTarget(screenWidth, screenHeight);
		bg = Color.Blue;
	}

	function update(): Void 
	{
		
	}

	function render(framebuffer: Framebuffer): Void
	{	
		var g = backbuffer.g2;

		g.begin(bg);
	    g.end();

    	framebuffer.g2.begin();
    	Scaler.scale(backbuffer, framebuffer, System.screenRotation);
    	framebuffer.g2.end();
	}
}
