-- Services
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

-- Detect executor safely
local executorName = "Unknown Executor"
if type(identifyexecutor) == "function" then
    local success, nameOrTable = pcall(identifyexecutor)
    if success then
        if type(nameOrTable) == "string" then
            executorName = nameOrTable
        elseif type(nameOrTable) == "table" then
            local name, version = identifyexecutor()
            if name and name ~= "Unknown" then
                executorName = name .. " " .. (version or "")
            end
        else
            local name, version = identifyexecutor()
            if name and name ~= "Unknown" then
                executorName = name .. " " .. (version or "")
            end
        end
    end
end

-- Modern Blur Effect with smoother transition
local blur = Instance.new("BlurEffect")
blur.Parent = Lighting
blur.Size = 0
blur.Enabled = true

-- UI Container
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LumenSplash"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = game.CoreGui

-- Background overlay for better contrast
local overlay = Instance.new("Frame")
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.Position = UDim2.new(0, 0, 0, 0)
overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
overlay.BackgroundTransparency = 0.4
overlay.BorderSizePixel = 0
overlay.ZIndex = 1
overlay.Parent = screenGui

-- Main container for centered content
local mainContainer = Instance.new("Frame")
mainContainer.Size = UDim2.new(0.8, 0, 0.4, 0)
mainContainer.Position = UDim2.new(0.1, 0, 0.3, 0) -- Perfect center
mainContainer.BackgroundTransparency = 1
mainContainer.ZIndex = 2
mainContainer.Parent = screenGui

-- Main Title (Lumen) - Large, Bold, Centered
local logoText = Instance.new("TextLabel")
logoText.Size = UDim2.new(1, 0, 0.5, 0)
logoText.Position = UDim2.new(0, 0, 0.2, 0)
logoText.BackgroundTransparency = 1
logoText.Text = "Lumen"
logoText.TextColor3 = Color3.fromRGB(255, 255, 255)
logoText.Font = Enum.Font.GothamBold
logoText.TextScaled = true
logoText.TextStrokeTransparency = 0
logoText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
logoText.ZIndex = 3
-- Add subtle shadow effect
logoText.TextTransparency = 0
logoText.Parent = mainContainer

-- Subtitle (Free · ExecutorName) - Medium size
local subText = Instance.new("TextLabel")
subText.Size = UDim2.new(1, 0, 0.15, 0)
subText.Position = UDim2.new(0, 0, 1, 0)
subText.BackgroundTransparency = 1
subText.Text = "Free · " .. executorName
subText.TextColor3 = Color3.fromRGB(249, 233, 153)
subText.Font = Enum.Font.Gotham
subText.TextScaled = true
subText.TextStrokeTransparency = 0.3
subText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
subText.ZIndex = 3
subText.Parent = mainContainer

-- Link (.gg/lumen) - Smaller size
local linkText = Instance.new("TextLabel")
linkText.Size = UDim2.new(1, 0, 0.12, 0)
linkText.Position = UDim2.new(0, 0, 2, 0)
linkText.BackgroundTransparency = 1
linkText.Text = ".gg/lumen"
linkText.TextColor3 = Color3.fromRGB(200, 200, 200)
linkText.Font = Enum.Font.Gotham
linkText.TextScaled = true
linkText.TextStrokeTransparency = 0.5
linkText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
linkText.ZIndex = 3
linkText.Parent = mainContainer

-- Set initial positions for slide animation (start from bottom)
logoText.Position = UDim2.new(0, 0, 0.4, 0)
subText.Position = UDim2.new(0, 0, 0.85, 0)
linkText.Position = UDim2.new(0, 0, 1, 0)

-- Set initial transparency for fade in
logoText.TextTransparency = 1
subText.TextTransparency = 1
linkText.TextTransparency = 1
overlay.BackgroundTransparency = 1

-- Animate IN with staggered timing for professional effect
local blurTween = TweenService:Create(blur, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = 24})
local overlayTween = TweenService:Create(overlay, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0.3})

blurTween:Play()
overlayTween:Play()

-- Logo animation (first)
task.wait(0.3)
local logoPosTween = TweenService:Create(logoText, TweenInfo.new(1.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    Position = UDim2.new(0, 0, 0.2, 0)
})
local logoFadeTween = TweenService:Create(logoText, TweenInfo.new(1.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    TextTransparency = 0
})
logoPosTween:Play()
logoFadeTween:Play()

-- Subtitle animation (second)
task.wait(0.2)
local subPosTween = TweenService:Create(subText, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    Position = UDim2.new(0, 0, 0.65, 0)
})
local subFadeTween = TweenService:Create(subText, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    TextTransparency = 0
})
subPosTween:Play()
subFadeTween:Play()

