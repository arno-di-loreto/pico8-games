pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
--batcave returns
--by arnaud lauret

function _init()
	make_player()
	game={}
	game.last_time=time()
	game.delta_time=0
end

function _update()
	game.delta_time=time()-game.last_time
	game.last_time=time()
	update_player(game.delta_time)
	update_player(game.delta_time)
end

function _draw()
	cls()
	rectfill(0,0,128,128,5)
	draw_player()
end
-->8
--player
function make_player()
	player = {}
	player.width = 8
	player.height = 8
	player.x = (128 - player.width)/2
	player.y = (128 - player.height)/2
	player.x_speed=0
	player.y_speed=0
	player.max_speed=1.2
	player.acceleration=0.7
	player.friction=0.90
	player.sprite = make_sprite(2,6,6,true)
end

function move_player()
	if btn(⬆️) then
		player.y_speed-=player.acceleration
	elseif btn(⬇️) then
		player.y_speed+=player.acceleration
	else
		player.y_speed*=player.friction
	end

	if btn(➡️) then
		player.x_speed+=player.acceleration
	elseif btn(⬅️) then
		player.x_speed-=player.acceleration
	else
		player.x_speed*=player.friction
	end
		
	if abs(player.x_speed) > player.max_speed then
		player.x_speed=(player.x_speed/abs(player.x_speed))*player.max_speed
	end
	if abs(player.y_speed) > player.max_speed then
		player.y_speed=(player.y_speed/abs(player.y_speed))*player.max_speed
	end

	player.x+=player.x_speed
	player.y+=player.y_speed

	if player.x > 128-player.width then
		player.x = 128-player.width
		player.x_speed=0
	elseif player.x < 0 then
		player.x = 0
		player.x_speed=0
	end
	
	if player.y > 128-player.height then
		player.y = 128-player.height
		player.y_speed=0
	elseif player.y < 0 then
		player.y = 0
		player.y_speed=0
	end

end

function update_player(delta_time)
	move_player()
	update_sprite(player.sprite,delta_time)
end

function draw_player()
	print("x speed:"..player.x_speed,2,2,11)
	print("y speed:"..player.y_speed,2,12,11)
	draw_sprite(player.sprite,
													player.x,
													player.y)
end
-->8
--sprite

function init_frames(
										first,last,loop_back)
	local frames={}
	for i=first,last do
		add(frames,i)
	end
	if loop_back then
		for i=last-1,first+1,-1 do
			add(frames,i)
		end
	end
	return frames
end

function make_sprite(
					first,last,fps,loop_style)
	local sprite={}	
	sprite.frames=init_frames(
									first,last,loop_style)
	sprite.current=1
	sprite.fps=fps
	sprite.frame_time=0
	return sprite
end

function update_sprite(sprite,delta_time)
	sprite.frame_time+=delta_time
	if sprite.frame_time > 1/sprite.fps then
		sprite.current=(sprite.current%#sprite.frames)+1
		sprite.frame_time=0
	end
end

function draw_sprite(sprite,x,y)
	spr(sprite.frames[sprite.current],x,y)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000001001000010010000100100001001000010010000100100000000000000000000000000000000000000000000000000000000000000000000000000
00700700001111011011110100111100001111000011110000111100000000000000000000000000000000000000000000000000000000000000000000000000
00077000001111011011110110111101001111000011110000111100000000000000000000000000000000000000000000000000000000000000000000000000
00077000018118100171171001711710117117110171171001711710000000000000000000000000000000000000000000000000000000000000000000000000
00700700101111000011110000111100001111001011110110111101000000000000000000000000000000000000000000000000000000000000000000000000
00000000100110000001100000011000000110000001100010011001000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000454444440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000555555550007000000777000007770000000700000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000444445440077000000000700000007000007700000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000555555550007000000000700000007000070700000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000444544440007000000777000007770000700700000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000555555550007000007000000000007000777770000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000444445440007000007000000000007000000700000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000555555550077700000777000007770000000700000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
1111111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111111111111111111111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000e050150500e0500e0500e0500e0500e0500e050100500c0500e0500c0500e0500c0500e0501f05021050230500e0500c0500e050150500e050150500e050150500e050150500e050150500e05015050
0010000017550175501755017550165501355017550195502680027800175501c8001655012800155501655027800258001e5500e800118001b550208002655023800215501580029550245501e5501955017550
__music__
00 01424344

