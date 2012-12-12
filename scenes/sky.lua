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
  local _BASE = (...):match('(.*)scenes%.sky$')
  local Vec3 = require (_BASE .. ('core.vec3'))
  local Sphere = require (_BASE .. ('primitive.sphere'))
  local Scene = require (_BASE .. ('scene'))
  
  local Center = Vec3(50,40.8,-860)
  
  local theScene = Scene()
  theScene:addPrimitive(
     --                     position,    rad,                                        emission,                 color, reflTyp,
     Sphere(        Vec3(1,0,2)*3000,   1600,                      Vec3(1,.9,.8)*1.2e1*1.56*2,                Vec3(), 'DIFF'), -- Sun
     Sphere(        Vec3(1,0,2)*3500,   1560,                     Vec3(1,.5,.05)*4.8e1*1.56*2,                Vec3(), 'DIFF'), -- Horizon sun2
     Sphere(   Center+Vec3(0,0,-200),  10000, Vec3(0.00063842, 0.02001478, 0.28923243)*6e-2*8,     Vec3(.7,.7,1)*.25, 'DIFF'), -- Sky
     Sphere(    Vec3(50, -100000, 0), 100000,                                          Vec3(),        Vec3(.3,.3,.3), 'DIFF'), -- Ground
     Sphere(  Vec3(50, -110048.5, 0), 110000,                               Vec3(.9,.5,.05)*4,                Vec3(), 'DIFF'), -- Horizon brightener
     Sphere(Vec3(50, -4e4-30, -3000),    4e4,                                          Vec3(),        Vec3(.2,.2,.2), 'DIFF'), -- Mountains     
     Sphere(        Vec3(22,26.5,42),   26.5,                                          Vec3(),      Vec3(1,1,1)*.596, 'SPEC'), -- White Mirror
     Sphere(          Vec3(75,13,82),     13,                                          Vec3(), Vec3(.96,.96,.96)*.96, 'REFR'), -- Glass
     Sphere(          Vec3(87,22,24),     22,                                          Vec3(),   Vec3(.6,.6,.6)*.696, 'REFR')  -- Glass2

 )
 
 return theScene     
end    