-- Link animation (third)
task.wait(0.15)
local linkPosTween = TweenService:Create(linkText, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    Position = UDim2.new(0, 0, 0.8, 0)
})
local linkFadeTween = TweenService:Create(linkText, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    TextTransparency = 0
})
linkPosTween:Play()
linkFadeTween:Play()

-- Wait for full display
task.wait(2.8)

-- Animate OUT with buttery smooth transitions
local blurOutTween = TweenService:Create(blur, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {Size = 0})
local overlayOutTween = TweenService:Create(overlay, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {BackgroundTransparency = 1})

-- Logo fade out - Ultra smooth
local logoOutPos = TweenService:Create(logoText, TweenInfo.new(1.6, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
    Position = UDim2.new(0, 0, -0.15, 0)
})
local logoOutFade = TweenService:Create(logoText, TweenInfo.new(1.6, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
    TextTransparency = 1
})

-- Subtitle fade out - Smooth follow
local subOutPos = TweenService:Create(subText, TweenInfo.new(1.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
    Position = UDim2.new(0, 0, 0.53, 0)
})
local subOutFade = TweenService:Create(subText, TweenInfo.new(1.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
    TextTransparency = 1
})

-- Link fade out - Smooth follow
local linkOutPos = TweenService:Create(linkText, TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
    Position = UDim2.new(0, 0, 0.71, 0)
})
local linkOutFade = TweenService:Create(linkText, TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
    TextTransparency = 1
})

-- Play all out animations with tighter timing
blurOutTween:Play()
overlayOutTween:Play()
logoOutPos:Play()
logoOutFade:Play()
task.wait(0.08)
subOutPos:Play()
subOutFade:Play()
task.wait(0.08)
linkOutPos:Play()
linkOutFade:Play()

-- Clean up
task.wait(1.8)
screenGui:Destroy()
if blur and blur.Parent then
    blur:Destroy()
end

-- Load library
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/battleeyeconductdivison-wq/vinci2/refs/heads/main/f242141n3.lua"))()

-- Create window
local window = library:window({
    name = "Lumen",
    suffix = "",
    gameInfo = "Arcade Basketball | " .. executorName
})




--------------------------------------------------------------------------------
-- PLAYER TAB
--------------------------------------------------------------------------------
window:seperator({name = "Player"})
local LocalPlayerTab = window:tab({
    name = "Player",
    tabs = {"Main"}
})

local LocalPlayerColumn = LocalPlayerTab:column({})
local LocalPlayerModsSection = LocalPlayerColumn:section({
    name = "Player Options",
    side = "left",
    size = 0.5
})

local LocalModsColumn = LocalPlayerTab:column({})
local PlayerModsSec = LocalModsColumn:section({
    name = "Player Mods",
    side = "right",
    size = 0.75
})

local ShootingShit = LocalPlayerColumn:section({
    name = "Shooting",
    side = "right",
    size = 0.45
})

--------------------------------------------------------------------------------
-- GAME TAB (with subtabs)
--------------------------------------------------------------------------------
window:seperator({name = "Game"})
local LocalGameTab, TeleportTab = window:tab({
    name = "Game",
    tabs = {"Main","Teleports"}
})

-- Main subtab
local MainGen = LocalGameTab:column({})
local MainSection = MainGen:section({
    name = "General",
    side = "left",
    size = 0.35
})

local MainGen2 = LocalGameTab:column({})
local MainSection2 = MainGen2:section({
    name = "Player",
    side = "right",
    size = 0.45
})

-- Teleports subtab
local Teleporter = TeleportTab:column({})
local Teleport = Teleporter:section({
    name = "Teleports",
    side = "right",
    size = 1
})

--------------------------------------------------------------------------------
-- SETTINGS TAB
--------------------------------------------------------------------------------
window:seperator({name = "Settings"})
local SettingsTab = window:tab({
    name = "Settings",
    tabs = {"Main"}
})

local SettingsColumn = SettingsTab:column({})
local SettingsSection = SettingsColumn:section({
    name = "Settings",
    side = "left",
    size = 0.6
})

local GameSettingsColumn = SettingsTab:column({})
local GameSettingsSection = GameSettingsColumn:section({
    name = "Game Settings",
    side = "right",
    size = 0.8
})

--------------------------------------------------------------------------------
-- SERVER INFO LABEL
--------------------------------------------------------------------------------
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local gameInfo = MarketplaceService:GetProductInfo(game.PlaceId)

local ServerLabel = GameSettingsSection:label({
    name = gameInfo.Name,
    info = "Players: "..#Players:GetPlayers().." / "..Players.MaxPlayers
})

