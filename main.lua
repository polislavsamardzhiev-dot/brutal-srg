-- BrutalSRGroblox - Custom Rig + Rage + Movement + Fly + Anti-Aim + Pitch + TP + Currency
-- Works on: Solara, Xeno, Krnl, Fluxus, Delta, Codex, Wave

-- ============================================================
-- CLEANUP
-- ============================================================
if getgenv and getgenv().BrutalSRGCleanup then
    pcall(getgenv().BrutalSRGCleanup)
end

-- ============================================================
-- SERVICES
-- ============================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local LP = Players.LocalPlayer
local Cam = workspace.CurrentCamera

local VIM
pcall(function() VIM = game:GetService("VirtualInputManager") end)

local EXECUTOR_NAME = "Unknown"
if typeof(identifyexecutor) == "function" then
    pcall(function() EXECUTOR_NAME = identifyexecutor() end)
end

-- ============================================================
-- GAME STRUCTURE
-- ============================================================
local GameStructure = {
    CharacterFolderName = "Characters",
    HealthAttr = "Health",
    MaxHealthAttr = "MaxHealth",
    DeadAttr = "Dead",
    PlayerTeamAttr = "Team",
    PlayerDeadAttr = "Dead",
    HeadName = "Head",
    RootName = "HumanoidRootPart",
    Colors = {
        [ "Terrorists" ] = Color3.fromRGB(255, 80, 40),
        [ "Counter-Terrorists" ] = Color3.fromRGB(60, 140, 255),
        [ "Unknown" ] = Color3.fromRGB(200, 200, 200),
    },
}

-- ============================================================
-- SETTINGS
-- ============================================================
local S = {
    BoxESP = false, SkeletonESP = false, Chams = false,
    UseTeamColors = true,
    BoxColor = Color3.fromRGB(255, 30, 30),
    SkeletonColor = Color3.fromRGB(255, 60, 60),
    ChamsColor = Color3.fromRGB(200, 0, 0),
    ChamsFillTransparency = 0.45,

    Aimbot = false, AutoShoot = false, FOVVisual = false, FOV = 100,
    AimSmoothing = 0.25, AimMaxDelta = 15,

    HitboxHead = true, HitboxTorso = true, HitboxLegs = false,

    Bhop = false, BhopSpeedBoost = false, BhopSpeed = 32,

    NoClip = false,
    SpeedHack = false,
    SpeedValue = 50,
    JumpPowerHack = false,
    JumpPowerValue = 100,

    Fly = false,
    FlySpeed = 50,

    AntiAim = false,
    AASpinBody = false,
    AASpinHead = false,
    AAJitter = false,
    AASpinSpeed = 30,
    AAHeadPitch = 0,
    AAHeadRoll = 0,
    AAPitchMode = "Off",
    AAPitchAngle = 89,
    AAPitchFlipSpeed = 0.05,

    ThirdPerson = false,
    ThirdPersonDistance = 12,
    ThirdPersonOffset = Vector3.new(0, 2, 0),
    ThirdPersonHideArms = true,
    ThirdPersonMinDistance = 2,
    ThirdPersonWallCheck = true,
    ThirdPersonSmooth = false,
    ThirdPersonSmoothSpeed = 0.15,

    RageAimbot = false, RageHitbox = "Head", RageFOV = 180,
    RageAutoShoot = true, RageWallCheck = true, RageShootDelay = 0.1,
    RageMaxDistance = 500, RageFireAngle = 3,
    RagePrediction = 0.03,
    RageLockFrames = 2,
    RageAdaptiveLead = true,

    SilentAim = false,
    SilentAimFOV = 360,
    SilentAimHitbox = "Head",
    SilentAimAngleThreshold = 5,
    SilentAimSettle = 0.03,

    IgnoreTeammates = true,

    Tracers = false,
    TracerColor = Color3.fromRGB(255, 60, 60),
    TracerLifetime = 6,
    TracerThickness = 2,

    CurrencyAutoFire = false,
    CurrencyFireRate = 20,
    CurrencyArgs = "",
    CurrencyTargetPath = "",

    UIScale = 100,
}

local Binds = {
    MenuToggle = Enum.KeyCode.Insert,
    BoxESP = nil, SkeletonESP = nil, Chams = nil,
    Aimbot = nil, AutoShoot = nil, FOVVisual = nil,
    HitboxHead = nil, HitboxTorso = nil, HitboxLegs = nil,
    Bhop = nil, BhopSpeedBoost = nil,
    ThirdPerson = nil, RageAimbot = nil, IgnoreTeammates = nil,
    Tracers = nil, SilentAim = nil,
    NoClip = nil, SpeedHack = nil, JumpPowerHack = nil,
    Fly = nil,
    AntiAim = nil, AASpinBody = nil, AASpinHead = nil, AAJitter = nil,
    ThirdPersonWallCheck = nil, ThirdPersonSmooth = nil,
    CurrencyAutoFire = nil,
}

-- ============================================================
-- THEME (modern red/black)
-- ============================================================
local Theme = {
    Bg           = Color3.fromRGB(17, 17, 20),
    BgDeep       = Color3.fromRGB(12, 12, 15),
    SidePanel    = Color3.fromRGB(20, 20, 24),
    CardBg       = Color3.fromRGB(25, 25, 30),
    CardBgHover  = Color3.fromRGB(32, 32, 38),
    RowBg        = Color3.fromRGB(28, 28, 33),
    RowBgHover   = Color3.fromRGB(38, 38, 44),
    Border       = Color3.fromRGB(44, 44, 50),
    BorderSoft   = Color3.fromRGB(58, 58, 66),
    BorderHot    = Color3.fromRGB(120, 30, 35),
    Text         = Color3.fromRGB(220, 220, 228),
    TextDim      = Color3.fromRGB(140, 140, 150),
    TextBright   = Color3.fromRGB(255, 255, 255),
    Accent       = Color3.fromRGB(225, 45, 55),
    AccentBright = Color3.fromRGB(255, 75, 85),
    AccentDim    = Color3.fromRGB(120, 25, 32),
    AccentDeep   = Color3.fromRGB(60, 12, 16),
    On           = Color3.fromRGB(255, 70, 80),
    Off          = Color3.fromRGB(90, 45, 50),
    Ok           = Color3.fromRGB(85, 200, 120),
    Warn         = Color3.fromRGB(240, 185, 55),
    Font         = Enum.Font.GothamMedium,
    FontBold     = Enum.Font.GothamBold,
    FontSemi     = Enum.Font.GothamSemibold,
}

-- ============================================================
-- CONFIG SYSTEM
-- ============================================================
local Configs = {}
local SelectedConfig = nil
local ConfigUI = {}
local UIWidgets = {}

local HAS_FILE_IO = (typeof(writefile) == "function"
    and typeof(readfile) == "function"
    and typeof(isfile) == "function")

local CONFIG_FILE = "BrutalSRG_configs.json"

local function serializeTable(t, indent)
    indent = indent or ""
    local parts = {}
    for k, v in pairs(t) do
        local key = (type(k) == "string") and string.format("%q", k) or tostring(k)
        local val
        local vt = typeof(v)
        if vt == "Color3" then val = string.format("Color3.new(%f,%f,%f)", v.R, v.G, v.B)
        elseif vt == "Vector3" then val = string.format("Vector3.new(%f,%f,%f)", v.X, v.Y, v.Z)
        elseif vt == "Vector2" then val = string.format("Vector2.new(%f,%f)", v.X, v.Y)
        elseif vt == "EnumItem" then val = string.format("Enum.%s.%s", tostring(v.EnumType), v.Name)
        elseif vt == "boolean" or vt == "number" then val = tostring(v)
        elseif vt == "string" then val = string.format("%q", v)
        elseif vt == "table" then val = serializeTable(v, indent .. "  ")
        else val = "nil" end
        table.insert(parts, indent .. "  [" .. key .. "] = " .. val)
    end
    return "{\n" .. table.concat(parts, ",\n") .. "\n" .. indent .. "}"
end

local function deserializeTable(str)
    if typeof(loadstring) ~= "function" then return nil end
    local fn = loadstring("return " .. str)
    if not fn then return nil end
    local ok, result = pcall(fn)
    if ok and type(result) == "table" then return result end
    return nil
end

local function saveConfigsToDisk()
    if not HAS_FILE_IO then return end
    pcall(function() writefile(CONFIG_FILE, serializeTable(Configs)) end)
end

local function loadConfigsFromDisk()
    if not HAS_FILE_IO then return end
    if not isfile(CONFIG_FILE) then return end
    pcall(function()
        local data = readfile(CONFIG_FILE)
        if data and data ~= "" then
            local result = deserializeTable(data)
            if result then Configs = result end
        end
    end)
end

local function snapshotSettings()
    local snap = {}
    for k, v in pairs(S) do snap[k] = v end
    return snap
end

local function applySettings(snap)
    for k, v in pairs(snap) do
        if S[k] ~= nil then S[k] = v end
    end
end

local function createConfig(name)
    if not name or name == "" or Configs[name] then return end
    Configs[name] = { settings = snapshotSettings(), binds = {} }
    for k, v in pairs(Binds) do Configs[name].binds[k] = v end
    saveConfigsToDisk()
end

local function saveCurrentToConfig(name)
    if not Configs[name] then createConfig(name) end
    Configs[name].settings = snapshotSettings()
    Configs[name].binds = {}
    for k, v in pairs(Binds) do Configs[name].binds[k] = v end
    saveConfigsToDisk()
end

local function loadConfig(name)
    local cfg = Configs[name]
    if not cfg then return end
    applySettings(cfg.settings)
    for k, v in pairs(cfg.binds or {}) do
        if Binds[k] ~= nil or k == "MenuToggle" then Binds[k] = v end
    end
    saveConfigsToDisk()
end

local function deleteConfig(name)
    Configs[name] = nil
    saveConfigsToDisk()
end

loadConfigsFromDisk()

-- ============================================================
-- CUSTOM RIG HELPERS
-- ============================================================
local function getCharacter(plr)
    if not plr then return nil end
    local charsFolder = workspace:FindFirstChild(GameStructure.CharacterFolderName)
    if charsFolder then
        local m = charsFolder:FindFirstChild(plr.Name)
        if m and m:IsA("Model") then return m end
    end
    if plr.Character then return plr.Character end
    return nil
end

local function getHealth(model)
    if not model then return 0 end
    local h = model:GetAttribute(GameStructure.HealthAttr)
    if typeof(h) == "number" then return h end
    local hum = model:FindFirstChildOfClass("Humanoid")
    if hum then return hum.Health end
    return 0
end

local function getMaxHealth(model)
    if not model then return 100 end
    local h = model:GetAttribute(GameStructure.MaxHealthAttr)
    if typeof(h) == "number" then return h end
    local hum = model:FindFirstChildOfClass("Humanoid")
    if hum then return hum.MaxHealth end
    return 100
end

local function isDead(model, plr)
    if not model then return true end
    local deadAttr = model:GetAttribute(GameStructure.DeadAttr)
    if deadAttr == true then return true end
    if plr then
        local pDead = plr:GetAttribute(GameStructure.PlayerDeadAttr)
        if pDead == true then return true end
    end
    if getHealth(model) <= 0 then return true end
    return false
end

local function getTeam(plr)
    if not plr then return nil end
    local t = plr:GetAttribute(GameStructure.PlayerTeamAttr)
    if typeof(t) == "string" then return t end
    if plr.Team then return plr.Team.Name end
    return nil
end

local function getTeamColor(plr)
    local t = getTeam(plr)
    if t and GameStructure.Colors[t] then return GameStructure.Colors[t] end
    return GameStructure.Colors["Unknown"]
end

local function isSameTeam(plr)
    local myTeam = getTeam(LP)
    local theirTeam = getTeam(plr)
    if not myTeam or not theirTeam then return false end
    return myTeam == theirTeam
end

local function isValidCharacter(model, plr)
    if not model or not model:IsA("Model") then return false end
    if model == getCharacter(LP) then return false end
    if not model.Parent then return false end
    if isDead(model, plr) then return false end
    if not (model:FindFirstChild(GameStructure.HeadName) or model:FindFirstChild(GameStructure.RootName)) then
        return false
    end
    if S.IgnoreTeammates and plr and isSameTeam(plr) then return false end
    return true
end

