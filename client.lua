-- Script By Szaby :D

local sx, sy = guiGetScreenSize()

local currentways = {} -- Ide lehet szállítani az árút (mindig csak 2)

local trailselections = {} -- Ezek alapján választod ki a trailert, ebbe vannak a random értékek

local shipments = { -- Szállítható dolgok (Bővíthető)
	{"Búza"},
	{"Cukorrépa"},
	{"Játékgépek"},
	{"Vasrudak"},
	{"Elektronika alkatrészek"},
	{"Vegyszerek"},
	{"Olaj"},
	{"Faforgács"},
}


function MarkerHit (hitPlayer, matchingDimension)
	if (matchingDimension) then 
		if (getElementData(source, "marker") == "truckerjob:spawntruck") then 
			if (not getElementData(localPlayer, "truckerjob:ownedtruck")) then 
				addEventHandler("onClientRender", root, renderspawntruckpanel)
				addEventHandler("onClientClick", root, clickspawnrenderpanel)
				setElementFrozen(localPlayer, true)
				bindKey("backspace", "up", quitrenderpanel)
			else 
				addEventHandler("onClientRender", root, deltruckerjobvehicle)
				addEventHandler("onClientClick", root, clickspawnrenderpanel)
				if (getPedOccupiedVehicle(localPlayer)) then 
					setElementFrozen(getPedOccupiedVehicle(localPlayer), true)
				else 
					setElementFrozen(localPlayer, true)
				end 
				bindKey("backspace", "up", quitrenderpanel)
			end 
		end 
	end 
end
addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerHit )

function renderspawntruckpanel ()
	dxDrawRectangle(sx*0.35, sy*0.25, sx*0.3, sy*0.45, tocolor(0, 0, 0, 180))
	dxDrawText("Munkajármű igénylés", sx*0.35, sy*0.28, sx*0.65, sy*0.45, tocolor(225, 255, 255, 180), 2, "default", "center")

	dxDrawRectangle(sx*0.35, sy*0.65, sx*0.15, sy*0.05, tocolor(25, 220, 30, isMouseInPosition(sx*0.35, sy*0.65, sx*0.15, sy*0.05) and 220 or 255)) -- Lehívás
	dxDrawRectangle(sx*0.50, sy*0.65, sx*0.15, sy*0.05, tocolor(220, 25, 30, isMouseInPosition(sx*0.50, sy*0.65, sx*0.15, sy*0.05) and 220 or 255)) -- Mégse / Kilépés

	dxDrawText("Lehívás", sx*0.35, sy*0.66, sx*0.5, sy*0.05, tocolor(225, 255, 255, 200), 2, "default", "center")
	dxDrawText("Mégse", sx*0.50, sy*0.66, sx*0.66, sy*0.05, tocolor(225, 255, 255, 220), 2, "default", "center")
end 

function quitrenderpanel()
	removeEventHandler("onClientRender", root, renderspawntruckpanel)
	removeEventHandler("onClientClick", root, clickspawnrenderpanel)
	removeEventHandler("onClientRender", root, deltruckerjobvehicle)
	if (getPedOccupiedVehicle(localPlayer)) then 
		setElementFrozen(getPedOccupiedVehicle(localPlayer), false)
	else 
		setElementFrozen(localPlayer, false)
	end 
	unbindKey("backspace", "up", quitrenderpanel)
end

function clickspawnrenderpanel(button, state)
	if (button == "left" and state == "up") then 
		if (isMouseInPosition(sx*0.35, sy*0.65, sx*0.15, sy*0.05)) then 
			if (not getElementData(localPlayer, "truckerjob:ownedtruck")) then 
				triggerServerEvent("spawntruck", localPlayer, localPlayer)
				quitrenderpanel()
			end 
		end 
		if (isMouseInPosition(sx*0.50, sy*0.65, sx*0.15, sy*0.05)) then 
			quitrenderpanel()
		end 
		if (isMouseInPosition(sx*0.39, sy*0.55, sx*0.1, sy*0.04)) then 
			local veh = getElementData(localPlayer, "truckerjob:ownedtruck")
			if (veh) then 
				triggerServerEvent("destroytruckervehicle", localPlayer, localPlayer, veh)
				quitrenderpanel()
			end 
		end 
		if (isMouseInPosition (sx*0.5, sy*0.55, sx*0.1, sy*0.04)) then 
			quitrenderpanel()
		end 
	end 
