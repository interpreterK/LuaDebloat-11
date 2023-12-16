-- Setup:
-- winget install DEVCOM.Lua
-- lua main.lua

-- Built on:
-- Lua 5.4.6  Copyright (C) 1994-2023 Lua.org, PUC-Rio

--Removes Calculator, Notepad, Snipping Tool, and Paint
local RemoveExtras = true

--Uses App id's instead of names (extra computing time)
local UseAppIDs = true

local Packages = {
	"skype",
	"onedrive",
	"Microsoft Teams",
	"3D Viewer",
	"Camera",
	"Cortana",
	"Feedback Hub",
	"Maps",
	"Media Player",
	"Microsoft 365 (Office)",
	"Mail and Calendar",
	"Microsoft Clipchamp",
	"Microsoft Photos",
	"Microsoft To Do",
	"Microsoft Update Health Tools",
	"Mixed Reality Portal",
	"Movies & TV",
	"News",
	"OneNote for Windows 10",
	"Paint 3D",
	"People",
	"Power Automate",
	"Gaming Services",
	"Quick Assist",
	"Microsoft People",
	"Solitaire & Casual Games",
	"Spotify Music", --Please stop using this very smelly shit
	"Sound Recorder",
	"Sticky Notes",
	"Weather",
	"Windows Clock",
	"Xbox",
	"Xbox Console Companion",
	"Xbox Live",
	"Xbox Game Bar Plugin",
	"Xbox Identitiy Provider",
	"Xbox Game Speech Window",
	"Xbox TCUI",
	"Game Bar",
	"Get Help",
	"Microsoft Tips",
	"Phone Link"
}

local ExtraPackages = {
	"Windows Calculator",
	"Windows Notepad",
	"Paint",
	"Snipping Tool"
}

local s_gmatch = string.gmatch
local s_gsub = string.gsub

local t_insert = table.insert
local t_move = table.move
local t_concat = table.concat

local i_popen = io.popen
local o_execute = os.execute

local function ForEachPackage(fun)
	for i = 1, #Packages do
		fun(i, Packages[i])
	end
end

local function Split(String, Delimiter)
	Delimiter = Delimiter or ','
	local Split_String = {}
	for reg in s_gmatch(String, "[^"..Delimiter.."]+") do
		t_insert(Split_String, reg)
	end
	return Split_String
end

local function GetApplicationID(io_popen, PackageName)
	local ListLines = Split(io_popen, '\n')
	local AppName = ListLines[3]

	--My faster split algorithm
	local ID = nil
	local CutInfo = AppName and s_gsub(AppName, '%s[%d%p]+$', '')
	print(CutInfo)
	if CutInfo then
		ID = s_gsub(CutInfo, '^['..PackageName..']+%s?', '')
	end
	return ID
end

if RemoveExtras then
	t_move(ExtraPackages, 1, #ExtraPackages, #Packages+1, Packages)
end

if UseAppIDs then
	print("-> UseAppIDs mode is ON, this will take longer...\n")

	ForEachPackage(function(i, Package)
		local popen_list = i_popen("winget list "..Package.."", 'r'):read('a')

		if popen_list:lower():find("no installed") then
			print("Package: \""..Package.."\" not installed (Skipping)")
		else
			local ApplicationID = GetApplicationID(popen_list, Packages[i])
			if ApplicationID then
				local PreviousName = Package
				Packages[i] = ApplicationID
				print(PreviousName, "->", Packages[i])
			else
				print("\n[ERROR]: Failed to get the Application ID for:", Package, "got:", ApplicationID, '\n')
			end
		end
	end)
end

--Parse all the entires
ForEachPackage(function(i, Package)
	Packages[i] = "\""..Package.."\""
end)
print(t_concat(Packages, ',\n'))
print("\n-> Starting bloat remover...\n")

-- ForEachPackage(function(i, Package)
-- 	print("["..tostring(i).."/"..#Packages.."]: "..Package.."")
-- 	o_execute("winget uninstall "..Package)
-- end)