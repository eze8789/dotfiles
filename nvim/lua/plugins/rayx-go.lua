return {
  "ray-x/go.nvim",
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("go").setup({

      disable_defaults = false, -- true|false when true set false to all boolean settings and replace all table
      -- settings with {}
      go = "go", -- go command, can be go[default] or go1.18beta1
      goimports = "gopls", -- goimports command, can be gopls[default] or either goimports or golines if need to split long lines
      gofmt = "gopls", -- gofmt through gopls: alternative is gofumpt, goimports, golines, gofmt, etc
      fillstruct = "gopls", -- set to fillstruct if gopls fails to fill struct
      max_line_len = 0, -- max line length in golines format, Target maximum line length for golines
      tag_transform = false, -- can be transform option("snakecase", "camelcase", etc) check gomodifytags for details and more options
      tag_options = "json=omitempty", -- sets options sent to gomodifytags, i.e., json=omitempty
      gotests_template = "", -- sets gotests -template parameter (check gotests for details)
      gotests_template_dir = "", -- sets gotests -template_dir parameter (check gotests for details)
      comment_placeholder = "", -- comment_placeholder your cool placeholder e.g. 󰟓       
      icons = { breakpoint = "🧘", currentpos = "🏃" }, -- setup to `false` to disable icons setup
      verbose = false, -- output loginf in messages
      lsp_cfg = false, -- true: use non-default gopls setup specified in go/lsp.lua
      -- false: do nothing
      -- if lsp_cfg is a table, merge table with with non-default gopls setup in go/lsp.lua, e.g.
      --   lsp_cfg = {settings={gopls={matcher='CaseInsensitive', ['local'] = 'your_local_module_path', gofumpt = true }}}
      lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
      -- false: do not set default gofmt in gopls format to gofumpt
      lsp_on_attach = nil, -- nil: use on_attach function defined in go/lsp.lua,
      --      when lsp_cfg is true
      -- if lsp_on_attach is a function: use this function as on_attach function for gopls
      lsp_keymaps = true, -- set to false to disable gopls/lsp keymap
      lsp_codelens = true, -- set to false to disable codelens, true by default, you can use a function
      -- function(bufnr)
      --    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>F", "<cmd>lua vim.lsp.buf.formatting()<CR>", {noremap=true, silent=true})
      -- end
      -- to setup a table of codelens
      diagnostic = { -- set diagnostic to false to disable vim.diagnostic setup
        hdlr = false, -- hook lsp diag handler and send diag to quickfix
        underline = true,
        -- virtual text setup
        virtual_text = { spacing = 0, prefix = "■" },
        signs = true,
        update_in_insert = false,
      },
      -- if you need to setup your ui for input and select, you can do it here
      -- go_input = require('guihua.input').input -- set to vim.ui.input to disable guihua input
      -- go_select = require('guihua.select').select -- vim.ui.select to disable guihua select
      lsp_document_formatting = true,
      -- set to true: use gopls to format
      -- false if you want to use other formatter tool(e.g. efm, nulls)
      lsp_inlay_hints = {
        enable = true,
        -- hint style, set to 'eol' for end-of-line hints, 'inlay' for inline hints
        -- inlay only avalible for 0.10.x
        style = "inlay",
        -- Note: following setup only works for style = 'eol', you do not need to set it for 'inlay'
        -- Only show inlay hints for the current line
        only_current_line = false,
        -- Event which triggers a refersh of the inlay hints.
        -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
        -- not that this may cause higher CPU usage.
        -- This option is only respected when only_current_line and
        -- autoSetHints both are true.
        only_current_line_autocmd = "CursorHold",
        -- whether to show variable name before type hints with the inlay hints or not
        -- default: false
        show_variable_name = true,
        -- prefix for parameter hints
        parameter_hints_prefix = "󰊕 ",
        show_parameter_hints = true,
        -- prefix for all the other hints (type, chaining)
        other_hints_prefix = "=> ",
        -- whether to align to the lenght of the longest line in the file
        max_len_align = false,
        -- padding from the left if max_len_align is true
        max_len_align_padding = 1,
        -- whether to align to the extreme right or not
        right_align = false,
        -- padding from the right if right_align is true
        right_align_padding = 6,
        -- The color of the hints
        highlight = "Comment",
      },
      gopls_cmd = nil, -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile","/var/log/gopls.log" }
      gopls_remote_auto = true, -- add -remote=auto to gopls
      gocoverage_sign = "█",
      sign_priority = 5, -- change to a higher number to override other signs
      dap_debug = true, -- set to false to disable dap
      dap_debug_keymap = true, -- true: use keymap for debugger defined in go/dap.lua
      -- false: do not use keymap in go/dap.lua.  you must define your own.
      -- Windows: Use Visual Studio keymap
      dap_debug_gui = {}, -- bool|table put your dap-ui setup here set to false to disable
      dap_debug_vt = { enabled_commands = true, all_frames = true }, -- bool|table put your dap-virtual-text setup here set to false to disable

      dap_port = 38697, -- can be set to a number, if set to -1 go.nvim will pick up a random port
      dap_timeout = 15, --  see dap option initialize_timeout_sec = 15,
      dap_retries = 20, -- see dap option max_retries
      build_tags = "tag1,tag2", -- set default build tags
      textobjects = true, -- enable default text objects through treesittter-text-objects
      test_runner = "go", -- one of {`go`,  `dlv`, `ginkgo`, `gotestsum`}
      verbose_tests = true, -- set to add verbose flag to tests deprecated, see '-v' option
      iferr_vertical_shift = 4, -- defines where the cursor will end up vertically from the begining of if err statement
    })
  end,
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
