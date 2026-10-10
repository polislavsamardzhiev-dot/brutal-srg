-- ============================================================
-- BrutalSRG Key System
-- ============================================================

local MAIN_URL = "https://raw.githubusercontent.com/YOUR_USERNAME/brutal-srg/main/main.lua"

-- Change this to whatever keys you want to accept:
local VALID_KEYS = {
    ["BRUTAL-TEST-2025"] = true,
    ["MY-SECOND-KEY"]    = true,
}

-- ============================================================
-- UI
-- ============================================================
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "BrutalKeySystem"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local parented = false
pcall(function() gui.Parent = game:GetService("CoreGui"); parented = true end)
if not parented then
    gui.Parent = LP:WaitForChild("PlayerGui")
end

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(400, 220)
frame.Position = UDim2.fromScale(0.5, 0.5)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
frame.BorderSizePixel = 0
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(200, 0, 0)
stroke.Thickness = 2
stroke.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 44)
title.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
title.BorderSizePixel = 0
title.Text = "BRUTAL SRG — KEY SYSTEM"
title.TextColor3 = Color3.fromRGB(255, 60, 60)
title.Font = Enum.Font.GothamBlack
title.TextSize = 16
title.Parent = frame
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

local box = Instance.new("TextBox")
box.Size = UDim2.new(1, -40, 0, 40)
box.Position = UDim2.fromOffset(20, 70)
box.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = "Enter your key..."
box.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
box.Font = Enum.Font.Gotham
box.TextSize = 13
box.ClearTextOnFocus = false
box.Text = ""
box.Parent = frame
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -40, 0, 22)
status.Position = UDim2.fromOffset(20, 116)
status.BackgroundTransparency = 1
status.Text = ""
status.TextColor3 = Color3.fromRGB(255, 120, 120)
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = frame

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, -40, 0, 42)
btn.Position = UDim2.fromOffset(20, 148)
btn.BackgroundColor3 = Color3.fromRGB(140, 0, 0)
btn.Text = "SUBMIT"
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 14
btn.Parent = frame
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

-- ============================================================
-- VALIDATION + LOAD
-- ============================================================
local function loadMain()
    local ok, err = pcall(function()
        local src = game:HttpGet(MAIN_URL)
        local fn = loadstring(src)
        if not fn then error("Failed to compile main script") end
        fn()
    end)
    if not ok then
        warn("[BrutalSRG] Main script error: " .. tostring(err))
        status.Text = "✖ Load failed (check console)"
        status.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end

btn.MouseButton1Click:Connect(function()
    local key = box.Text
    if VALID_KEYS[key] then
        status.Text = "✔ Key valid! Loading..."
        status.TextColor3 = Color3.fromRGB(0, 255, 100)
        task.wait(0.6)
        gui:Destroy()
        loadMain()
    else
        status.Text = "✖ Invalid key"
        status.TextColor3 = Color3.fromRGB(255, 80, 80)
        box.Text = ""
    end
end)

-- Allow Enter key to submit
box.FocusLost:Connect(function(enter)
    if enter then btn:Activate() end
end)
