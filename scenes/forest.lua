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
  
  local cos, sin, pi = math.cos, math.sin, math.pi
  local tc = Vec3(0.0588, 0.361, 0.0941)
  local sc = Vec3(1,1,1)*.7
  
  local theScene = Scene()
  theScene:addPrimitive(
     --                                                          position,  rad,      emission,            color, reflTyp,
    Sphere(                                          Vec3(50, 1e5+130, 0),  1e5,  Vec3(1,1,1)*1.3,              Vec3(), 'DIFF'), -- Light
    Sphere(                                          Vec3(50, -1e2+2, 47),  1e2,           Vec3(),      Vec3(1,1,1)*.7, 'DIFF'), -- Ground
    Sphere( Vec3(50, -30, 300)+Vec3(-sin(50*pi/180),0,cos(50*pi/180))*1e4,  1e4,           Vec3(),     Vec3(1,1,1)*.99, 'SPEC'), -- Mirror L
    Sphere(  Vec3(50, -30, 300)+Vec3(sin(50*pi/180),0,cos(50*pi/180))*1e4,  1e4,           Vec3(),     Vec3(1,1,1)*.99, 'SPEC'), -- Mirror R
    Sphere(Vec3(50, -30, -50)+Vec3(-sin(30*pi/180),0,-cos(30*pi/180))*1e4,  1e4,           Vec3(),     Vec3(1,1,1)*.99, 'SPEC'), -- Mirror FL
    Sphere( Vec3(50, -30, -50)+Vec3(sin(30*pi/180),0,-cos(30*pi/180))*1e4,  1e4,           Vec3(),     Vec3(1,1,1)*.99, 'SPEC'), -- Mirror
    Sphere(                                              Vec3(50,6*.6,47),    4,           Vec3(), Vec3(.13,.066,.033), 'DIFF'), -- Tree
    Sphere(                                         Vec3(50,6*2+16*.6,47),   16,           Vec3(),                  tc, 'DIFF'), -- Tree
    Sphere(                                 Vec3(50,6*2+16*.6*2+11*.6,47),   11,           Vec3(),                  tc, 'DIFF'), -- Tree
    Sphere(                          Vec3(50,6*2+16*.6*2+11*.6*2+7*.6,47),    7,           Vec3(),                  tc, 'DIFF'), -- Tree
    Sphere(                                     Vec3(50,1.8+6*2+16*.6,47), 15.5,           Vec3(),                  sc, 'DIFF'), -- Tree
    Sphere(                             Vec3(50,1.8+6*2+16*.6*2+11*.6,47), 10.5,           Vec3(),                  sc, 'DIFF'), -- Tree
    Sphere(                      Vec3(50,1.8+6*2+16*.6*2+11*.6*2+7*.6,47),  6.5,           Vec3(),                  sc, 'DIFF')  -- Tree)
 )
 
 return theScene     
end    