end 


function deltruckerjobvehicle ()
	dxDrawRectangle(sx*0.38, sy*0.5, sx*0.24, sy*0.1, tocolor(0, 0, 0, 200))
	dxDrawText("Szeretnéd leadni a munkajárműved?", sx*0.45, sy*0.5, sx*0.55, sy*0.55, tocolor(255, 255, 255, 255), 2, "sans", "center", "center", false, false, false, false)

	dxDrawRectangle(sx*0.39, sy*0.55, sx*0.1, sy*0.04, tocolor(3, 252, 57, isMouseInPosition(sx*0.39, sy*0.55, sx*0.1, sy*0.04) and 200 or 255))
	dxDrawText("Igen", sx*0.39, sy*0.55, sx*0.48, sy*0.59, tocolor(255, 255, 255, 255), 2, "sans", "center", "center", false, false, false, false)

	dxDrawRectangle(sx*0.5, sy*0.55, sx*0.1, sy*0.04, tocolor(189, 51, 51, isMouseInPosition (sx*0.5, sy*0.55, sx*0.1, sy*0.04) and 200 or 255))
	dxDrawText("Nem", sx*0.5, sy*0.55, sx*0.6, sy*0.59, tocolor(255, 255, 255, 255), 2, "sans", "center", "center", false, false, false, false)
end 


--// Innentől pótválasztás, stb minden \\--

-- local sfcol = createColRectangle(-1825.67261, 96.20790, 3, 11)
-- local bbcol = createColRectangle(88.76878, -309.01599, 3, 11)

local camerapos = {
	{2224.73877, -2218.20825, -34.71632, 2215.39941, -2218.17676, -36.83493},
	{2224.73877, -2210.20825, -34.71632, 2215.39941, -2210.20825, -36.83493},
	{2224.73877, -2211.20825, -34.71632, 2215.39941, -2211.20825, -36.83493},
	{2224.73877, -2194.20825, -34.71632, 2215.39941, -2194.20825, -36.83493},
} 

function depopedclick(button, state, _, _, _, _, _, clickedElement)
	if ( (button == "right") and (state == "up") ) then 
		if (clickedElement) then 
			-- print(localPlayer)
			-- print(getRootElement())
			-- if (source == localPlayer) then 
				local pX, pY, pZ = getElementPosition(localPlayer);
				local pedX, pedY, pedZ = getElementPosition(clickedElement);
				local distance = getDistanceBetweenPoints3D(pX, pY, pZ, pedX, pedY, pedZ);
				if (distance < 6) then 
					if (getElementData(localPlayer, "truckerjob:ownedtruck")) then 
						if (getElementData(clickedElement, "ped:type") == "truckerjob:lsdepoped") then -- LS DEPÓ pedre kattintás
							if (getElementData(localPlayer, "currentway")) then -- Ha van felvéve neki fuvar
								if (getElementData(localPlayer, "currentway") == "Los Santos") then -- Ha LS be kell vinni
									outputChatBox("Megérkeztél a szállítmánnyal megkapod a fizetséged")
									triggerServerEvent("getpaying", localPlayer, localPlayer, trailselections[localPlayer].pay)
									-- trailselections[localPlayer] = {}
								else 
									outputChatBox("Rosz helyre hoztad a szállítmányt")
								end 
							else 
								outputChatBox("Válassz pótot!")
								chosetrailer("LS")		
							end 
						end 

						if (getElementData(clickedElement, "ped:type") == "truckerjob:bbdepoped") then -- BB DEPÓ pedre kattintás
							if (getElementData(localPlayer, "currentway")) then -- Ha van felvéve neki fuvar
								if (getElementData(localPlayer, "currentway") == "BlueBerry") then -- Ha BB be kell vinni
									-- iprint(trailselections[localPlayer])
									triggerServerEvent("getpaying", localPlayer, localPlayer, trailselections[localPlayer].pay)
									-- trailselections[localPlayer] = {}
								else 
									outputChatBox("Rosz helyre hoztad a szállítmányt")
								end 
							else 
								outputChatBox("Válassz pótot!")
								chosetrailer("BB")
							end 
						end 

						if (getElementData(clickedElement, "ped:type") == "truckerjob:sfdepoped") then -- SF DEPÓ pedre kattintás
							if (getElementData(localPlayer, "currentway")) then -- Ha van felvéve neki fuvar
								if (getElementData(localPlayer, "currentway") == "San Fiero") then -- Ha SF be kell vinni
									triggerServerEvent("getpaying", localPlayer, localPlayer, trailselections[localPlayer].pay)
									-- trailselections[localPlayer] = {}
								else 
									outputChatBox("Rosz helyre hoztad a szállítmányt")
								end 
							else 
								outputChatBox("Válassz pótot!")
								chosetrailer("SF")
							end 
						end 
					else 
						outputChatBox("Nincs kamionod menj és vegyél fel eggyet")
					end 
				end 
			-- end
		end 
	end
