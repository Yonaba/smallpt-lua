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
  local _BASE = (...):match('(.*)scenes%.cornellbox$')
  local Vec3 = require (_BASE .. ('core.vec3'))
  local Sphere = require (_BASE .. ('primitive.sphere'))
  local Scene = require (_BASE .. ('scene'))
  
  local theScene = Scene()
  theScene:addPrimitive(
     --                               position,  rad,        emission,                color, reflTyp,
     Sphere(Vec3(  1e5+1,      40.8,     81.6),  1e5,          Vec3(), Vec3(0.75,0.25,0.25), 'DIFF'), -- Left
     Sphere(Vec3(-1e5+99,      40.8,     81.6),  1e5,          Vec3(), Vec3(0.25,0.75,0.25), 'DIFF'), -- Right
     Sphere(Vec3(     50,      40.8,      1e5),  1e5,          Vec3(), Vec3(0.75,0.75,0.75), 'DIFF'), -- Back
     Sphere(Vec3(     50,      40.8, -1e5+170),  1e5,          Vec3(),               Vec3(), 'DIFF'), -- Front
     Sphere(Vec3(     50,       1e5,     81.6),  1e5,          Vec3(), Vec3(0.75,0.75,0.75), 'DIFF'), -- Bottom
     Sphere(Vec3(     50, -1e5+81.6,     81.6),  1e5,          Vec3(), Vec3(0.75,0.75,0.75), 'DIFF'), -- Top
     Sphere(Vec3(     27,      16.5,       47), 16.5,          Vec3(),  Vec3(1,1,1) * 0.999, 'DIFF'), -- Mirror
     Sphere(Vec3(     73,      16.5,       78), 16.5,          Vec3(),  Vec3(1,1,1) * 0.999, 'DIFF'), -- Glass
     Sphere(Vec3(     50,      65.1,     81.6),  1.5, Vec3(4,4,4)*100,               Vec3(), 'DIFF')  -- Light
 )
 
 return theScene     
end    