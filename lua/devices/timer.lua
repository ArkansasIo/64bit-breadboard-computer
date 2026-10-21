local Class = require('lua.class')

local Timer = Class.define('Timer')

function Timer:init()
    self.count = 0
    self.reload = 1000
    self.control = 0
    self.status = 0
end

function Timer:tick()
    if (self.control & 1) == 0 then return end
    self.count = self.count - 1
    if self.count <= 0 then
        self.count = self.reload
        self.status = self.status | 1
    end
end

function Timer:read8(offset)
    if offset == 0 then return self.count & 0xFF end
    if offset == 4 then return self.reload & 0xFF end
    if offset == 8 then return self.control end
    if offset == 12 then return self.status end
    return 0
end

function Timer:write8(offset, value)
    value = value & 0xFF
    if offset == 0 then self.count = value end
    if offset == 4 then self.reload = value end
    if offset == 8 then self.control = value end
    if offset == 12 then self.status = self.status & (~value) end
end

return Timer
