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
  
  local INFINITY = 1e20
  
  local Scene = {}
  Scene.__index = Scene
  
  function Scene.new(scene)
    return setmetatable({
      primitives = {},
      shaders = {}
    },scene)
  end
  
  function Scene.addPrimitive(scene, prim)
    scene.primitives[#scene.primitives+1] = prim
  end
  
  function Scene.getNearestHitPrimitive(scene, ray)
    local t = INFINITY
    local hitPrim
    for i = 1,#scene.primitives do
      local d = scene.primitives[i]:hit(ray)
      if d and d<t then
        t = d
        hitPrim = scene.primitives[i]
      end        
    end
    return t, hitPrim  
  end
  
  return setmetatable(Scene,
    {__call= function(self,...)
        return Scene:new(...)
      end
    })
  
end