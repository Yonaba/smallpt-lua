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
  local CORE_PATH = (...):match('^(.*[%./])[^%.%/]+$') or ''
  local math_utils = require (CORE_PATH .. 'math')
  
  local sqrt, max = math.sqrt, math.max  
  local clamp = math_utils.clamp

  local Vec3 = {x = 0, y = 0, z = 0}
  Vec3.__index = Vec3

  -- Inits a new vector
  function Vec3:new(x, y, z)
    return setmetatable({
      x = x or 0,
      y = y or 0,
      z = z or 0,
      },Vec3)
  end

  -- Tostrings vector
  function Vec3.__tostring(v)
    return ('Vec3: x: %.5f y:%.5f z: %.5f')
            :format(v.x, v.y, v.z)
  end

  -- Magnitude
  function Vec3:len()
    return sqrt(self.x * self.x 
              + self.y * self.y 
              + self.z * self.z)
  end

  -- Vector addition
  function Vec3.__add(a, b)
    return Vec3:new(a.x + b.x, a.y + b.y, a.z + b.z)
  end

  -- Vector substraction
  function Vec3.__sub(a, b)
    return Vec3:new(a.x - b.x, a.y - b.y, a.z - b.z)
  end

  -- Vector scaling
  function Vec3.__mul(v, f)
    return Vec3:new(v.x * f, v.y * f, v.z * f)
  end
  
  -- Vector component-to-component product
  function Vec3.mul(a, b)
    return Vec3:new(a.x * b.x, a.y * b.y, a.z * b.z)
  end

  -- Dot product
  function Vec3.dot(a, b)
    return (a.x * b.x + a.y * b.y + a.z * b.z)
  end

  -- Cross product
  function Vec3.__mod(a, b)
    return Vec3:new(
      a.y * b.z - a.z * b.y,
      a.z * b.x - a.x * b.z,
      a.x * b.y - a.y * b.x
    )
  end

  -- Unary
  function Vec3.__unm(a)
    return Vec3:new(-a.x, -a.y, -a.z)
  end

  -- Normalization
  function Vec3:norm()
    local l = 1/sqrt(self.x * self.x 
                   + self.y * self.y 
                   + self.z * self.z)
    self.x, self.y, self.z = self.x * l, self.y * l, self.z * l
    return self
  end

  -- Clamping
  function Vec3:clamp(mn, mx)
    return Vec3:new(clamp(self.x, mn, mx),
                    clamp(self.y, mn, mx), 
                    clamp(self.z, mx, mx))
  end

  return setmetatable(Vec3,
    {__call= function(self,...)
        return Vec3:new(...)
      end
    })

end
