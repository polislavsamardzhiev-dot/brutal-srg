local TOKEN  = "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"
local USER   = "polislavsamardzhiev-dot"
local REPO   = "brutal-srg"
local BRANCH = "main"
local FILE   = "keycheck.lua"

local url = string.format(
    "https://raw.githubusercontent.com/%s/%s/%s/%s?token=%s",
    USER, REPO, BRANCH, FILE, TOKEN
)

local ok, err = pcall(function()
    local src = game:HttpGet(url)
    if src:sub(1, 3) == "404" then error("keycheck.lua not found — check URL/token") end
    local fn = loadstring(src)
    if not fn then error("compile failed") end
    fn()
end)

if not ok then
    warn("[BrutalSRG] Load error: " .. tostring(err))
end
