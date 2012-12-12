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
  local _BASE = (...):match('(.*)scenes%.wada$')
  local Vec3 = require (_BASE .. ('core.vec3'))
  local Sphere = require (_BASE .. ('primitive.sphere'))
  local Scene = require (_BASE .. ('scene'))
  
  local cos, sin, pi = math.cos, math.sin, math.pi
  local R = 120
  local T = 30 * pi/180
  local D = R / cos(T)
  
  -- Needs validation, weird behaviour
  
  local theScene = Scene()
  theScene:addPrimitive(
     --                                     position, rad,        emission,                  color, reflTyp,
    Sphere(                         Vec3(50, 100, 0), 1e5, Vec3(1,1,1)*3e0,                 Vec3(), 'DIFF'), -- Sky
    Sphere(                    Vec3(50, -1e5-D-R, 0), 1e5,          Vec3(),         Vec3(.1,.1,.1), 'DIFF'), -- Ground
    Sphere(Vec3(50,40.8,62)+Vec3( cos(T),sin(T),0)*D,   R,          Vec3(),     Vec3(1,.3,.3)*.999, 'SPEC'), -- Rred
    Sphere(Vec3(50,40.8,62)+Vec3(-cos(T),sin(T),0)*D,   R,          Vec3(),     Vec3(.3,1,.3)*.999, 'SPEC'), -- Green
    Sphere(          Vec3(50,40.8,62)+Vec3(0,-1,0)*D,   R,          Vec3(),     Vec3(.3,.3,1)*.999, 'SPEC'), -- Blue
    Sphere(          Vec3(50,40.8,62)+Vec3(0,0,-1)*D,   R,          Vec3(), Vec3(.53,.53,.53)*.999, 'SPEC'), -- Back
    Sphere(           Vec3(50,40.8,62)+Vec3(0,0,1)*D,   R,          Vec3(),       Vec3(1,1,1)*.999, 'REFR')  -- Front
)
 
 return theScene     
end    