-- ============================================================
-- INSPECTOR
-- ============================================================
local function inspectAllPlayers()
    print("========================================")
    print("=== CUSTOM RIG INSPECTOR ===")
    print("Local Player:", LP.Name)
    print("My Team:", tostring(getTeam(LP)))
    print("Executor:", EXECUTOR_NAME)
    local charsFolder = workspace:FindFirstChild(GameStructure.CharacterFolderName)
    if charsFolder then
        print("Children count:", #charsFolder:GetChildren())
        for _, child in ipairs(charsFolder:GetChildren()) do
            print("  -", child.Name, "(" .. child.ClassName .. ")")
        end
    end
    for _, p in ipairs(Players:GetPlayers()) do
        print("----------------------------------------")
        print("PLAYER:", p.Name, "| Team:", tostring(getTeam(p)))
        local char = getCharacter(p)
        if char then
            print("  Model:", char:GetFullName())
            print("  Health:", getHealth(char))
            print("  Dead:", tostring(isDead(char, p)))
        else
            print("  [No character]")
        end
    end
    print("========================================")
end

if getgenv then getgenv().InspectPlayers = inspectAllPlayers end

-- ============================================================
-- GUI
-- ============================================================
local gui = Instance.new("ScreenGui")
gui.Name = "BrutalSRGroblox"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999999

local function tryParent(target)
    if not target then return false end
    local ok = pcall(function() gui.Parent = target end)
    if not ok then return false end
    task.wait(0.05)
    return gui.Parent == target
end

local parented = false
local parentName = "NONE"
do
    local ok, cg = pcall(function() return game:GetService("CoreGui") end)
    if ok and cg and tryParent(cg) then parented = true; parentName = "CoreGui" end
end
if not parented then
    local pg = LP:FindFirstChild("PlayerGui") or LP:WaitForChild("PlayerGui", 5)
    if pg and tryParent(pg) then parented = true; parentName = "PlayerGui" end
end
if not parented and typeof(gethui) == "function" then
    local ok, hui = pcall(gethui)
    if ok and hui and tryParent(hui) then parented = true; parentName = "gethui" end
end
if not parented then warn("[BrutalSRG] Could not parent GUI!") return end

print("[BrutalSRG] GUI parented to:", parentName)

local function makeDraggable(f, bar)
    local drag, dIn, start, sPos
    bar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
            or i.UserInputType == Enum.UserInputType.Touch then
            drag = true; start = i.Position; sPos = f.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then drag = false end
            end)
        end
    end)
    bar.InputChanged:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement
            or i.UserInputType == Enum.UserInputType.Touch then dIn = i end
    end)
    UIS.InputChanged:Connect(function(i)
        if drag and i == dIn then
            local d = i.Position - start
            f.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + d.X, sPos.Y.Scale, sPos.Y.Offset + d.Y)
        end
    end)
end

local function corner(inst, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = inst
    return c
end

local function stroke(parent, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color or Theme.Border
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = parent
    return s
end

local function softShadow(parent, transparency, size)
    local f = Instance.new("Frame")
    f.Name = "__shadow"
    f.BackgroundColor3 = Color3.new(0, 0, 0)
    f.BackgroundTransparency = transparency or 0.55
    f.BorderSizePixel = 0
    f.Size = UDim2.new(1, size or 10, 1, size or 10)
    f.Position = UDim2.fromOffset(-(size or 10)/2, -(size or 10)/2 + 3)
    f.ZIndex = parent.ZIndex - 1
    f.Parent = parent
    corner(f, 12)
    return f
end

-- ============================================================
-- ROOT MENU
-- ============================================================
local Menu = Instance.new("Frame")
Menu.Name = "MainMenu"
Menu.Size = UDim2.fromOffset(1160, 720)
Menu.Position = UDim2.fromScale(0.5, 0.5)
Menu.AnchorPoint = Vector2.new(0.5, 0.5)
Menu.BackgroundColor3 = Theme.Bg
Menu.BorderSizePixel = 0
Menu.Visible = false
Menu.Active = true
Menu.ClipsDescendants = false
Menu.Parent = gui
corner(Menu, 10)
softShadow(Menu, 0.5, 16)
stroke(Menu, Theme.BorderSoft, 1, 0.2)

-- UIScale
local menuScale = Instance.new("UIScale")
menuScale.Scale = (S.UIScale or 100) / 100
menuScale.Parent = Menu

-- ============================================================
-- SIDE PANEL (left, with logo + tabs stacked vertically)
-- ============================================================
local SidePanel = Instance.new("Frame")
SidePanel.Size = UDim2.fromOffset(210, 720)
SidePanel.BackgroundColor3 = Theme.SidePanel
SidePanel.BorderSizePixel = 0
SidePanel.Parent = Menu
corner(SidePanel, 10)

-- hide bottom-right corner of side panel by covering with a square
local sideMask = Instance.new("Frame")
sideMask.Size = UDim2.new(0, 10, 0, 10)
sideMask.Position = UDim2.new(1, -10, 1, -10)
sideMask.BackgroundColor3 = Theme.SidePanel
sideMask.BorderSizePixel = 0
sideMask.ZIndex = 2
sideMask.Parent = SidePanel

-- Logo area
local Logo = Instance.new("Frame")
Logo.Size = UDim2.new(1, 0, 0, 88)
Logo.BackgroundColor3 = Theme.SidePanel
Logo.BorderSizePixel = 0
Logo.Parent = SidePanel
corner(Logo, 10)

local LogoIcon = Instance.new("Frame")
LogoIcon.Size = UDim2.fromOffset(36, 36)
LogoIcon.Position = UDim2.fromOffset(20, 22)
LogoIcon.BackgroundColor3 = Theme.Accent
LogoIcon.BorderSizePixel = 0
LogoIcon.Parent = Logo
corner(LogoIcon, 9)
local LogoIconInner = Instance.new("Frame")
LogoIconInner.Size = UDim2.fromOffset(14, 14)
LogoIconInner.Position = UDim2.fromScale(0.5, 0.5)
LogoIconInner.AnchorPoint = Vector2.new(0.5, 0.5)
LogoIconInner.BackgroundColor3 = Theme.BgDeep
LogoIconInner.BorderSizePixel = 0
LogoIconInner.Parent = LogoIcon
corner(LogoIconInner, 4)

local LogoTitle = Instance.new("TextLabel")
LogoTitle.Size = UDim2.new(1, -76, 0, 22)
LogoTitle.Position = UDim2.fromOffset(66, 24)
LogoTitle.BackgroundTransparency = 1
LogoTitle.Text = "BrutalSRG"
LogoTitle.TextColor3 = Theme.TextBright
LogoTitle.Font = Theme.FontBold
LogoTitle.TextSize = 17
LogoTitle.TextXAlignment = Enum.TextXAlignment.Left
LogoTitle.Parent = Logo

local LogoSub = Instance.new("TextLabel")
LogoSub.Size = UDim2.new(1, -76, 0, 16)
LogoSub.Position = UDim2.fromOffset(66, 44)
LogoSub.BackgroundTransparency = 1
LogoSub.Text = "v1.0  ·  Premium"
LogoSub.TextColor3 = Theme.AccentBright
LogoSub.Font = Theme.Font
LogoSub.TextSize = 11
LogoSub.TextXAlignment = Enum.TextXAlignment.Left
LogoSub.Parent = Logo

-- Divider under logo
local logoDivider = Instance.new("Frame")
logoDivider.Size = UDim2.new(1, -24, 0, 1)
logoDivider.Position = UDim2.fromOffset(12, 88)
logoDivider.BackgroundColor3 = Theme.Border
logoDivider.BorderSizePixel = 0
logoDivider.Parent = SidePanel

-- Tab container (vertical)
local TabList = Instance.new("Frame")
TabList.Size = UDim2.new(1, 0, 1, -170)
TabList.Position = UDim2.fromOffset(0, 100)
TabList.BackgroundTransparency = 1
TabList.Parent = SidePanel

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Vertical
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 3)
TabListLayout.Parent = TabList

local TabListPad = Instance.new("UIPadding")
TabListPad.PaddingLeft = UDim.new(0, 10)
TabListPad.PaddingRight = UDim.new(0, 10)
TabListPad.PaddingTop = UDim.new(0, 6)
TabListPad.Parent = TabList

-- Bottom user card
local UserCard = Instance.new("Frame")
UserCard.Size = UDim2.new(1, -20, 0, 56)
UserCard.Position = UDim2.new(0, 10, 1, -66)
UserCard.BackgroundColor3 = Theme.CardBg
UserCard.BorderSizePixel = 0
UserCard.Parent = SidePanel
corner(UserCard, 8)
stroke(UserCard, Theme.Border, 1)

local avatar = Instance.new("ImageLabel")
avatar.Size = UDim2.fromOffset(36, 36)
avatar.Position = UDim2.fromOffset(10, 10)
avatar.BackgroundColor3 = Theme.AccentDeep
avatar.BorderSizePixel = 0
avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(LP.UserId) .. "&w=60&h=60"
avatar.Parent = UserCard
corner(avatar, 18)

local uname = Instance.new("TextLabel")
uname.Size = UDim2.new(1, -58, 0, 18)
uname.Position = UDim2.fromOffset(54, 10)
uname.BackgroundTransparency = 1
uname.Text = LP.DisplayName or LP.Name
uname.TextColor3 = Theme.TextBright
uname.Font = Theme.FontBold
uname.TextSize = 12
uname.TextXAlignment = Enum.TextXAlignment.Left
uname.Parent = UserCard

local uexec = Instance.new("TextLabel")
uexec.Size = UDim2.new(1, -58, 0, 14)
uexec.Position = UDim2.fromOffset(54, 28)
uexec.BackgroundTransparency = 1
uexec.Text = EXECUTOR_NAME
uexec.TextColor3 = Theme.TextDim
uexec.Font = Theme.Font
uexec.TextSize = 10
uexec.TextXAlignment = Enum.TextXAlignment.Left
uexec.Parent = UserCard

-- ============================================================
-- TOP BAR (right side)
-- ============================================================
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, -210, 0, 60)
TopBar.Position = UDim2.fromOffset(210, 0)
TopBar.BackgroundColor3 = Theme.SidePanel
TopBar.BorderSizePixel = 0
TopBar.Parent = Menu

local topMask = Instance.new("Frame")
topMask.Size = UDim2.new(0, 10, 0, 10)
topMask.Position = UDim2.new(0, 0, 0, 0)
topMask.BackgroundColor3 = Theme.SidePanel
topMask.BorderSizePixel = 0
topMask.ZIndex = 2
topMask.Parent = TopBar

local CurrentTabTitle = Instance.new("TextLabel")
CurrentTabTitle.Size = UDim2.new(1, -180, 0, 24)
CurrentTabTitle.Position = UDim2.fromOffset(24, 12)
CurrentTabTitle.BackgroundTransparency = 1
CurrentTabTitle.Text = "RAGE"
CurrentTabTitle.TextColor3 = Theme.TextBright
CurrentTabTitle.Font = Theme.FontBold
CurrentTabTitle.TextSize = 17
CurrentTabTitle.TextXAlignment = Enum.TextXAlignment.Left
CurrentTabTitle.Parent = TopBar

local CurrentTabSub = Instance.new("TextLabel")
CurrentTabSub.Size = UDim2.new(1, -180, 0, 16)
CurrentTabSub.Position = UDim2.fromOffset(24, 34)
CurrentTabSub.BackgroundTransparency = 1
CurrentTabSub.Text = "rage aimbot · auto shoot · silent aim"
CurrentTabSub.TextColor3 = Theme.TextDim
CurrentTabSub.Font = Theme.Font
CurrentTabSub.TextSize = 11
CurrentTabSub.TextXAlignment = Enum.TextXAlignment.Left
CurrentTabSub.Parent = TopBar

-- Close/hide button top right
local HideBtn = Instance.new("TextButton")
HideBtn.Size = UDim2.fromOffset(30, 30)
HideBtn.Position = UDim2.new(1, -42, 0, 15)
HideBtn.BackgroundColor3 = Theme.CardBg
HideBtn.Text = "—"
HideBtn.TextColor3 = Theme.Text
HideBtn.Font = Theme.FontBold
HideBtn.TextSize = 16
HideBtn.AutoButtonColor = false
HideBtn.Parent = TopBar
corner(HideBtn, 6)
stroke(HideBtn, Theme.Border, 1)
HideBtn.MouseButton1Click:Connect(function() Menu.Visible = false end)
HideBtn.MouseEnter:Connect(function() HideBtn.BackgroundColor3 = Theme.RowBgHover end)
HideBtn.MouseLeave:Connect(function() HideBtn.BackgroundColor3 = Theme.CardBg end)

-- Divider line between top bar and content
local topDivider = Instance.new("Frame")
topDivider.Size = UDim2.new(1, -210, 0, 1)
topDivider.Position = UDim2.fromOffset(210, 60)
topDivider.BackgroundColor3 = Theme.Border
topDivider.BorderSizePixel = 0
topDivider.Parent = Menu

makeDraggable(Menu, TopBar)

-- ============================================================
-- CONTENT AREA (right side, below top bar)
-- ============================================================
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -210, 1, -60)
ContentArea.Position = UDim2.fromOffset(210, 60)
ContentArea.BackgroundColor3 = Theme.Bg
ContentArea.BorderSizePixel = 0
ContentArea.Parent = Menu

local Tabs = {}

