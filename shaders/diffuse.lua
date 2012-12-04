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
  local pi, cos, sin, sqrt =  math.pi, math.cos, math.sin, math.sqrt
  local tau, abs = 2 * pi, math.abs
  local _BASE = (...):match('(.+%.)%w+%.%w+%.lua$')
  local Vec3 = require (_BASE .. ('core.vec3'))
  local Ray = require (_BASE .. ('core.ray'))
  local RESolver = require (_BASE .. ('core.RESolver'))
  
  return function (scene, ray, hitPoint, n, color, emColor, inclEmColor, depth)
    local nl = n:dot(ray.direction) < 0 and n or -n
    local r1, r2 = tau * rand(), rand()
    local r2s, w = sqrt(r2), nl
    local u = abs(w.x) > 0.1 and Vec3(0,1,0) or (Vec3(1,0,0)%w):norm()
    local v = (w%u)
    local d = (u * (cos(r1) * r2s) + v * (sin(r1) * r2s) + w * (sqrt(1-r2))):norm()
    local emColor = Vec3()
    
    for i = 1,#scene.primitives do
      local prim = scene.primitives[i]
      if not prim.emColor:isNought() then
        local sw = prim.position - hitPoint
        local su = abs(sw.x) > 0.1 and Vec3(0,1,0) or (Vec3(1,1,1)%sw):norm()
        local sv = (sw%su)
        
        local cos_a_max = sqrt(1 - (prim.radius * prim.radius) / 
            ((hitPoint - prim.position):dot(hitPoint - prim.position)))
        local eps1, eps2 = rand(), rand()
        local cos_a = 1 - eps1 + eps1 * cos_a_max
        local sin_a = sqrt(1 - cos_a * cos_a)
        local phi = tau * eps2
        local l = (su * (cos(phi) * sin_a) + sv * (sin(phi) * sin_a) + sw * (cos_a)):norm()
        
        local shadowRay = Ray(hitPoint, l)
        local hitDistance, hitPrim = scene:getNearestHitPrimitive(shadowRay)
        if hitPrim then
          local omega = tau * (1 - cos_a_max)      
          emColor = emColor + color:mul(prim.emColor * (l:dot(nl) * omega * invPi))
        end        
      end      
    end*
    
    local newRay = Ray(hitPoint, d)
    local newRadiance = RESolver(scene, newRay, depth, 0)
    return emColor * (inclEmColor or 1) + color:mul(newRadiance)
    
     
  end

end