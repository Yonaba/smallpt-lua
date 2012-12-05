local Vec3 = require 'core.vec3'
local Sphere = require 'primitive.sphere'
local Scene = require 'scene'

local myScene = Scene()
myScene:addPrimitive(
   --                               position,  rad,        emission,                color, reflTyp,
   Sphere(Vec3(  1e5+1,      40.8,     81.6),  1e5,          Vec3(), Vec3(0.75,0.25,0.25), 'DIFF'), -- Left
   Sphere(Vec3(-1e5+99,      40.8,     81.6),  1e5,          Vec3(), Vec3(0.25,0.75,0.25), 'DIFF'), -- Rght
   Sphere(Vec3(     50,      40.8,      1e5),  1e5,          Vec3(), Vec3(0.75,0.75,0.75), 'DIFF'), -- Back
   Sphere(Vec3(     50,      40.8, -1e5+170),  1e5,          Vec3(),               Vec3(), 'DIFF'), -- Frnt
   Sphere(Vec3(     50,       1e5,     81.6),  1e5,          Vec3(), Vec3(0.75,0.75,0.75), 'DIFF'), -- Botm
   Sphere(Vec3(     50, -1e5+81.6,     81.6),  1e5,          Vec3(), Vec3(0.75,0.75,0.75), 'DIFF'), -- Top
   Sphere(Vec3(     27,      16.5,       47), 16.5,          Vec3(),  Vec3(1,1,1) * 0.999, 'SPEC'), -- Mirr
   Sphere(Vec3(     73,      16.5,       78), 16.5,          Vec3(),  Vec3(1,1,1) * 0.999, 'REFR'), -- Glas
   Sphere(Vec3(     90,      21.6,       15),  2.5, Vec3(4,4,4)*100,  Vec3(1,1,1) * 0.999, 'DIFF')  -- Lite
)

local w, h, samps = 200, 100, 1
local map2d = myScene:render(w, h, samps)
-- // Needs a gamma correction to be applied later on