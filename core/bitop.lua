--[[

  (c) 2008-2011 David Manura.  Licensed under the same terms as Lua (MIT).

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
  (end license)

--]]

--[[

    Note: This file is part of bit.numberlua - Bitwise operations
    implemented in pure Lua as numbers, by David Manura.
    I did not want to rely on a pure C library to achieve bitwise operations,
    so I basically ripped out from D. Manura's work the functions I needed.
    Though Lua 5.2 provides a bit32 interface, I kept this for backward
    compatibility with Lua 5.1. I will hopefully provide later adhoc code to switch
    to Lua's 5.2 bit32 library in case this is run from 5.2.

    Reference : http://github.com/davidm/lua-bit-numberlua
    Version: 0.3.1.20120131

--]]


local MOD = 2^32
local MODM = MOD-1

local function memoize(f)
  local mt = {}
  local t = setmetatable({}, mt)
  function mt:__index(k)
    local v = f(k); t[k] = v
    return v
  end
  return t
end

local function make_bitop_uncached(t, m)
  local function bitop(a, b)
    local res,p = 0,1
    while a ~= 0 and b ~= 0 do
      local am, bm = a%m, b%m
      res = res + t[am][bm]*p
      a = (a - am) / m
      b = (b - bm) / m
      p = p*m
    end
    res = res + (a+b)*p
    return res
  end
  return bitop
end


local function make_bitop(t)
  local op1 = make_bitop_uncached(t,2^1)
  local op2 = memoize(function(a)
    return memoize(function(b)
      return op1(a, b)
    end)
  end)
  return make_bitop_uncached(op2, 2^(t.n or 1))
end

local bxor = make_bitop {[0]={[0]=0,[1]=1},[1]={[0]=1,[1]=0}, n=4}

local function bnot(a)
  return MODM - a
end

local function band(a,b)
	return ((a+b) - bxor(a,b))/2
end

local function bor(a,b)
 return MODM - band(MODM - a, MODM - b)
end

local function bit_tobit(x)
  x = x % MOD
  if x >= 0x80000000 then x = x - MOD end
  return x
end

local function bit_bnot(x)
  return bit_tobit(bnot(x % MOD))
end

local function bit_bor(a,b,c,...)
  if c then
    return bit_bor(bit_bor(a, b), c, ...)
  elseif b then
    return bit_tobit(bor(a % MOD, b % MOD))
  else
    return bit_tobit(a)
  end
end

local function bit_band(a, b, c, ...)
  if c then
    return bit_band(bit_band(a, b), c, ...)
  elseif b then
    return bit_tobit(band(a % MOD, b % MOD))
  else
    return bit_tobit(a)
  end
end

-- NOTE : This is a custom added function
-- For multiple args support with bit_bnot()
local unpack  = unpack
local function bit_not(...)
  if arg and arg.n == 1 then return bit_bnot(arg[1]) end
  for i=1,arg.n do arg[i] = bit_bnot(arg[i]) end
  return bit_band(unpack(arg))
end

return {
	AND = bit_band,
	OR = bit_bor,
	NOT = bit_not,
}
