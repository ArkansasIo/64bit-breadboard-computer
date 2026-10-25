local Class=require('lua.class')
local Device=Class.define('Micro8Device')
function Device:init() self.reg={} end
function Device:read8(a) return self.reg[a] or 0 end
function Device:write8(a,v) self.reg[a]=v&0xFF end

local UART=Class.define('Micro8UART',Device)
function UART:init() self.output='' end
function UART:read8(a) return 0 end
function UART:write8(a,v) if a==0 then self.output=self.output..string.char(v&0xFF) end end

local GPIO=Class.define('Micro8GPIO',Device)
function GPIO:init() self.value=0 end
function GPIO:read8(a) return self.value end
function GPIO:write8(a,v) self.value=v&0xFF end

local Timer=Class.define('Micro8Timer',Device)
function Timer:init() self.counter=0 end
function Timer:read8(a) return self.counter&0xFF end
function Timer:write8(a,v) self.counter=v&0xFF end

return {Device=Device,UART=UART,GPIO=GPIO,Timer=Timer}
