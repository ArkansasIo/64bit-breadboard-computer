local Class = require('lua.class')

local Memory = Class.define('Memory')

function Memory:init(size)
    assert(size > 0, 'memory size must be positive')
    self.size = size
    self.data = {}
    for i = 0, size - 1 do self.data[i] = 0 end
end

function Memory:check(addr, width)
    assert(addr >= 0 and addr + width <= self.size, string.format('memory access out of range: 0x%X', addr))
end

function Memory:read8(addr)
    self:check(addr, 1)
    return self.data[addr]
end

function Memory:write8(addr, value)
    self:check(addr, 1)
    self.data[addr] = value & 0xFF
end

function Memory:read64(addr)
    self:check(addr, 8)
    local value = 0
    for i = 0, 7 do value = value | (self.data[addr + i] << (i * 8)) end
    return value
end

function Memory:write64(addr, value)
    self:check(addr, 8)
    for i = 0, 7 do self.data[addr + i] = (value >> (i * 8)) & 0xFF end
end

return Memory
