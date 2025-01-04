const gruvbox_fg = "#ebdbb2"
const gruvbox_green = "#b8bb26"
const gruvbox_blue = "#83a598"
const gruvbox_yellow = "#fabd2f"
const gruvbox_purple = "#d3869b"
const gruvbox_gray = "#928374"
const gruvbox_bg = "#28282800"
const gruvbox_red = "#fb4934"
const gruvbox_aqua = "#8ec07c"
const gruvbox_orange = "#fe8019"

const gruvbox_green_bold = { fg: $gruvbox_green bg: $gruvbox_bg attr: b }
const gruvbox_purple_bold = { fg: $gruvbox_purple bg: $gruvbox_bg attr: b }
const gruvbox_red_bold = { fg: $gruvbox_red bg: $gruvbox_bg attr: b }
const gruvbox_yellow_bold = { fg: $gruvbox_yellow bg: $gruvbox_bg attr: b }
const gruvbox_aqua_bold = { fg: $gruvbox_aqua bg: $gruvbox_bg attr: b }
const gruvbox_blue_bold = { fg: $gruvbox_blue bg: $gruvbox_bg attr: b }
const gruvbox_gray_bold = { fg: $gruvbox_gray bg: $gruvbox_bg attr: b }

export const gruvbox_theme = {
    separator: $gruvbox_fg
    leading_trailing_space_bg: { attr: n }
    header: $gruvbox_gray_bold
    empty: $gruvbox_blue
    bool: $gruvbox_fg
    int: $gruvbox_fg
    filesize: $gruvbox_fg
    duration: $gruvbox_fg
    date: $gruvbox_fg
    range: $gruvbox_fg
    float: $gruvbox_fg
    string: $gruvbox_fg
    nothing: $gruvbox_fg
    binary: $gruvbox_fg
    cellpath: $gruvbox_fg
    row_index: $gruvbox_gray
    record: $gruvbox_fg
    list: $gruvbox_fg
    block: $gruvbox_fg
    hints: $gruvbox_gray

    shape_garbage: $gruvbox_red_bold
    shape_binary: $gruvbox_purple_bold
    shape_bool: $gruvbox_aqua
    shape_int: $gruvbox_purple_bold
    shape_float: $gruvbox_purple_bold
    shape_range: $gruvbox_yellow_bold
    shape_internalcall: $gruvbox_aqua_bold
    shape_external: $gruvbox_aqua
    shape_externalarg: $gruvbox_green_bold
    shape_literal: $gruvbox_aqua
    shape_operator: $gruvbox_yellow
    shape_signature: $gruvbox_green_bold
    shape_string: $gruvbox_green
    shape_string_interpolation: $gruvbox_aqua_bold
    shape_datetime: $gruvbox_aqua_bold
    shape_list: $gruvbox_aqua_bold
    shape_table: $gruvbox_blue_bold
    shape_record: $gruvbox_aqua_bold
    shape_block: $gruvbox_blue_bold
    shape_filepath: $gruvbox_blue
    shape_globpattern: $gruvbox_aqua_bold
    shape_variable: $gruvbox_purple
    shape_flag: $gruvbox_blue_bold
    shape_custom: $gruvbox_green
    shape_nothing: $gruvbox_aqua
  }
