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
  local _BASE = (...):match('(.*)scenes%.wada2$')
  local Vec3 = require (_BASE .. ('core.vec3'))
  local Sphere = require (_BASE .. ('primitive.sphere'))
  local Scene = require (_BASE .. ('scene'))
  
  local cos, sin, pi = math.cos, math.sin, math.pi
  local sqrt = math.sqrt
  local R = 120
  local T = 30 * pi/180
  local D = R / cos(T)
  local Z = 62
  local C = Vec3(0.275, 0.612, 0.949)
  
  local theScene = Scene()
  theScene:addPrimitive(
     --                                       position,                                    rad,      emission,            color, reflTyp,
    Sphere(     Vec3(50,28,Z)+Vec3( cos(T),sin(T),0)*D,                                      R,        C*6e-2, Vec3(1,1,1)*.996, 'SPEC'), -- Red
    Sphere(     Vec3(50,28,Z)+Vec3(-cos(T),sin(T),0)*D,                                      R,        C*6e-2, Vec3(1,1,1)*.996, 'SPEC'), -- Green
    Sphere(               Vec3(50,28,Z)+Vec3(0,-1,0)*D,                                      R,        C*6e-2, Vec3(1,1,1)*.996, 'SPEC'), -- Blue
    Sphere( Vec3(50,28,Z)+Vec3(0,0,-1)*R*2*sqrt(2./3.),                                      R,        C*0e-2, Vec3(1,1,1)*.996, 'SPEC'), -- Back
    Sphere(Vec3(50,28,Z)+Vec3(0,0,-R*2*sqrt(2./3.)/3.), 2*2*R*2*sqrt(2./3.)-R*2*sqrt(2./3.)/3., Vec3(1,1,1)*0,   Vec3(1,1,1)*.5, 'SPEC')  -- Front
)
 
 return theScene     
end    