; bB level code - auto-generated from editor
; Level 1: New Level
; DO NOT EDIT MANUALLY - regenerate from .json

; Room 0
LoadRoom0
  pfhline 0 0 31 on
  pfhline 0 1 0 on
  pfhline 30 1 31 on
  pfhline 0 2 0 on
  pfhline 30 2 31 on
  pfhline 0 3 3 on
  pfhline 24 3 31 on
  pfhline 0 4 0 on
  pfhline 30 4 31 on
  pfhline 0 5 8 on
  pfhline 27 5 31 on
  pfhline 0 6 0 on
  pfhline 30 6 31 on
  pfhline 0 7 0 on
  pfhline 30 7 31 on
  pfhline 0 8 3 on
  pfhline 22 8 31 on
  pfhline 0 9 0 on
  pfhline 30 9 31 on
  pfhline 0 10 0 on
  pfhline 30 10 31 on
  pfhline 0 11 11 on
  pfhline 19 11 31 on
  return

; Room 1
LoadRoom1
  pfhline 0 0 11 on
  pfhline 19 0 31 on
  pfhline 0 1 0 on
  pfhline 30 1 31 on
  pfhline 0 2 0 on
  pfhline 30 2 31 on
  pfhline 0 3 0 on
  pfhline 30 3 31 on
  pfhline 0 4 0 on
  pfhline 30 4 31 on
  pfhline 0 5 0 on
  pfhline 30 5 31 on
  pfhline 0 6 0 on
  pfhline 30 6 31 on
  pfhline 0 7 0 on
  pfhline 30 7 31 on
  pfhline 0 8 0 on
  pfhline 30 8 31 on
  pfhline 0 9 0 on
  pfhline 30 9 31 on
  pfhline 0 10 0 on
  pfhline 30 10 31 on
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
