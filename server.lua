local lsdepoped = createPed(260, 2183.13477, -2247.87866, 13.72500)
setElementData(lsdepoped, "ped:type", "truckerjob:lsdepoped")
setElementFrozen(lsdepoped, true)

local bbdepoped = createPed(260, 115.10840, -224.25433, 1.82500, 136)
setElementData(bbdepoped, "ped:type", "truckerjob:bbdepoped")
setElementFrozen(bbdepoped, true)

local sfdepoped = createPed(260, -1820.47290, 152.69681, 15.32500, 136)
setElementData(sfdepoped, "ped:type", "truckerjob:sfdepoped")

local marker = createMarker(1725.3179931641, -2073.3881835938, 13.58215713501)
setElementData(marker, "marker", "truckerjob:spawntruck")
setElementFrozen(marker, true)

function start ()
    for k,v in ipairs(getElementsByType("player")) do
        removeElementData(v, "truckerjob:ownedtruck")
        removeElementData(v, "currentway")
        removeElementData(v, "truckerjob:trailer")
    end 
end 
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), start)

local modelid = 403 -- Kamion ID je :D

-- // Kamion lehívás, törlés \\ --

local truckspawnpos = { -- Los Santos felvevő helynél van
    {1805.5936279297, -2047.9675292969, 14.1},
    {1805.5936279297, -2042.9675292969, 14.1},
    {1805.5936279297, -2037.9675292969, 14.1},
}

function spawntruck(player)
    local rnd = math.random(1, #truckspawnpos)
    local vehicle = createVehicle(403, truckspawnpos[rnd][1], truckspawnpos[rnd][2], truckspawnpos[rnd][3], 0, 0, 90)
    setElementData(player, "truckerjob:ownedtruck", vehicle)
    warpPedIntoVehicle(player, vehicle)
    setVehicleEngineState(vehicle, true)
end 
addEvent("spawntruck", true)
addEventHandler("spawntruck", root, spawntruck)

function destroytruckervehicle(player, vehicle)
    destroyElement(vehicle)
    removeElementData(player, "truckerjob:ownedtruck")
end 
addEvent("destroytruckervehicle", true)
addEventHandler("destroytruckervehicle", root, destroytruckervehicle)

function getpaying(player, money)
    local trailer = getElementData(player, "truckerjob:trailer")
    destroyElement(trailer)
    removeElementData(player, "currentway")
    removeElementData(player, "truckerjob:trailer")
    setPlayerMoney(player, getPlayerMoney(player) + tonumber(money))
end 
addEvent("getpaying", true)
addEventHandler("getpaying", root, getpaying)

-- // Innentől már ha van kamionod \\ --

local spawntrailersls = {
    {2174.7485351563, -2228.1765136719, 14.03858470916, 224},
    -- {2187.7973632813, -2215.2788085938, 14.15262603759, 224, 2178.4104003906, -2206.9936523438, 14.154671669006},
    {2187.7973632813, -2215.2788085938, 14.15262603759, 224},
    {2201.1684570313, -2202.0231933594, 14.160978317261, 224},
}

local spawntrailersbb = {
    {103.99401092529, -273.21264648438, 2.184695482254, 0},
    {77.99401092529, -273.21264648438, 2.184695482254, 0},
    {65.1, -273.21264648438, 2.184695482254, 0},
    {52.3, -273.21264648438, 2.184695482254, 0},
}

local spawntrailerssf = {
    {-1834.6489257813, 127.9610748291, 15.723130226135, 0},
    {-1844.6489257813, 127.9610748291, 15.723130226135, 0},
    {-1854.6489257813, 127.9610748291, 15.723130226135, 0},
}

function spawntrailer(player, depo)
    -- outputChatBox(depo)
    if (depo == "LS") then 
        local rnd = math.random(1, #spawntrailersls)
        local veh = getElementData(player, "truckerjob:ownedtruck")
        setElementPosition(veh, spawntrailersls[rnd][1], spawntrailersls[rnd][2], spawntrailersls[rnd][3])
        setElementRotation(veh, 0, 0, spawntrailersls[rnd][4])
        local trail = createVehicle(435, spawntrailersls[rnd][1], spawntrailersls[rnd][2], spawntrailersls[rnd][3])
        setElementRotation(trail, 0, 0, 224)
        setElementData(player, "truckerjob:trailer", trail)
        attachTrailerToVehicle(veh, trail)
        warpPedIntoVehicle(player, veh)
    elseif (depo == "BB") then 
        local rnd = math.random(1, #spawntrailersbb)
        local veh = getElementData(player, "truckerjob:ownedtruck")
        setElementPosition(veh, spawntrailersbb[rnd][1], spawntrailersbb[rnd][2], spawntrailersbb[rnd][3])
        setElementRotation(veh, 0, 0, spawntrailersbb[rnd][4])

        local trail = createVehicle(435, spawntrailersbb[rnd][1], spawntrailersbb[rnd][2], spawntrailersbb[rnd][3])
        setElementRotation(trail, 0, 0, 0)
        setElementData(player, "truckerjob:trailer", trail)

        attachTrailerToVehicle(veh, trail)
        warpPedIntoVehicle(player, veh)
    elseif (depo == "SF") then 
        local rnd = math.random(1, #spawntrailerssf)
        local veh = getElementData(player, "truckerjob:ownedtruck")
        setElementPosition(veh, spawntrailerssf[rnd][1], spawntrailerssf[rnd][2], spawntrailerssf[rnd][3])
        setElementRotation(veh, 0, 0, spawntrailerssf[rnd][4])
        local trail = createVehicle(435, spawntrailerssf[rnd][1], spawntrailerssf[rnd][2], spawntrailerssf[rnd][3])
        setElementRotation(trail, 0, 0, 0)
        setElementData(player, "truckerjob:trailer", trail)
        attachTrailerToVehicle(veh, trail)
        warpPedIntoVehicle(player, veh)
    else 
        outputChatBox("afgasfgsaasgsg")
    end 
end 
addEvent("spawntrailer", true)
addEventHandler("spawntrailer", root, spawntrailer)

--// Teszteléshez szükséges dolgok
function kamion (playerSource)
    setElementPosition(playerSource, 1730.70447, -2072.33887, 13.63171)
end 
addCommandHandler("kamion", kamion)

function lsdepo (playerSource)
    setElementPosition(playerSource, 2182.66406, -2244.93530, 13.72500)
end 
addCommandHandler("lsdepo", lsdepo)

function sfdepo (playerSource)
    setElementPosition(playerSource, -1831.90881, 149.09135, 15.11719)
end 
addCommandHandler("sfdepo", sfdepo)

function bbdepo (playerSource)
    setElementPosition(playerSource, 113.69408, -227.06433, 1.82500)
end 
addCommandHandler("bbdepo", bbdepo)