task.spawn(function()
    while true do
        if ServerLabel and type(ServerLabel) == "table" then
            ServerLabel.info = "Players: "..#Players:GetPlayers().." / "..Players.MaxPlayers
        end
        task.wait(1)
    end
end)



-- Global variables
g = g or {}

------------------------------------------------------------------
-- Player Options Section (Left Side)
------------------------------------------------------------------

LocalPlayerModsSection:toggle({
    name = "Unlimited Stamina",
     type = "toggle",
    default = false,
    callback = function(state)
        g.infinitestamina = state

        if state then
            stamina_thread = task.spawn(function()
                while g.infinitestamina and task.wait(0.1) do
                    local player = game.Players.LocalPlayer
                    if player and player:FindFirstChild("Values") then
                        local stamina = player.Values:FindFirstChild("Stamina")
                        local maxStamina = player.Values:FindFirstChild("MaxStamina")
                        if stamina and maxStamina then
                            stamina.Value = maxStamina.Value
                        end
                    end
                end
            end)
        elseif stamina_thread then
            task.cancel(stamina_thread)
        end
    end
})

LocalPlayerModsSection:toggle({
    name = "Always Sprint",
    type = "toggle",
    default = false,
    callback = function(state)
        g.autosprint = state

        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local Sprint = ReplicatedStorage.Events.Sprint

        if state then
            sprint_thread = task.spawn(function()
                while g.autosprint do
                    task.wait(0.1)
                    local player = game.Players.LocalPlayer
                    local char = player.Character
                    if char and char:FindFirstChildOfClass("Humanoid") then
                        local humanoid = char.Humanoid
                        if humanoid.MoveDirection.Magnitude > 0 then
                            Sprint:FireServer(humanoid.MoveDirection.Magnitude)
                        end
                    end
                end
            end)

            -- Anti-turn-off: constantly enforce sprint = true
            anti_off_thread = task.spawn(function()
                while g.autosprint do
                    task.wait(0.1)
                    Sprint:FireServer(true)
                end
            end)
        elseif sprint_thread then
            task.cancel(sprint_thread)
            task.cancel(anti_off_thread)
            Sprint:FireServer(false)
        end
    end
})





--[[
LocalPlayerModsSection:toggle({
    name = "No Boundaries",
    type = "toggle",
    default = false,
    callback = function(state)
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local LocalPlayer = Players.LocalPlayer

        -- Track NoClip loop
        if state then
            _G.FullNoClip = RunService.Stepped:Connect(function()
                local character = LocalPlayer.Character
                if character then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                    -- Optional: prevent character from being blocked by Terrain
                    if character:FindFirstChild("HumanoidRootPart") then
                        character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame
                    end
                end
            end)

            -- Reapply on respawn
            LocalPlayer.CharacterAdded:Connect(function(character)
                if _G.FullNoClip then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)

        else
            -- Stop NoClip
            if _G.FullNoClip then
                _G.FullNoClip:Disconnect()
                _G.FullNoClip = nil
            end
            -- Restore collisions for your character
            local character = LocalPlayer.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
})
-- ]]

------------------------------------------------------------------
-- Player Mods Section (Right Side)
------------------------------------------------------------------

-- Walkspeed with slider
PlayerModsSec:toggle({
     type = "toggle",
    name = "Walkspeed",
    default = false,
    callback = function(state)
        g.customwalkspeed = state
        
        if state then
            walkspeed_thread = task.spawn(function()
                while g.customwalkspeed and task.wait(0.1) do
                    local player = game.Players.LocalPlayer
                    local char = player.Character
                    if char and char:FindFirstChildOfClass("Humanoid") then
                        char.Humanoid.WalkSpeed = g.walkspeedvalue or 16
                    end
                end
            end)
        elseif walkspeed_thread then
            task.cancel(walkspeed_thread)
            local player = game.Players.LocalPlayer
            local char = player.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                char.Humanoid.WalkSpeed = 16
            end
        end
    end
})

-- Spinbot with slider
PlayerModsSec:toggle({
     type = "toggle",
    name = "Spinbot",
    default = false,
    callback = function(state)
        g.spinbot = state
        
        if state then
            spinbot_thread = task.spawn(function()
                while g.spinbot and task.wait() do
                    local player = game.Players.LocalPlayer
                    local char = player.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local speed = g.spinbotspeed or 5
                        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(speed), 0)
                    end
                end
            end)
        elseif spinbot_thread then
            task.cancel(spinbot_thread)
        end
    end
})

