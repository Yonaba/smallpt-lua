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
  local Sphere = require (ROOT_PATH .. ('primitive.sphere'))
  local Scene = require (ROOT_PATH .. ('scene'))
  
  local Center = Vec3(50,-20,-860)
  
  local theScene = Scene()
  theScene:addPrimitive(
     --                      position,  rad,                      emission,            color, reflTyp,
    Sphere( Center+Vec3(0,-8000,-900), 8000,            Vec3(1,.4,.1)*5e-1,           Vec3(), 'DIFF'), -- Sun
    Sphere(             Center+Vec3(),  1e4, Vec3(0.631, 0.753, 1.00)*3e-1,   Vec3(1,1,1)*.5, 'DIFF'), -- Sky
    Sphere( Center+Vec3(-350,0, -100),  150,                        Vec3(),   Vec3(1,1,1)*.3, 'DIFF'), -- Mountain
    Sphere(  Center+Vec3(-210,0,-100),  200,                        Vec3(),   Vec3(1,1,1)*.3, 'DIFF'), -- Mountain2
    Sphere( Center+Vec3(-210,85,-100),  145,                        Vec3(),   Vec3(1,1,1)*.8, 'DIFF'), -- Snow
    Sphere(   Center+Vec3(-50,0,-100),  150,                        Vec3(),   Vec3(1,1,1)*.3, 'DIFF'), -- Mountain3
    Sphere(   Center+Vec3(100,0,-100),  150,                        Vec3(),   Vec3(1,1,1)*.3, 'DIFF'), -- Mountain4
    Sphere(   Center+Vec3(250,0,-100),  125,                        Vec3(),   Vec3(1,1,1)*.3, 'DIFF'), -- Mountain5
    Sphere(   Center+Vec3(375,0,-100),  150,                        Vec3(),   Vec3(1,1,1)*.3, 'DIFF'), -- Mountain6
    Sphere( Center+Vec3(0,-2400,-500), 2500,                        Vec3(),   Vec3(1,1,1)*.1, 'DIFF'), -- Base
    Sphere(  Center+Vec3(0,-8000,200), 8000,                        Vec3(),    Vec3(.2,.2,1), 'REFR'), -- Mountain7
    Sphere( Center+Vec3(0,-8000,1100), 8000,                        Vec3(),     Vec3(0,.3,0), 'DIFF'), -- Grass
    Sphere( Center+Vec3(-75, -5, 850),    8,                        Vec3(),     Vec3(0,.3,0), 'DIFF'), -- Bush
    Sphere( Center+Vec3(0,   23, 825),   30,                        Vec3(), Vec3(1,1,1)*.996, 'REFR'), -- Ball
    Sphere( Center+Vec3(200,280,-400),   30,                        Vec3(),   Vec3(1,1,1)*.8, 'DIFF'), -- Clouds
    Sphere( Center+Vec3(237,280,-400),   37,                        Vec3(),   Vec3(1,1,1)*.8, 'DIFF'), -- Clouds2
    Sphere( Center+Vec3(267,280,-400),   28,                        Vec3(),   Vec3(1,1,1)*.8, 'DIFF'), -- clouds3
    Sphere(Center+Vec3(150,280,-1000),   40,                        Vec3(),   Vec3(1,1,1)*.8, 'DIFF'), -- clouds4
    Sphere(Center+Vec3(187,280,-1000),   37,                        Vec3(),   Vec3(1,1,1)*.8, 'DIFF'), -- clouds5
    Sphere( Center+Vec3(600,280,-1100),  40,                        Vec3(),   Vec3(1,1,1)*.8, 'DIFF'), -- clouds6
    Sphere( Center+Vec3(637,280,-1100),  37,                        Vec3(),   Vec3(1,1,1)*.8, 'DIFF'), -- clouds7
    Sphere(Center+Vec3(-800,280,-1400),  37,                        Vec3(),   Vec3(1,1,1)*.8, 'DIFF'), -- clouds8
    Sphere(   Center+Vec3(0,280,-1600),  37,                        Vec3(),   Vec3(1,1,1)*.8, 'DIFF'), -- clouds9
    Sphere( Center+Vec3(537,280,-1800),  37,                        Vec3(),   Vec3(1,1,1)*.8, 'DIFF')  -- clouds10
 
 )
 
 return theScene     
end    