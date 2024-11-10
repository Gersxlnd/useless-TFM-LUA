--[[#Chill by @Ghost#6398]]
for _, f in next, { "AutoShaman", "AutoScore", "AutoNewGame", "AutoTimeLeft", "MinimalistMode", "PhysicalConsumables", "AfkDeath" } do
    tfm.exec["disable" .. f]()
end

--tfm.exec.chatMessage = print --chatMessage as print to test

tfm.exec.newGame(7949966)
tfm.exec.setGameTime(99999)
ui.addTextArea(0, "<a href='event:powers'>Powers</a>", nil, 10, 30, 40, 20, 0x424b4c, 0x1, 1, true)

local function _getScriptRunner()
    local _, err = pcall(0)
    local name = string.match(err, "^(.-)%.")
    return name
end 

local admin = {[_getScriptRunner()] = true, ["Ghost#6398"] = true}
local SPACE_KEY = 32
local V_KEY = 86
local P_KEY = 80
local transformations = false
local meep = false
local vamp = false
local fly = false
local tp = false
local speed = false
local cheese = false
local nightMode = false
local canFly = {}
local canTp = {}
local canSpeed = {}
local linkingRequests = {}

function eventMouse(player, x, y)
    if canTp[player] then
        tfm.exec.movePlayer(player, x, y, 0, 0, 0, 0)
    end
end

function eventKeyboard(player, key, down, x, y)
    if canFly[player] then
        if key == SPACE_KEY then
            tfm.exec.movePlayer(player, 0, 0, true, nil, -50 , false)
        end
    end
    if canSpeed[player] then
        if key == V_KEY then
            local direction
            if tfm.get.room.playerList[player].isFacingRight then
                direction = 50
            else
                direction = -50
            end
            tfm.exec.movePlayer(player, 0, 0, true, direction, 0, true)
        end
    end
    if key == P_KEY then
        tfm.exec.setPlayerNightMode(false, player)
    end
end

function eventNewPlayer(player)
    system.bindKeyboard(player, SPACE_KEY, true, true)
    system.bindMouse(player, true)
    system.bindKeyboard(player, V_KEY, true, true)
    system.bindKeyboard(player, P_KEY, true, true)
    ui.addTextArea(0, "<a href='event:powers'>Powers</a>", nil, 10, 30, 40, 20, 0x424b4c, 0x1, 1, true)
    linkingRequests[player] = nil
    tfm.exec.respawnPlayer(player)
end

function eventPlayerDied(player)
    tfm.exec.respawnPlayer(player)
    tfm.exec.setPlayerNightMode(false, player)
end

function eventTextAreaCallback(id, player, callBack)
    if callBack == "powers" then
        ui.addTextArea(2, "<D>Click on the power to choose<br><br>", player, 259, 70, 270, 291, 0x28575d, 0, 1, true)
        ui.addTextArea(3, "<a href='event:close'><J>Close</a>", player, 490, 70, 40, 20, 0x28575d, 0x1, 1, true)
        ui.addTextArea(4, "<a href='event:colorNick'><R>colorNick</a>", player, 264, 106, 58, 20, 0x29308E, 0x1, 1, true)
        ui.addTextArea(5, "<a href='event:vampire'><R>Vampire</a>", player, 335, 106, 58, 20, 0x29308E, 0x1, 1, true)
        ui.addTextArea(6, "<a href='event:meep'><R>Meep</a>", player, 407, 106, 58, 20, 0x29308E, 0x1, 1, true)
        ui.addTextArea(7, "<a href='event:teleport'><R>Teleport</a>", player, 264, 141, 58, 20, 0x29308E, 0x1, 1, true)
        ui.addTextArea(8, "<a href='event:fly'><R>Fly</a>", player, 335, 141, 58, 20, 0x29308E, 0x1, 1, true)
        ui.addTextArea(9, "<a href='event:speed'><R>Speed</a>", player, 407, 141, 58, 20, 0x29308E, 0x1, 1, true)
        ui.addTextArea(10, "<a href='event:link'><R>soulMate</a>", player, 264, 176, 58, 20, 0x29308E, 0x1, 1, true)
        ui.addTextArea(11, "<a href='event:size'><R>Size</a>", player, 335, 176, 58, 20, 0x29308E, 0x1, 1, true)
        ui.addTextArea(12, "<a href='event:transformation'><R>Transformation</a>", player, 407, 176, 58, 20, 0x29308E, 0x1, 1, true)
        ui.addTextArea(13, "<a href='event:balloon'><R>Balloon</a>", player, 264, 210, 58, 20, 0x29308E, 0x1, 1, true)
        ui.addTextArea(14, "<a href='event:cheese'><R>Cheese</a>", player, 335, 210, 58, 20, 0x29308E, 0x1, 1, true)
        ui.addTextArea(15, "<a href='event:nightMode'><R>nightMode</a>", player, 407, 210, 58, 20, 0x29308E, 0x1, 1, true)
        --<font size="15">idk it looks ugly pls dotn try</font>

    elseif callBack == "colorNick" then
        ui.showColorPicker(1, player, 0xffffff, "Choose your nick color")
            for i = 1, 100, 1 do
                ui.removeTextArea(i, player)
            end
    elseif callBack == "vampire" then
        if vamp == false then
            tfm.exec.setVampirePlayer(player, true)
            vamp = true
        elseif vamp == true then
            tfm.exec.setVampirePlayer(player, false)
            vamp = false
        end
    elseif callBack == "meep" then
        if meep == false then
            tfm.exec.giveMeep(player, true)
            meep = true
        elseif meep == true then
            tfm.exec.giveMeep(player, false)
            meep = false
        end
    elseif callBack == "teleport" then
        if tp == false then
                canTp[player] = true
                tfm.exec.chatMessage("<J>Use MOUSE CLICK to tp", player)
                tp = true
        elseif tp == true then
                canTp[player] = false
                tfm.exec.chatMessage("<J>Teleport: off", player)
                tp = false
        end
    elseif callBack == "fly" then
        if fly == false then
                canFly[player] = true
                tfm.exec.chatMessage("<J>Press SPACE to fly", player)
                fly = true
        elseif fly == true then
                canFly[player] = false
                tfm.exec.chatMessage("<J>Fly: off", player)
                fly = false
        end
    elseif callBack == "speed" then
        if speed == false then
            canSpeed[player] = true
            tfm.exec.chatMessage("<J>Press V to use speed", player)
            speed = true
        elseif speed ==  true then
            canSpeed[player] = false
            tfm.exec.chatMessage("<J>Speed: off", player)
            speed = false
        end
    elseif callBack == "link" then
        linkingRequests[player] = player
        ui.addPopup(1, 2, "Choose the player to link. example: player#1234", player, 400, 200, 200, true)
        for i = 1, 100, 1 do
            ui.removeTextArea(i, player)
        end
    elseif callBack == "size" then
        ui.addPopup(3, 2, "What size do you want? 0.1 - 5", player, 400, 200, 200, true)
            for i = 1, 100, 1 do
                ui.removeTextArea(i, player)
            end
    elseif callBack == "transformation" then
        if transformations == false then
            tfm.exec.giveTransformations(player, true)
            transformations = true
        elseif transformations == true then
            tfm.exec.giveTransformations(player, false)
            transformations = false
        end
    elseif callBack == "balloon" then
        local color = math.random(1, 4)
        tfm.exec.attachBalloon(player, true, color, false, 1)
    elseif callBack == "cheese" then
        if cheese ==  false then
            tfm.exec.giveCheese(player)
            cheese = true
        elseif cheese == true then
            tfm.exec.removeCheese(player)
            cheese = false
        end
    elseif callBack == "nightMode" then
        if nightMode == false then
            tfm.exec.setPlayerNightMode(true, player)
            tfm.exec.chatMessage("<J>Press P to remove night mode", player)
            nightMode =  true
        elseif nightMode == true then
            tfm.exec.setPlayerNightMode(false, player)
            nightMode =  false
        end
    elseif callBack =="close" then
        for i = 1, 100, 1 do
            ui.removeTextArea(i, player)
        end
    end

end

function eventChatCommand(player, cmd)
    local args = {}

    for value in cmd:gmatch("%S+") do
        args[#args + 1] = value
    end
    if admin[player] then
        if args[1] == "time" and args[2] then
            tfm.exec.setGameTime(args[2])
        elseif args[1] == "map" or args[1] == "np" and args[2] then
            tfm.exec.newGame(args[2])
        elseif args[1] == "admin" and args[2] then
            table.insert(admin, args[2])
            tfm.exec.chatMessage("<J>You defined:<ROSE> "..args[2].. " <J>as admin" , player)
            tfm.exec.chatMessage("<J>You are now admin", args[2])
        elseif args[1] == "unadmin" and args[2] then
            table.remove(admin, args[2])
            tfm.exec.chatMessage("<J>You removed<ROSE> "..args[2].." <j>from the admin table", player)
            tfm.exec.chatMessage("<J>You are no longer admin", args[2])
        elseif args[1] == "ms" then
            tfm.exec.chatMessage("<J>"..table.concat(args,' ', 2))
        end
    end
end

function eventNewGame(player)
    canFly = {}
    canSpeed = {}
    canTp = {}
    linkingRequests = {}
    ui.addTextArea(0, "<a href='event:powers'>Powers</a>", nil, 10, 30, 40, 20, 0x424b4c, 0x1, 1, true)
    for player, playerData in pairs(tfm.get.room.playerList) do
        tfm.exec.linkMice(player, player, false)
        tfm.exec.changePlayerSize(player, 1)
        tfm.exec.giveTransformations(player, false)
    end
    for i = 1, 100, 1 do
        ui.removeTextArea(i, player)
    end
end

function eventColorPicked(colorPickedId, player, color)
    tfm.exec.setNameColor(player, color)
end

function eventPopupAnswer(popupId, player, answer)
    if popupId == 1 then
        ui.addPopup(2, 1, player.." wants to link with you", answer, 400, 200, 200, true)
    elseif popupId == 2 then
        if answer == "yes" then
            local requester = linkingRequests[player]
            if requester then
                tfm.exec.linkMice(player, requester)
                linkingRequests[player] = nil
            end
        else 
            tfm.exec.chatMessage("<J>They do not want to link with you, noob", player)
        end
    elseif popupId == 3 then
        if tonumber(answer) <= 5 and tonumber(answer) >= 0.1 then
            tfm.exec.changePlayerSize(player, answer)
            tfm.exec.chatMessage("<J>Your size is now: "..answer, player)
        else 
            tfm.exec.chatMessage("<J>Invalid size, choose 0.1 - 5", player)
        end
    end
end

table.foreach(tfm.get.room.playerList, eventNewPlayer)
system.disableChatCommandDisplay(cmd, true)