local function createTab(name, icon, subtitle)
    -- Sidebar button
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.BackgroundColor3 = Theme.SidePanel
    btn.TextColor3 = Theme.TextDim
    btn.Font = Theme.FontSemi
    btn.TextSize = 13
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.LayoutOrder = #Tabs + 1
    btn.Parent = TabList
    corner(btn, 6)

    -- Left accent bar (visible when active)
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0, 3, 0, 20)
    bar.Position = UDim2.new(0, 4, 0.5, -10)
    bar.BackgroundColor3 = Theme.AccentBright
    bar.BorderSizePixel = 0
    bar.Visible = false
    bar.ZIndex = 2
    bar.Parent = btn
    corner(bar, 2)

    -- Icon
    local iconLbl = Instance.new("TextLabel")
    iconLbl.Size = UDim2.fromOffset(24, 24)
    iconLbl.Position = UDim2.fromOffset(16, 7)
    iconLbl.BackgroundTransparency = 1
    iconLbl.Text = icon or "•"
    iconLbl.TextColor3 = Theme.TextDim
    iconLbl.Font = Theme.FontBold
    iconLbl.TextSize = 14
    iconLbl.ZIndex = 2
    iconLbl.Parent = btn

    -- Label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -56, 1, 0)
    label.Position = UDim2.fromOffset(46, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Theme.TextDim
    label.Font = Theme.FontSemi
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 2
    label.Parent = btn

    -- Page
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 5
    page.ScrollBarImageColor3 = Theme.Accent
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    page.Parent = ContentArea

    local pageLayout = Instance.new("UIListLayout")
    pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pageLayout.Padding = UDim.new(0, 8)
    pageLayout.Parent = page

    local pagePad = Instance.new("UIPadding")
    pagePad.PaddingLeft = UDim.new(0, 18)
    pagePad.PaddingRight = UDim.new(0, 18)
    pagePad.PaddingTop = UDim.new(0, 14)
    pagePad.PaddingBottom = UDim.new(0, 16)
    pagePad.Parent = page

    local function makeColumns()
        local holder = Instance.new("Frame")
        holder.Size = UDim2.new(1, 0, 0, 0)
        holder.AutomaticSize = Enum.AutomaticSize.Y
        holder.BackgroundTransparency = 1
        holder.Parent = page

        local hLayout = Instance.new("UIListLayout")
        hLayout.FillDirection = Enum.FillDirection.Horizontal
        hLayout.SortOrder = Enum.SortOrder.LayoutOrder
        hLayout.Padding = UDim.new(0, 12)
        hLayout.Parent = holder

        local left = Instance.new("Frame")
        left.Size = UDim2.new(0.5, -6, 0, 0)
        left.AutomaticSize = Enum.AutomaticSize.Y
        left.BackgroundTransparency = 1
        left.LayoutOrder = 1
        left.Parent = holder
        local ll = Instance.new("UIListLayout")
        ll.SortOrder = Enum.SortOrder.LayoutOrder
        ll.Padding = UDim.new(0, 6)
        ll.Parent = left

        local right = Instance.new("Frame")
        right.Size = UDim2.new(0.5, -6, 0, 0)
        right.AutomaticSize = Enum.AutomaticSize.Y
        right.BackgroundTransparency = 1
        right.LayoutOrder = 2
        right.Parent = holder
        local rl = Instance.new("UIListLayout")
        rl.SortOrder = Enum.SortOrder.LayoutOrder
        rl.Padding = UDim.new(0, 6)
        rl.Parent = right

        return left, right
    end

    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do
            t.Page.Visible = false
            t.Button.BackgroundColor3 = Theme.SidePanel
            t.Icon.TextColor3 = Theme.TextDim
            t.Label.TextColor3 = Theme.TextDim
            t.Bar.Visible = false
        end
        page.Visible = true
        btn.BackgroundColor3 = Theme.CardBg
        iconLbl.TextColor3 = Theme.AccentBright
        label.TextColor3 = Theme.TextBright
        bar.Visible = true
        CurrentTabTitle.Text = string.upper(name)
        CurrentTabSub.Text = subtitle or ""
    end)

    btn.MouseEnter:Connect(function()
        if not page.Visible then
            btn.BackgroundColor3 = Theme.CardBg
            iconLbl.TextColor3 = Theme.Text
            label.TextColor3 = Theme.Text
        end
    end)
    btn.MouseLeave:Connect(function()
        if not page.Visible then
            btn.BackgroundColor3 = Theme.SidePanel
            iconLbl.TextColor3 = Theme.TextDim
            label.TextColor3 = Theme.TextDim
        end
    end)

    local tab = {
        Button = btn, Page = page, makeColumns = makeColumns,
        Bar = bar, Icon = iconLbl, Label = label, Name = name, Subtitle = subtitle,
    }
    Tabs[name] = tab
    return tab
end

-- ============================================================
-- WIDGETS
-- ============================================================
local function createSection(parent, text)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 30)
    row.BackgroundTransparency = 1
    row.Parent = parent

    local iconLbl = Instance.new("TextLabel")
    iconLbl.Size = UDim2.fromOffset(16, 30)
    iconLbl.BackgroundTransparency = 1
    iconLbl.Text = "◆"
    iconLbl.TextColor3 = Theme.Accent
    iconLbl.Font = Theme.FontBold
    iconLbl.TextSize = 11
    iconLbl.Parent = row

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -22, 1, 0)
    l.Position = UDim2.fromOffset(20, 0)
    l.BackgroundTransparency = 1
    l.Font = Theme.FontBold
    l.TextSize = 12
    l.TextColor3 = Theme.TextDim
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Text = string.upper(text)
    l.Parent = row
end

local function createLabel(parent, text)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, 0, 0, 22)
    l.BackgroundTransparency = 1
    l.Font = Theme.Font
    l.TextSize = 12
    l.TextColor3 = Theme.TextDim
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Text = text
    l.Parent = parent
    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0, 4)
    pad.Parent = l
end

local function createBindableToggle(parent, name, key)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 40)
    row.BackgroundColor3 = Theme.RowBg
    row.BorderSizePixel = 0
    row.Parent = parent
    corner(row, 8)
    local rowStroke = stroke(row, Theme.Border, 1)

    -- Left accent bar
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0, 3, 0, 22)
    bar.Position = UDim2.new(0, 6, 0.5, -11)
    bar.BackgroundColor3 = Theme.Off
    bar.BorderSizePixel = 0
    bar.Parent = row
    corner(bar, 2)

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(1, -120, 1, 0)
    toggleBtn.Position = UDim2.fromOffset(16, 0)
    toggleBtn.BackgroundTransparency = 1
    toggleBtn.Font = Theme.FontSemi
    toggleBtn.TextSize = 13
    toggleBtn.TextXAlignment = Enum.TextXAlignment.Left
    toggleBtn.Text = name
    toggleBtn.TextColor3 = Theme.Text
    toggleBtn.AutoButtonColor = false
    toggleBtn.Parent = row

    -- Small "toggle switch"
    local switch = Instance.new("Frame")
    switch.Size = UDim2.fromOffset(34, 18)
    switch.Position = UDim2.new(1, -110, 0.5, -9)
    switch.BackgroundColor3 = Theme.Off
    switch.BorderSizePixel = 0
    switch.Parent = row
    corner(switch, 9)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.fromOffset(12, 12)
    knob.Position = UDim2.fromOffset(3, 3)
    knob.BackgroundColor3 = Theme.TextBright
    knob.BorderSizePixel = 0
    knob.Parent = switch
    corner(knob, 6)

    local bindBtn = Instance.new("TextButton")
    bindBtn.Size = UDim2.fromOffset(72, 24)
    bindBtn.Position = UDim2.new(1, -72, 0.5, -12)
    bindBtn.BackgroundColor3 = Theme.CardBg
    bindBtn.TextColor3 = Theme.TextDim
    bindBtn.Font = Theme.FontSemi
    bindBtn.TextSize = 11
    bindBtn.Text = ""
    bindBtn.AutoButtonColor = false
    bindBtn.Parent = row
    corner(bindBtn, 6)
    stroke(bindBtn, Theme.Border, 1)

    local function refresh()
        local on = S[key]
        toggleBtn.TextColor3 = on and Theme.TextBright or Theme.TextDim
        switch.BackgroundColor3 = on and Theme.On or Theme.Off
        bar.BackgroundColor3 = on and Theme.AccentBright or Theme.Off
        rowStroke.Color = on and Theme.BorderHot or Theme.Border
        if on then
            knob.Position = UDim2.new(1, -15, 0.5, -6)
        else
            knob.Position = UDim2.fromOffset(3, 3)
        end
        local kb = Binds[key]
        if kb then
            bindBtn.Text = kb.Name
            bindBtn.TextColor3 = Theme.AccentBright
            bindBtn.BackgroundColor3 = Theme.AccentDeep
        else
            bindBtn.Text = "—"
            bindBtn.TextColor3 = Theme.TextDim
            bindBtn.BackgroundColor3 = Theme.CardBg
        end
    end
    refresh()

    toggleBtn.MouseButton1Click:Connect(function() S[key] = not S[key] refresh() end)
    toggleBtn.MouseEnter:Connect(function() row.BackgroundColor3 = Theme.RowBgHover end)
    toggleBtn.MouseLeave:Connect(function() row.BackgroundColor3 = Theme.RowBg end)

    local waiting = false
    bindBtn.MouseButton1Click:Connect(function()
        if waiting then return end
        waiting = true
        bindBtn.Text = "..."
        bindBtn.TextColor3 = Theme.Warn
        local conn
        conn = UIS.InputBegan:Connect(function(i, gp)
            if gp then return end
            if i.UserInputType ~= Enum.UserInputType.Keyboard then return end
            conn:Disconnect()
            if i.KeyCode == Enum.KeyCode.Backspace or i.KeyCode == Enum.KeyCode.Delete then
                Binds[key] = nil
            else
                Binds[key] = i.KeyCode
            end
            waiting = false
            refresh()
        end)
    end)

    table.insert(UIWidgets, refresh)
end

local function createValueRow(parent, label, getV, dec, inc)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 40)
    row.BackgroundColor3 = Theme.RowBg
    row.BorderSizePixel = 0
    row.Parent = parent
    corner(row, 8)
    stroke(row, Theme.Border, 1)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -110, 1, 0)
    lbl.Position = UDim2.fromOffset(16, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Theme.Text
    lbl.Font = Theme.FontSemi
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    local function upd() lbl.Text = label .. ": " .. tostring(getV()) end
    upd()

    local minus = Instance.new("TextButton")
    minus.Size = UDim2.fromOffset(32, 26)
    minus.Position = UDim2.new(1, -74, 0.5, -13)
    minus.BackgroundColor3 = Theme.CardBg
    minus.Text = "−"
    minus.TextColor3 = Theme.Text
    minus.Font = Theme.FontBold
    minus.TextSize = 15
    minus.AutoButtonColor = false
    minus.Parent = row
    corner(minus, 6)
    stroke(minus, Theme.Border, 1)

    local plus = Instance.new("TextButton")
    plus.Size = UDim2.fromOffset(32, 26)
    plus.Position = UDim2.new(1, -38, 0.5, -13)
    plus.BackgroundColor3 = Theme.CardBg
    plus.Text = "+"
    plus.TextColor3 = Theme.Text
    plus.Font = Theme.FontBold
    plus.TextSize = 15
    plus.AutoButtonColor = false
    plus.Parent = row
    corner(plus, 6)
    stroke(plus, Theme.Border, 1)

    minus.MouseButton1Click:Connect(function() dec(); upd() end)
    plus.MouseButton1Click:Connect(function() inc(); upd() end)

    minus.MouseEnter:Connect(function()
        minus.BackgroundColor3 = Theme.AccentDeep
        minus.TextColor3 = Theme.AccentBright
    end)
    minus.MouseLeave:Connect(function()
        minus.BackgroundColor3 = Theme.CardBg
        minus.TextColor3 = Theme.Text
    end)
    plus.MouseEnter:Connect(function()
        plus.BackgroundColor3 = Theme.AccentDeep
        plus.TextColor3 = Theme.AccentBright
    end)
    plus.MouseLeave:Connect(function()
        plus.BackgroundColor3 = Theme.CardBg
        plus.TextColor3 = Theme.Text
    end)

    table.insert(UIWidgets, upd)
end

local function createTextButton(parent, text, cb, bg)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, 34)
    b.BackgroundColor3 = bg or Theme.CardBg
    b.Text = text
    b.TextColor3 = Theme.Text
    b.Font = Theme.FontSemi
    b.TextSize = 13
    b.AutoButtonColor = false
    b.Parent = parent
    corner(b, 8)
    stroke(b, Theme.Border, 1)
    b.MouseButton1Click:Connect(cb)
    b.MouseEnter:Connect(function()
        b.BackgroundColor3 = Theme.RowBgHover
        b.TextColor3 = Theme.TextBright
    end)
    b.MouseLeave:Connect(function()
        b.BackgroundColor3 = bg or Theme.CardBg
        b.TextColor3 = Theme.Text
    end)
    return b
end