-- Enhanced Dribble Glide
PlayerModsSec:toggle({
     type = "toggle",
    name = "Dribble Glide",
    default = false,
    callback = function(state)
        g.dribbleglide = state
        
        if state then
            dribble_thread = task.spawn(function()
                while g.dribbleglide and task.wait() do
                    local player = game.Players.LocalPlayer
                    local char = player.Character
                    local values = player:FindFirstChild('Values')
                    
                    if char and values and values:FindFirstChild('Dribbling') then
                        if values.Dribbling.Value == true then
                            local humanoid = char:FindFirstChildOfClass('Humanoid')
                            local hrp = char:FindFirstChild('HumanoidRootPart')
                            
                            if humanoid and hrp and humanoid.MoveDirection.Magnitude > 0 then
                                -- Enhanced glide mechanics
                                local intensity = g.glideintensity or 10
                                local dist = intensity * 0.15 -- Better distance calculation
                                local direction = humanoid.MoveDirection
                                
                                -- Smooth movement with better interpolation
                                local currentPos = hrp.Position
                                local targetPos = currentPos + (direction * dist)
                                
                                -- Enhanced CFrame calculation for smoother movement
                                local newCFrame = CFrame.new(
                                    targetPos,
                                    targetPos + direction
                                )
                                
                                -- Smoother lerp with dynamic speed
                                local lerpSpeed = math.clamp(intensity / 50, 0.1, 0.8)
                                hrp.CFrame = hrp.CFrame:Lerp(newCFrame, lerpSpeed)
                                
                                -- Add slight upward momentum for better feel
                                local bodyVelocity = hrp:FindFirstChild("GlideVelocity")
                                if not bodyVelocity then
                                    bodyVelocity = Instance.new("BodyVelocity")
                                    bodyVelocity.Name = "GlideVelocity"
                                    bodyVelocity.Parent = hrp
                                end
                                
                                bodyVelocity.Velocity = Vector3.new(
                                    direction.X * intensity * 2,
                                    2, -- Slight upward lift
                                    direction.Z * intensity * 2
                                )
                                bodyVelocity.MaxForce = Vector3.new(4000, 400, 4000)
                            end
                        else
                            -- Clean up when not dribbling
                            local hrp = char:FindFirstChild('HumanoidRootPart')
                            if hrp then
                                local bodyVelocity = hrp:FindFirstChild("GlideVelocity")
                                if bodyVelocity then
                                    bodyVelocity:Destroy()
                                end
                            end
                        end
                    end
                end
            end)
        elseif dribble_thread then
            task.cancel(dribble_thread)
            -- Clean up
            local player = game.Players.LocalPlayer
            local char = player.Character
            local hrp = char and char:FindFirstChild('HumanoidRootPart')
            if hrp then
                local bodyVelocity = hrp:FindFirstChild("GlideVelocity")
                if bodyVelocity then
                    bodyVelocity:Destroy()
                end
            end
        end
    end
})






PlayerModsSec:slider({
    name = "Walkspeed Value",
    min = 16,
    max = 100,
    default = 16,
    callback = function(value)
        g.walkspeedvalue = value
    end
})



PlayerModsSec:slider({
    name = "Spinbot Speed",
    min = 1,
    max = 20,
    default = 5,
    callback = function(value)
        g.spinbotspeed = value
    end
})



PlayerModsSec:slider({
    name = "Glide Intensity",
    min = 1,
    max = 35,
    default = 10,
    callback = function(value)
        g.glideintensity = value
    end
})









ShootingShit:toggle({
    type = "toggle",
    name = "Auto Green",
    default = false,
    callback = function(state)
        -- create a store in genv for the hook + original function
        if not getgenv().AutoGreenHook then
            getgenv().AutoGreenHook = {
                old = nil,
                active = false
            }
        end

        if state and not getgenv().AutoGreenHook.active then
            -- Find remote
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local ShootRemote
            for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                if v:IsA("RemoteEvent") and v.Name:lower():find("shoot") then
                    ShootRemote = v
                    break
                end
            end

            -- Save original __namecall
            local oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local method = getnamecallmethod()
                local args = { ... }

                if not checkcaller() and self == ShootRemote and method:lower() == "fireserver" then
                    args[2] = -0.98
                    return getgenv().AutoGreenHook.old(self, unpack(args))
                end

                return getgenv().AutoGreenHook.old(self, ...)
            end)

            getgenv().AutoGreenHook.old = oldNamecall
            getgenv().AutoGreenHook.active = true

        elseif not state and getgenv().AutoGreenHook.active then
            -- restore original namecall
            hookmetamethod(game, "__namecall", getgenv().AutoGreenHook.old)
            getgenv().AutoGreenHook.active = false
            getgenv().AutoGreenHook.old = nil
        end
    end
})


