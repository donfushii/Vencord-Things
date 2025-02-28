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

local function isPrivileged(userId)
    return table.find(ADMINS, userId) or table.find(MODS, userId) or table.find(PREMIUM, userId)
end

local function updateDisplayName(targetPlayer, observerPlayer)
    local humanoid = targetPlayer.Character and targetPlayer.Character:FindFirstChildWhichIsA('Humanoid')
    if humanoid then
        if not isPrivileged(targetPlayer.UserId) and isPrivileged(observerPlayer.UserId) then
            humanoid.DisplayName = ('[\240\159\152\130] ' .. targetPlayer.DisplayName) -- 🎂 Emoji de usuario no verificado
        end
    end
end

local function onCharacterAdded(targetPlayer)
    targetPlayer.CharacterAdded:Connect(function()
        for _, observerPlayer in pairs(Players:GetPlayers()) do
            updateDisplayName(targetPlayer, observerPlayer)
        end
    end)
end

local function ImperiumEmojis()
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        onCharacterAdded(targetPlayer)
        for _, observerPlayer in pairs(Players:GetPlayers()) do
            updateDisplayName(targetPlayer, observerPlayer)
        end
    end
end

Players.PlayerAdded:Connect(function(targetPlayer)
    onCharacterAdded(targetPlayer)
    for _, observerPlayer in pairs(Players:GetPlayers()) do
        updateDisplayName(targetPlayer, observerPlayer)
    end
end)

local succ, err = pcall(ImperiumEmojis)
if not succ then
    warn("> Imperium  |  Error  •  While executing Name Emojis: " .. err)
end
