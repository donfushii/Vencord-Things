local Players = game:GetService("Players")

local ADMINS = {
    5127756688,
    1897808935
}

local MODS = {
    000
}

local PREMIUM = {
    000
}

local UNVERIFIED = {}
local localPlayer = Players.LocalPlayer

local function isPrivileged(player)
    return table.find(ADMINS, player.UserId) or table.find(MODS, player.UserId) or table.find(PREMIUM, player.UserId)
end

local function updateDisplayName(targetPlayer)
    local humanoid = targetPlayer.Character and targetPlayer.Character:FindFirstChildWhichIsA('Humanoid')
    if humanoid and UNVERIFIED[targetPlayer.UserId] then
        humanoid.DisplayName = ('[🎂] ' .. targetPlayer.DisplayName) -- Emoji de usuario no verificado
    end
end

if not isPrivileged(localPlayer) then
    UNVERIFIED[localPlayer.UserId] = true
    if localPlayer.Character then
        updateDisplayName(localPlayer)
    end
end

local function onPlayerAdded(player)
    if isPrivileged(player) then
        player.CharacterAdded:Connect(function()
            for userId in pairs(UNVERIFIED) do
                local unverifiedPlayer = Players:GetPlayerByUserId(userId)
                if unverifiedPlayer then
                    updateDisplayName(unverifiedPlayer)
                end
            end
        end)
    end
end

for _, player in pairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

Players.PlayerAdded:Connect(onPlayerAdded)

localPlayer.CharacterAdded:Connect(function()
    updateDisplayName(localPlayer)
end)


print("aaa")
