--hp bar
local oldhp = 100

surface.CreateFont("Roboto Bk", { --font settings
	font = "Roboto Bk",
	size = ScreenScale(12),
	outline = true,
	antialias = true
})

surface.CreateFont("Roboto", { --font settings
	font = "Roboto",
	size = ScreenScale(8),
	outline = true,
	antialias = true
})

hook.Add( "InitPostEntity", "nickInit", function()
	plyhp = LocalPlayer():Health()
	plyar = LocalPlayer():Armor()
	isAlive = LocalPlayer():Alive()
end )


local oldar = 0
local armal = 255
local armal2 = 175

local widthhp = 100
local widthar = 0

local g = 175
local r = 0

function DrawPlyHPHUD()
	draw.RoundedBox(5,32,ScrH() - 64,ScreenScale(100),ScreenScale(14),Color(5,5,5,175))
	draw.DrawText("HP ".. oldhp, "Roboto Bk", 36, ScrH() - 64) --HP
	draw.RoundedBox(0,32,ScrH() - 32,ScreenScale(100),ScreenScale(1),Color(175,175,175,175))
	draw.RoundedBox(0,32,ScrH() - 32,ScreenScale(widthhp),ScreenScale(1),Color(r,g,0))
	
	draw.RoundedBox(5,320,ScrH() - 64,ScreenScale(100),ScreenScale(14),Color(5,5,5,armal2))
	draw.DrawText("ARMOR ".. oldar, "Roboto Bk", 326, ScrH() - 64, Color(255,255,255,armal)) --ARMOR
	draw.RoundedBox(0,320,ScrH() - 32,ScreenScale(100),ScreenScale(1),Color(175,175,175,armal2))
	draw.RoundedBox(0,320,ScrH() - 32,ScreenScale(widthar),ScreenScale(1),Color(0,175,175,armal))
end

hook.Add("HUDPaint", "DrawPlyHPHUD", DrawPlyHPHUD)

hook.Add("Think", "PlyHPThink", function()
	plyhp = LocalPlayer():Health()
	plyar = LocalPlayer():Armor()
	isAlive = LocalPlayer():Alive()
	
	if(plyhp < 0 or isAlive == false) then --we dont wanna player watch negative number
		plyhp = 0
		oldhp = 0
	end if(plyhp > 0) then
		while oldhp < plyhp do
			oldhp = oldhp + 0.5
		end
	
		while oldhp > plyhp do
			oldhp = oldhp - 0.5
		end
		
	end
	
	widthhp = oldhp
	widthar = oldar

	if(plyhp < 25) then
		r = 175
		g = 0
	end if(plyhp > 25) then
		r = 0
		g = 175
	end
	
	while oldar < plyar do
		oldar = oldar + 0.5
	end
	
	while oldar > plyar do
		oldar = oldar - 0.5
	end
	
	if(plyhp > 100) then
		widthhp = 100
	end
	if(plyar > 100) then
		widthar = 100
	end

	if(plyar == 0) then
		while(armal > 0) do
			armal = armal - 1
			armal2 = armal2 - 1
		end
	end
	
	if(plyar > 0) then
		while(armal < 255) do
			armal = armal + 1
			armal2 = armal2 + 1
		end
	end
end)

local hide = {
	CHudHealth = true,
	CHudBattery = true,
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then return false end

	-- Don't return anything here, it may break other addons that rely on this hook.
end )