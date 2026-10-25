local Class=require('lua.class')
local Memory=require('lua.micro8.memory')
local Bus=require('lua.micro8.bus')
local CPU=require('lua.micro8.cpu')
local Devices=require('lua.micro8.devices')
local Computer=Class.define('Micro8Computer')
function Computer:init()
 self.memory=Memory(0x10000); self.bus=Bus(); self.uart=Devices.UART(); self.gpio=Devices.GPIO(); self.timer=Devices.Timer()
 self.bus:map('UART',0xF000,0x100,self.uart); self.bus:map('GPIO',0xF100,0x100,self.gpio); self.bus:map('TIMER',0xF200,0x100,self.timer)
 self.cpu=CPU(self.memory,self.bus)
end
function Computer:load(bytes,base) self.memory:load(bytes,base or 0) end
function Computer:reset(entry) self.cpu:reset(entry or 0) end
function Computer:run(limit) return self.cpu:run(limit) end
return Computer
