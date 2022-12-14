local QBCore = exports['qb-core']:GetCoreObject()

isLoggedIn = true

local onDuty = false

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	if PlayerData.job.onduty then
	    if PlayerData.job.name == "burgershot" then
		TriggerServerEvent("QBCore:ToggleDuty")
	    end
	end
end)

RegisterNetEvent('QBCore:Client:SetDuty')
AddEventHandler('QBCore:Client:SetDuty', function(duty)
    if PlayerData.job.name == 'burgershot' then
    	onDuty = duty
    end
end)

Citizen.CreateThread(function()
    BurgerShot = AddBlipForCoord(-1197.32, -897.655, 13.995)
    SetBlipSprite (BurgerShot, 106)
    SetBlipDisplay(BurgerShot, 4)
    SetBlipScale  (BurgerShot, 0.5)
    SetBlipAsShortRange(BurgerShot, true)
    SetBlipColour(BurgerShot, 75)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("BurgerShot")
    EndTextCommandSetBlipName(BurgerShot)
end) 

RegisterNetEvent("qb-burgershot:DutyB")
AddEventHandler("qb-burgershot:DutyB", function()
    TriggerServerEvent("QBCore:ToggleDuty")
end)

RegisterNetEvent("qb-burgershot:Tray1")
AddEventHandler("qb-burgershot:Tray1", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgertray1")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgertray1", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-burgershot:Tray4")
AddEventHandler("qb-burgershot:Tray4", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgertray4")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgertray4", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-burgershot:Tray3")
AddEventHandler("qb-burgershot:Tray3", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgertray3")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgertray3", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("qb-burgershot:Storage")
AddEventHandler("qb-burgershot:Storage", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgerstorage")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgerstorage", {
        maxweight = 250000,
        slots = 40,
    })
end)

RegisterNetEvent("qb-burgershot:Storage2")
AddEventHandler("qb-burgershot:Storage2", function()
    TriggerEvent("inventory:client:SetCurrentStash", "burgerstorage2")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "burgerstorage2", {
        maxweight = 250000,
        slots = 40,
    })
end)

RegisterNetEvent("qb-burgershot:CreateMurderMeal")
AddEventHandler("qb-burgershot:CreateMurderMeal", function()
	if onDuty then
		local hasIngredients = (
			QBCore.Functions.HasItem('burger-heartstopper') and
			QBCore.Functions.HasItem('burger-fries') and
			QBCore.Functions.HasItem('burger-softdrink'))			

		if hasIngredients then
			QBCore.Functions.Progressbar("pickup_sla", "Making A Murder Meal..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('qb-burgershot:server:makeMeal-murder')
					QBCore.Functions.Notify("You made a Murder Meal", "success")
				end, function()
					QBCore.Functions.Notify("Cancelled..", "error")
				end)
		else
			QBCore.Functions.Notify("You don't have the right ingredients!", "error", 5000)
		end

	else
		QBCore.Functions.Notify("You're not clocked in...", "error", 5000)
	end
end)

RegisterNetEvent("qb-burgershot:MurderMeal")
AddEventHandler("qb-burgershot:MurderMeal", function()
	QBCore.Functions.TriggerCallback("qb-burgershot:server:openMealBox", function(toy)
		if toy then
			if toy == "rare" then
				QBCore.Functions.Notify("You got a rare toy! Congratulations!", "success")
			elseif toy == "shiny" then
				QBCore.Functions.Notify("You got an exceedingly rare SHINY TOY! you lucky motherfucker.", "success")
			else
				QBCore.Functions.Notify("You got a toy!", "success")
			end
		else
			QBCore.Functions.Notify("No toy this time. :(", "error")
		end
	end)
end)

--	local randomToy = math.random(1,10)
	
-- 	TriggerServerEvent('QBCore:Server:RemoveItem', "burger-murdermeal", 1)
-- -- 		--add items from box
-- -- 		TriggerServerEvent('QBCore:Server:AddItem', "burger-heartstopper", 1)
-- -- 		TriggerServerEvent('QBCore:Server:AddItem', "burger-softdrink", 1)
-- -- 		TriggerServerEvent('QBCore:Server:AddItem', "burger-fries", 1)

-- -- 		if randomToy < 4 then
-- -- 			QBCore.Functions.Notify("No toy in Box Looool", "error")
-- -- 		elseif randomToy == 4 then
-- -- 			TriggerServerEvent('QBCore:Server:AddItem', "burger-toy1", 1)
-- --             		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-toy1"], "add")
-- -- 		elseif randomToy < 10 and randomToy > 4 then
-- -- 			QBCore.Functions.Notify("No toy in Box Looool", "error")
-- -- 		elseif randomToy == 10 then
-- -- 			TriggerServerEvent('QBCore:Server:AddItem', "burger-toy2", 1)
-- --             		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-toy2"], "add")
-- -- 		else
-- --             		QBCore.Functions.Notify("No toy in Box Looool", "error")
-- --         end


RegisterNetEvent("qb-burgershot:BleederBurger")
AddEventHandler("qb-burgershot:BleederBurger", function()
    if onDuty then
		local hasIngredients = (
			QBCore.Functions.HasItem('burger-meat') and
			QBCore.Functions.HasItem('burger-lettuce') and
			QBCore.Functions.HasItem('burger-tomato') and
			QBCore.Functions.HasItem('burger-bun'))			

		if hasIngredients then
			QBCore.Functions.Progressbar("pickup_sla", "Making A Bleeder Burger..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('qb-burgershot:server:makeMeal-bleeder')
					QBCore.Functions.Notify("You made a Bleeder Burger", "success")
				end, function()
					QBCore.Functions.Notify("Cancelled..", "error")
				end)
		else
			QBCore.Functions.Notify("You don't have the right ingredients!", "error", 5000)
		end

	else
		QBCore.Functions.Notify("You're not clocked in...", "error", 5000)
	end
end)

RegisterNetEvent("qb-burgershot:MoneyShot")
AddEventHandler("qb-burgershot:MoneyShot", function()
    if onDuty then
		
		QBCore.Functions.TriggerCallback('qb-burgershot:server:CheckPatties', function(patties) 
			local pattyCount = 0
			
			if patties then 
				pattyCount = patties
			else 
				pattyCount = 0
			end

			local hasIngredients = (
				pattyCount >= 2 and
				QBCore.Functions.HasItem('burger-lettuce') and
				QBCore.Functions.HasItem('burger-tomato') and
				QBCore.Functions.HasItem('burger-bun'))			

			if hasIngredients then
				QBCore.Functions.Progressbar("pickup_sla", "Making A MoneyShot Burger..", 4000, false, true, {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					}, {
						animDict = "mp_common",
						anim = "givetake1_a",
						flags = 8,
					}, {}, {}, function() -- Done
						TriggerServerEvent('qb-burgershot:server:makeMeal-moneyshot')
						QBCore.Functions.Notify("You made a Moneyshot Burger", "success")
					end, function()
						QBCore.Functions.Notify("Cancelled..", "error")
					end)
			else
				QBCore.Functions.Notify("You don't have the right ingredients!", "error", 5000)
			end
		end)
	else
		QBCore.Functions.Notify("You're not clocked in...", "error", 5000)
	end
end)

RegisterNetEvent("qb-burgershot:HeartStopper")
AddEventHandler("qb-burgershot:HeartStopper", function()
    if onDuty then
		QBCore.Functions.TriggerCallback('qb-burgershot:server:CheckPatties', function(patties) 
			local pattyCount = 0
			
			if patties then 
				pattyCount = patties
			else 
				pattyCount = 0
			end

			local hasIngredients = (
				pattyCount >= 10 and
				QBCore.Functions.HasItem('burger-lettuce') and
				QBCore.Functions.HasItem('burger-tomato') and
				QBCore.Functions.HasItem('burger-bun'))			

			if hasIngredients then
				QBCore.Functions.Progressbar("pickup_sla", "Making A Heartstopper Burger..", 4000, false, true, {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					}, {
						animDict = "mp_common",
						anim = "givetake1_a",
						flags = 8,
					}, {}, {}, function() -- Done
						TriggerServerEvent('qb-burgershot:server:makeMeal-heartstopper')
						QBCore.Functions.Notify("You made a Heartstopper Burger", "success")
					end, function()
						QBCore.Functions.Notify("Cancelled..", "error")
					end)
			else
				QBCore.Functions.Notify("You don't have the right ingredients! You need 10 patties.", "error", 5000)
			end
		end)

	else
		QBCore.Functions.Notify("You're not clocked in...", "error", 5000)
	end
end)


RegisterNetEvent("qb-burgershot:Torpedo")
AddEventHandler("qb-burgershot:Torpedo", function()
	if onDuty then
    
		local hasIngredients = (
			QBCore.Functions.HasItem('burger-meat') and
			QBCore.Functions.HasItem('burger-bun'))			

		if hasIngredients then
			QBCore.Functions.Progressbar("pickup_sla", "Making A Torpedo Roll..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('qb-burgershot:server:makeMeal-torpedo')
					QBCore.Functions.Notify("You made a Torpedo Roll", "success")
				end, function()
					QBCore.Functions.Notify("Cancelled..", "error")
				end)
		else
			QBCore.Functions.Notify("You don't have the right ingredients!", "error", 5000)
		end

	else
		QBCore.Functions.Notify("You're not clocked in...", "error", 5000)
	end
end)

RegisterNetEvent("qb-burgershot:MeatFree")
AddEventHandler("qb-burgershot:MeatFree", function()
	if onDuty then
    
		local hasIngredients = (
			QBCore.Functions.HasItem('burger-lettuce') and
			QBCore.Functions.HasItem('burger-tomato') and
			QBCore.Functions.HasItem('burger-bun'))			

		if hasIngredients then
			QBCore.Functions.Progressbar("pickup_sla", "Making A Meat Free Burger..", 4000, false, true, {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				}, {
					animDict = "mp_common",
					anim = "givetake1_a",
					flags = 8,
				}, {}, {}, function() -- Done
					TriggerServerEvent('qb-burgershot:server:makeMeal-meatfree')
					QBCore.Functions.Notify("You made a Meat Free Burger", "success")
				end, function()
					QBCore.Functions.Notify("Cancelled..", "error")
				end)
		else
			QBCore.Functions.Notify("You don't have the right ingredients!", "error", 5000)
		end

	else
		QBCore.Functions.Notify("You're not clocked in...", "error", 5000)
	end
end)



RegisterNetEvent("qb-burgershot:SoftDrink")
AddEventHandler("qb-burgershot:SoftDrink", function()
    if onDuty then
    	hasItem = QBCore.Functions.HasItem('burger-sodasyrup')
		if hasItem then
			QBCore.Functions.Progressbar("pickup", "Filling a cup..", 4000, false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = false,
			})
			Citizen.Wait(4000)
			TriggerServerEvent('qb-burgershot:server:makeSoftDrink')
			QBCore.Functions.Notify("You made some sodas", "success")
        else
            QBCore.Functions.Notify("You don't have any soda syrup..", "error")
        end
    else
        QBCore.Functions.Notify("You must be Clocked into work", "error")
    end
end)