--[[
ShootingShit:toggle({
    name = "Shoot Backwards (Perfect)",
    type = "toggle",
    default = false,
    callback = function(state)
        if state then
            if not getgenv().ShootBackwardsHook then
                getgenv().ShootBackwardsHook = { old = nil, active = false }
            end

            if not getgenv().ShootBackwardsHook.active then
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local Players = game:GetService("Players")
                local LP = Players.LocalPlayer
                local Char = LP.Character or LP.CharacterAdded:Wait()
                local HRP = Char:WaitForChild("HumanoidRootPart")

                -- Find the shoot remote
                local ShootRemote
                for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                    if v:IsA("RemoteEvent") and v.Name:lower():find("shoot") then
                        ShootRemote = v
                        break
                    end
                end

                -- Hook __namecall
                local oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                    local method = getnamecallmethod()
                    local args = {...}

                    if not checkcaller() and self == ShootRemote and method:lower() == "fireserver" then
                        -- Let the original shoot happen first
                        local result = getgenv().ShootBackwardsHook.old(self, ...)

                        -- Force 180° turn immediately after the ball leaves
                        task.spawn(function()
                            local originalCF = HRP.CFrame
                            local backwardCF = CFrame.new(originalCF.Position, originalCF.Position - originalCF.LookVector)

                            -- Lock rotation for short period to simulate "backward shot"
                            local shooting = true
                            task.spawn(function()
                                while shooting do
                                    if HRP then
                                        HRP.CFrame = backwardCF
                                    end
                                    task.wait()
                                end
                            end)

                            -- Wait for duration of "shot active" (adjust to match game)
                            local duration = 0.5 -- tweak for your game, or detect key/button release
                            task.wait(duration)
                            shooting = false -- unlock rotation
                        end)

                        return result
                    end

                    return getgenv().ShootBackwardsHook.old(self, ...)
                end)

                getgenv().ShootBackwardsHook.old = oldNamecall
                getgenv().ShootBackwardsHook.active = true
            end

        else
            -- Restore original hook
            if getgenv().ShootBackwardsHook and getgenv().ShootBackwardsHook.active then
                hookmetamethod(game, "__namecall", getgenv().ShootBackwardsHook.old)
                getgenv().ShootBackwardsHook.active = false
                getgenv().ShootBackwardsHook.old = nil
            end
        end
    end
})
--]]


ShootingShit:toggle({
    name = "Anti Contest",
    type = "toggle",
    default = false,
    callback = function(state)
        if state then
            if not getgenv().ShootHighHook then
                getgenv().ShootHighHook = { old = nil, active = false }
            end

            if not getgenv().ShootHighHook.active then
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local Players = game:GetService("Players")
                local LP = Players.LocalPlayer
                local Char = LP.Character or LP.CharacterAdded:Wait()
                local HRP = Char:WaitForChild("HumanoidRootPart")

                -- Store original Y position to calculate max height
                local originalY = HRP.Position.Y

                -- Find the shoot RemoteEvent
                local ShootRemote
                for _, v in pairs(ReplicatedStorage:GetDescendants()) do
                    if v:IsA("RemoteEvent") and v.Name:lower():find("shoot") then
                        ShootRemote = v
                        break
                    end
                end

                -- Hook __namecall to detect actual shooting
                local oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                    local method = getnamecallmethod()
                    local args = {...}

                    if not checkcaller() and self == ShootRemote and method:lower() == "fireserver" then
                        -- Let the shot happen first
                        local result = getgenv().ShootHighHook.old(self, ...)

                        -- Teleport upward, max 20 studs above original Y
                        task.spawn(function()
                            local currentY = HRP.Position.Y
                            local targetY = math.min(originalY + 20, currentY + 20)
                            local upCF = CFrame.new(HRP.Position.X, targetY, HRP.Position.Z)

                            -- Keep the player floating while shot is active
                            local duration = 0.7
                            local startTime = tick()
                            while tick() - startTime < duration do
                                if HRP then
                                    HRP.CFrame = upCF
                                end
                                task.wait()
                            end

                            -- Return to original position smoothly
                            if HRP then
                                HRP.CFrame = CFrame.new(HRP.Position.X, originalY, HRP.Position.Z)
                            end
                        end)

                        return result
                    end

                    return getgenv().ShootHighHook.old(self, ...)
                end)

                getgenv().ShootHighHook.old = oldNamecall
                getgenv().ShootHighHook.active = true
            end
        else
            -- Restore original hook
            if getgenv().ShootHighHook and getgenv().ShootHighHook.active then
                hookmetamethod(game, "__namecall", getgenv().ShootHighHook.old)
                getgenv().ShootHighHook.active = false
                getgenv().ShootHighHook.old = nil
            end
        end
    end
})










