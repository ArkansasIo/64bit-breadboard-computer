local Class = require('lua.class')

local Device = Class.define('Device')
function Device:init(name, base)
    self.name = name
    self.base = base
end
function Device:describe()
    return string.format('%s @ 0x%08X', self.name, self.base)
end

local LedDevice = Class.define('LedDevice', Device)
function LedDevice:init(name, base, count)
    Device.init(self, name, base)
    self.count = count
    self.state = 0
end
function LedDevice:set(mask)
    self.state = mask & ((1 << self.count) - 1)
end
function LedDevice:describe()
    return Device.describe(self) .. string.format(' leds=%d state=0x%02X', self.count, self.state)
end

local board = LedDevice('FrontPanelLEDs', 0xF0001000, 8)
board:set(0xA5)
print(board:describe())
assert(board:is_a(LedDevice))
assert(board:is_a(Device))
