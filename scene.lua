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
  local rand = math.random()
  local _BASE = (...):match('(.+)%w+%.lua$')) 
  local Vec3 = require (_BASE .. ('core.vec3'))
  local Ray = require (_BASE .. ('core.ray'))
  local RESolver = require (_BASE .. ('core.RESolver'))
  local INFINITY = 1e20
  
  local array2D = function (w, h)
    local map = {}
    for y = 1, h do map[y] = {}
      for i = 1, w do map[y][i] = Vec3() end
    end
    return map
  end
  
  local Scene = {}
  Scene.__index = Scene
  
  function Scene.new(scene)
    return setmetatable({
      primitives = {},
      shaders = {},
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
  
  function Scene.render(scene, w, h, samps)
    local cam = Ray(Vec3(50,52,295.6), Vec3(0,-0.042612,-1):norm())
    local cx = Vec3(w * 0.5135 / h)
    local cy = ((cx % (cam.direction)):norm()) * 0.5135
    local map = array2D(w,h)
    
    for y = 1, h do
      for x = 1, w do
        for sy = 0, 1 do
          for sx = 0, 1 do
            local r = Vec()
            for s = 1, samps do
              local r = Vec3()
              local r1 , r2 = 2 * rand(), 2 * rand()
              local dx = r1 < 1 and sqrt(r1) - 1 or 1 - sqrt(2 - r1)
              local dy = r2 < 1 and sqrt(r2) - 1 or 1 - sqrt(2 - r2)
              local d = cx * (((sx + 0.5 + dx) / 2 + x) / w - 0.5)
                     + cy * (((sy + 0.5 + dy) / 2 + y) / h - 0.5)
                     + cam.d
              
              local newRay = Ray(cam.origin + d * 140, d:norm())
              r = r + RESolver(scene, newRay, 0) * (1/samps)
            end
            map[y][x] = map[y][x] + r:clamp() * 0.25
          end        
      end
    end
  end
  
  return setmetatable(Scene,
    {__call= function(self,...)
        return Scene:new(...)
      end
    })
  
end