require('nvim-tree').setup {
  actions = {
    open_file = {
      quit_on_open = true,
      resize_window = false
    }
  },
  respect_buf_cwd = true,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true
  },
  view = {
    adaptive_size = true,
  }
}
