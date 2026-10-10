-- BrutalSRG loader (public repo — no token needed)
local USER   = "polislavsamardzhiev-dot"
local REPO   = "brutal-srg"
local BRANCH = "main"
local FILE   = "keycheck.lua"

local url = "https://raw.githubusercontent.com/" .. USER .. "/" .. REPO .. "/" .. BRANCH .. "/" .. FILE .. "?v=" .. tostring(os.time())

warn("[Loader] Fetching: " .. url)

local ok, err = pcall(function()
    local src = game:HttpGet(url)
    if src:sub(1, 3) == "404" then error("keycheck.lua 404") end
    warn("[Loader] Fetched, length: " .. #src)
    local fn = loadstring(src)
    if not fn then error("compile failed") end
    fn()
end)

if not ok then
    warn("[BrutalSRG] Load error: " .. tostring(err))
end
