-- BrutalSRG loader stub
local KEYCHECK_URL = "https://raw.githubusercontent.com/YOUR_USERNAME/brutal-srg/main/keycheck.lua"

local ok, err = pcall(function()
    local src = game:HttpGet(KEYCHECK_URL)
    local fn = loadstring(src)
    if not fn then error("Failed to compile keycheck") end
    fn()
end)

if not ok then
    warn("[BrutalSRG] Loader error: " .. tostring(err))
end
