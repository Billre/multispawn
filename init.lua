
-- register privs for spawn points
minetest.register_privilege("farm", {description = "Farm spawn.", give_to_singleplayer=false})
minetest.register_privilege("woods", {description = "Woods spawn.", give_to_singleplayer=false})
minetest.register_privilege("mine", {description = "Mine spawn.", give_to_singleplayer=false})
minetest.register_privilege("games", {description = "Games spawn.", give_to_singleplayer=false})
minetest.register_privilege("spawn1", {description = "Area1 spawn.", give_to_singleplayer=false})
minetest.register_privilege("spawn2", {description = "Area2 spawn.", give_to_singleplayer=false})
minetest.register_privilege("spawn3", {description = "Area3 spawn.", give_to_singleplayer=false})
minetest.register_privilege("spawn4", {description = "Area4 spawn.", give_to_singleplayer=false})


-- function to select and move player to correct spawn
local function respawn(name)
	local spawnpos
	-- check minetest.conf file for correct coordinates depending on privs	
	if minetest.check_player_privs(name, {farm=true}) then
		spawnpos = minetest.setting_get_pos("spawn_coordinate_farm")
	elseif minetest.check_player_privs(name, {woods=true}) then
		spawnpos = minetest.setting_get_pos("spawn_coordinate_woods")
	elseif minetest.check_player_privs(name, {mine=true}) then
		spawnpos = minetest.setting_get_pos("spawn_coordinate_mine")
	elseif minetest.check_player_privs(name, {games=true}) then
		spawnpos = minetest.setting_get_pos("spawn_coordinate_games")	
	elseif minetest.check_player_privs(name, {spawn1=true}) then
		spawnpos = minetest.setting_get_pos("spawn_coordinate_Area1")
	elseif minetest.check_player_privs(name, {spawn2=true}) then
		spawnpos = minetest.setting_get_pos("spawn_coordinate_Area2")
	elseif minetest.check_player_privs(name, {spawn3=true}) then
		spawnpos = minetest.setting_get_pos("spawn_coordinate_Area3")
	elseif minetest.check_player_privs(name, {spawn4=true}) then
		spawnpos = minetest.setting_get_pos("spawn_coordinate_Area4")
	end

	-- return if no valid spawn position...
	if not spawnpos then
		minetest.chat_send_player(name, "No spawn point set...")
	else
		-- if spawn position found, teleport player
		local player = minetest.get_player_by_name(name)
		player:setpos(spawnpos)
		minetest.chat_send_player(name, "Teleported to Current Spawn!")
	end

	return true
end


-- spawn command
minetest.register_chatcommand("spawn", {
	description = "Teleport to current spawn point.",
	privs = {},
	func = function(name)
		respawn(name)
	end
})


-- teleports player on respawn
minetest.register_on_respawnplayer(function(player)
	if respawn(player:get_player_name()) then
		return true
	end
end)