RegisterNetEvent("qb-burgershot:mShake")
AddEventHandler("qb-burgershot:mShake", function()
    if onDuty then
    	hasItem = QBCore.Functions.HasItem('burger-mshakeformula')
		if hasItem then
			QBCore.Functions.Progressbar("pickup", "Filling a cup..", 4000, false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = false,
			})
			Citizen.Wait(4000)
			TriggerServerEvent('qb-burgershot:server:makeMilkshake')
			QBCore.Functions.Notify("You made some shakes", "success")
        else
            QBCore.Functions.Notify("You don't have any shake formula..", "error")
        end
    else
        QBCore.Functions.Notify("You must be Clocked into work", "error")
    end
end)

RegisterNetEvent("qb-burgershot:Fries")
AddEventHandler("qb-burgershot:Fries", function()
    if onDuty then
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
        if HasItem then
           MakeFries()
        else
            QBCore.Functions.Notify("You don't have any potatoes..", "error")
        end
      end, 'burger-potato')
    else
        QBCore.Functions.Notify("You must be Clocked into work", "error")
    end
end)


RegisterNetEvent("qb-burgershot:PattyFry")
AddEventHandler("qb-burgershot:PattyFry", function()
    if onDuty then
    
		local hasPatty = QBCore.Functions.HasItem('burger-raw')

		if hasPatty then
			MakePatty()
		else
			QBCore.Functions.Notify("You don't have any patties!", "error", 5000)
		end

	else
		QBCore.Functions.Notify("You're not clocked in...", "error", 5000)
	end
end)