-- ============================================================
-- COLOR PICKER
-- ============================================================
local function createColorPicker(parent, labelText, getColor, setColor)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, 0, 0, 40)
    holder.BackgroundColor3 = Theme.RowBg
    holder.BorderSizePixel = 0
    holder.Parent = parent
    corner(holder, 8)
    stroke(holder, Theme.Border, 1)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -100, 1, 0)
    lbl.Position = UDim2.fromOffset(16, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Theme.Text
    lbl.Font = Theme.FontSemi
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Text = labelText
    lbl.Parent = holder

    local preview = Instance.new("Frame")
    preview.Size = UDim2.fromOffset(64, 22)
    preview.Position = UDim2.new(1, -76, 0.5, -11)
    preview.BackgroundColor3 = getColor()
    preview.BorderSizePixel = 0
    preview.Parent = holder
    corner(preview, 6)
    stroke(preview, Theme.BorderSoft, 1)

    local popup = Instance.new("Frame")
    popup.Size = UDim2.fromOffset(340, 360)
    popup.Position = UDim2.fromScale(0.5, 0.5)
    popup.AnchorPoint = Vector2.new(0.5, 0.5)
    popup.BackgroundColor3 = Theme.CardBg
    popup.BorderSizePixel = 0
    popup.Visible = false
    popup.ZIndex = 50
    popup.Parent = Menu
    corner(popup, 10)
    softShadow(popup, 0.5, 14)
    stroke(popup, Theme.BorderHot, 1)

    local pTitle = Instance.new("TextLabel")
    pTitle.Size = UDim2.new(1, 0, 0, 40)
    pTitle.BackgroundColor3 = Theme.SidePanel
    pTitle.BorderSizePixel = 0
    pTitle.Text = "  " .. labelText
    pTitle.TextColor3 = Theme.TextBright
    pTitle.Font = Theme.FontBold
    pTitle.TextSize = 13
    pTitle.TextXAlignment = Enum.TextXAlignment.Left
    pTitle.ZIndex = 51
    pTitle.Parent = popup
    corner(pTitle, 10)

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.fromOffset(28, 26)
    closeBtn.Position = UDim2.new(1, -36, 0, 7)
    closeBtn.BackgroundColor3 = Theme.AccentDeep
    closeBtn.Text = "×"
    closeBtn.TextColor3 = Theme.AccentBright
    closeBtn.Font = Theme.FontBold
    closeBtn.TextSize = 16
    closeBtn.AutoButtonColor = false
    closeBtn.ZIndex = 52
    closeBtn.Parent = popup
    corner(closeBtn, 6)
    stroke(closeBtn, Theme.BorderHot, 1)

    local state = { r = math.floor(getColor().R * 255), g = math.floor(getColor().G * 255), b = math.floor(getColor().B * 255) }

    local function updateColor()
        local c = Color3.fromRGB(state.r, state.g, state.b)
        setColor(c)
        preview.BackgroundColor3 = c
    end

    local sliderRefs = {}

    local function makeSlider(name, y, key)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0, 30, 0, 22)
        label.Position = UDim2.fromOffset(20, y + 4)
        label.BackgroundTransparency = 1
        label.Text = name
        label.TextColor3 = Theme.Text
        label.Font = Theme.FontBold
        label.TextSize = 13
        label.ZIndex = 51
        label.Parent = popup

        local valueLbl = Instance.new("TextLabel")
        valueLbl.Size = UDim2.new(0, 46, 0, 22)
        valueLbl.Position = UDim2.new(1, -66, 0, y + 4)
        valueLbl.BackgroundTransparency = 1
        valueLbl.Text = tostring(state[key])
        valueLbl.TextColor3 = Theme.TextBright
        valueLbl.Font = Theme.FontSemi
        valueLbl.TextSize = 13
        valueLbl.ZIndex = 51
        valueLbl.Parent = popup

        local sliderBg = Instance.new("Frame")
        sliderBg.Size = UDim2.new(1, -120, 0, 10)
        sliderBg.Position = UDim2.fromOffset(62, y + 10)
        sliderBg.BackgroundColor3 = Theme.BgDeep
        sliderBg.BorderSizePixel = 0
        sliderBg.ZIndex = 51
        sliderBg.Parent = popup
        corner(sliderBg, 5)
        stroke(sliderBg, Theme.Border, 1)

        local fill = Instance.new("Frame")
        fill.Size = UDim2.new(state[key] / 255, 0, 1, 0)
        fill.BackgroundColor3 = Theme.Accent
        fill.BorderSizePixel = 0
        fill.ZIndex = 52
        fill.Parent = sliderBg
        corner(fill, 5)

        sliderRefs[key] = { fill = fill, valueLbl = valueLbl }

        local dragging = false
        local function updateFromInput(input)
            local rel = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
            state[key] = math.floor(rel * 255)
            fill.Size = UDim2.new(rel, 0, 1, 0)
            valueLbl.Text = tostring(state[key])
            updateColor()
        end

        sliderBg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                updateFromInput(input)
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch) then
                updateFromInput(input)
            end
        end)

        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
    end

    makeSlider("R", 52, "r")
    makeSlider("G", 98, "g")
    makeSlider("B", 144, "b")

    local presetsTitle = Instance.new("TextLabel")
    presetsTitle.Size = UDim2.new(1, -20, 0, 22)
    presetsTitle.Position = UDim2.fromOffset(16, 200)
    presetsTitle.BackgroundTransparency = 1
    presetsTitle.Text = "PRESETS"
    presetsTitle.TextColor3 = Theme.TextDim
    presetsTitle.Font = Theme.FontBold
    presetsTitle.TextSize = 11
    presetsTitle.ZIndex = 51
    presetsTitle.Parent = popup

    local presetColors = {
        Color3.fromRGB(255, 30, 30), Color3.fromRGB(200, 0, 0), Color3.fromRGB(120, 0, 0),
        Color3.fromRGB(255, 100, 100), Color3.fromRGB(255, 0, 80), Color3.fromRGB(180, 20, 60),
        Color3.fromRGB(255, 150, 0), Color3.fromRGB(255, 255, 0), Color3.fromRGB(0, 255, 100),
        Color3.fromRGB(0, 200, 255), Color3.fromRGB(100, 0, 255), Color3.fromRGB(255, 255, 255),
    }

    for i, c in ipairs(presetColors) do
        local col = (i - 1) % 6
        local row = math.floor((i - 1) / 6)
        local swatch = Instance.new("TextButton")
        swatch.Size = UDim2.fromOffset(46, 34)
        swatch.Position = UDim2.fromOffset(18 + col * 52, 226 + row * 42)
        swatch.BackgroundColor3 = c
        swatch.Text = ""
        swatch.BorderSizePixel = 0
        swatch.AutoButtonColor = false
        swatch.ZIndex = 51
        swatch.Parent = popup
        corner(swatch, 6)
        stroke(swatch, Theme.BorderSoft, 1)

        swatch.MouseButton1Click:Connect(function()
            state.r = math.floor(c.R * 255)
            state.g = math.floor(c.G * 255)
            state.b = math.floor(c.B * 255)
            for k, ref in pairs(sliderRefs) do
                local rel = state[k] / 255
                ref.fill.Size = UDim2.new(rel, 0, 1, 0)
                ref.valueLbl.Text = tostring(state[k])
            end
            updateColor()
        end)
    end

    closeBtn.MouseButton1Click:Connect(function() popup.Visible = false end)

    preview.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            popup.Visible = not popup.Visible
        end
    end)

    local function refresh()
        preview.BackgroundColor3 = getColor()
        local c = getColor()
        state.r = math.floor(c.R * 255)
        state.g = math.floor(c.G * 255)
        state.b = math.floor(c.B * 255)
        for k, ref in pairs(sliderRefs) do
            local rel = state[k] / 255
            ref.fill.Size = UDim2.new(rel, 0, 1, 0)
            ref.valueLbl.Text = tostring(state[k])
        end
    end
    table.insert(UIWidgets, refresh)
end

-- ============================================================
-- CREATE TABS
-- ============================================================
local RageTab = createTab("Rage", "✦", "rage aimbot · auto shoot · silent aim")
local VisTab = createTab("Visuals", "◉", "esp · chams · skeleton · colors")
local AimTab = createTab("Aim", "⊕", "aimbot · tuning · hitboxes")
local MoveTab = createTab("Movement", "➤", "bhop · speed · fly · noclip")
local AATab = createTab("Anti-Aim", "⟲", "spin · jitter · pitch")
local CamTab = createTab("Camera", "▣", "third person · ui scale")
local TracerTab = createTab("Tracers", "═", "bullet tracers")
local CurrencyTab = createTab("Currency", "$", "remote scanner · auto fire")
local ConfigTab = createTab("Configs", "⚙", "save and load settings")

-- RAGE TAB
do
    local left, right = RageTab.makeColumns()
    createSection(left, "Rage Aimbot")
    createBindableToggle(left, "Rage Aimbot", "RageAimbot")
    createBindableToggle(left, "Auto Shoot (M1)", "RageAutoShoot")
    createBindableToggle(left, "Wall Check", "RageWallCheck")
    createBindableToggle(left, "Ignore Teammates", "IgnoreTeammates")

    createSection(left, "Settings")
    createValueRow(left, "Rage FOV", function() return S.RageFOV end,
        function() S.RageFOV = math.clamp(S.RageFOV - 10, 10, 360) end,
        function() S.RageFOV = math.clamp(S.RageFOV + 10, 10, 360) end)
    createValueRow(left, "Max Distance", function() return S.RageMaxDistance end,
        function() S.RageMaxDistance = math.clamp(S.RageMaxDistance - 25, 50, 2000) end,
        function() S.RageMaxDistance = math.clamp(S.RageMaxDistance + 25, 50, 2000) end)
    createValueRow(left, "Shoot Delay", function() return math.floor(S.RageShootDelay * 1000) .. "ms" end,
        function() S.RageShootDelay = math.clamp(S.RageShootDelay - 0.01, 0.01, 1.0) end,
        function() S.RageShootDelay = math.clamp(S.RageShootDelay + 0.01, 0.01, 1.0) end)
    createValueRow(left, "Fire Angle", function() return S.RageFireAngle .. "°" end,
        function() S.RageFireAngle = math.clamp(S.RageFireAngle - 0.5, 0.5, 30) end,
        function() S.RageFireAngle = math.clamp(S.RageFireAngle + 0.5, 0.5, 30) end)
    createValueRow(left, "Lock Frames", function() return S.RageLockFrames end,
        function() S.RageLockFrames = math.clamp(S.RageLockFrames - 1, 1, 10) end,
        function() S.RageLockFrames = math.clamp(S.RageLockFrames + 1, 1, 10) end)
    createValueRow(left, "Prediction", function() return math.floor(S.RagePrediction * 1000) .. "ms" end,
        function() S.RagePrediction = math.clamp(S.RagePrediction - 0.005, 0, 0.1) end,
        function() S.RagePrediction = math.clamp(S.RagePrediction + 0.005, 0, 0.1) end)
    createBindableToggle(left, "Adaptive Lead", "RageAdaptiveLead")

    local rb
    rb = createTextButton(left, "Hitbox: " .. S.RageHitbox, function()
        local o = { "Head", "Torso", "Legs" }
        local i = 1
        for k, v in ipairs(o) do if v == S.RageHitbox then i = k break end end
        i = i % #o + 1
        S.RageHitbox = o[i]
        rb.Text = "Hitbox: " .. S.RageHitbox
    end, Theme.CardBg)

    createSection(right, "Silent Aim")
    createBindableToggle(right, "Silent Aim", "SilentAim")
    createValueRow(right, "SA FOV", function() return S.SilentAimFOV end,
        function() S.SilentAimFOV = math.clamp(S.SilentAimFOV - 10, 10, 360) end,
        function() S.SilentAimFOV = math.clamp(S.SilentAimFOV + 10, 10, 360) end)
    createValueRow(right, "SA Angle", function() return S.SilentAimAngleThreshold .. "°" end,
        function() S.SilentAimAngleThreshold = math.clamp(S.SilentAimAngleThreshold - 1, 1, 30) end,
        function() S.SilentAimAngleThreshold = math.clamp(S.SilentAimAngleThreshold + 1, 1, 30) end)
    createValueRow(right, "SA Settle", function() return math.floor(S.SilentAimSettle * 1000) .. "ms" end,
        function() S.SilentAimSettle = math.clamp(S.SilentAimSettle - 0.01, 0, 0.2) end,
        function() S.SilentAimSettle = math.clamp(S.SilentAimSettle + 0.01, 0, 0.2) end)

    local saHB
    saHB = createTextButton(right, "SA Hitbox: " .. S.SilentAimHitbox, function()
        local o = { "Head", "Torso", "Legs" }
        local i = 1
        for k, v in ipairs(o) do if v == S.SilentAimHitbox then i = k break end end
        i = i % #o + 1
        S.SilentAimHitbox = o[i]
        saHB.Text = "SA Hitbox: " .. S.SilentAimHitbox
    end, Theme.CardBg)

    createSection(right, "Diagnostic")
    createTextButton(right, "Inspect All Players", function()
        inspectAllPlayers()
    end, Theme.CardBg)
end

-- VISUALS TAB
do
    local left, right = VisTab.makeColumns()
    createSection(left, "ESP")
    createBindableToggle(left, "Box ESP", "BoxESP")
    createBindableToggle(left, "Skeleton ESP", "SkeletonESP")
    createBindableToggle(left, "Chams", "Chams")
    createBindableToggle(left, "Use Team Colors", "UseTeamColors")
    createValueRow(left, "Chams Fill",
        function() return string.format("%.2f", S.ChamsFillTransparency) end,
        function() S.ChamsFillTransparency = math.clamp(S.ChamsFillTransparency - 0.05, 0, 1) end,
        function() S.ChamsFillTransparency = math.clamp(S.ChamsFillTransparency + 0.05, 0, 1) end)

    createSection(right, "Colors")
    createColorPicker(right, "Box ESP", function() return S.BoxColor end,
        function(c) S.BoxColor = c end)
    createColorPicker(right, "Skeleton", function() return S.SkeletonColor end,
        function(c) S.SkeletonColor = c end)
    createColorPicker(right, "Chams", function() return S.ChamsColor end,
        function(c) S.ChamsColor = c end)
end

-- AIM TAB
do
    local left, right = AimTab.makeColumns()
    createSection(left, "Aimbot")
    createBindableToggle(left, "Aimbot", "Aimbot")
    createBindableToggle(left, "Auto Shoot", "AutoShoot")
    createBindableToggle(left, "FOV Visual", "FOVVisual")

    createSection(left, "Aimbot Hitboxes")
    createBindableToggle(left, "Aim Head", "HitboxHead")
    createBindableToggle(left, "Aim Torso", "HitboxTorso")
    createBindableToggle(left, "Aim Legs", "HitboxLegs")

    createSection(right, "Tuning")
    createValueRow(right, "FOV", function() return S.FOV end,
        function() S.FOV = math.clamp(S.FOV - 5, 10, 180) end,
        function() S.FOV = math.clamp(S.FOV + 5, 10, 180) end)
    createValueRow(right, "Smoothing", function() return string.format("%.2f", S.AimSmoothing) end,
        function() S.AimSmoothing = math.clamp(S.AimSmoothing - 0.05, 0.05, 1.0) end,
        function() S.AimSmoothing = math.clamp(S.AimSmoothing + 0.05, 0.05, 1.0) end)
    createValueRow(right, "Max Px/Frame", function() return S.AimMaxDelta end,
        function() S.AimMaxDelta = math.clamp(S.AimMaxDelta - 5, 1, 200) end,
        function() S.AimMaxDelta = math.clamp(S.AimMaxDelta + 5, 1, 200) end)
