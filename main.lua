-- Setup:
-- winget install DEVCOM.Lua
-- lua main.lua

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
	"Snipping Tool",
	"Solitaire & Casual Games",
	"Spotify Music",
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
}

for i = 1, #Packages do
	Packages[i] = "\""..Packages[i].."\""
end
print(table.concat(Packages, ", "))

for i = 1, #Packages do
	local Package = Packages[i]
	os.execute("echo ["..tostring(i).."/"..#Packages.."]: "..Package.." && winget uninstall "..Package)
end