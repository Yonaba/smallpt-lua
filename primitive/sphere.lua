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
  local math_utils = require ((...):gsub('primitive%.sphere$','core.math'))

  local sqrt = math.sqrt
  local assert = assert

  local REFLTYPES = 'DIFF|SPEC|REFR'
  local function checkRefl(str)
    return str and not REFLTYPES:match(str):match('[^%a]')
  end

  local Sphere = {}
  Sphere.__index = Sphere

  -- Inits a new shpere primitive
  function Sphere:new(pos, rad, emission, color, reflType)
    assert(checkRefl(reflType),'Non valid Reflection type')
    return setmetatable({
      position = pos,
      radius = rad, radiusSq = rad * rad,
      emission = emission, color = color,
      reflectionType = reflType  -- Possible values: DIFF|SPEC|REFR
    },Sphere)
  end

  -- Tests if a ray hits a sphere
  -- Returns distance if hit, false otherwise
  function Sphere:hit(ray, eps)
    local o_p = self.position - ray.origin
    
    -- Let t a distance
    -- Ray vs Sphere intersection Equation a * t ^ 2 + b * t + c = 0
    local d = math_utils.solveQuadratic(
      1,  -- a : ray.d:dot(ray.d) = 1, because normalized
      (o_p):dot(ray.direction) * 2, -- b : 2 * (o_p):dot(ray.d)
      (o_p):dot(o_p) - self.radiusSq, -- c : (o_p):dot(o_p) - (self.rad ^ 2)
      eps --[[ eps acts as a small fudge factor]])
    
    return d 
  end

  return setmetatable(Sphere,
    {__call= function(self,...)
        return Sphere:new(...)
      end
    })

end