------------------------------------------------------------------

-- Court Barriers and Out of Bounds Toggles
local Workspace = game:GetService("Workspace")

-- Toggle 1: No Court Barriers
MainSection:toggle({
    name = "No Court Barriers",
    type = "toggle",
    default = false,
    callback = function(value)
        -- Storage for original properties (local to this toggle)
        local originalProperties = {}
        
        if value then
            -- Turn ON: Disable court barriers
            local courts = Workspace:FindFirstChild("Courts")
            if not courts then return end
            
            -- Loop through all courts dynamically
            for _, court in pairs(courts:GetChildren()) do
                if court:IsA("Model") or court:IsA("Folder") then
                    -- Look for CourtBorder parts (CourtBorder, CourtBorder_2, etc.)
                    for _, part in pairs(court:GetDescendants()) do
                        if part:IsA("BasePart") and part.Name:match("^CourtBorder") then
                            -- Save original properties
                            originalProperties[part] = {
                                CanCollide = part.CanCollide,
                                CanTouch = part.CanTouch,
                                Transparency = part.Transparency
                            }
                            
                            -- Disable barriers
                            part.CanCollide = false
                            part.CanTouch = false
                            part.Transparency = 1
                        end
                    end
                end
            end
        else
            -- Turn OFF: Restore court barriers
            for part, properties in pairs(originalProperties) do
                if part and part.Parent then
                    -- Restore original properties
                    part.CanCollide = properties.CanCollide
                    part.CanTouch = properties.CanTouch
                    part.Transparency = properties.Transparency
                end
            end
            
            -- Clear the storage
            originalProperties = {}
        end
    end
})

-- Toggle 2: No Out Of Bounds
MainSection:toggle({
    name = "No Out Of Bounds",
    type = "toggle",
    default = false,
    callback = function(value)
        -- Storage for original properties (local to this toggle)
        local originalProperties = {}
        
        if value then
            -- Turn ON: Disable out of bounds
            local courts = Workspace:FindFirstChild("Courts")
            if not courts then return end
            
            -- Loop through all courts dynamically
            for _, court in pairs(courts:GetChildren()) do
                if court:IsA("Model") or court:IsA("Folder") then
                    -- Look for OutOfBounds model in each court
                    local outOfBounds = court:FindFirstChild("OutOfBounds")
                    if outOfBounds then
                        -- Loop through all parts in OutOfBounds model
                        for _, part in pairs(outOfBounds:GetDescendants()) do
                            if part:IsA("BasePart") then
                                -- Save original properties
                                originalProperties[part] = {
                                    CanCollide = part.CanCollide,
                                    CanTouch = part.CanTouch,
                                    Transparency = part.Transparency
                                }
                                
                                -- Disable out of bounds
                                part.CanCollide = false
                                part.CanTouch = false
                                part.Transparency = 1
                            end
                        end
                    end
                end
            end
        else
            -- Turn OFF: Restore out of bounds
            for part, properties in pairs(originalProperties) do
                if part and part.Parent then
                    -- Restore original properties
                    part.CanCollide = properties.CanCollide
                    part.CanTouch = properties.CanTouch
                    part.Transparency = properties.Transparency
                end
            end
            
            -- Clear the storage
            originalProperties = {}
        end
    end
})

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- Remote
local Guard = ReplicatedStorage.Events.Guard -- RemoteEvent 

-- Track connections
local autoGuardConnection
local detectingGuard
local targetPlayer -- store the player we're guarding

