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
  local max, rand = math.max, math.random
  local MAX_DEPTH = 5
  local Vec3 = require ((...):gsub('RESolver','vec3'))

  return function(scene, ray, depth, inclEmColor)
    local hitDistance, hitPrim = scene:getNearestHitPrimitive(ray)
    if not hitPrim then return Vec3() end
    local hitPoint = ray:pointAt(hitDistance)
    local hitNormal = (hitPoint - hitPrim.position):norm()
    local p = max(hitPrim.color.x, hitPrim.color.y, hitPrim.color.z)
    depth = depth + 1
    local fColor = hitPrim.color
    if depth > MAX_DEPTH then
      if rand() < p then fColor = hitPrim.color * (1/p)
      else return hitPrim.emission * (inclEmColor or 1)
      end
    end
    return scene.shaders[hitPrim.reflectionType](scene,
      ray, hitPoint, hitNormal,
      fColor, hitPrim.emission, inclEmColor,
      depth)
  end
end
