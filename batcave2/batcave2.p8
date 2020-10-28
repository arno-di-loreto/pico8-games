pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
--batcave returns
--by arnaud lauret

function _init()
	make_cave()
	make_player()
end

function _update()
	update_cave()
	update_player()
end

function _draw()
	cls()
	draw_cave()
	draw_player()
end
-->8
function make_player()
	player={}
	player.x=28
	player.y=60
	player.speed_x=0
	player.speed_y=0
	player.speed_max=2
	player.acceleration=3 -- constant accel
	player.deceleration=0.95 -- ratio
	player.spr_start=2
	player.spr_end=6
	player.spr_current=2
	player.spr_animate=1
	player.spr_dead=1
	player.spr_time=time()
	player.spr_speed=0.08
	player.height=8
	player.width=8
end

function animate_player()
	if time()-player.spr_time>player.spr_speed then
		player.spr_time=time()
		player.spr_current+=player.spr_animate
		if player.spr_current == player.spr_start or
				 player.spr_current == player.spr_end then
				 player.spr_animate=player.spr_animate*-1
		end 
	end
end

function move_player()

	-- set speed
	if btnp(⬆️) then
		player.speed_y-=player.acceleration
	elseif btnp(⬇️) then
		player.speed_y+=player.acceleration
	else
		player.speed_y*=player.deceleration
	end
	
	if btnp(⬅️) then
		player.speed_x-=player.acceleration
	elseif btnp(➡️) then
		player.speed_x+=player.acceleration
	else
		player.speed_x*=player.deceleration
	end
	
	-- max speed
	if abs(player.speed_x) > player.speed_max then
		if player.speed_x > 0 then
			player.speed_x = player.speed_max
		else
			player.speed_x = -player.speed_max
		end
	end
	if abs(player.speed_y) > player.speed_max then
		if player.speed_y > 0 then
			player.speed_y = player.speed_max
		else
			player.speed_y = -player.speed_max
		end
	end
	
	-- set new position
	player.y+=player.speed_y		
	player.x+=player.speed_x
	
	-- stay inside screen borders
	if player.y+player.width > 128 then
		player.y=128-player.width
		player.speed_y=0
	end
	if player.y < 0 then
		player.y=0
		player.speed_y=0
	end

	if player.x+player.height > 128 then
		player.x=128-player.height
		player.speed_x=0
	end
	if player.x < 0 then
		player.x=0
		player.speed_x=0
	end

end

function update_player()
	animate_player()
	move_player()
end

function draw_player()
	spr(player.spr_current,
	    player.x,
	    player.y)	
	print(player.speed_x.."/"..player.speed_y,2,2,3)
end
-->8
function make_cave()
end

function update_cave()
end

function draw_cave()
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000001001000010010000100100001001000010010000100100000000000000000000000000000000000000000000000000000000000000000000000000
00700700001111011011110100111100001111000011110000111100000000000000000000000000000000000000000000000000000000000000000000000000
00077000001111011011110110111101001111000011110000111100000000000000000000000000000000000000000000000000000000000000000000000000
00077000018118100171171001711710117117110171171001711710000000000000000000000000000000000000000000000000000000000000000000000000
00700700101111000011110000111100001111001011110110111101000000000000000000000000000000000000000000000000000000000000000000000000
00000000100110000001100000011000000110000001100010011001000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000e050150500e0500e0500e0500e0500e0500e050100500c0500e0500c0500e0500c0500e0501f05021050230500e0500c0500e050150500e050150500e050150500e050150500e050150500e05015050
0010000017550175501755017550165501355017550195502680027800175501c8001655012800155501655027800258001e5500e800118001b550208002655023800215501580029550245501e5501955017550
__music__
00 01424344

