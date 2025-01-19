local TRP3RPNameInQuestsOld_Frame = CreateFrame("Frame")
TRP3RPNameInQuestsOld_Frame:RegisterEvent("PLAYER_ENTERING_WORLD")


TRP3RPNameInQuestsOld_Frame:SetScript("OnEvent", function(self, event, arg1, arg2)

	if (event == "PLAYER_ENTERING_WORLD") then

		if (C_AddOns.DoesAddOnExist("tRP3_RPNameInQuests")) then
			C_AddOns.DisableAddOn("tRP3_RPNameInQuests")
		end

	end

end)