-- Functions --
function MakeFries()
	QBCore.Functions.Progressbar("pickup", "Frying the fries..", 4000, false, true, {
	    disableMovement = true,
	    disableCarMovement = true,
	    disableMouse = false,
	    disableCombat = true,
	},{
	    animDict = "amb@prop_human_bbq@male@base",
	    anim = "base",
	    flags = 8,
	    }, {
		model = "prop_cs_fork",
		bone = 28422,
		coords = vector3(-0.005, 0.00, 0.00),
		rotation = vector3(175.0, 160.0, 0.0),
	    }
	)
	Citizen.Wait(4000)

	TriggerServerEvent('qb-burgershot:server:cookFries') -- cook the fries
	QBCore.Functions.Notify("You made 4 fries", "success")
	StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0) -- stop animating
end


function MakePatty()

	QBCore.Functions.TriggerCallback('qb-burgershot:server:CheckPattiesRaw', function(patties) 
		local pattyCount = 0
		
		if patties then 
			pattyCount = patties
		else 
			pattyCount = 0
		end
	

		if pattyCount < 10 then
			QBCore.Functions.Notify("You need 10 patties!", "error")
			return
		end

		QBCore.Functions.Progressbar("pickup", "Cooking the Patty..", 4000, false, true, {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		},{
			animDict = "amb@prop_human_bbq@male@base",
			anim = "base",
			flags = 8,
		}, {
			model = "prop_cs_fork",
			bone = 28422,
			coords = vector3(-0.005, 0.00, 0.00),
			rotation = vector3(175.0, 160.0, 0.0),
		}) 

		Citizen.Wait(4000)

		TriggerServerEvent('qb-burgershot:server:cookPatty')
		QBCore.Functions.Notify("You cooked the meat", "success")
		StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@base", "base", 1.0)

	end)
end

function MakeSoftDrink()
    TriggerServerEvent('QBCore:Server:RemoveItem', "burger-sodasyrup", 1)
    QBCore.Functions.Progressbar("pickup", "Filling a cup..", 4000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    })
    Citizen.Wait(4000)
    TriggerServerEvent('QBCore:Server:AddItem', "burger-softdrink", 1)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-softdrink"], "add")
    QBCore.Functions.Notify("You made a Soda", "success")
end  


function MakeMShake()
    TriggerServerEvent('QBCore:Server:RemoveItem', "burger-mshakeformula", 1)
    QBCore.Functions.Progressbar("pickup", "Filling up a cup..", 4000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    })
    Citizen.Wait(4000)
    TriggerServerEvent('QBCore:Server:AddItem', "burger-mshake", 1)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["burger-mshake"], "add")
    QBCore.Functions.Notify("You made a Milkshake", "success")
end  
   
RegisterNetEvent("qb-burgershot:shop")
AddEventHandler("qb-burgershot:shop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "burgershot", Config.Items)
end)
