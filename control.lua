


script.on_event("hk-add-msg", function(event)
    local player = game.players[event.player_index]
    game.print("Keyboard shortcut pressed on tick: " ..tostring(event.tick))
    game.print("Cursor place")
  end)