local request = syn and syn.request or request

return setmetatable({}, {
    __index = function(self, Method)
        return function(Url, Args)
            local Data = {}
            Data.Url = Url
            Data.Method = string.upper(Method)

            for Index, Value in next, Args or {} do
                Data[string.upper(string.sub(Index, 1, 1)) .. string.lower(string.sub(Index, 2, -1))] = Value
            end

            return setmetatable(request(Data), {
                __tostring = function(self)
                    return self.Body
                end
            })
        end
    end
})
