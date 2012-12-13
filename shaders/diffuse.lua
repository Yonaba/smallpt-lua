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
  local ROOT_PATH = (...):match('^(.*[%./])[^%.%/]+[%./][^%.%/]+$')  or ''
  local Vec3 = require (ROOT_PATH .. ('core.vec3'))
  local Ray = require (ROOT_PATH .. ('core.ray'))
  local radiance = require (ROOT_PATH .. ('core.radiance'))

  local cos, sin = math.cos, math.sin
  local sqrt, rand, abs = math.sqrt, math.random, math.abs
  local pi = math.pi; local tau, invPi = 2 * pi, 1/pi
  
  -- Evaluates an ideal diffuse reflection for a given ray on a surface point
  -- Passed-in emColor parameter will not be used here
  return function (scene, ray, hitPoint, n, color, emColor, inclEmColor, depth, MAX_DEPTH)
    -- Angle around and distance from center
    local nl = n:dot(ray.direction) < 0 and n or -(n)
    local r1, r2 = tau * rand(), rand(); local r2s = sqrt(r2)
    
    -- Creates an orthonormal reference
    local w = nl
    local u = ((abs(w.x) > 0.1 and Vec3(0,1,0) or Vec3(1,0,0)) %w):norm()
    local v = (w % u)
    local d = (u * (cos(r1) * r2s) + v * (sin(r1) * r2s) + w * (sqrt(1-r2))):norm()
    
    -- Sampling lighting
    -- Evaluates new emission looping on each primitive
    local emission = Vec3()
        
	  for i = 1,#scene.primitives do
      local prim = scene.primitives[i]
      -- Skipping non-lights primitives
      if not (prim.emission.x <= 0 and prim.emission.y <= 0 and prim.emission.z <= 0) then
        -- Setting a random direction towards primitive
        local sw = prim.position - hitPoint
        local su = ((abs(sw.x) > 0.1 and Vec3(0,1,0) or Vec3(1,1,1)) % sw):norm()
        local sv = (sw % su)
        local cos_a_max = sqrt(1 - (prim.radius * prim.radius) /
            ((hitPoint - prim.position):dot(hitPoint - prim.position)))
        local eps1, eps2 = rand(), rand()
        local cos_a = 1 - eps1 + eps1 * cos_a_max
        local sin_a = sqrt(1 - cos_a * cos_a)
        local phi = tau * eps2
        local l = (su * (cos(phi) * sin_a) + sv * (sin(phi) * sin_a) + sw * (cos_a)):norm()
        
        -- Fires a new shadow ray
        local shadowRay = Ray(hitPoint, l)
        local hitDistance, hitPrim = scene:getNearestHitPrimitive(shadowRay)
        if hitPrim and (hitPrim == prim) then
        local omega = tau * (1 - cos_a_max)
        emission = emission + 
          (color:mul(prim.emission * ((l:dot(nl)) * omega)) * invPi)
        end
      end
    end
    
    -- Computes new radiance at the next recursion depth
    -- Without considering the emissive term
    local newRay = Ray(hitPoint, d)    
    local newRadiance = radiance(scene, newRay, 0, depth, MAX_DEPTH)
    return emission * (inclEmColor or 0) + emission + color:mul(newRadiance)
  end
end
