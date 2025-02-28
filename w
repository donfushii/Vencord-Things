--[[

Copyright (C) 2025 github.com/donfushii
Powered By Imperium ♡

--]]

if game.PlaceId ~= 189707 then return end

-- [ IMPERIUM LIBRARY ] --

local ImperiumLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Imperium-Development/Imperium/main/UILibrary/ImperiumLibrary.lua"))()

local Windows = ImperiumLib:Window("Imperium", Color3.fromRGB(212, 255, 254), Enum.KeyCode.V)

ImperiumLib:Notification("Notification", "Welcome to Imperium! Join our Discord by pressing Okay or using our invite:\n\n・  discord.gg/sH5Mh2XfPC", "Okay!", function()
    setclipboard("https://discord.gg/sH5Mh2XfPC")
end)

-- [ LIBRARY TABS ] --

local HomeTAB = Windows:Tab("Home")
local HoleTAB = Windows:Tab("BlackHole")

-- [ SERVICE'S ] --

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local connection

-- [ BLACKHOLE  -  SETTING'S ] --

local rotationRadius = 80
local rotationHeight = 100
local rotationSpeed = 5
local attractionStrength = 1000

local ringPartsEnabled = false
local heartbeatConnection
local parts = {}

if not getgenv().Network then
    getgenv().Network = {
        BaseParts = {},
        Velocity = Vector3.new(14.46262424, 14.46262424, 14.46262424)
    }

    Network.RetainPart = function(Part)
        if typeof(Part) == "Instance" and Part:IsA("BasePart") and Part:IsDescendantOf(workspace) then
            table.insert(Network.BaseParts, Part)
            Part.CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0.0001, 0.0001, 0.0001, 0.0001)
            --Part.CanCollide = false
        end
    end

    local function EnablePartControl()
        LocalPlayer.ReplicationFocus = workspace

        local success, _ = pcall(function()
            sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
        end)

        if not success then
            print("> Imperium  |  Error  •  Ur exploit doesn't support 'sethiddenproperty()' function.")
            return
        end

        heartbeatConnection = RunService.Heartbeat:Connect(function()
            if ringPartsEnabled and #Network.BaseParts > 0 then
                sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
                for _, Part in pairs(Network.BaseParts) do
                    if Part:IsDescendantOf(workspace) then
                        Part.Velocity = Network.Velocity
                    end
                end
            else
                if heartbeatConnection then
                    heartbeatConnection:Disconnect()
                    heartbeatConnection = nil
                end
            end
        end)
    end
    EnablePartControl()
end

local function RetainPart(Part)
    if Part:IsA("BasePart") and not Part.Anchored and Part:IsDescendantOf(workspace) then
        if Part.Parent == LocalPlayer.Character or Part:IsDescendantOf(LocalPlayer.Character) then
            return false
        end

        Part.CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0.0001, 0.0001, 0.0001, 0.0001)
        return true
    end
    return false
end

local function addPart(part)
    if RetainPart(part) then
        if not table.find(parts, part) then
            table.insert(parts, part)
        end
    end
end

local function removePart(part)
    local index = table.find(parts, part)
    if index then
        table.remove(parts, index)
    end
end

for _, part in pairs(workspace:GetDescendants()) do
    addPart(part)
end

workspace.DescendantAdded:Connect(addPart)
workspace.DescendantRemoving:Connect(removePart)

-- [ TAB #1  -  HOME ] --

HomeTAB:ImageLabel(function()
end)

-- [ TAB #4  -  BLACKHOLE ] --

HoleTAB:Slider("  ・  Ring BlackHole Radius", 1, 200, 80, function(value)
    rotationRadius = value
end)

HoleTAB:Slider("  ・  Ring BlackHole Speed", 1, 20, 5, function(value) 
    rotationSpeed = value
end)

HoleTAB:Toggle("  ・  Enable Ring BlackHole", false, function(value)
    ringPartsEnabled = value

    if value then
        if not heartbeatConnection then
            heartbeatConnection = RunService.Heartbeat:Connect(function(deltaTime)
                local humanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    local tornadoCenter = humanoidRootPart.Position
                    for _, part in pairs(parts) do
                        if part.Parent and not part.Anchored then
                            local distanceToCenter = (part.Position - tornadoCenter).Magnitude
                            if distanceToCenter > rotationRadius * 2 then
                                continue
                            end
                            local partPos = part.Position
                            local horizontalOffset = Vector3.new(partPos.X, tornadoCenter.Y, partPos.Z) - tornadoCenter
                            local angle = math.atan2(horizontalOffset.Z, horizontalOffset.X)
                            local newAngle = angle + math.rad(rotationSpeed)
                            local clampedDistance = math.min(rotationRadius, horizontalOffset.Magnitude)

                            local targetPos = Vector3.new(
                                tornadoCenter.X + math.cos(newAngle) * clampedDistance,
                                tornadoCenter.Y + (rotationHeight * math.abs(math.sin((partPos.Y - tornadoCenter.Y) / rotationHeight))),
                                tornadoCenter.Z + math.sin(newAngle) * clampedDistance)

                            local directionToTarget = (targetPos - part.Position).Unit
                            part.Velocity = directionToTarget * attractionStrength
                        end
                    end
                end
            end)
        end
    else
        if heartbeatConnection then
            heartbeatConnection:Disconnect()
            heartbeatConnection = nil
        end
    end
end)
