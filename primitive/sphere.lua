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
  local EPS = 1e-4

  local Sphere = {}
  Sphere.__index = Sphere

  function Sphere.new(sphere, position, radius, emission, color, reflectionType)
    return setmetatable({
      position = position,
      radius = radius, radiusSq = radius * radius,
      emission = emission, color = color,
      reflectionType = reflectionType or 'DIFF'
    },sphere)
  end

  function Sphere.hit(sphere, ray)
    local op = sphere.position - ray.origin
    local B = op:dot(ray.direction)
    local delta = (B*B) - op:dot(op) + sphere.radiusSq
    if delta < 0 then return false end
    delta = sqrt(delta)
    local t1, t2 = B - delta, B + delta
    return t1 > EPS and t1 or (t2 > EPS and t2 or false)
  end

  return setmetatable(Sphere,
    {__call= function(self,...)
        return Sphere:new(...)
      end
    })

end
