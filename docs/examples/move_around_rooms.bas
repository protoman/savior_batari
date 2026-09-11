   rem * move around rooms

   dim room = a
   dim p0_x = b
   dim p0_y = c

   data room_shape
   7,11,4,1,2,9,10,3,9,12,8,4,15,6,5,3,13
   11,10,3,5,15,0,1,1,14,8,4,15,14,10,2,12,14
end

   data move_north
   0,0,0,0,5,2,4,8,9,0,11,12,0,0,0,14,0,0
   3,21,0,0,20,0,0,22,23,28,0,27,24,32,0,31
end

   data move_east
   1,0,3,4,0,0,7,10,0,0,0,13,0,14,0,17,15,0
   19,20,0,0,24,22,23,0,0,26,0,0,31,0,0,0
end

   data move_south
   2,0,5,18,6,4,0,0,7,8,0,10,11,0,15,0,0,0
   0,0,22,19,25,26,30,0,0,29,27,0,0,33,31,0
end

   data move_west
   0,0,0,2,3,0,0,6,0,0,7,0,0,11,13,16,0,15
   0,18,19,0,23,24,22,0,27,0,0,0,0,30,0,0
end

   data room_color
   $86,$86,$86,$86,$C6,$C6,$66,$66,$66
   $66,$00,$00,$00,$00,$46,$46,$46
   $46,$1C,$1C,$1C,$1C,$24,$24,$24,$24
   $0E,$0E,$0E,$0E,$3A,$3A,$3A,$3A
end

   player0:
   %01101100
   %00101000
   %00111000
   %11111110
   %00010000
   %00111000
end

   COLUBK = $08
   room = 19
   gosub draw_room
   player0x = 92
   player0y = 47

loop
   COLUP0 = $2E

   p0_x = 0
   if joy0left then p0_x = 255
   if joy0right then p0_x = 1
   player0x = player0x + p0_x

   p0_y = 0
   if joy0up then p0_y = 255
   if joy0down then p0_y = 1
   player0y = player0y + p0_y

   if player0y = 6 then gosub go_north
   if player0x = 153 then gosub go_east
   if player0y = 88 then gosub go_south
   if player0x = 31 then gosub go_west

   drawscreen

   if collision(player0,playfield) then gosub knock_player_back

   goto loop

knock_player_back
   player0x = player0x - p0_x
   player0y = player0y - p0_y
   return

go_north
   player0y = 87
   room = move_north[room]
   goto draw_room

go_east
   player0x = 32
   room = move_east[room]
   goto draw_room

go_south
   player0y = 7
   room = move_south[room]
   goto draw_room

go_west
   player0x = 152
   room = move_west[room]

draw_room
   COLUPF = room_color[room]
   if room_shape[room] = 0 then goto draw_room_shape_0
   if room_shape[room] = 1 then goto draw_room_shape_1
   if room_shape[room] = 2 then goto draw_room_shape_2
   if room_shape[room] = 3 then goto draw_room_shape_3
   if room_shape[room] = 4 then goto draw_room_shape_4
   if room_shape[room] = 5 then goto draw_room_shape_5
   if room_shape[room] = 6 then goto draw_room_shape_6
   if room_shape[room] = 7 then goto draw_room_shape_7
   if room_shape[room] = 8 then goto draw_room_shape_8
   if room_shape[room] = 9 then goto draw_room_shape_9
   if room_shape[room] = 10 then goto draw_room_shape_10
   if room_shape[room] = 11 then goto draw_room_shape_11
   if room_shape[room] = 12 then goto draw_room_shape_12
   if room_shape[room] = 13 then goto draw_room_shape_13
   if room_shape[room] = 14 then goto draw_room_shape_14
   if room_shape[room] = 15 then goto draw_room_shape_15

draw_room_shape_0
   playfield:
   XXXXXXXXXXXX........XXXXXXXXXXXX
   XX............................XX
   XX............................XX
   XX............................XX
   ................................
   ................................
   ................................
   XX............................XX
   XX............................XX
   XX............................XX
   XXXXXXXXXXXX........XXXXXXXXXXXX
end
   return

draw_room_shape_1
   playfield:
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   XX............................XX
   XX............................XX
   XX............................XX
   ................................
   ................................
   ................................
   XX............................XX
   XX............................XX
   XX............................XX
   XXXXXXXXXXXX........XXXXXXXXXXXX
end
   return

