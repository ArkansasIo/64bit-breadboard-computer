local Class = require('lua.class')
local Memory = Class.define('Micro8Memory')

function Memory:init(size)
    self.size = size or 0x10000
    self.data = {}
    for i = 0, self.size - 1 do self.data[i] = 0 end
end

function Memory:check(addr) assert(addr >= 0 and addr < self.size, 'address out of range') end
function Memory:read8(addr) self:check(addr); return self.data[addr] end
function Memory:write8(addr, value) self:check(addr); self.data[addr] = value & 0xFF end
function Memory:load(bytes, base)
    base = base or 0
    for i, value in ipairs(bytes) do self:write8(base + i - 1, value) end
end
return Memory
