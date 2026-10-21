local Class = require('lua.class')
local Memory = require('lua.core.memory')
local Bus = require('lua.core.bus')
local CPU = require('lua.core.cpu')
local UART = require('lua.devices.uart')
local GPIO = require('lua.devices.gpio')
local Timer = require('lua.devices.timer')

local Computer = Class.define('Computer')

function Computer:init(ram_size)
    self.memory = Memory(ram_size or 1024 * 1024)
    self.bus = Bus()
    self.uart = UART()
    self.gpio = GPIO()
    self.timer = Timer()
    self.bus:map('uart', 0xF0000000, 0x1000, self.uart)
    self.bus:map('gpio', 0xF0001000, 0x1000, self.gpio)
    self.bus:map('timer', 0xF0002000, 0x1000, self.timer)
    self.cpu = CPU(self.memory, self.bus)
end

function Computer:reset(entry)
    self.cpu:reset(entry)
end

function Computer:tick()
    if not self.cpu.halted then self.cpu:step() end
    self.timer:tick()
end

return Computer