-- GUI toggle
MainSection:toggle({
    name = "Auto Guard",
    type = "toggle",
    default = false,
    callback = function(enabled)
        local localPlayer = Players.LocalPlayer

        if enabled then
            -- Lock onto closest player once
            if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local closestPlayer
                local shortestDistance = math.huge
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (player.Character.HumanoidRootPart.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
                        if distance < shortestDistance then
                            shortestDistance = distance
                            closestPlayer = player
                        end
                    end
                end
                targetPlayer = closestPlayer
            end

            autoGuardConnection = RunService.Heartbeat:Connect(function()
                if not enabled then
                    Guard:FireServer(false)
                    if autoGuardConnection then
                        autoGuardConnection:Disconnect()
                        autoGuardConnection = nil
                    end
                    targetPlayer = nil
                    return
                end

                if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    -- Guard the locked player
                    Guard:FireServer(true, targetPlayer)

                    -- Smoothly stay in front of the player
                    local hrp = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local targetHRP = targetPlayer.Character.HumanoidRootPart
                    if hrp then
                        local targetPosition = targetHRP.Position + (targetHRP.CFrame.LookVector * 3) -- 3 studs in front
                        local newCFrame = CFrame.new(hrp.Position:Lerp(targetPosition, 0.2), targetHRP.Position)
                        hrp.CFrame = newCFrame
                    end
                end
            end)

            -- Keep guard enabled automatically
            detectingGuard = RunService.Heartbeat:Connect(function()
                if not enabled then
                    if detectingGuard then
                        detectingGuard:Disconnect()
                        detectingGuard = nil
                    end
                    return
                end
                Guard:FireServer(true, targetPlayer)
            end)

        else
            -- Toggle off: stop everything
            Guard:FireServer(false)
            if autoGuardConnection then
                autoGuardConnection:Disconnect()
                autoGuardConnection = nil
            end
            if detectingGuard then
                detectingGuard:Disconnect()
                detectingGuard = nil
            end
            targetPlayer = nil
        end
    end
})















------------------------











-- Court 1 buttons
-- Court 1 buttons
Teleport:button({
    name = "1s | Court 1 | Home",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-250.99, 31.20, -205.53)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})

Teleport:button({
    name = "1s | Court 1 | Away",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-250.53, 31.20, -250.41)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})

-- Centered separator for Court 2
Teleport:label({
    name = "                                                                            ", -- spaces added to center
    info = ""
})

-- Court 2 buttons
Teleport:button({
    name = "1s | Court 2 | Home",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-155.60, 31.18, -207.62)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})

Teleport:button({
    name = "1s | Court 2 | Away",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-156.55, 31.20, -250.63)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})

-- Centered separator for Court 2
Teleport:label({
    name = "                                                                           ", -- spaces added to center
    info = ""
})

-- Court 2 buttons
Teleport:button({
    name = "1s | Court 3 | Home",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-118.45, 31.21, -253.47)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})

Teleport:button({
    name = "1s | Court 3 | Away",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-118.78, 31.20, -207.61)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})

Teleport:label({
    name = "                                                                            ", -- spaces added to center
    info = ""
})


-- Court 2 buttons
Teleport:button({
    name = "1s | Court 4 | Home",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-24.88, 31.18, -253.69)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})

Teleport:button({
    name = "1s | Court 4 | Away",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-25.37, 31.20, -208.90)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})

Teleport:label({
    name = "                                                                             ", -- spaces added to center
    info = ""
})


-- Court 2 buttons
Teleport:button({
    name = "2s | Court 1 | Home | Ball",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-121.49, 31.03, -95.27)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})

Teleport:button({
    name = "2s | Court 1 | Home | Non Ball",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-119.73, 31.01, -89.56)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})

-- Court 2 buttons
Teleport:button({
    name = "2s | Court 1 | Away | Ball",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-119.40, 31.01, -140.18)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})

Teleport:button({
    name = "2s | Court 1 | Away | Non Ball",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-119.77, 31.03, -145.68)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})





Teleport:label({
    name = "                                                                           ", -- spaces added to center
    info = ""
})

-- Court 2 buttons
Teleport:button({
    name = "2s | Court 2 | Home | Ball",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-155.11, 31.01, -93.42)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})

Teleport:button({
    name = "2s | Court 2 | Home | Non Ball",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-156.80, 30.82, -88.10)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})

-- Court 2 buttons
Teleport:button({
    name = "2s | Court 2 | Away | Ball",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-155.84, 31.01, -138.81)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})

Teleport:button({
    name = "2s | Court 2 | Away | Non Ball",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-156.36, 30.83, -143.75)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})


Teleport:label({
    name = "                                                                          ", -- spaces added to center
    info = ""
})

-- Court 2 buttons
Teleport:button({
    name = "3s | Court 1 | Home | Ball",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-116.59, 37.15, 26.84)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})

Teleport:button({
    name = "3s | Court 1 | Home | Non Ball",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-111.37, 37.16, 27.06)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})

Teleport:button({
    name = "3s | Court 1 | Home | Non Ball",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-105.82, 37.16, 27.38)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})



-- Court 2 buttons
Teleport:button({
    name = "3s | Court 1 | Away | Ball",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-161.99, 37.16, 27.32)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})

Teleport:button({
    name = "3s | Court 1 | Away | Non Ball",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-167.19, 37.16, 27.28)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})

Teleport:button({
    name = "3s | Court 1 | Away | Non Ball",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-172.24, 37.16, 27.17)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})