end

-- MOVEMENT TAB
do
    local left, right = MoveTab.makeColumns()
    createSection(left, "Bhop")
    createBindableToggle(left, "BHOP (Hold Space)", "Bhop")
    createBindableToggle(left, "BHOP Speed Boost", "BhopSpeedBoost")

    createSection(left, "Exploits")
    createBindableToggle(left, "No-Clip", "NoClip")
    createBindableToggle(left, "Speed Hack", "SpeedHack")
    createBindableToggle(left, "Jump Power Hack", "JumpPowerHack")
    createBindableToggle(left, "Fly (Hold F)", "Fly")

    createSection(right, "Speed")
    createValueRow(right, "Walk Speed", function() return S.SpeedValue end,
        function() S.SpeedValue = math.clamp(S.SpeedValue - 5, 16, 500) end,
        function() S.SpeedValue = math.clamp(S.SpeedValue + 5, 16, 500) end)

    createSection(right, "Jump")
    createValueRow(right, "Jump Power", function() return S.JumpPowerValue end,
        function() S.JumpPowerValue = math.clamp(S.JumpPowerValue - 10, 50, 500) end,
        function() S.JumpPowerValue = math.clamp(S.JumpPowerValue + 10, 50, 500) end)

    createSection(right, "Fly")
    createValueRow(right, "Fly Speed", function() return S.FlySpeed end,
        function() S.FlySpeed = math.clamp(S.FlySpeed - 5, 5, 300) end,
        function() S.FlySpeed = math.clamp(S.FlySpeed + 5, 5, 300) end)
end

-- ANTI-AIM TAB
do
    local left, right = AATab.makeColumns()
    createSection(left, "Anti-Aim")
    createBindableToggle(left, "Anti-Aim Master", "AntiAim")
    createBindableToggle(left, "Spin Body", "AASpinBody")
    createBindableToggle(left, "Spin Head Only", "AASpinHead")
    createBindableToggle(left, "Jitter Mode", "AAJitter")

    createSection(right, "Spin")
    createValueRow(right, "Spin Speed", function() return S.AASpinSpeed .. "°" end,
        function() S.AASpinSpeed = math.clamp(S.AASpinSpeed - 5, 1, 180) end,
        function() S.AASpinSpeed = math.clamp(S.AASpinSpeed + 5, 1, 180) end)

    createSection(right, "Head Fake")
    createValueRow(right, "Head Pitch", function() return S.AAHeadPitch .. "°" end,
        function() S.AAHeadPitch = math.clamp(S.AAHeadPitch - 5, -89, 89) end,
        function() S.AAHeadPitch = math.clamp(S.AAHeadPitch + 5, -89, 89) end)
    createValueRow(right, "Head Roll", function() return S.AAHeadRoll .. "°" end,
        function() S.AAHeadRoll = math.clamp(S.AAHeadRoll - 5, -89, 89) end,
        function() S.AAHeadRoll = math.clamp(S.AAHeadRoll + 5, -89, 89) end)

    createSection(right, "Pitch Anti-Aim")
    local pitchBtn
    pitchBtn = createTextButton(right, "Pitch Mode: " .. S.AAPitchMode, function()
        local modes = { "Off", "Down", "Up", "Flip" }
        local idx = 1
        for i, v in ipairs(modes) do
            if v == S.AAPitchMode then idx = i break end
        end
        idx = idx % #modes + 1
        S.AAPitchMode = modes[idx]
        pitchBtn.Text = "Pitch Mode: " .. S.AAPitchMode
    end, Theme.CardBg)

    createValueRow(right, "Pitch Angle", function() return S.AAPitchAngle .. "°" end,
        function() S.AAPitchAngle = math.clamp(S.AAPitchAngle - 5, 30, 89) end,
        function() S.AAPitchAngle = math.clamp(S.AAPitchAngle + 5, 30, 89) end)

    createValueRow(right, "Flip Speed", function() return math.floor(S.AAPitchFlipSpeed * 1000) .. "ms" end,
        function() S.AAPitchFlipSpeed = math.clamp(S.AAPitchFlipSpeed - 0.01, 0.01, 1.0) end,
        function() S.AAPitchFlipSpeed = math.clamp(S.AAPitchFlipSpeed + 0.01, 0.01, 1.0) end)
end

-- CAMERA TAB
do
    local left, right = CamTab.makeColumns()
    createSection(left, "Camera")
    createBindableToggle(left, "Third Person", "ThirdPerson")
    createBindableToggle(left, "Hide Arms/Weapon", "ThirdPersonHideArms")

    createSection(left, "TP Systems")
    createBindableToggle(left, "Wall Collision", "ThirdPersonWallCheck")
    createBindableToggle(left, "Smooth Follow", "ThirdPersonSmooth")

    createSection(right, "TP Tuning")
    createValueRow(right, "TP Distance", function() return S.ThirdPersonDistance end,
        function() S.ThirdPersonDistance = math.clamp(S.ThirdPersonDistance - 1, 4, 40) end,
        function() S.ThirdPersonDistance = math.clamp(S.ThirdPersonDistance + 1, 4, 40) end)
    createValueRow(right, "TP Height", function() return S.ThirdPersonOffset.Y end,
        function() S.ThirdPersonOffset = Vector3.new(0, math.clamp(S.ThirdPersonOffset.Y - 0.5, -5, 10), 0) end,
        function() S.ThirdPersonOffset = Vector3.new(0, math.clamp(S.ThirdPersonOffset.Y + 0.5, -5, 10), 0) end)
    createValueRow(right, "Min Distance", function() return S.ThirdPersonMinDistance end,
        function() S.ThirdPersonMinDistance = math.clamp(S.ThirdPersonMinDistance - 0.5, 1, 10) end,
        function() S.ThirdPersonMinDistance = math.clamp(S.ThirdPersonMinDistance + 0.5, 1, 10) end)
    createValueRow(right, "Smooth Speed", function() return string.format("%.2f", S.ThirdPersonSmoothSpeed) end,
        function() S.ThirdPersonSmoothSpeed = math.clamp(S.ThirdPersonSmoothSpeed - 0.05, 0.05, 1.0) end,
        function() S.ThirdPersonSmoothSpeed = math.clamp(S.ThirdPersonSmoothSpeed + 0.05, 0.05, 1.0) end)

    createSection(right, "UI Scale")
    createValueRow(right, "Menu Scale", function() return S.UIScale .. "%" end,
        function()
            S.UIScale = math.clamp(S.UIScale - 5, 25, 200)
            menuScale.Scale = S.UIScale / 100
        end,
        function()
            S.UIScale = math.clamp(S.UIScale + 5, 25, 200)
            menuScale.Scale = S.UIScale / 100
        end)
    createLabel(right, "Range: 25% – 200%  ·  scales the whole menu")
end

-- TRACERS TAB
do
    local left, right = TracerTab.makeColumns()
    createSection(left, "Bullet Tracers")
    createBindableToggle(left, "Enable Tracers", "Tracers")

    createSection(right, "Settings")
    createValueRow(right, "Lifetime", function() return S.TracerLifetime .. "s" end,
        function() S.TracerLifetime = math.clamp(S.TracerLifetime - 1, 0, 15) end,
        function() S.TracerLifetime = math.clamp(S.TracerLifetime + 1, 0, 15) end)
    createValueRow(right, "Thickness", function() return S.TracerThickness .. "px" end,
        function() S.TracerThickness = math.clamp(S.TracerThickness - 1, 1, 10) end,
        function() S.TracerThickness = math.clamp(S.TracerThickness + 1, 1, 10) end)
    createColorPicker(right, "Tracer Color", function() return S.TracerColor end,
        function(c) S.TracerColor = c end)
end

