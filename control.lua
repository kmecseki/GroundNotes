
local function open_text_entry_gui(player, position, endpos, surface)
  
  if player.gui.center.message_frame then
    player.gui.center.message_frame.destroy()
  end
  
  local frame = player.gui.center.add {
    type = "frame",
    name = "message_frame",
    caption = "Enter your message",
    direction = "vertical"
  }
  
  frame.add {
    type = "textfield",
    name = "message_textfield",
    text = ""
  }

  frame.add {
    type = "button",
    name = "submit_message_button",
    caption = "Done"
  }

  frame.add {
    type = "label",
    name = "orlabel",
    caption = "or"
  }

  frame.add {
    type = "button",
    name = "remove_messages_button",
    caption = "Remove messages"
  }

  global[player.index] =  { position = position, endpos = endpos, surface = surface}

end


local function message_tool_selected(event)
  -- Change the mouse cursor to show the player they can pick the location
  -- for the message.

  if event.prototype_name and event.prototype_name ~= "hk-add-msg-sc" then
    return
  end

  local player = game.players[event.player_index]
  -- Set the cursor to a custom item
  player.cursor_stack.set_stack({name = "add-message-here"})
  player.clear_gui_arrow()
end


local function get_cursor_position(event)

  local player = game.players[event.player_index]

  if player.cursor_stack and player.cursor_stack.valid_for_read then
    local position = event.area.left_top
    local endpos = event.area.right_bottom
    local surface = event.surface
    player.cursor_stack.clear()
    open_text_entry_gui(player, position, endpos, surface)
  end
end


local function place_note(event)

  local player = game.players[event.player_index]

  if event.element.name == "submit_message_button" then

    local message = player.gui.center.message_frame.message_textfield.text
    -- Get the stored position
    local position = global[player.index].position
    local surface = global[player.index].surface

    if global.messages == nil then global.messages = {} end
      local id = rendering.draw_text({
      text = message,
      surface = surface,
      target = position,
      color = {r=1,g=0,b=0,a=0.9},
      scale = 2,
      alignment = "center",
      vertical_alignment = "top",
      time_to_live = 0
    })

    global.messages[id] = {
      id = id,
      position = position,
      message = message
    }

    player.gui.center.message_frame.destroy()

  elseif event.element.name == "remove_messages_button" then
    -- find all messages that are in the selection and remove them

    for _, messageunit in pairs(global.messages) do

      if messageunit ~= nil then
        local id = messageunit.id
        local position = rendering.get_target(id).position

        if position.x > global[player.index].position.x and position.x < global[player.index].endpos.x and position.y > global[player.index].position.y and position.y < global[player.index].endpos.y then
          rendering.destroy(id)
          global.messages[id] = nil
        end
      end
    end

    player.gui.center.message_frame.destroy()

  end
end


script.on_event("hk-add-msg", message_tool_selected)


local function initialize()

  global.messages = {}
  global.message_number = 0
end

script.on_event(defines.events.on_lua_shortcut, message_tool_selected)

script.on_event(defines.events.on_player_selected_area, get_cursor_position)

script.on_event(defines.events.on_gui_click, place_note)

script.on_init(initialize)



