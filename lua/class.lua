local Class = {}

function Class.define(name, base)
    local cls = {}
    cls.__name = name
    cls.__index = cls
    cls.__base = base

    setmetatable(cls, {
        __index = base,
        __call = function(c, ...)
            local self = setmetatable({}, c)
            if self.init then
                self:init(...)
            end
            return self
        end,
    })

    function cls:is_a(other)
        local current = self
        while current do
            if current == other then return true end
            current = current.__base
        end
        return false
    end

    return cls
end

return Class
