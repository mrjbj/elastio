ya.on("ya::key", function(evt)
    ya.err("Key pressed: " .. ya.serialize(evt))
    return false
end)