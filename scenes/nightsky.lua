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
  
  local sqrt = math.sqrt
  
  local theScene = Scene()
  theScene:addPrimitive(
     --                           position,   rad,                       emission,                   color, reflTyp,
  Sphere(             Vec3(.82,.92,-2)*1e4, 2.5e3,               Vec3(1,1,1)*.8e2,                  Vec3(), 'DIFF'), -- Moon
  Sphere(                   Vec3(50, 0, 0), 2.5e4, Vec3(0.114, 0.133, 0.212)*1e-2, Vec3(.216,.384,1)*0.003, 'DIFF'), -- Sky
  Sphere(            Vec3(-.2,0.16,-1)*1e4,   5e0,   Vec3(1.00, 0.843, 0.698)*1e2,                  Vec3(), 'DIFF'), -- Star
  Sphere(            Vec3(0,  0.18,-1)*1e4,   5e0,   Vec3(1.00, 0.851, 0.710)*1e2,                  Vec3(), 'DIFF'), -- Star2
  Sphere(            Vec3(.3, 0.15,-1)*1e4,   5e0,   Vec3(0.671, 0.780, 1.00)*1e2,                  Vec3(), 'DIFF'), -- Star3
  Sphere(           Vec3(600,-3.5e4+1,300), 3.5e4,                         Vec3(),       Vec3(.6,.8,1)*.01, 'REFR'), -- Pool
  Sphere(             Vec3(-500,-5e4+0, 0),   5e4,                         Vec3(),         Vec3(1,1,1)*.35, 'DIFF'), -- Hill
  Sphere(                    Vec3(27,0,47),  16.5,                         Vec3(),         Vec3(1,1,1)*.33, 'DIFF'), -- Hut
  Sphere(Vec3(27+8*sqrt(2),0,47+8*sqrt(2)),     7,                         Vec3(),         Vec3(1,1,1)*.33, 'DIFF'), -- Door
  Sphere(             Vec3(-1e3,-300,-3e3),   500,                         Vec3(),        Vec3(1,1,1)*.351, 'DIFF'), -- Mount
  Sphere(                Vec3(0,-500,-3e3),   830,                         Vec3(),        Vec3(1,1,1)*.354, 'DIFF'), -- Mount2
  Sphere(              Vec3(1e3,-300,-3e3),   490,                         Vec3(),        Vec3(1,1,1)*.352, 'DIFF')  -- Mount3
)
 
 return theScene     
end    