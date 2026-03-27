 Yazi 26.x's opener system (the [open] rules) doesn't trigger at all for 0-byte files — it checks file content/mime type before even evaluating the rules, so empty files silently fall through.

  The fix was to add a keymap that uses shell to invoke nvim directly, bypassing the opener system entirely:

  run = ['shell --block -- [ ! -d "%h" ] && nvim "%h" || true', 'enter']

  - %h — yazi's variable for the hovered file path
  - [ ! -d "%h" ] — if it's not a directory, run nvim
  - 'enter' — second command in the array; enters the directory if it was one (no-op on files)
  - --block — makes yazi hand off the terminal to nvim, same as block = true in openers

  So pressing Enter now calls nvim directly on whatever is hovered, regardless of whether the file is empty, non-empty, or doesn't even exist yet.
