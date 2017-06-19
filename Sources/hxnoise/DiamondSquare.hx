/*
Copyright (c) 2016 Kristian Brodal

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Taken from: https://github.com/whuop/hxNoise
*/
package hxnoise;

class DiamondSquare
{
	private var m_values : Array<Float>;
	private var m_width : Int;
	private var m_height : Int;
	private var m_featureSize : Int;
	private var m_scale : Float;
	private var m_randFunc : Void -> Float;

	public function new(width : Int, height : Int, featureSize : Int, scale : Float, randFunc : Void -> Float) : Void
	{
		m_width = width;
		m_height = height;
		m_featureSize = featureSize;
		m_scale = scale;
		m_randFunc = randFunc;
		m_values = new Array<Float>();

		var x = 0;
		var endX = m_width;
		var y = 0;
		var endY = m_height;

		while(x < endX)
		{
			while (y < endY)
			{
				setValue(x, y, randFunc());
				y += m_featureSize;
			}
			y = 0;
			x += m_featureSize;
		}
	}

	public function sampleSquare(x : Int, y : Int, size : Int, value : Float) : Void
	{
		var hs : Int = Math.floor(size / 2);

		var a = getValue(x - hs, y - hs);
		var b = getValue(x + hs, y - hs);
		var c = getValue(x - hs, y + hs);
		var d = getValue(x + hs, y + hs);

		setValue(x, y, ((a+b+c+d) / 4.0) + value);
	}

	public function sampleDiamond(x : Int, y : Int, size : Int, value : Float) : Void
	{
		var hs : Int = Math.floor(size / 2);

		var a = getValue(x - hs, y);
		var b = getValue(x + hs, y);
		var c = getValue(x, y - hs);
		var d = getValue(x, y + hs);

		setValue(x, y, ((a+b+c+d) / 4.0) + value);
	}

	public function diamondSquare() : Void
	{
		var stepSize : Int = m_featureSize;
		var scale : Float = m_scale;
		while(stepSize > 1)
        {
            var halfStep : Int = Math.floor(stepSize / 2.0);
			var endX = m_width + halfStep;
			var y = halfStep;
			var endY = m_height + halfStep;

			
			while(y < endY)
			{
				var x = halfStep;
				while(x < endX)
				{
					sampleSquare(x, y, stepSize, m_randFunc() * scale);
					x+=stepSize;
				}
				y+=stepSize;
			}

			endX = m_width;
			y = 0;
			endY = m_height;

			
			while(y < endY)
			{
				var x = 0;
				while(x < endX)
				{
					sampleDiamond(x + halfStep, y, stepSize, m_randFunc() * scale);
					x+=stepSize;
				}
				x = 0;
				y+=stepSize;
			}

			endX = m_width;
			y = 0;
			endY = m_height;

			while(y < endY)
			{
				var x = 0;
				while(x < endX)
				{
					sampleDiamond(x, y + halfStep, stepSize, m_randFunc() * scale);
					x+=stepSize;
				}
				y+=stepSize;
			}

            stepSize = Math.floor(stepSize / 2);
            scale /= 2.0;
        }
	}

	public function getValue(x : Int, y : Int) : Float
	{
		x = wrap(x, m_width);
		y = wrap(y, m_height);
        return m_values[x * m_width + y];
	}

	public function setValue(x : Int, y : Int, value : Float) : Void
	{
		x = wrap(x, m_width);
		y = wrap(y, m_height);
		m_values[x * m_width + y] = value;
	}

	private function wrap(v : Int, maxLength : Int) : Int
	{
		var wrapped = (maxLength - 1 + v) % (maxLength - 1);
        return wrapped;
	}
}