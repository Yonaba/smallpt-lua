--[[
	Copyright (c) 2012 Roland Yonaba

	Permission is hereby granted, free of charge, to any person obtaining a
	copy of this software and associated documentation files (the
	"Software"), to deal in the Software without restriction, including
	without limitation the rights to use, copy, modify, merge, publish,
	distribute, sublicense, and/or sell copies of the Software, and to
	permit persons to whom the Software is furnished to do so, subject to
	the following conditions:

	The above copyright notice and this permission notice shall be included
	in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
	OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
	IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
	CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
	TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
	SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--]]

if (...) then
  local sqrt = math.sqrt

  return {
    -- Clamps a value.
    -- Assumes mininum and maximum bounds being respectively 0 and 1 when not given
    clamp = function(v, min, max)
      min, max = min or 0, max or 1
      return v < min and min or (v > max and max or v)
    end,

    -- Solves a quadratic equation: a * x^2 + b *x + c = 0
    solveQuadratic = function(a, b, c, EPS)
	  EPS = EPS or 0
      local delta = (b * b) - 4 * (a * c)
      if delta < 0 then return false end
      delta = sqrt(delta)
      local t1, t2 = (b - delta)/(2 * a), (b + delta)/(2 * a)
      return t1 > EPS and t1 or (t2 > EPS and t2 or false)
    end,
  }
end
