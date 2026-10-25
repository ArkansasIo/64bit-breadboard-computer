local Class = require('lua.class')
local Bus = Class.define('Micro8Bus')
function Bus:init() self.devices={} end
function Bus:map(name,base,size,device) self.devices[name]={base=base,size=size,device=device} end
function Bus:find(addr) for _,m in pairs(self.devices) do if addr>=m.base and addr<m.base+m.size then return m,addr-m.base end end; error(string.format('unmapped MMIO %04X',addr)) end
function Bus:read8(addr) local m,o=self:find(addr); return m.device:read8(o) end
function Bus:write8(addr,v) local m,o=self:find(addr); m.device:write8(o,v) end
return Bus
