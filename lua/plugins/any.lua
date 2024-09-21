local plugins = {


  -- this opts will extend the default opts 
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {"html", "css", "bash", "go"},
    },
  },

  {
  "mfussenegger/nvim-dap",
  recommended = true,
  desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "leoluz/nvim-dap-go",
    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
  },

  -- stylua: ignore
  keys = {
    { "<Space>de", "", desc = "+debug", mode = {"n", "v"} },
    { "<Space>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<Space>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<Space>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<Space>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<Space>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
    { "<Space>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<Space>dj", function() require("dap").down() end, desc = "Down" },
    { "<Space>dk", function() require("dap").up() end, desc = "Up" },
    { "<Space>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<Space>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<Space>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<Space>dp", function() require("dap").pause() end, desc = "Pause" },
    { "<Space>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<Space>ds", function() require("dap").session() end, desc = "Session" },
    { "<Space>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<Space>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },
  },
  {
    "leoluz/nvim-dap-go",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "mfussenegger/nvim-dap"},
    ft = "go",
    opts = {},
    config = function ()
      require('dap-go').setup {
        dap_configurations = {
        {
          -- Must be "go" or it will be ignored by the plugin
          type = "go",
          name = "Attach remote",
          mode = "remote",
          request = "attach",
        },
      },
      -- delve configurations
      delve = {
        -- the path to the executable dlv which will be used for debugging.
        -- by default, this is the "dlv" executable on your PATH.
        path = "/Users/alancaldelas/go/bin/dlv",
        -- time to wait for delve to initialize the debug session.
        -- default to 20 seconds
        initialize_timeout_sec = 20,
        -- a string that defines the port to start delve debugger.
        -- default to string "${port}" which instructs nvim-dap
        -- to start the process in a random available port.
        -- if you set a port in your debug configuration, its value will be
        -- assigned dynamically.
        port = "${port}",
        -- additional args to pass to dlv
        args = {},
        -- the build flags that are passed to delve.
        -- defaults to empty string, but can be used to provide flags
        -- such as "-tags=unit" to make sure the test suite is
        -- compiled during debugging, for example.
        -- passing build flags using args is ineffective, as those are
        -- ignored by delve in dap mode.
        -- avaliable ui interactive function to prompt for arguments get_arguments
        build_flags = {},
        -- whether the dlv process to be created detached or not. there is
        -- an issue on Windows where this needs to be set to false
        -- otherwise the dlv server creation will fail.
        -- avaliable ui interactive function to prompt for build flags: get_build_flags
        detached = vim.fn.has("win32") == 0,
        -- the current working directory to run dlv from, if other than
        -- the current working directory.
        cwd = nil,
      },
      -- options related to running closest test
      tests = {
      -- enables verbosity when running the test.
      verbose = false,
      },
     }
    end
  },
  { "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    -- stylua: ignore
    keys = {
      { "<Space>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
      { "<Space>dE", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
    },
    opts = {},
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
   },
}

return plugins