-- CURRENCY TAB
do
    local left, right = CurrencyTab.makeColumns()

    createSection(left, "Remote Scanner")
    createTextButton(left, "Scan All Remotes", function()
        print("========================================")
        print("=== REMOTE SCANNER ===")
        local results = {}
        for _, obj in ipairs(game:GetDescendants()) do
            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                table.insert(results, obj)
                print(string.format("  %s | %s", obj.ClassName, obj:GetFullName()))
            end
        end
        print(string.format("Total remotes found: %d", #results))
        print("========================================")
    end, Theme.CardBg)

    createTextButton(left, "Scan Money-Related", function()
        print("========================================")
        print("=== MONEY-RELATED REMOTES ===")
        local keywords = { "cash", "money", "coin", "reward", "buy", "purchase", "claim", "earn", "shop", "sell", "credit", "gem", "gold", "point" }
        local count = 0
        for _, obj in ipairs(game:GetDescendants()) do
            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                local lower = obj.Name:lower()
                for _, kw in ipairs(keywords) do
                    if lower:find(kw, 1, true) then
                        count = count + 1
                        print(string.format("  [%s] %s", kw, obj:GetFullName()))
                        break
                    end
                end
            end
        end
        print(string.format("Money-related remotes: %d", count))
        print("========================================")
    end, Theme.CardBg)

    createSection(left, "Target")
    local targetBox = Instance.new("TextBox")
    targetBox.Size = UDim2.new(1, 0, 0, 34)
    targetBox.BackgroundColor3 = Theme.RowBg
    targetBox.TextColor3 = Theme.Text
    targetBox.PlaceholderText = "Full path of remote..."
    targetBox.PlaceholderColor3 = Theme.TextDim
    targetBox.Font = Theme.Font
    targetBox.TextSize = 12
    targetBox.Text = S.CurrencyTargetPath
    targetBox.ClearTextOnFocus = false
    targetBox.Parent = left
    corner(targetBox, 8)
    stroke(targetBox, Theme.Border, 1)
    targetBox:GetPropertyChangedSignal("Text"):Connect(function()
        S.CurrencyTargetPath = targetBox.Text
    end)

    createSection(left, "Arguments")
    local argsBox = Instance.new("TextBox")
    argsBox.Size = UDim2.new(1, 0, 0, 34)
    argsBox.BackgroundColor3 = Theme.RowBg
    argsBox.TextColor3 = Theme.Text
    argsBox.PlaceholderText = "1, 100, \"text\", true..."
    argsBox.PlaceholderColor3 = Theme.TextDim
    argsBox.Font = Theme.Font
    argsBox.TextSize = 12
    argsBox.Text = S.CurrencyArgs
    argsBox.ClearTextOnFocus = false
    argsBox.Parent = left
    corner(argsBox, 8)
    stroke(argsBox, Theme.Border, 1)
    argsBox:GetPropertyChangedSignal("Text"):Connect(function()
        S.CurrencyArgs = argsBox.Text
    end)

    createSection(left, "Manual Fire")
    createTextButton(left, "Fire Once", function()
        local path = S.CurrencyTargetPath
        if not path or path == "" then
            warn("[Currency] No target path set")
            return
        end
        local remote
        pcall(function()
            remote = game:GetDescendants()
            for _, obj in ipairs(remote) do
                if obj:GetFullName() == path or obj.Name == path then
                    if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                        remote = obj
                        break
                    end
                end
            end
        end)
        if not remote or (not remote:IsA("RemoteEvent") and not remote:IsA("RemoteFunction")) then
            warn("[Currency] Remote not found:", path)
            return
        end
        local args = {}
        if S.CurrencyArgs and S.CurrencyArgs ~= "" then
            local fn = loadstring("return {" .. S.CurrencyArgs .. "}")
            if fn then
                local ok, result = pcall(fn)
                if ok and type(result) == "table" then
                    args = result
                end
            end
        end
        local success = pcall(function()
            if remote:IsA("RemoteEvent") then
                remote:FireServer(table.unpack(args))
            elseif remote:IsA("RemoteFunction") then
                remote:InvokeServer(table.unpack(args))
            end
        end)
        print("[Currency] Fired", remote:GetFullName(), success and "OK" or "FAILED")
    end, Theme.CardBg)

    createSection(right, "Auto Fire")
    createBindableToggle(right, "Auto Fire Loop", "CurrencyAutoFire")

    createValueRow(right, "Fire Rate", function() return S.CurrencyFireRate .. "/s" end,
        function() S.CurrencyFireRate = math.clamp(S.CurrencyFireRate - 5, 1, 100) end,
        function() S.CurrencyFireRate = math.clamp(S.CurrencyFireRate + 5, 1, 100) end)

    createTextButton(right, "Stop Auto-Fire", function()
        S.CurrencyAutoFire = false
        print("[Currency] Auto-fire stopped")
    end, Theme.CardBg)

    createSection(right, "How To")
    createLabel(right, "1. Scan remotes")
    createLabel(right, "2. Copy full path")
    createLabel(right, "3. Paste into Target")
    createLabel(right, "4. Add args (optional)")
    createLabel(right, "5. Fire Once to test")
    createLabel(right, "6. Enable Auto Fire")

    createSection(right, "Warning")
    createLabel(right, "Only works on games with no")
    createLabel(right, "server validation or rate limit.")
end

-- CONFIGS TAB
do
    local left, right = ConfigTab.makeColumns()

    createSection(left, "Config Name")
    local nameBox = Instance.new("TextBox")
    nameBox.Size = UDim2.new(1, 0, 0, 36)
    nameBox.BackgroundColor3 = Theme.RowBg
    nameBox.TextColor3 = Theme.Text
    nameBox.PlaceholderText = "Enter config name..."
    nameBox.PlaceholderColor3 = Theme.TextDim
    nameBox.Font = Theme.Font
    nameBox.TextSize = 12
    nameBox.Text = ""
    nameBox.ClearTextOnFocus = false
    nameBox.Parent = left
    corner(nameBox, 8)
    stroke(nameBox, Theme.Border, 1)

    createSection(left, "Actions")
    createTextButton(left, "Create New Config", function()
        local n = nameBox.Text
        if n and n ~= "" then
            createConfig(n)
            if ConfigUI.refreshList then ConfigUI.refreshList() end
            nameBox.Text = ""
        end
    end, Theme.CardBg)

    createTextButton(left, "Save Current Settings", function()
        local n = nameBox.Text
        if n and n ~= "" then
            saveCurrentToConfig(n)
            if ConfigUI.refreshList then ConfigUI.refreshList() end
            nameBox.Text = ""
        end
    end, Theme.CardBg)

    createTextButton(left, "Load Config", function()
        local n = nameBox.Text
        if n and n ~= "" and Configs[n] then
            loadConfig(n)
            SelectedConfig = n
            if ConfigUI.refreshAll then ConfigUI.refreshAll() end
            menuScale.Scale = (S.UIScale or 100) / 100
        end
    end, Theme.CardBg)

    createTextButton(left, "Delete Config", function()
        local n = nameBox.Text
        if n and n ~= "" then
            deleteConfig(n)
            if SelectedConfig == n then SelectedConfig = nil end
            if ConfigUI.refreshList then ConfigUI.refreshList() end
            nameBox.Text = ""
        end
    end, Theme.CardBg)

    createSection(left, "Debug")
    createTextButton(left, "Inspect Players (F9)", function()
        inspectAllPlayers()
    end, Theme.CardBg)

    createSection(right, "Saved Configs")
    local configListFrame = Instance.new("Frame")
    configListFrame.Size = UDim2.new(1, 0, 0, 440)
    configListFrame.BackgroundColor3 = Theme.RowBg
    configListFrame.BorderSizePixel = 0
    configListFrame.Parent = right
    corner(configListFrame, 8)
    stroke(configListFrame, Theme.Border, 1)

    local listScroll = Instance.new("ScrollingFrame")
    listScroll.Size = UDim2.new(1, -12, 1, -12)
    listScroll.Position = UDim2.fromOffset(6, 6)
    listScroll.BackgroundTransparency = 1
    listScroll.BorderSizePixel = 0
    listScroll.ScrollBarThickness = 5
    listScroll.ScrollBarImageColor3 = Theme.Accent
    listScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    listScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    listScroll.Parent = configListFrame

    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 3)
    listLayout.Parent = listScroll

    local function refreshConfigList()
        for _, c in ipairs(listScroll:GetChildren()) do
            if c:IsA("TextButton") or c:IsA("TextLabel") then c:Destroy() end
        end
        local count = 0
        for name, _ in pairs(Configs) do
            count = count + 1
            local row = Instance.new("TextButton")
            row.Size = UDim2.new(1, 0, 0, 32)
            row.BackgroundColor3 = (SelectedConfig == name) and Theme.AccentDeep or Theme.CardBg
            row.Text = (SelectedConfig == name) and ("  › " .. name) or ("    " .. name)
            row.TextColor3 = (SelectedConfig == name) and Theme.AccentBright or Theme.Text
            row.Font = Theme.FontSemi
            row.TextSize = 12
            row.TextXAlignment = Enum.TextXAlignment.Left
            row.AutoButtonColor = false
            row.Parent = listScroll
            corner(row, 6)
            stroke(row, (SelectedConfig == name) and Theme.BorderHot or Theme.Border, 1)
            row.MouseButton1Click:Connect(function()
                if SelectedConfig == name then
                    loadConfig(name)
                    if ConfigUI.refreshAll then ConfigUI.refreshAll() end
                    menuScale.Scale = (S.UIScale or 100) / 100
                else
                    SelectedConfig = name
                    nameBox.Text = name
                    refreshConfigList()
                end
            end)
        end
        if count == 0 then
            local empty = Instance.new("TextLabel")
            empty.Size = UDim2.new(1, 0, 0, 60)
            empty.BackgroundTransparency = 1
            empty.Text = "no configs yet\ncreate one on the left"
            empty.TextColor3 = Theme.TextDim
            empty.Font = Theme.Font
            empty.TextSize = 12
            empty.TextWrapped = true
            empty.Parent = listScroll
        end
    end

    ConfigUI.refreshList = refreshConfigList
    refreshConfigList()
end

-- Open first tab
for _, t in pairs(Tabs) do
    t.Page.Visible = false
    t.Button.BackgroundColor3 = Theme.SidePanel
    t.Icon.TextColor3 = Theme.TextDim
    t.Label.TextColor3 = Theme.TextDim
    t.Bar.Visible = false
end
Tabs["Rage"].Page.Visible = true
Tabs["Rage"].Button.BackgroundColor3 = Theme.CardBg
Tabs["Rage"].Icon.TextColor3 = Theme.AccentBright
Tabs["Rage"].Label.TextColor3 = Theme.TextBright
Tabs["Rage"].Bar.Visible = true
CurrentTabTitle.Text = "RAGE"
CurrentTabSub.Text = Tabs["Rage"].Subtitle

ConfigUI.refreshAll = function()
    for _, refreshFn in ipairs(UIWidgets) do
        pcall(refreshFn)
    end
    if ConfigUI.refreshList then pcall(ConfigUI.refreshList) end
end

-- ============================================================
-- MOVEMENT EXPLOITS
-- ============================================================
local savedCanCollide = {}

local function enableNoClip()
    local char = LP.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
            savedCanCollide[part] = true
            part.CanCollide = false
        end
    end
end

local function disableNoClip()
    for part, _ in pairs(savedCanCollide) do
        pcall(function()
            if part and part.Parent then part.CanCollide = true end
        end)
    end
    savedCanCollide = {}
end

local function applySpeedHack()
    local char = LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    pcall(function() hum.WalkSpeed = S.SpeedValue end)
end

local function applyJumpHack()
    local char = LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    pcall(function() hum.UseJumpPower = true hum.JumpPower = S.JumpPowerValue end)
end

local flyActive = false
local flyBV = nil
local flyBG = nil
local flyConn = nil

local function enableFly()
    if flyActive then return end
    local char = LP.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    flyActive = true

    flyBV = Instance.new("BodyVelocity")
    flyBV.Name = "BrutalFlyBV"
    flyBV.MaxForce = Vector3.new(1e6, 1e6, 1e6)
    flyBV.Velocity = Vector3.zero
    flyBV.Parent = root

    flyBG = Instance.new("BodyGyro")
    flyBG.Name = "BrutalFlyBG"
    flyBG.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
    flyBG.P = 10000
    flyBG.D = 500
    flyBG.CFrame = root.CFrame
    flyBG.Parent = root

    flyConn = RunService.RenderStepped:Connect(function()
        if not flyActive then return end
        local c = LP.Character
        if not c then return end
        local r = c:FindFirstChild("HumanoidRootPart")
        if not r or not flyBV then return end
        local moveDir = Vector3.zero
        local camCF = Cam.CFrame
        if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camCF.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camCF.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camCF.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camCF.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) or UIS:IsKeyDown(Enum.KeyCode.RightShift) then
            moveDir = moveDir - Vector3.new(0, 1, 0)
        end
        if moveDir.Magnitude > 0 then moveDir = moveDir.Unit * S.FlySpeed end
        flyBV.Velocity = moveDir
        flyBG.CFrame = CFrame.new(r.Position, r.Position + camCF.LookVector)
    end)
end

local function disableFly()
    flyActive = false
    if flyConn then flyConn:Disconnect() flyConn = nil end
    if flyBV then pcall(function() flyBV:Destroy() end) flyBV = nil end
    if flyBG then pcall(function() flyBG:Destroy() end) flyBG = nil end
end

local function movementStep()
    if S.NoClip then enableNoClip()
    elseif next(savedCanCollide) then disableNoClip() end
    if S.SpeedHack then applySpeedHack() end
    if S.JumpPowerHack then applyJumpHack() end
end

-- ============================================================
-- ANTI-AIM SYSTEM
-- ============================================================
local aaAngle = 0
local aaLastJitter = 0
local aaJitterOffset = 0
local aaOriginalNeckC0 = nil
local aaOriginalWaistC0 = nil
local aaPitchDirection = 1
local aaLastFlip = 0

local function getNeck()
    local char = LP.Character
    if not char then return nil end
    local upperTorso = char:FindFirstChild("UpperTorso")
    local head = char:FindFirstChild("Head")
    if upperTorso and head then
        local neck = upperTorso:FindFirstChild("Neck")
        if neck then return neck end
    end
    local torso = char:FindFirstChild("Torso")
    if torso and head then
        local neck = torso:FindFirstChild("Neck")
        if neck then return neck end
    end
    return nil
end

local function getWaist()
    local char = LP.Character
    if not char then return nil end
    local lowerTorso = char:FindFirstChild("LowerTorso")
    if lowerTorso then
        local waist = lowerTorso:FindFirstChild("Waist")
        if waist then return waist end
    end
    local root = char:FindFirstChild("HumanoidRootPart")
    local torso = char:FindFirstChild("Torso")
    if root and torso then
        local rj = root:FindFirstChild("RootJoint")
        if rj then return rj end
    end
    return nil
end

local function calculatePitch()
    local mode = S.AAPitchMode
    if mode == "Off" then return 0 end
    if mode == "Down" then return math.rad(S.AAPitchAngle) end
    if mode == "Up" then return math.rad(-S.AAPitchAngle) end
    if mode == "Flip" then
        local now = tick()
        if now - aaLastFlip >= S.AAPitchFlipSpeed then
            aaLastFlip = now
            aaPitchDirection = -aaPitchDirection
        end
        return math.rad(S.AAPitchAngle * aaPitchDirection)
    end
    return 0
end

local function antiAimStep()
    if not S.AntiAim then
        local neck = getNeck()
        if neck and aaOriginalNeckC0 then
            pcall(function() neck.C0 = aaOriginalNeckC0 end)
            aaOriginalNeckC0 = nil
        end
        local waist = getWaist()
        if waist and aaOriginalWaistC0 then
            pcall(function() waist.C0 = aaOriginalWaistC0 end)
            aaOriginalWaistC0 = nil
        end
        return
    end

    local char = LP.Character
    if not char then return end

    aaAngle = aaAngle + S.AASpinSpeed
    if aaAngle >= 360 then aaAngle = aaAngle - 360 end

    if S.AAJitter then
        if tick() - aaLastJitter > 0.05 then
            aaLastJitter = tick()
            aaJitterOffset = math.random(-180, 180)
        end
    else
        aaJitterOffset = 0
    end

    local finalYaw = aaAngle + aaJitterOffset
    local pitchRad = calculatePitch()

    if S.AASpinBody then
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            pcall(function()
                root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, math.rad(finalYaw), 0)
            end)
        end
    end

    if S.AASpinHead or S.AAPitchMode ~= "Off" then
        local neck = getNeck()
        if neck then
            if not aaOriginalNeckC0 then
                aaOriginalNeckC0 = neck.C0
            end
            local spinRad = math.rad(finalYaw)
            local rollRad = math.rad(S.AAHeadRoll)
            pcall(function()
                neck.C0 = aaOriginalNeckC0 * CFrame.Angles(pitchRad, spinRad, rollRad)
            end)
        end
    else
        if aaOriginalNeckC0 then
            local neck = getNeck()
            if neck then
                pcall(function() neck.C0 = aaOriginalNeckC0 end)
                aaOriginalNeckC0 = nil
            end
        end
    end

    if S.AAPitchMode ~= "Off" then
        local waist = getWaist()
        if waist then
            if not aaOriginalWaistC0 then
                aaOriginalWaistC0 = waist.C0
            end
            pcall(function()
                waist.C0 = aaOriginalWaistC0 * CFrame.Angles(pitchRad * 0.5, 0, 0)
            end)
        end
    else
        if aaOriginalWaistC0 then
            local waist = getWaist()
            if waist then
                pcall(function() waist.C0 = aaOriginalWaistC0 end)
                aaOriginalWaistC0 = nil
            end
        end
    end
end

-- ============================================================
-- THIRD PERSON
-- ============================================================
local tp = {
    savedType = nil, savedSubj = nil, savedMin = nil, savedMax = nil,
    savedFOV = nil, savedMode = nil, hiddenParts = {}, active = false,
    currentDist = 0,
}

local function hideArmsTP()
    local c = LP.Character
    if not c then return end
    for _, o in ipairs(c:GetDescendants()) do
        if o:IsA("BasePart") and o.Name ~= "HumanoidRootPart" then
            if tp.hiddenParts[o] == nil then tp.hiddenParts[o] = o.LocalTransparencyModifier end
            o.LocalTransparencyModifier = 1
        end
    end
end

local function restoreArmsTP()
    for part, orig in pairs(tp.hiddenParts) do
        pcall(function()
            if part and part.Parent then part.LocalTransparencyModifier = orig or 0 end
        end)
    end
    tp.hiddenParts = {}
end

local function enableThirdPerson()
    if tp.active then return end
    tp.savedType = Cam.CameraType
    tp.savedSubj = Cam.CameraSubject
    tp.savedMin = LP.CameraMinZoomDistance
    tp.savedMax = LP.CameraMaxZoomDistance
    tp.savedFOV = Cam.FieldOfView
    tp.savedMode = LP.CameraMode
    tp.currentDist = S.ThirdPersonDistance

    pcall(function() Cam.CameraType = Enum.CameraType.Scriptable end)
    pcall(function() LP.CameraMode = Enum.CameraMode.Classic end)
    tp.active = true
