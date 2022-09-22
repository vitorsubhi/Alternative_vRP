-----------------------------------------------------------------------------------------------------------------------------------------
-- ANDAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("andar",function(source,args,rawCommand)
	if args[1] and exports["chat"]:statusChat(source) then
		vCLIENT.movementClip(source,walking[parseInt(args[1])][1])
	end
end)