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
  local sqrt, rand = math.sqrt, math.random
  local _BASE = (...):match('^[^%.]+%.')
  local Ray = require (_BASE .. ('core.ray'))
  local RESolver = require (_BASE .. ('core.RESolver'))
  
  return function (scene, ray, hitPoint, n, color, emColor, inclEmColor, depth)
    local nl = n:dot(ray.direction) < 0 and n or -n
    local reflRay = Ray(hitPoint, ray.direction * (2 * n:dot(ray.direction)))
    local isInside = n:dot(nl) > 0
    
    local nc, nt = 1, 1.5
    local nnt = isInside and nc/nt or nt/nc
    local ddn = ray.direction:dot(nl)
    local cos2t = 1 - nnt * nnt * (1 - ddn * ddn)
    
    if cos2t < 0 then
      local newRadiance = RESolver(scene, reflRay, depth)
      return emColor + color:mul(newRadiance)
    end
    
    local tdir = ((ray.direction * nnt) - 
      (n * ((isInside and 1 or -1) * (ddn * nnt + sqrt(cos2t))))):norm()
    
    local a, b = nt - nc, nt + nc
    local R0 = (a * a)/(b * b)
    local c = 1 - (isInside and -ddn or tdir:dot(n))
    local Re = R0 + (1 - R0) * c * c * c * c * c
    local Tr = 1 - Re
    local P = 0.25 + 0.5 * Re
    local RP = Re / P
    local TP = Tr / (1 - P)
    
    local newRadiance = depth > 2 and rand() < P 
      and (RESolver(reflRay, depth) * RP)
       or (RESolver(Ray(hitPoint, tdir), depth) * TP)
       or (RESolver(reflRay, depth) * Re + RESolver(Ray(hitPoint, tdir), depth) * Tr)
       
    return emColor + color:mul(newRadiance)    
  end

end