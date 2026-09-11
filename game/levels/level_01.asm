; bB level code - auto-generated from editor
; Level 1: New Level
; DO NOT EDIT MANUALLY - regenerate from .json

; Room 0
LoadRoom0
  pfhline 0 0 12 on
  pfhline 19 0 31 on
  pfhline 0 1 3 on
  pfhline 28 1 31 on
  pfhline 0 2 3 on
  pfhline 28 2 31 on
  pfhline 0 3 3 on
  pfhline 28 3 31 on
  pfhline 0 4 1 on
  pfhline 30 4 31 on
  pfhline 0 5 1 on
  pfhline 30 5 31 on
  pfhline 0 6 1 on
  pfhline 30 6 31 on
  pfhline 0 7 1 on
  pfhline 30 7 31 on
  pfhline 0 8 13 on
  pfhline 19 8 31 on
  pfhline 0 9 13 on
  pfhline 19 9 31 on
  pfhline 0 10 13 on
  pfhline 19 10 31 on
  pfhline 0 11 13 on
  pfhline 19 11 31 on
  return

; Room 1
LoadRoom1
  pfhline 0 0 13 on
  pfhline 18 0 31 on
  pfhline 0 1 13 on
  pfhline 18 1 31 on
  pfhline 0 2 13 on
  pfhline 18 2 31 on
  pfhline 0 3 13 on
  pfhline 18 3 31 on
  pfhline 0 4 3 on
  pfhline 28 4 31 on
  pfhline 0 5 3 on
  pfhline 28 5 31 on
  pfhline 0 6 3 on
  pfhline 28 6 31 on
  pfhline 0 7 3 on
  pfhline 28 7 31 on
  pfhline 0 8 31 on
  pfhline 0 9 31 on
  pfhline 0 10 31 on
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