end

local function disableThirdPerson()
    if not tp.active then return end
    restoreArmsTP()
    pcall(function()
        Cam.CameraType = tp.savedType or Enum.CameraType.Custom
        Cam.CameraSubject = tp.savedSubj or (LP.Character and LP.Character:FindFirstChildOfClass("Humanoid"))
    end)
    pcall(function()
        if tp.savedMin then LP.CameraMinZoomDistance = tp.savedMin end
        if tp.savedMax then LP.CameraMaxZoomDistance = tp.savedMax end
    end)
    pcall(function() if tp.savedFOV then Cam.FieldOfView = tp.savedFOV end end)
    pcall(function() if tp.savedMode then LP.CameraMode = tp.savedMode end end)
    tp.active = false
    task.delay(0.15, function()
        if tp.active then return end
        pcall(function() Cam.CameraType = tp.savedType or Enum.CameraType.Custom end)
    end)
    task.delay(0.2, function()
        if not tp.active then
            tp.savedType = nil; tp.savedSubj = nil; tp.savedMin = nil
            tp.savedMax = nil; tp.savedFOV = nil; tp.savedMode = nil
        end
    end)
end

local function getTPSubject()
    local c = LP.Character
    if not c then return nil end
    local head = c:FindFirstChild("Head")
    local root = c:FindFirstChild("HumanoidRootPart")
    local base = head or root
    if not base then return nil end
    return base.Position + S.ThirdPersonOffset
end

local function thirdStep()
    if not S.ThirdPerson then
        if tp.active then disableThirdPerson() end
        return
    end
    if not tp.active then enableThirdPerson() end

    pcall(function() Cam.CameraType = Enum.CameraType.Scriptable end)
    if S.ThirdPersonHideArms then hideArmsTP() else restoreArmsTP() end

    local subject = getTPSubject()
    if not subject then return end

    local lookDir = Cam.CFrame.LookVector
    if lookDir.Magnitude < 0.01 then
        lookDir = Vector3.new(0, 0, -1)
    end
    lookDir = lookDir.Unit

    local desiredDist = S.ThirdPersonDistance
    local desiredPos = subject - lookDir * desiredDist
    local finalPos = desiredPos

    if S.ThirdPersonWallCheck then
        local rayDir = desiredPos - subject
        local rayLen = rayDir.Magnitude
        if rayLen > 0.01 then
            local rp = RaycastParams.new()
            rp.FilterType = Enum.RaycastFilterType.Exclude
            rp.FilterDescendantsInstances = { LP.Character, Cam }
            rp.IgnoreWater = true
            local hit = workspace:Raycast(subject, rayDir.Unit * rayLen, rp)
            if hit then
                local clampedDist = math.max(S.ThirdPersonMinDistance, (hit.Position - subject).Magnitude - 0.5)
                finalPos = subject - lookDir * clampedDist
            end
        end
    end

    if S.ThirdPersonSmooth then
        local targetDist = (finalPos - subject).Magnitude
        tp.currentDist = tp.currentDist + (targetDist - tp.currentDist) * S.ThirdPersonSmoothSpeed
        finalPos = subject - lookDir * tp.currentDist
    end

    pcall(function()
        Cam.CFrame = CFrame.lookAt(finalPos, subject)
    end)
end

-- ============================================================
-- CURRENCY AUTO-FIRE
-- ============================================================
local currencyConn = nil
local currencyLastFire = 0

local function fireCurrencyOnce()
    local path = S.CurrencyTargetPath
    if not path or path == "" then return false end
    local remote
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            if obj:GetFullName() == path or obj.Name == path then
                remote = obj
                break
            end
        end
    end
    if not remote then return false end

    local args = {}
    if S.CurrencyArgs and S.CurrencyArgs ~= "" then
        local fn = loadstring("return {" .. S.CurrencyArgs .. "}")
        if fn then
            local ok, result = pcall(fn)
            if ok and type(result) == "table" then
                args = result
            end
        end
    end

    return pcall(function()
        if remote:IsA("RemoteEvent") then
            remote:FireServer(table.unpack(args))
        elseif remote:IsA("RemoteFunction") then
            remote:InvokeServer(table.unpack(args))
        end
    end)
end

task.spawn(function()
    while true do
        if S.CurrencyAutoFire then
            local interval = 1 / math.max(S.CurrencyFireRate, 1)
            if tick() - currencyLastFire >= interval then
                currencyLastFire = tick()
                fireCurrencyOnce()
            end
        end
        task.wait(0.005)
    end
end)

-- ============================================================
-- FOLDERS + STATE
-- ============================================================
local ESPFolder = Instance.new("Folder")
ESPFolder.Parent = gui
local TracerFolder = Instance.new("Folder")
TracerFolder.Parent = gui

local boxes, skeletons, highlights = {}, {}, {}
local targetData = {}
local activeTracers = {}

local function clearBoxes()
    for _, v in pairs(boxes) do pcall(function() v:Destroy() end) end
    boxes = {}
end
local function clearSkeletons()
    for _, d in pairs(skeletons) do
        for _, l in pairs(d.lines) do pcall(function() l:Destroy() end) end
    end
    skeletons = {}
end
local function clearChams()
    for _, h in pairs(highlights) do pcall(function() h:Destroy() end) end
    highlights = {}
end

local function refresh()
    targetData = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then
            local char = getCharacter(p)
            if char and isValidCharacter(char, p) then
                table.insert(targetData, { model = char, plr = p })
            end
        end
    end
end

refresh()
Players.PlayerAdded:Connect(function() task.wait(1) refresh() end)
Players.PlayerRemoving:Connect(function() task.wait(0.1) refresh() end)
task.spawn(function()
    while true do refresh() task.wait(0.5) end
end)

-- ============================================================
-- ESP
-- ============================================================
local function getBoxColorFor(player)
    if S.UseTeamColors then return getTeamColor(player) end
    return S.BoxColor
end

local function createBox()
    local f = Instance.new("Frame")
    f.BackgroundTransparency = 1
    f.Visible = false
    f.Parent = ESPFolder
    local s = Instance.new("UIStroke")
    s.Thickness = 1.5
    s.Parent = f
    return f
end

local function updBoxEntry(entry)
    local m = entry.model
    local p = entry.plr
    if not m or not m.Parent or isDead(m, p) then
        if boxes[m] then boxes[m]:Destroy() boxes[m] = nil end
        return
    end
    if not boxes[m] then boxes[m] = createBox() end
    local head = m:FindFirstChild("Head")
    local root = m:FindFirstChild("HumanoidRootPart") or m.PrimaryPart
        or m:FindFirstChild("UpperTorso") or m:FindFirstChild("Torso")
    if not root then boxes[m].Visible = false return end
    local top = head and (head.Position + Vector3.new(0, 0.7, 0)) or (root.Position + Vector3.new(0, 2.3, 0))
    local bot = root.Position - Vector3.new(0, 3, 0)
    local tP, tO = Cam:WorldToViewportPoint(top)
    local bP, bO = Cam:WorldToViewportPoint(bot)
    if (not tO and not bO) or tP.Z < 0 then boxes[m].Visible = false return end
    local h = math.abs(tP.Y - bP.Y)
    local w = h * 0.65
    boxes[m].Position = UDim2.fromOffset((tP.X + bP.X)/2 - w/2, math.min(tP.Y, bP.Y))
    boxes[m].Size = UDim2.fromOffset(w, h)
    boxes[m].UIStroke.Color = getBoxColorFor(p)
    boxes[m].Visible = true
end

