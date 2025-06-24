local GL = _G.Gargul;
local RollOff = GL.RollOff;

local function GetPlayerGuildRank(playerName)
    if GL.User.Guild.name == nil then
        return nil;
    end

    local fullName = GL:addRealm(playerName);
    local player = GL.Player:fromName(fullName);
    if player then
        local Guild = GL:tableGet(player, "Guild");
        if (Guild and Guild.name == GL.User.Guild.name) then
            return Guild.rank;
        end
    end

    return "Pug";
end

-- Overwrite of the existing function
local function FormatRollerNameGuildRank(OriginalRollOff, playerName, numberOfTimesRolledByPlayer)
    local rollerName = playerName;
    if (numberOfTimesRolledByPlayer > 1) then
        rollerName = ("%s [%s]"):format(rollerName, numberOfTimesRolledByPlayer);
    end

    local rank = GetPlayerGuildRank(playerName)
    if rank then
        -- must start with [. Otherwise parsing fails in RollOff:award
        rollerName = ("%s [|c00F48CBA%s|r]"):format(rollerName, rank)
    end

    return rollerName;
end

RollOff.formatRollerName = function(self, ...)
    return FormatRollerNameGuildRank(self, ...)
end