---------------------
-- ESX Declaration --
---------------------
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

---------------
-- Functions --
---------------
function Draw3DText(x, y, z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
	if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextDropShadow(0, 0, 0, 55)
		SetTextEdge(0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
	DrawRect(_x,_y + 0.0125, 0.015 + (string.len(text)) / 380, 0.028, 0, 0, 0, 25)
end

---------
-- Ped --
---------
Citizen.CreateThread(function()
	-- Seller Ped --
	if Config.EnableSellerPed == true then
		RequestModel(GetHashKey('mp_m_shopkeep_01'))
		while not HasModelLoaded(GetHashKey('mp_m_shopkeep_01')) do Citizen.Wait(10) end
		SellerPed = CreatePed(3, GetHashKey('mp_m_shopkeep_01'), Config.PositionSellerPed.x,  Config.PositionSellerPed.y,  Config.PositionSellerPed.z,  Config.PositionSellerPed.a, false, false)
		SetEntityInvincible(SellerPed, true)
		SetBlockingOfNonTemporaryEvents(SellerPed, true)
		Citizen.Wait(1000)
		PlayAmbientSpeech1(SellerPed, 'GENERIC_HI', 'SPEECH_PARAMS_STANDARD')
		FreezeEntityPosition(SellerPed, true)
	end
end)

Citizen.CreateThread(function()
	-- Dealer Ped --
	if Config.EnableDealerPed == true then
		RequestModel(GetHashKey('u_m_m_streetart_01'))
		while not HasModelLoaded(GetHashKey('u_m_m_streetart_01')) do Citizen.Wait(10) end
		DealerPed = CreatePed(20, GetHashKey('u_m_m_streetart_01')	, Config.PositionDealerPed.x, Config.PositionDealerPed.y, Config.PositionDealerPed.z, Config.PositionDealerPed.a, false, false)
		SetEntityInvincible(Config.DealerPed, true)
		SetBlockingOfNonTemporaryEvents(Config.DealerPed, true)
		Citizen.Wait(1000)
		PlayAmbientSpeech1(DealerPed, 'GENERIC_HI', 'SPEECH_PARAMS_STANDARD')
		FreezeEntityPosition(DealerPed, true)
	end
end)

-----------
-- Blips --
-----------
Citizen.CreateThread(function()
	-- Seller Ped --
	if Config.EnableSellerPed == true then
		blip = AddBlipForCoord(Config.PositionSellerPed.x, Config.PositionSellerPed.y, Config.PositionSellerPed.z)
		SetBlipSprite(blip, 402)
		SetBlipDisplay(blip, 6)
		SetBlipScale(blip, 1.0)
		SetBlipColour(blip, 39)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Magasin")
		EndTextCommandSetBlipName(blip)
	end
end)

---------------
-- Open Menu --
---------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		-- Open Seller Menu --
		if Config.EnableSellerPed == true then
			if GetDistanceBetweenCoords(Config.PositionSellerPed.x, Config.PositionSellerPed.y, Config.PositionSellerPed.z, GetEntityCoords(PlayerPedId())) < 2.5 then
				Draw3DText(Config.PositionSellerPed.x, Config.PositionSellerPed.y, Config.PositionSellerPed.z + 1.0, "~g~E~s~ - Ouvrir le magasin")
				if IsControlJustPressed(0, 51) then
					RageUI.Visible(RMenu:Get('seller', 'main'), not RageUI.Visible(RMenu:Get('seller', 'main')))
				end
			end
		end

		-- Open Dealer Menu --
		if Config.EnableDealerPed == true then
			if GetDistanceBetweenCoords(Config.PositionDealerPed.x, Config.PositionDealerPed.y, Config.PositionDealerPed.z, GetEntityCoords(PlayerPedId())) < 2.5 then
				Draw3DText(Config.PositionDealerPed.x, Config.PositionDealerPed.y, Config.PositionDealerPed.z + 1.0, "~r~E~s~ - Parler au dealer")
				if IsControlJustPressed(0, 51) then
					RageUI.Visible(RMenu:Get('dealer', 'main'), not RageUI.Visible(RMenu:Get('dealer', 'main')))
				end
			end
		end
	end
end)

-----------------
-- RageUI Menu --
-----------------
-- Seller Ped Menu --
RMenu.Add('seller', 'main', RageUI.CreateMenu('Magasin', 'Articles disponibles'))

-- Dealer Ped Menu --
RMenu.Add('dealer', 'main', RageUI.CreateMenu('Dealer', 'Objets disponibles'))

----------------------
-- RageUI.IsVisible --
----------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		-- Seller Ped Menu --
		RageUI.IsVisible(RMenu:Get('seller', 'main'), true, true, true, function()
			if Config.ItemsForSellerPed == nil then return end
			for k,v in pairs(Config.ItemsForSellerPed) do
				RageUI.Button(Config.ItemsForSellerPed[k].label, nil, {}, true, function(h, a, s)
					if (s) then TriggerServerEvent('esx_peds:buyItem', Config.ItemsForSellerPed[k].name, Config.ItemsForSellerPed[k].price) end
				end, function()end)
			end
		end, function()end)

		-- Dealer Ped Menu --
		RageUI.IsVisible(RMenu:Get('dealer', 'main'), true, true, true, function()
			if Config.ItemsForSellerPed == nil then return end
			for k,v in pairs(Config.ItemsForDealerPed) do
				RageUI.Button(Config.ItemsForDealerPed[k].label, nil, {}, true, function(h, a, s)
					if (s) then TriggerServerEvent('esx_peds:buyItem', Config.ItemsForDealerPed[k].name, Config.ItemsForDealerPed[k].price) end
				end, function()end)
			end
		end, function()end)
	end
end)