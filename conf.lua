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

function love.conf(config)
  
  config.title = "PathTracing Demo (Lua Port of SmallPt from K. Beason)"
  config.author = "Roland_Yonaba"                                     
  config.url = "https://github.com/Yonaba/smallpt-lua"
	config.version = "0.8.0"

  config.screen.width = 800
  config.screen.height = 600

  config.modules.audio = false
  config.modules.sound = false

  config.modules.keyboard = true                          
  config.modules.mouse = true
  config.modules.joystick = false
	
  config.modules.image = true
  config.modules.graphics = true
  config.modules.timer = true
  config.modules.event = true
  config.modules.physics = false
  
end