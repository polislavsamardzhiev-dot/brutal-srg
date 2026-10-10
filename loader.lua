-- BrutalSRG private loader
local TOKEN  = "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"
local USER   = "polislavsamardzhiev-dot"
local REPO   = "brutal-srg"
local BRANCH = "main"
local FILE   = "keycheck.lua"

local url = string.format(
    "https://raw.githubusercontent.com/%s/%s/%s/%s?token=%s",
    USER, REPO, BRANCH, FILE, TOKEN
)

warn("[Loader] Fetching: " .. url:sub(1, 80) .. "...")

local ok, err = pcall(function()
    local src = game:HttpGet(url)
    if src:sub(1, 3) == "404" then error("keycheck.lua 404 — check URL/token") end
    warn("[Loader] Fetched, length: " .. #src)
    local fn = loadstring(src)
    if not fn then error("compile failed") end
    fn()
end)

if not ok then
    warn("[BrutalSRG] Load error: " .. tostring(err))
end
