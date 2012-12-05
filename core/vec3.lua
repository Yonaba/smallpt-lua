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

  local sqrt, max = math.sqrt, math.max

  local clamp = function(v, mn, mx)
    mn, mx = mn or 0, mx or 1
    return v < mn and mn or (v > mx and mx or v)
  end

  local Vec3 = {x = 0, y = 0, z = 0}
  Vec3.__index = Vec3
  
  function Vec3.new(v, x, y, z)
    return setmetatable({
      x = x or 0,
      y = y or 0,
      z = z or 0,
      },v)
  end

  function Vec3.__tostring(a)
    return ('Vec3: x: %.3f y:%.3f z: %.3f')
            :format(a.x, a.y, a.z)
  end

  function Vec3.len(a)
    return sqrt(a.x * a.x + a.y * a.y + a.z * a.z)
  end

  function Vec3.__add(a, b)
    return Vec3:new(a.x + b.x, a.y + b.y, a.z + b.z)
  end

  function Vec3.__sub(a, b)
    return Vec3:new(a.x - b.x, a.y - b.y, a.z - b.z)
  end

  function Vec3.__mul(v, f)
    return Vec3:new(v.x * f, v.y * f, v.z * f)
  end

  function Vec3.mul(a, b)
    return Vec3:new(a.x * b.x, a.y * b.y, a.z * b.z)
  end

  function Vec3.dot(a, b)
    return (a.x * b.x + a.y * b.y + a.z * b.z)
  end

  function Vec3.__mod(a, b)
    return Vec3:new(
      a.y * b.z - a.z * b.y,
      a.z * b.x - a.x * b.z,
      a.x * b.y - a.y * b.x
    )
  end
  
  function Vec3.__unm(a)
    return Vec3:new(-a.x, -a.y, -a.z)
  end

  function Vec3.norm(a)
    local l = 1/sqrt(a.x * a.x + a.y * a.y + a.z * a.z)
    a.x, a.y, a.z = a.x * l, a.y * l, a.z * l
    return a
  end

  function Vec3.clamp(a)
    return Vec3:new(clamp(a.x), clamp(a.y), clamp(a.z))
  end
  
  function Vec3.isNought(a)
    return (a.x <= 0 and a.y <= 0 and a.z <= 0)
  end

  return setmetatable(Vec3,
    {__call= function(self,...)
        return Vec3:new(...)
      end
    })

end
