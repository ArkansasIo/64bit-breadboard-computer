local Class = require('lua.class')

local GPIO = Class.define('GPIO')

function GPIO:init()
    self.output = 0
    self.input = 0
    self.direction = 0
end

function GPIO:read8(offset)
    if offset == 0 then return self.output end
    if offset == 4 then return self.input end
    if offset == 8 then return self.direction end
    return 0
end

function GPIO:write8(offset, value)
    value = value & 0xFF
    if offset == 0 then self.output = value end
    if offset == 8 then self.direction = value end
end

return GPIO
