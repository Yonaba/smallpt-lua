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
  local _BASE = (...):match('(.*)scenes%.overlap$')
  local Vec3 = require (_BASE .. ('core.vec3'))
  local Sphere = require (_BASE .. ('primitive.sphere'))
  local Scene = require (_BASE .. ('scene'))
  
   -- Needs validation, weird behaviour
   
  local theScene = Scene()
  theScene:addPrimitive(
     --             position, rad,         emission,             color, reflTyp,
    Sphere(Vec3(50+75,28,62), 150, Vec3(1,1,1)*0e-3, Vec3(1,.9,.8)*.93, 'REFR'),
    Sphere(Vec3(50+5,-28,62),  28,  Vec3(1,1,1)*1e1,     Vec3(1,1,1)*0, 'DIFF'),
    Sphere(   Vec3(50,28,62), 300, Vec3(1,1,1)*0e-3,   Vec3(1,1,1)*.93, 'SPEC')
 )
 
 return theScene     
end    