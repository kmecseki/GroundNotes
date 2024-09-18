local default_gui = data.raw['gui-style'].default

default_gui["button_default"] = {
    type = "button_style",
    align = "center",
    vertical_align = "center",
    font="default-small",
    top_padding = 0,
    bottom_padding = 0,
    left_padding = 0,
    right_padding = 0,
    height = 20,
    width = 30
}

data:extend({
    {
        type = "custom-input",
        name = "hk-add-msg",
        key_sequence = "ALT + m",
        order = 'a-a',
    },
    {
        type = "shortcut",
        name = "addmsg",
        order = "a[add]-m[msg]",
        action = "lua",
        associated_control_input = "hk-add-msg",
        localised_name = {"shortcuts.add-msg"},
        toggleable = false,
        icon = {
            filename = "__GroundNotes__/graphics/buttonmsg.png",
            priority = "extra-high-no-scale",
            size = 128,
            scale = 1,
            flags = {"gui-icon"}
        },
        disabled_icon = {
            filename = "__GroundNotes__/graphics/buttonmsg.png",
            priority = "extra-high-no-scale",
            size = 128,
            scale = 1,
            flags = {"gui-icon"}
        },
        small_icon = {
            filename = "__GroundNotes__/graphics/buttonmsg64.png",
            priority = "extra-high-no-scale",
            size = 64,
            scale = 1,
            flags = {"gui-icon"}
        },
        disabled_small_icon = {
            filename = "__GroundNotes__/graphics/buttonmsg64.png",
            priority = "extra-high-no-scale",
            size = 64,
            scale = 1,
            flags = {"gui-icon"}
        },
    }
})