local BoneConnections = {
    {"Head", "UpperTorso"},
    {"UpperTorso", "LowerTorso"},
    {"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"}, {"LeftLowerArm", "LeftHand"},
    {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"}, {"RightLowerArm", "RightHand"},
    {"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"}, {"LeftLowerLeg", "LeftFoot"},
    {"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}, {"RightLowerLeg", "RightFoot"},
}

local function updSkeletonEntry(entry)
    local m = entry.model
    local p = entry.plr
    if not m or not m.Parent or isDead(m, p) then
        if skeletons[m] then
            for _, l in pairs(skeletons[m].lines) do pcall(function() l:Destroy() end) end
            skeletons[m] = nil
        end
        return
    end
    if not skeletons[m] then
        skeletons[m] = { lines = {} }
        for i = 1, #BoneConnections do
            local l = Instance.new("Frame")
            l.BackgroundColor3 = S.SkeletonColor
            l.BorderSizePixel = 0
            l.AnchorPoint = Vector2.new(0.5, 0.5)
            l.Visible = false
            l.Parent = ESPFolder
            table.insert(skeletons[m].lines, l)
        end
    end
    for i, conn in ipairs(BoneConnections) do
        local p1 = m:FindFirstChild(conn[1])
        local p2 = m:FindFirstChild(conn[2])
        local line = skeletons[m].lines[i]
        if p1 and p2 and p1:IsA("BasePart") and p2:IsA("BasePart") then
            local a, aO = Cam:WorldToViewportPoint(p1.Position)
            local b, bO = Cam:WorldToViewportPoint(p2.Position)
            if aO and bO and a.Z > 0 and b.Z > 0 then
                local pa = Vector2.new(a.X, a.Y)
                local pb = Vector2.new(b.X, b.Y)
                local dist = (pb - pa).Magnitude
                local mid = (pa + pb) / 2
                local ang = math.deg(math.atan2(pb.Y - pa.Y, pb.X - pa.X))
                line.Position = UDim2.fromOffset(mid.X, mid.Y)
                line.Size = UDim2.fromOffset(dist, 2)
                line.Rotation = ang
                line.BackgroundColor3 = S.UseTeamColors and getTeamColor(p) or S.SkeletonColor
                line.Visible = true
            else
                line.Visible = false
            end
        else
            line.Visible = false
        end
    end
end

local function updChamsEntry(entry)
    local m = entry.model
    local p = entry.plr
    if not m or not m.Parent or isDead(m, p) then
        if highlights[m] then highlights[m]:Destroy() highlights[m] = nil end
        return
    end
    if not highlights[m] then
        local h
        pcall(function()
            h = Instance.new("Highlight")
            h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            h.Parent = m
        end)
        highlights[m] = h
    end
    if highlights[m] then
        pcall(function()
            highlights[m].Enabled = true
            highlights[m].FillColor = S.UseTeamColors and getTeamColor(p) or S.ChamsColor
            highlights[m].OutlineColor = S.UseTeamColors and getTeamColor(p) or S.ChamsColor
            highlights[m].FillTransparency = S.ChamsFillTransparency
        end)
    end
end

-- ============================================================
-- TRACERS
-- ============================================================
local function createTracer(worldStart, worldEnd, color, thickness)
    local line = Instance.new("Frame")
    line.BackgroundColor3 = color
    line.BorderSizePixel = 0
    line.AnchorPoint = Vector2.new(0.5, 0.5)
    line.ZIndex = 5
    line.Parent = TracerFolder
    local tracer = { Frame = line, Start = worldStart, End = worldEnd, Color = color, Thickness = thickness, SpawnTime = tick() }
    table.insert(activeTracers, tracer)
    return tracer
end

local function updTracer(tracer)
    local a, aO = Cam:WorldToViewportPoint(tracer.Start)
    local b, bO = Cam:WorldToViewportPoint(tracer.End)
    if not aO or not bO or a.Z < 0 or b.Z < 0 then
        tracer.Frame.Visible = false
        return
    end
    local pa = Vector2.new(a.X, a.Y)
    local pb = Vector2.new(b.X, b.Y)
    local dist = (pb - pa).Magnitude
    local mid = (pa + pb) / 2
    local ang = math.deg(math.atan2(pb.Y - pa.Y, pb.X - pa.X))
    tracer.Frame.Position = UDim2.fromOffset(mid.X, mid.Y)
    tracer.Frame.Size = UDim2.fromOffset(dist, tracer.Thickness)
    tracer.Frame.Rotation = ang
    tracer.Frame.BackgroundColor3 = S.TracerColor
    tracer.Frame.Visible = true
end

local function cleanTracers()
    local now = tick()
    for i = #activeTracers, 1, -1 do
        local t = activeTracers[i]
        if now - t.SpawnTime >= S.TracerLifetime then
            pcall(function() t.Frame:Destroy() end)
            table.remove(activeTracers, i)
        end
    end
end

-- ============================================================
-- AIM HELPERS
-- ============================================================
local function getHitboxFor(model, kind)
    if not model then return nil end
    if kind == "Head" then
        return model:FindFirstChild("Head") or model:FindFirstChild("UpperTorso")
            or model:FindFirstChild("Torso") or model:FindFirstChild("HumanoidRootPart")
    end
    if kind == "Torso" then
        return model:FindFirstChild("UpperTorso") or model:FindFirstChild("Torso")
            or model:FindFirstChild("LowerTorso") or model:FindFirstChild("HumanoidRootPart")
            or model:FindFirstChild("Head")
    end
    return model:FindFirstChild("LeftUpperLeg") or model:FindFirstChild("RightUpperLeg")
        or model:FindFirstChild("Left Leg") or model:FindFirstChild("Right Leg")
        or model:FindFirstChild("LowerTorso") or model:FindFirstChild("UpperTorso")
        or model:FindFirstChild("Torso")
end

local function hasLOS(part)
    if not S.RageWallCheck then return true end
    if not part then return false end
    local o = Cam.CFrame.Position
    local d = part.Position - o
    local rp = RaycastParams.new()
    rp.FilterType = Enum.RaycastFilterType.Exclude
    rp.FilterDescendantsInstances = { LP.Character, Cam }
    rp.IgnoreWater = true
    local res = workspace:Raycast(o, d, rp)
    if not res then return true end
    return res.Instance == part or res.Instance:IsDescendantOf(part.Parent)
end

local function pressM1()
    local c = LP.Character
    if not c then return end
    if typeof(mouse1click) == "function" then
        if pcall(mouse1click) then return end
    end
    if typeof(mouse1press) == "function" and typeof(mouse1release) == "function" then
        if pcall(function() mouse1press(); task.wait(0.01); mouse1release() end) then return end
    end
    if typeof(keypress) == "function" then
        if pcall(function()
            keypress(0x01); task.wait(0.01)
            if typeof(keyrelease) == "function" then keyrelease(0x01) end
        end) then return end
    end
    local tool = c:FindFirstChildOfClass("Tool")
    if tool then pcall(function() tool:Activate() end) return end
    if VIM then
        local p = UIS:GetMouseLocation()
        pcall(function()
            VIM:SendMouseButtonEvent(p.X, p.Y, 0, true, game, 0)
            task.wait(0.01)
            VIM:SendMouseButtonEvent(p.X, p.Y, 0, false, game, 0)
        end)
    end
end

local lastShot = 0
local aimRef, aimActive = nil, false

local function findTarget(hitboxKind, fov, maxDist)
    local myChar = LP.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then myRoot = { Position = Cam.CFrame.Position } end
    local look = Cam.CFrame.LookVector
    local camPos = Cam.CFrame.Position
    local cosT = fov >= 360 and -1 or math.cos(math.rad(fov * 0.5))
    local best = nil
    local bestPart = nil
    local bestDot = cosT
    for _, entry in ipairs(targetData) do
        local m = entry.model
        local p = entry.plr
        if m and m.Parent and not isDead(m, p) then
            local part = getHitboxFor(m, hitboxKind)
            if part then
                local wd = (part.Position - myRoot.Position).Magnitude
                if wd <= (maxDist or 500) then
                    local d = part.Position - camPos
                    if d.Magnitude > 0.1 then
                        local dot = look:Dot(d.Unit)
                        if dot >= cosT and dot > bestDot then
                            bestDot = dot; best = m; bestPart = part
                        end
                    end
                end
            end
        end
    end
    return best, bestPart
end

-- ============================================================
-- RAGE AIMBOT
-- ============================================================
local rageLastShot = 0
local rageLockedTarget = nil
local rageLockedFrames = 0
local rageLockedPos = nil

local function rageStep()
    if not S.RageAimbot then
        rageLockedTarget = nil; rageLockedFrames = 0; rageLockedPos = nil
        return
    end
    local target, part = findTarget(S.RageHitbox, S.RageFOV, S.RageMaxDistance)
    if not part then
        rageLockedTarget = nil; rageLockedFrames = 0; rageLockedPos = nil
        return
    end
    if not hasLOS(part) then
        rageLockedTarget = nil; rageLockedFrames = 0; rageLockedPos = nil
        return
    end
    local vel = nil
    pcall(function() vel = part.AssemblyLinearVelocity or part.Velocity end)
    local speed = vel and vel.Magnitude or 0
    local leadTime = S.RagePrediction
    if S.RageAdaptiveLead and speed > 10 then
        leadTime = leadTime + math.min(speed * 0.005, 0.08)
    end
    local aimPos = part.Position
    if vel and speed > 1 then aimPos = part.Position + vel * leadTime end
    if rageLockedTarget ~= part then
        rageLockedTarget = part; rageLockedFrames = 0; rageLockedPos = nil
    end
    pcall(function() Cam.CFrame = CFrame.lookAt(Cam.CFrame.Position, aimPos) end)
    local look = Cam.CFrame.LookVector
    local toTarget = aimPos - Cam.CFrame.Position
    if toTarget.Magnitude < 0.1 then
        rageLockedFrames = 0; rageLockedPos = nil; return
    end
    local dot = math.clamp(look:Dot(toTarget.Unit), -1, 1)
    local angleDeg = math.deg(math.acos(dot))
    if angleDeg <= S.RageFireAngle then
        if rageLockedPos and (aimPos - rageLockedPos).Magnitude > 2 then rageLockedFrames = 0 end
        rageLockedPos = aimPos
        rageLockedFrames = rageLockedFrames + 1
        if rageLockedFrames >= S.RageLockFrames then
            if S.RageAutoShoot then
                if tick() - rageLastShot >= S.RageShootDelay then
                    rageLastShot = tick()
                    pressM1()
                    if S.Tracers then createTracer(Cam.CFrame.Position, aimPos, S.TracerColor, S.TracerThickness) end
                end
            end
        end
    else
        rageLockedFrames = 0; rageLockedPos = nil
    end
end

-- ============================================================
-- SILENT AIM
-- ============================================================
local silentLastFire = 0
local silentStableSince = 0
local silentLastLook = nil

local function silentAimStep()
    if not S.SilentAim then silentLastLook = nil silentStableSince = 0 return end
    if S.Aimbot or S.RageAimbot then return end
    local now = tick()
    local target, part = findTarget(S.SilentAimHitbox, S.SilentAimFOV, S.RageMaxDistance)
    if not part then silentLastLook = nil silentStableSince = 0 return end
    if not hasLOS(part) then return end
    local camPos = Cam.CFrame.Position
    local look = Cam.CFrame.LookVector
    local toTarget = part.Position - camPos
    if toTarget.Magnitude < 0.1 then return end
    local ang = math.deg(math.acos(math.clamp(look:Dot(toTarget.Unit), -1, 1)))
    if ang > S.SilentAimAngleThreshold then return end
    if silentLastLook then
        if look:Dot(silentLastLook) > 0.9995 then
            if silentStableSince == 0 then silentStableSince = now end
        else silentStableSince = 0 end
    else silentStableSince = 0 end
    silentLastLook = look
    if S.SilentAimSettle > 0 then
        if silentStableSince == 0 or (now - silentStableSince) < S.SilentAimSettle then return end
    end
    if now - silentLastFire < 0.05 then return end
    silentLastFire = now
    local savedCFrame = Cam.CFrame
    local snapCFrame = CFrame.lookAt(camPos, part.Position)
    pcall(function() Cam.CFrame = snapCFrame end)
    pcall(function() pressM1() end)
    pcall(function() Cam.CFrame = savedCFrame end)
    if S.Tracers then createTracer(camPos, part.Position, S.TracerColor, S.TracerThickness) end
end

local function aimStep()
    if not S.Aimbot then aimActive = false aimRef = nil return end
    local cP = Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2)
    local rad = (S.FOV/180) * (Cam.ViewportSize.Y * 0.55)
    local bp, bd = nil, math.huge
    for _, entry in ipairs(targetData) do
        local m = entry.model
        local p = entry.plr
        if m and m.Parent and not isDead(m, p) then
            local parts = {}
            if S.HitboxHead then table.insert(parts, m:FindFirstChild("Head")) end
            if S.HitboxTorso then table.insert(parts, m:FindFirstChild("UpperTorso") or m:FindFirstChild("Torso") or m:FindFirstChild("HumanoidRootPart")) end
            if S.HitboxLegs then table.insert(parts, m:FindFirstChild("LeftUpperLeg")) end
            for _, p2 in ipairs(parts) do
                if p2 then
                    local pos, on = Cam:WorldToViewportPoint(p2.Position)
                    if on and pos.Z > 0 then
                        local d = (Vector2.new(pos.X, pos.Y) - cP).Magnitude
                        if d <= rad and d < bd then bd = d; bp = p2 end
                    end
                end
            end
        end
    end
    if not bp then aimActive = false aimRef = nil return end
    local desired = CFrame.lookAt(Cam.CFrame.Position, bp.Position)
    if not aimActive then aimActive = true aimRef = Cam.CFrame end
    local blend = math.clamp(S.AimSmoothing, 0.01, 1)
    local nc = aimRef:Lerp(desired, blend)
    pcall(function() Cam.CFrame = nc end)
    aimRef = nc
end

-- ============================================================
-- BHOP
-- ============================================================
local bhopHeld = false

local function bhopStep()
    if not S.Bhop or not bhopHeld then return end
    local c = LP.Character
    if not c then return end
    local h = c:FindFirstChildOfClass("Humanoid")
    local r = c:FindFirstChild("HumanoidRootPart")
    if not h or not r then return end
    if h.FloorMaterial ~= Enum.Material.Air and r.AssemblyLinearVelocity.Y <= 0.05 then
        h.Jump = true
        pcall(function() h:ChangeState(Enum.HumanoidStateType.Jumping) end)
    else h.Jump = true end
    if S.BhopSpeedBoost then pcall(function() h.WalkSpeed = S.BhopSpeed end) end
end

task.spawn(function()
    local wasBoost = false
    while true do
        local active = S.BhopSpeedBoost and S.Bhop and bhopHeld
        if active then wasBoost = true
        elseif wasBoost then
            local c = LP.Character
            if c then
                local h = c:FindFirstChildOfClass("Humanoid")
                if h then pcall(function() h.WalkSpeed = 16 end) end
            end
            wasBoost = false
        end
        task.wait(0.2)
    end
end)

-- ============================================================
-- FOV CIRCLE
-- ============================================================
local fovCircle = Instance.new("Frame")
fovCircle.AnchorPoint = Vector2.new(0.5, 0.5)
fovCircle.Position = UDim2.fromScale(0.5, 0.5)
fovCircle.BackgroundTransparency = 1
fovCircle.Visible = false
fovCircle.Parent = gui
Instance.new("UICorner", fovCircle).CornerRadius = UDim.new(1, 0)
local cs = Instance.new("UIStroke")
cs.Thickness = 1.5
cs.Color = Theme.Accent
cs.Parent = fovCircle

-- ============================================================
-- KEYBINDS
-- ============================================================
UIS.InputBegan:Connect(function(i, gp)
    if gp then return end
    if i.KeyCode == Enum.KeyCode.Space then bhopHeld = true end
    for k, kb in pairs(Binds) do
        if kb and i.KeyCode == kb then
            if k == "MenuToggle" then
                Menu.Visible = not Menu.Visible
            elseif S[k] ~= nil then
                S[k] = not S[k]
                if not S[k] then
                    if k == "BoxESP" then clearBoxes() end
                    if k == "SkeletonESP" then clearSkeletons() end
                    if k == "Chams" then clearChams() end
                    if k == "ThirdPerson" and tp.active then disableThirdPerson() end
                    if k == "NoClip" then disableNoClip() end
                    if k == "Fly" then disableFly() end
                    if k == "SpeedHack" then
                        local char = LP.Character
                        local hum = char and char:FindFirstChildOfClass("Humanoid")
                        if hum then pcall(function() hum.WalkSpeed = 16 end) end
                    end
                    if k == "JumpPowerHack" then
                        local char = LP.Character
                        local hum = char and char:FindFirstChildOfClass("Humanoid")
                        if hum then pcall(function() hum.JumpPower = 50 end) end
                    end
                end
            end
        end
    end
end)

UIS.InputEnded:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.Space then bhopHeld = false end
end)

-- ============================================================
-- MAIN LOOPS
-- ============================================================
pcall(function() RunService:UnbindFromRenderStep("BrutalSRG_Render") end)

RunService:BindToRenderStep("BrutalSRG_Render", Enum.RenderPriority.Camera.Value + 1, function()
    Cam = workspace.CurrentCamera
    if S.AntiAim then antiAimStep() end
    if S.RageAimbot then rageStep()
    elseif S.SilentAim then silentAimStep()
    elseif S.ThirdPerson then thirdStep()
    else aimStep() end
end)

local bhopConn = RunService.Stepped:Connect(function() bhopStep() end)

local moveConn = RunService.Heartbeat:Connect(function()
    if S.NoClip or S.SpeedHack or S.JumpPowerHack then movementStep() end
end)

local flyBindConn = UIS.InputBegan:Connect(function(i, gp)
    if gp then return end
    if not S.Fly then return end
    if i.KeyCode == Enum.KeyCode.F then enableFly() end
end)

local flyReleaseConn = UIS.InputEnded:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.F then disableFly() end
end)

local lastRender = 0
local renderConn = RunService.RenderStepped:Connect(function()
    fovCircle.Visible = S.FOVVisual
    if S.FOVVisual then fovCircle.Size = UDim2.fromOffset(S.FOV * 2.8, S.FOV * 2.8) end
    local now = tick()
    if now - lastRender >= 0.022 then
        lastRender = now
        for _, entry in ipairs(targetData) do
            if S.BoxESP then updBoxEntry(entry) end
            if S.SkeletonESP then updSkeletonEntry(entry) end
            if S.Chams then updChamsEntry(entry) end
        end
    end
    if S.Tracers then
        for _, t in ipairs(activeTracers) do updTracer(t) end
    end
    cleanTracers()
end)

-- ============================================================
-- CLEANUP
-- ============================================================
if getgenv then
    getgenv().BrutalSRGCleanup = function()
        pcall(function() RunService:UnbindFromRenderStep("BrutalSRG_Render") end)
        pcall(function() bhopConn:Disconnect() end)
        pcall(function() moveConn:Disconnect() end)
        pcall(function() flyBindConn:Disconnect() end)
        pcall(function() flyReleaseConn:Disconnect() end)
        pcall(function() renderConn:Disconnect() end)
        pcall(function() if tp.active then disableThirdPerson() end end)
        pcall(function() disableNoClip() end)
        pcall(function() disableFly() end)
        pcall(function() gui:Destroy() end)
    end
end

print("=== BrutalSRGroblox loaded ===")
print("Executor:", EXECUTOR_NAME)
print("GUI parent:", parentName)
print("INSERT = Toggle Menu")
