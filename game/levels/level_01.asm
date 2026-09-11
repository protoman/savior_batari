; bB level code - auto-generated from editor
; Level 1: New Level
; DO NOT EDIT MANUALLY - regenerate from .json

; Room 0
LoadRoom0
  pfhline 0 0 12 on
  pfhline 19 0 31 on
  pfhline 0 1 0 on
  pfhline 31 1 31 on
  pfhline 0 2 0 on
  pfhline 31 2 31 on
  pfhline 0 3 0 on
  pfhline 31 3 31 on
  pfhline 0 7 3 on
  pfhline 28 7 31 on
  pfhline 0 8 0 on
  pfhline 10 8 21 on
  pfhline 31 8 31 on
  pfhline 0 9 0 on
  pfhline 31 9 31 on
  pfhline 0 10 0 on
  pfhline 31 10 31 on
  pfhline 0 11 5 on
  pfhline 10 11 21 on
  pfhline 26 11 31 on
  return

; Room 1
LoadRoom1
  pfhline 0 0 5 on
  pfhline 10 0 21 on
  pfhline 26 0 31 on
  pfhline 0 1 0 on
  pfhline 15 1 16 on
  pfhline 31 1 31 on
  pfhline 0 2 0 on
  pfhline 15 2 16 on
  pfhline 31 2 31 on
  pfhline 0 3 0 on
  pfhline 15 3 16 on
  pfhline 31 3 31 on
  pfhline 0 4 0 on
  pfhline 15 4 16 on
  pfhline 31 4 31 on
  pfhline 0 5 0 on
  pfhline 15 5 16 on
  pfhline 31 5 31 on
  pfhline 0 6 0 on
  pfhline 15 6 16 on
  pfhline 31 6 31 on
  pfhline 0 7 0 on
  pfhline 15 7 16 on
  pfhline 31 7 31 on
  pfhline 0 8 0 on
  pfhline 15 8 16 on
  pfhline 31 8 31 on
  pfhline 0 9 0 on
  pfhline 15 9 16 on
  pfhline 31 9 31 on
  pfhline 0 10 0 on
  pfhline 15 10 16 on
  pfhline 31 10 31 on
  pfhline 0 11 31 on
  return

; Room loader dispatcher
; Set variable 'o' to room index before calling
LoadRoom
  pfclear
  if o = 0 then gosub LoadRoom0
  if o = 1 then gosub LoadRoom1
  return

; End of level 1 data
