local wk = require("which-key")
local builtin_telescope = require("telescope.builtin")
local hop = require("hop")
local directions = require("hop.hint").HintDirection
wk.add({
  -- Files
  {
    "<leader>f",
    group = "[F]iles",
    {
      mode = "n",
      "<leader>fa",
      builtin_telescope.find_files,
      desc = "[F]iles [A]ll",
    },
    {
      mode = "n",
      "<leader>fg",
      builtin_telescope.git_files,
      desc = "[F]iles [G]it",
    },
    {
      mode = "n",
      "<leader>ft",
      "<CMD>Neotree toggle<CR>",
      desc = "[F]ile [T]ree",
    },
    {
      mode = "n",
      "<leader>fl",
      function()
        require("lint").try_lint()
      end,
      desc = "[F]ile [L]int",
    },
    {
      mode = "n",
      "<leader>ff",
      function()
        require("conform").format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end,
      desc = "[F]ile [F]ormat",
    },
  },

  -- Tabs/Terminal
  {
    "<leader>t",
    group = "[T]abs/[T]erminal",
    {
      {
        mode = "n",
        "<leader>tn",
        "<CMD>tabnew<CR>",
        desc = "[T]abs [N]ew"
      },
      {
        mode = "n",
        "<S-H>",
        "<CMD>tabprevious<CR>",
      },

      {
        mode = "n",
        "<S-L>",
        "<CMD>tabnext<CR>",
      },
      {
        mode = "n",
        "<leader>tc",
        "<CMD>tabclose<CR>",
        desc = "[T]abs [C]lose"
      },
    }
  },

  -- Projects
  {
    "<leader>p",
    group = "[P]rojects",
    {
      {
        mode = "n",
        "<leader>pa",
        ":lua require'telescope'.extensions.project.project{display = 'full'}<CR>",
        desc = "[P]rojects [A]ll",
      },
    },
  },

  -- Directory
  {
    mode = "n",
    "<leader>d",
    -- TODO: Open Oil AND toggle actions.preview
    -- TODO: Shift-Enter opens in new tab
    "<CMD>Oil<CR>",
    desc = "[D]irectory",
  },

  {
    "<leader>r",
    group = "[R]un",
    {
      {
        mode = "n",
        "<leader>rt",
        "<CMD>OverseerToggle[!] right<CR>",
        desc = "[R]un [T]oggle"
      },
      {
        mode = "n",
        "<leader>rc",
        "<CMD>OverseerRun<CR>",
        desc = "[R]un [C]ommand"
      },
      {
        mode = "n",
        "<leader>rn",
        "<CMD>OverseerRunCmd<CR>",
        desc = "[R]un [N]ew Command"
      },
      {
        mode = "n",
        "<leader>rb",
        "<CMD>OverseerBuild<CR>",
        desc = "[R]un [B]uild Command"
      },
      {
        mode = "n",
        "<leader>rs",
        "<CMD>OverseerSaveBundle<CR>",
        desc = "[R]un [S]ave"
      }
    }
  },

  -- Words
  {
    "<leader>w",
    group = "[W]ords",
    {
      mode = "v",
      "<leader>ws",
      builtin_telescope.grep_string,
      desc = "[W]ord [S]earch selected",
    },
    {
      mode = "n",
      "<leader>wl",
      builtin_telescope.grep_string,
      desc = "[W]ord [L]ive search",
    },
},

  -- Hop
  {
    {
      mode = { "n", "v" },
      "f",
      function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR })
      end,
      remap = true,
    },
    {
      mode = { "n", "v" },
      "F",
      function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR })
      end,
      remap = true,
    },
    {
      mode = { "n", "v" },
      "t",
      function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, hint_offset = -1 })
      end,
      remap = true,
    },
    {
      mode = { "n", "v" },
      "T",
      function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, hint_offset = 1 })
      end,
      remap = true,
    },
  },

  -- Git
  {
    "<leader>g",
    group = "[G]it",
    {
      mode = "n",
      "<leader>gs",
      ":Git<CR>",
      desc = "[G]it [S]tatus",
    },
    {
      mode = "n",
      "<leader>gdv",
      ":Gvdiff",
      desc = "[G]it [D]ifference [V]ertical",
    },
    {
      mode = "n",
      "<leader>gl",
      ":Git log<CR>",
      desc = "[G]it [L]og commit history",
    },
    {
      mode = "n",
      "<leader>gb",
      ":Git blame<CR>",
      desc = "[G]it [B]lame",
    },
    {
      mode = "n",
      "<leader>gc",
      ":Git commit<CR>",
      desc = "[G]it [C]ommit",
    },
  },

  -- Undotree
  {
    mode = "n",
    "<leader>u",
    vim.cmd.UndotreeToggle,
    desc = "[U]ndo Tree",
  },

  -- Code
  {
    "<leader>c",
    group = "[C]ode",
    {
      mode = "n",
      "<leader>cc",
      "<CMD>ClaudeCode<CR>",
      desc = "[C]ode [C]laude"
    },
    {
      mode = "n",
      "<leader>cp",
      function()
        require('render-markdown').toggle()
      end,
      desc = "[C]ode [P]review"
    }
  }
})
