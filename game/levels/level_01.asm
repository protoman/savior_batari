; bB level code - auto-generated from editor
; Level 1: Level 1
; DO NOT EDIT MANUALLY - regenerate from .json

; Room 0
LoadRoom0
  pfhline 0 0 31 on
  pfhline 0 1 0 on
  pfhline 31 1 31 on
  pfhline 0 2 0 on
  pfhline 31 2 31 on
  pfhline 0 3 0 on
  pfhline 31 3 31 on
  pfhline 0 4 0 on
  pfhline 12 4 12 on
  pfhline 31 4 31 on
  pfhline 0 5 0 on
  pfhline 12 5 12 on
  pfhline 31 5 31 on
  pfhline 0 6 0 on
  pfhline 12 6 12 on
  pfhline 31 6 31 on
  pfhline 0 7 0 on
  pfhline 12 7 12 on
  pfhline 31 7 31 on
  pfhline 0 8 0 on
  pfhline 31 8 31 on
  pfhline 0 9 0 on
  pfhline 31 9 31 on
  pfhline 0 10 0 on
  pfhline 31 10 31 on
  pfhline 0 11 12 on
  pfhline 19 11 31 on
  ; Enemies: count=1
  ; type=0 x=40 y=6
  return

; Room 1
LoadRoom1
  pfhline 0 0 12 on
  pfhline 19 0 31 on
  pfhline 0 1 0 on
  pfhline 31 1 31 on
  pfhline 0 2 0 on
  pfhline 31 2 31 on
  pfhline 0 3 0 on
  pfhline 31 3 31 on
  pfhline 0 4 0 on
  pfhline 31 4 31 on
  pfhline 0 5 0 on
  pfhline 31 5 31 on
  pfhline 0 6 0 on
  pfhline 31 6 31 on
  pfhline 0 7 0 on
  pfhline 20 7 20 on
  pfhline 31 7 31 on
  pfhline 0 8 0 on
  pfhline 20 8 20 on
  pfhline 31 8 31 on
  pfhline 0 9 0 on
  pfhline 20 9 20 on
  pfhline 31 9 31 on
  pfhline 0 10 0 on
  pfhline 20 10 20 on
  pfhline 31 10 31 on
  pfhline 0 11 31 on
  ; Enemies: count=1
  ; type=2 x=32 y=20
  return

; Room loader dispatcher
; Set variable 'o' to room index before calling
LoadRoom
  pfclear
  if o = 0 then gosub LoadRoom0
  if o = 1 then gosub LoadRoom1
  return

; End of level 1 data
