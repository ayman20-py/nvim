return {
  -- Colorscheme
  {"catppuccin/nvim", name = "catppuccin", priority = 1000},

  -- Utilities
  {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  {
    'ThePrimeagen/harpoon'
  },


  -- Treesitter 
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}, 

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  }, 

  -- Lualine
  { "nvim-lualine/lualine.nvim", 
    config = function()
      require("lualine").setup({
        options = {
          theme = 'dracula'
        }
      })
    end
  },

  -- Lsp
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function() 
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" }
      })
    end
  },

}