end
addEventHandler("onClientClick", getRootElement(), depopedclick);



function chosetrailer(depo)
	if (depo == "LS") then 
		currentways = {
			{"San Fiero"},
			{"BlueBerry"},
		}
		nowdepo = "LS"
	end 
	if (depo == "SF") then 
		currentways = {
			{"Los Santos"},
			{"BlueBerry"},
		}
		nowdepo = "SF"
	end 
	if (depo == "BB") then 
		currentways = {
			{"San Fiero"},
			{"Los Santos"},
		}
		nowdepo = "BB"
	end 
	-- Trailerek létrehozása
	trail1 = createVehicle(435, 2212.50513, -2219.07983, -38.95332, 0, 0, -50)
	trail2 = createVehicle(435, 2212.50513, -2211.07983, -38.95332, 0, 0, -50)
	trail3 = createVehicle(435, 2212.50513, -2203.07983, -38.95332, 0, 0, -50)
	trail4 = createVehicle(435, 2212.50513, -2195.07983, -38.95332, 0, 0, -50)
	setCameraMatrix(2224.73877, -2218.20825, -34.71632, 2215.39941, -2218.17676, -36.83493) -- Kamera

	-- Random cuccok szállítmány, ár, stb
	for i=1, 4 do 
		local rnd = math.random(1, #currentways)
		local rndmoney = math.random(1000, 3000)
		local rndshipment = math.random(1, #shipments)
		-- print(i)
		-- table.insert(currentways, [i][1], currentways[rnd])
		-- table.insert(currentways, [i][2], rndmoney)
		-- table.insert(currentways, [i][3], shipments[rndshipment])
		trailselections[i] = {}
		trailselections[i].way = tostring(currentways[rnd][1])
		trailselections[i].pay = rndmoney
		trailselections[i].shipment = tostring(shipments[rndshipment][1])
	end 
	-- Eventek, meg minden szükséges szar
	setElementFrozen(localPlayer, true)
	bindKey("backspace", "up", leftselection)
	pointer = 1
	addEventHandler("onClientKey", root, navigation)
	addEventHandler("onClientRender", root, rendertrailercontent)
	addEventHandler("onClientClick", root, clicktrailerselection)
end 


function leftselection()
	unbindKey("backspace", "up", leftselection)
	setCameraTarget(localPlayer)
	removeEventHandler("onClientKey", root, navigation)
	removeEventHandler("onClientRender", root, rendertrailercontent)
	removeEventHandler("onClientClick", root, clicktrailerselection)

	-- removeEventHandler("onClientRender", root, inbbrender)
	-- removeEventHandler("onClientRender", root, insfrender)
	-- removeEventHandler("onClientRender", root, inlsrender)
	
	setElementFrozen(localPlayer, false)
	-- for i=1, 4 do 
		-- trailselections[i] = {}
	-- end 
	if (trail1) then 
		destroyElement(trail1)
		destroyElement(trail2)
		destroyElement(trail3)
		destroyElement(trail4)
	end 
end 

function navigation(button, state)
	if (button == "arrow_l" and state == false) then 
		if (pointer > 1) then 
			pointer = pointer - 1
			setCameraMatrix(camerapos[pointer][1], camerapos[pointer][2], camerapos[pointer][3], camerapos[pointer][4], camerapos[pointer][5], camerapos[pointer][6])
			-- outputChatBox(trailselections[pointer].way.." | "..trailselections[pointer].pay.. " | "..trailselections[pointer].shipment)
		end 
	end
	if (button == "arrow_r" and state == false) then 
		if (pointer < 4) then 
			pointer = pointer + 1 
			setCameraMatrix(camerapos[pointer][1], camerapos[pointer][2], camerapos[pointer][3], camerapos[pointer][4], camerapos[pointer][5], camerapos[pointer][6])
			-- outputChatBox(trailselections[pointer].way.." | "..trailselections[pointer].pay.. " | "..trailselections[pointer].shipment)
		end 
	end 
end 
-- addEventHandler("onClientKey", root, navigation)

function rendertrailercontent()
	dxDrawRectangle(sx*0.64, sy*0.49, sx*0.32, sy*0.45, tocolor(0, 0, 0, 255)) --Háttér háttere :D 
	dxDrawRectangle(sx*0.65, sy*0.5, sx*0.3, sy*0.43, tocolor(255, 255, 255, 255)) --Háttér

	dxDrawLine(sx*0.65, sy*0.55, sx*0.95, sy*0.55, tocolor(0, 0, 0, 255), 3) --Infó alatti vonal
	
	dxDrawLine(sx*0.76, sy*0.55, sx*0.76, sy*0.839, tocolor(0, 0, 0, 255), 3) -- Dolgok melleti vonal
	dxDrawLine(sx*0.65, sy*0.65, sx*0.95, sy*0.65, tocolor(0, 0, 0, 255), 3) -- Útvonal alatti
	dxDrawLine(sx*0.65, sy*0.75, sx*0.95, sy*0.75, tocolor(0, 0, 0, 255), 3) -- Rakomány alatti
	dxDrawLine(sx*0.65, sy*0.839, sx*0.95, sy*0.839, tocolor(0, 0, 0, 255), 3) -- Dolgok alatti vonal

	dxDrawText("Útvonal:", sx*0.655, sy*0.585, sx*0.8, sy*0.585, tocolor(0, 0, 0, 255), 3, "default") -- Útvonal:
	dxDrawText("Rakomány:", sx*0.655, sy*0.675, sx*0.8, sy*0.675, tocolor(0, 0, 0, 255), 3, "default") -- Rakomámy:
	dxDrawText("Fizetés:", sx*0.655, sy*0.77, sx*0.8, sy*0.77, tocolor(0, 0, 0, 255), 3, "default") -- Rakomámy:

	dxDrawText(trailselections[pointer].way, sx*0.76, sy*0.595, sx*0.95, sy*0.585, tocolor(0, 0, 0, 255), 2.5, "default", "center" ) --Útvonal
	dxDrawText(trailselections[pointer].shipment, sx*0.76, sy*0.778, sx*0.95, sy*0.585, tocolor(0, 0, 0, 255), 2.5, "default", "center" ) --Szállítmány
	dxDrawText("$"..trailselections[pointer].pay, sx*0.76, sy*0.685, sx*0.95, sy*0.585, tocolor(0, 0, 0, 255), 2.5, "default", "center" ) -- Fizetés

	dxDrawText("Információk:", sx*0.65, sy*0.505, sx*0.95, sy*0.505, tocolor(0, 0, 0, 255), 3, "default", "center") --Elvállalás szöveg
	dxDrawRectangle(sx*0.67, sy*0.86, sx*0.26, sy*0.05, tocolor(102, 222, 98, isMouseInPosition (sx*0.67, sy*0.86, sx*0.26, sy*0.05) and 200 or 255)) --Elvállalás háttér
	dxDrawText("Elvállalás", sx*0.65, sy*0.862, sx*0.95, sy*0.862, tocolor(0, 0, 0, 255), 3, "default", "center") --Elvállalás szöveg

	-- 

	--[[
	-- dxDrawRectangle(sx*0.64, sy*0.49, sx*0.32, sy*0.45, tocolor(255, 255, 255, 255)) --Háttér háttere :D 
	dxDrawRectangle(sx*0.65, sy*0.5, sx*0.3, sy*0.43, tocolor(0, 0, 0, 255)) --Háttér

	dxDrawLine(sx*0.65, sy*0.55, sx*0.95, sy*0.55, tocolor(255, 255, 255, 255), 3) --Infó alatti vonal
	
	dxDrawLine(sx*0.76, sy*0.55, sx*0.76, sy*0.839, tocolor(255, 255, 255, 255), 3) -- Dolgok melleti vonal
	dxDrawLine(x*0.65, y*0.65, x*0.95, y*0.65, tocolor(255, 255, 255, 255), 3) -- Útvonal alatti
	dxDrawLine(x*0.65, y*0.75, x*0.95, y*0.75, tocolor(255, 255, 255, 255), 3) -- Rakomány alatti
	dxDrawLine(sx*0.65, sy*0.839, sx*0.95, sy*0.839, tocolor(255, 255, 255, 255), 3) -- Dolgok alatti vonal

	dxDrawText("Útvonal:", sx*0.655, sy*0.585, sx*0.8, sy*0.585, tocolor(255, 255, 255, 255), 3, "default") -- Útvonal:
	dxDrawText("Rakomány:", sx*0.655, sy*0.675, sx*0.8, sy*0.675, tocolor(255, 255, 255, 255), 3, "default") -- Rakomámy:
	dxDrawText("Fizetés:", sx*0.655, sy*0.77, sx*0.8, sy*0.77, tocolor(255, 255, 255, 255), 3, "default") -- Rakomámy:

	dxDrawText(trailselections[pointer].way, x*0.76, y*0.595, x*0.95, y*0.585, tocolor(255, 255, 255, 255), 2.5, "default", "center" ) --Útvonal
	dxDrawText(trailselections[pointer].shipment, x*0.76, y*0.778, x*0.95, y*0.585, tocolor(255, 255, 255, 255), 2.5, "default", "center" ) --Szállítmány
	dxDrawText("$"..trailselections[pointer].pay, x*0.76, y*0.685, x*0.95, y*0.585, tocolor(255, 255, 255, 255), 2.5, "default", "center" ) -- Fizetés

	dxDrawText("Információk:", sx*0.65, sy*0.505, sx*0.95, sy*0.505, tocolor(255, 255, 255, 255), 3, "default", "center") --Elvállalás szöveg
	dxDrawRectangle(sx*0.67, sy*0.86, sx*0.26, sy*0.05, tocolor(102, 222, 98, isMouseInPosition (sx*0.67, sy*0.86, sx*0.26, sy*0.05) and 200 or 255)) --Elvállalás háttér
	dxDrawText("Elvállalás", sx*0.65, sy*0.862, sx*0.95, sy*0.862, tocolor(255, 255, 255, 255), 3, "default", "center") --Elvállalás szöveg
	--]]
end 
-- addEventHandler("onClientRender", root, rendertrailercontent)

function clicktrailerselection(button, state)
	if ((button == "left") and (state == "up")) then 
		if (isMouseInPosition(sx*0.67, sy*0.86, sx*0.26, sy*0.05)) then 
			trailselections[localPlayer] = {}
			trailselections[localPlayer].way = tostring(trailselections[pointer].way)
			trailselections[localPlayer].shipment = tostring(trailselections[pointer].shipment)
			trailselections[localPlayer].pay = tostring(trailselections[pointer].pay)
			setElementData(localPlayer, "currentway", tostring(trailselections[pointer].way)) 
			-- outputChatBox("asdasd "..nowdepo)
			-- print(trailselections[localPlayer].way)
			if (trailselections[localPlayer].way == "BlueBerry") then 
				addEventHandler("onClientRender", root, inbbrender)
				outputChatBox("BBB")
			elseif(trailselections[localPlayer].way == "San Fiero") then 
				outputChatBox("SFF")
				addEventHandler("onClientRender", root, insfrender)
			elseif(trailselections[localPlayer].way == "Los Santos") then 
				outputChatBox("LSS")
				addEventHandler("onClientRender", root, inlsrender)
			else 
				print("egyik se")
			end 
			-- iprint(trailselections[localPlayer])
			leftselection()
			-- iprint(trailselections[localPlayer])
			loadingshipments()
			triggerServerEvent("spawntrailer", localPlayer, localPlayer, tostring(nowdepo))
			-- iprint(trailselections[localPlayer])
		end 
	end 
end 
-- addEventHandler("onClientClick", root, clicktrailerselection)

function loadingshipments()

end 

function getshipments ()
	iprint(trailselections[localPlayer])
end 
addCommandHandler("getshipments", getshipments)


function inbbrender() -- BlueBerry
	-- outputChatBox("fut ez a szar")
	local towingVehicle = getPedOccupiedVehicle(localPlayer) -- create a trailer-tower (roadtrain)
	if (towingVehicle) then 
		local trailer = getVehicleTowedByVehicle(towingVehicle) -- create a trailer
		if ( getVehicleTowedByVehicle ( towingVehicle ) == trailer and trailer) then -- if it attached
			local trx, try, trz = getElementPosition(trailer)
			local _, _, trrz = getElementRotation(trailer)
			local distance = getDistanceBetweenPoints3D(trx, try, trz, 90.00890, -300.71936, 1.57813)
			-- print(distance.." | "..trrz)
			if (distance < 1 and trrz > 355 or distance < 1 and trrz < 5) then
				dxDrawLine3D(88.28205, -294.33035, 0.6, 88.28205, -305.49323, 0.6, tocolor(20, 200, 35))
				dxDrawLine3D(88.28205, -305.49323, 0.6, 91.75629, -305.49323, 0.6, tocolor(20, 200, 35))
				dxDrawLine3D(91.75629, -305.49323, 0.6, 91.75629, -294.33035, 0.6, tocolor(20, 200, 35))
				dxDrawLine3D(91.75629, -294.33035, 0.6, 88.28205, -294.33035, 0.6, tocolor(20, 200, 35))
			else 
				dxDrawLine3D(88.28205, -294.33035, 0.6, 88.28205, -305.49323, 0.6, tocolor(200, 20, 35))
				dxDrawLine3D(88.28205, -305.49323, 0.6, 91.75629, -305.49323, 0.6, tocolor(200, 20, 35))
				dxDrawLine3D(91.75629, -305.49323, 0.6, 91.75629, -294.33035, 0.6, tocolor(200, 20, 35))
				dxDrawLine3D(91.75629, -294.33035, 0.6, 88.28205, -294.33035, 0.6, tocolor(200, 20, 35))
			end
		end
	end 
end
-- addEventHandler("onClientRender", root, inbbrender) -- Benne e van

function asd()
	addEventHandler("onClientRender", root, inbbrender)
end 
addCommandHandler("asd", asd)
 
function insfrender() --San Fiero
	-- outputChatBox("SFFF")
	local towingVehicle = getPedOccupiedVehicle(localPlayer) -- create a trailer-tower (roadtrain)
	if (towingVehicle) then 
		local trailer = getVehicleTowedByVehicle(towingVehicle) -- create a trailer
		if ( getVehicleTowedByVehicle ( towingVehicle ) == trailer and trailer) then -- if it attached
			local trx, try, trz = getElementPosition(trailer)
			local _, _, trrz = getElementRotation(trailer)
			local distance = getDistanceBetweenPoints3D(trx, try, trz, -1825.33667, 104.26640, 15.11719)
			-- print(distance.." | "..trrz)
			if (distance < 1 and trrz > 355 or distance < 1 and trrz < 5) then
				dxDrawLine3D(-1827.06030, 109.70036, 14.26, -1826.88770, 98.51074, 14.26, tocolor(20, 200, 35))
				dxDrawLine3D(-1826.88770, 98.51074, 14.26, -1823.6, 98.51074, 14.26, tocolor(20, 200, 35))
				dxDrawLine3D(-1823.6, 98.51074, 14.26, -1823.6, 109.70036, 14.26, tocolor(20, 200, 35))
				dxDrawLine3D(-1823.6, 109.70036, 14.26, -1827.06030, 109.70036, 14.26, tocolor(20, 200, 35))
			else 
				dxDrawLine3D(-1827.06030, 109.70036, 14.26, -1826.88770, 98.51074, 14.26, tocolor(200, 20, 35))
				dxDrawLine3D(-1826.88770, 98.51074, 14.26, -1823.6, 98.51074, 14.26, tocolor(200, 20, 35))
				dxDrawLine3D(-1823.6, 98.51074, 14.26, -1823.6, 109.70036, 14.26, tocolor(200, 20, 35))
				dxDrawLine3D(-1823.6, 109.70036, 14.26, -1827.06030, 109.70036, 14.26, tocolor(200, 00, 35))
			end
		end
	end 
end
-- addEventHandler("onClientRender", root, insfrender) -- Benne e van

function inlsrender() --Los Santos
	-- print("LS")
	local towingVehicle = getPedOccupiedVehicle(localPlayer) -- create a trailer-tower (roadtrain)
	if (towingVehicle) then 
		local trailer = getVehicleTowedByVehicle(towingVehicle) -- create a trailer
		if ( getVehicleTowedByVehicle ( towingVehicle ) == trailer and trailer) then -- if it attached
			local trx, try, trz = getElementPosition(trailer)
			local _, _, trrz = getElementRotation(trailer)
			local distance = getDistanceBetweenPoints3D(trx, try, trz, 2213.45752, -2267.78101, 13.55469)
			-- print(distance.." | "..trrz)
			if (distance < 1 and trrz > 44 or distance < 1 and trrz < 46) then
				dxDrawLine3D(2207.91162, -2264.82910, 13.55469, 2215.62720, -2272.63477, 13.55469, tocolor(20, 200, 35))
				dxDrawLine3D(2215.62720, -2272.63477, 13.55469, 2218.15552, -2270.12500, 13.55469, tocolor(20, 200, 35))
				dxDrawLine3D(2218.15552, -2270.12500, 13.55469, 2210.46851, -2262.52930, 13.55469, tocolor(20, 200, 35))
				dxDrawLine3D(2210.46851, -2262.52930, 13.55469, 2207.91162, -2264.82910, 13.55469, tocolor(20, 200, 35))
			else 
				dxDrawLine3D(2207.91162, -2264.82910, 13.55469, 2215.62720, -2272.63477, 13.55469, tocolor(200, 20, 35))
				dxDrawLine3D(2215.62720, -2272.63477, 13.55469, 2218.15552, -2270.12500, 13.55469, tocolor(200, 20, 35))
				dxDrawLine3D(2218.15552, -2270.12500, 13.55469, 2210.46851, -2262.52930, 13.55469, tocolor(200, 20, 35))
				dxDrawLine3D(2210.46851, -2262.52930, 13.55469, 2207.91162, -2264.82910, 13.55469, tocolor(200, 20, 35))
			end
		end
	end 
end
-- addEventHandler("onClientRender", root, inlsrender) -- Benne e van

--// Useful Functionok \\--

function isMouseInPosition ( x2, y2, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x2 and cx <= x2 + width ) and ( cy >= y2 and cy <= y2 + height ) )
end

function render()
	dxDrawRectangle(0, 0, sx, sy, tocolor(0, 0, 0, 240))
	dxDrawRectangle(sx*0.3, sy*0.76, sx*0.4, sy*0.08)
end 
-- addEventHandler("onClientRender", root, render)