local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LP = Players.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
local HRP = Char:WaitForChild('HumanoidRootPart')
local Humanoid = Char:WaitForChild('Humanoid')
local Inventory = LP:WaitForChild('Profile'):WaitForChild('Inventory')
local ClothingAssets = ReplicatedStorage:WaitForChild('ClothingAssets')
local Stamina = LP:WaitForChild('Values'):WaitForChild('Stamina')

MainSection2:button({
    name = "Unlock All",
    type = "button",
    default = false,
    callback = function()
        -- Clear current inventory
        for _, v in pairs(Inventory:GetChildren()) do
            v:Destroy()
        end

        -- Clone all clothing assets into inventory
        for _, v in pairs(ClothingAssets:GetChildren()) do
            v:Clone().Parent = Inventory
        end
    end
})

MainSection2:button({
    name = "Unlock Season Pass",
    type = "button",
    default = false,
    callback = function()
     game:GetService("Players").LocalPlayer.Profile.Gamepasses.SeasonPassPremium.Value = true
    end
})

MainSection2:button({
    name = "Max Season Pass Level ",
    type = "button",
    default = false,
    callback = function()
    game:GetService("Players").LocalPlayer.Profile.SeasonPass.SeasonPassLevel.Value = 100
    end
})
-------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------




-------------------------------------------------------------------------------------------------
Teleport:label({
    name = "                                                                                   ", -- spaces added to center
    info = ""
})

Teleport:button({
    name = "Boost Shop",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-184.74, 31.05, -23.33)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})

Teleport:button({
    name = "Crate Shop",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-105.99, 31.04, -20.66)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})

Teleport:button({
    name = "Daily Wheel Spin",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-72.94, 31.08, -17.35)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})

Teleport:button({
    name = "Season Pass Truck",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-50.49, 31.04, -27.33)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})

Teleport:button({
    name = "Practice Court",
    type = "button",
    default = false,
    callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local HRP = character:WaitForChild("HumanoidRootPart")
        local targetPosition = Vector3.new(-173.13, 31.02, -307.93)
        HRP.CFrame = CFrame.new(targetPosition)
    end
})











-----------------------------------------------------------------














SettingsSection:button({
    name = "Unload Lumen",
     type = "button",
    default = false,
    callback = function(state)
        if library[ "items" ] then 
            library[ "items" ]:Destroy()
        end

        if library[ "other" ] then 
            library[ "other" ]:Destroy()
        end 
        
        for index, connection in library.connections do 
            connection:Disconnect() 
            connection = nil 
        end
        
        library = nil 
    
    end
})


SettingsSection:keybind({
    name = "Menu Bind",
    callback = function(bool)
        window.toggle_menu(bool)
    end,
    default = Enum.KeyCode.RightShift -- directly set to RightShift
})








---------------------------------------------------


-- Rejoin current server
GameSettingsSection:button({
    name = "Rejoin",
    type = "button",
    default = false,
    callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end
})

-- Server hop (join a random different server)
GameSettingsSection:button({
    name = "Server Hop",
    type = "button",
    default = false,
    callback = function()
        local HttpService = game:GetService("HttpService")
        local TeleportService = game:GetService("TeleportService")
        local PlaceId = game.PlaceId
        local servers = HttpService:JSONDecode(game:HttpGet(
            ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100"):format(PlaceId)
        ))
        local available = {}
        for _,server in pairs(servers.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                table.insert(available, server.id)
            end
        end
        if #available > 0 then
            TeleportService:TeleportToPlaceInstance(PlaceId, available[math.random(1,#available)], game.Players.LocalPlayer)
        end
    end
})

-- Join lowest player server
GameSettingsSection:button({
    name = "Join Lowest Server",
    type = "button",
    default = false,
    callback = function()
        local HttpService = game:GetService("HttpService")
        local TeleportService = game:GetService("TeleportService")
        local PlaceId = game.PlaceId
        local servers = HttpService:JSONDecode(game:HttpGet(
            ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100"):format(PlaceId)
        ))
        local lowest
        for _,server in pairs(servers.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                if not lowest or server.playing < lowest.playing then
                    lowest = server
                end
            end
        end
        if lowest then
            TeleportService:TeleportToPlaceInstance(PlaceId, lowest.id, game.Players.LocalPlayer)
        end
    end
})


GameSettingsSection:button({
    name = "Copy Server Script",
    type = "button",
    default = false,
    callback = function()
        local jobId = game.JobId
        local placeId = game.PlaceId
        local code = [[
-- Lumen
-- discord.gg/lumen

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

TeleportService:TeleportToPlaceInstance(]]..placeId..[[, "]]..jobId..[[", Players.LocalPlayer)
        ]]
        setclipboard(code)
    end
})



