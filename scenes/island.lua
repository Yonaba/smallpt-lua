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
     --                     position,   rad,                       emission,                         color, reflTyp,
    Sphere(Center+Vec3(0, 600, -500),   160,                Vec3(1,1,1)*2e2,                        Vec3(), 'DIFF'), -- Sun
    Sphere(Center+Vec3(0,-880,-9120),   800,                Vec3(1,1,1)*2e1,                        Vec3(), 'DIFF'), -- Horizon
    Sphere(    Center+Vec3(0,0,-200), 10000, Vec3(0.0627, 0.188, 0.569)*1e0,                Vec3(1,1,1)*.4, 'DIFF'), -- Sky  
    Sphere( Center+Vec3(0,-720,-200),   800,                         Vec3(), Vec3(0.110, 0.898, 1.00)*.996, 'REFR'), -- Water
    Sphere( Center+Vec3(0,-720,-200),   790,                         Vec3(),            Vec3(.4,.3,.04)*.6, 'DIFF'), -- Earth
    Sphere(  Center+Vec3(0,-255,-50),   325,                         Vec3(),            Vec3(.4,.3,.04)*.8, 'DIFF'), -- Island
    Sphere(  Center+Vec3(0,-205,-33),   275,                         Vec3(),          Vec3(.02,.3,.02)*.75, 'DIFF')  -- Grass
 )
 
 return theScene     
end    