draw_room_shape_2
   playfield:
   XXXXXXXXXXXX........XXXXXXXXXXXX
   XX............................XX
   XX............................XX
   XX............................XX
   ..............................XX
   ..............................XX
   ..............................XX
   XX............................XX
   XX............................XX
   XX............................XX
   XXXXXXXXXXXX........XXXXXXXXXXXX
end
   return

draw_room_shape_3
   playfield:
   XXXXXXXXXXXX........XXXXXXXXXXXX
   XX............................XX
   XX............................XX
   XX............................XX
   ................................
   ................................
   ................................
   XX............................XX
   XX............................XX
   XX............................XX
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
   return

draw_room_shape_4
   playfield:
   XXXXXXXXXXXX........XXXXXXXXXXXX
   XX............................XX
   XX............................XX
   XX............................XX
   XX..............................
   XX..............................
   XX..............................
   XX............................XX
   XX............................XX
   XX............................XX
   XXXXXXXXXXXX........XXXXXXXXXXXX
end
   return

draw_room_shape_5
   playfield:
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   XX............................XX
   XX............................XX
   XX............................XX
   ..............................XX
   ..............................XX
   ..............................XX
   XX............................XX
   XX............................XX
   XX............................XX
   XXXXXXXXXXXX........XXXXXXXXXXXX
end
   return

draw_room_shape_6
   playfield:
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   XX............................XX
   XX............................XX
   XX............................XX
   ................................
   ................................
   ................................
   XX............................XX
   XX............................XX
   XX............................XX
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
   return

draw_room_shape_7
   playfield:
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   XX............................XX
   XX............................XX
   XX............................XX
   XX..............................
   XX..............................
   XX..............................
   XX............................XX
   XX............................XX
   XX............................XX
   XXXXXXXXXXXX........XXXXXXXXXXXX
end
   return

draw_room_shape_8
   playfield:
   XXXXXXXXXXXX........XXXXXXXXXXXX
   XX............................XX
   XX............................XX
   XX............................XX
   ..............................XX
   ..............................XX
   ..............................XX
   XX............................XX
   XX............................XX
   XX............................XX
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
   return

draw_room_shape_9
   playfield:
   XXXXXXXXXXXX........XXXXXXXXXXXX
   XX............................XX
   XX............................XX
   XX............................XX
   XX............................XX
   XX............................XX
   XX............................XX
   XX............................XX
   XX............................XX
   XX............................XX
   XXXXXXXXXXXX........XXXXXXXXXXXX
end
   return

draw_room_shape_10
   playfield:
   XXXXXXXXXXXX........XXXXXXXXXXXX
   XX............................XX
   XX............................XX
   XX............................XX
   XX..............................
   XX..............................
   XX..............................
   XX............................XX
   XX............................XX
   XX............................XX
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
   return

draw_room_shape_11
   playfield:
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   XX............................XX
   XX............................XX
   XX............................XX
   ..............................XX
   ..............................XX
   ..............................XX
   XX............................XX
   XX............................XX
   XX............................XX
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
   return

draw_room_shape_12
   playfield:
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   XX............................XX
   XX............................XX
   XX............................XX
   XX............................XX
   XX............................XX
   XX............................XX
   XX............................XX
   XX............................XX
   XX............................XX
   XXXXXXXXXXXX........XXXXXXXXXXXX
end
   return

draw_room_shape_13
   playfield:
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   XX............................XX
   XX............................XX
   XX............................XX
   XX..............................
   XX..............................
   XX..............................
   XX............................XX
   XX............................XX
   XX............................XX
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
   return

draw_room_shape_14
   playfield:
   XXXXXXXXXXXX........XXXXXXXXXXXX
   XX............................XX
   XX............................XX
   XX............................XX
   XX............................XX
   XX............................XX
   XX............................XX
   XX............................XX
   XX............................XX
   XX............................XX
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
   return

draw_room_shape_15
   playfield:
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   XX....X.X.X..........X.X.X....XX
   XX....XXXXX..........XXXXX....XX
   XX....XXXXX..XX..XX..XXXXX....XX
   XX....XXXXXXXXXXXXXXXXXXXX....XX
   XX....XXXXXXXXXXXXXXXXXXXX....XX
   XX....XXXXXXXXX..XXXXXXXXX....XX
   XX....XXXXXXXX....XXXXXXXX....XX
   XX............................XX
   XX............................XX
   XXXXXXXXXXXX........XXXXXXXXXXXX
end
   return
