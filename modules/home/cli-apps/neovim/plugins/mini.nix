_: {
  programs.nixvim = {
    plugins.mini = {
      enable = true;

      modules = {
        basics = { };
        bracketed = { };
        bufremove = { };
        indentscope = { };
        map = {
          # __raw = lua code
          # __unkeyed.* = no key, just the value
          integrations = {
            "__unkeyed.builtin_search".__raw = "require('mini.map').gen_integration.builtin_search()";
            "__unkeyed.gitsigns".__raw = "require('mini.map').gen_integration.gitsigns()";
            "__unkeyed.diagnostic".__raw = "require('mini.map').gen_integration.diagnostic()";
          };

          window = {
            winblend = 0;
          };
        };
        surround = { };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>um";
        lua = true;
        action = "MiniMap.toggle";
        options = {
          desc = "Toggle MiniMap";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>c";
        lua = true;
        action = ''require("mini.bufremove").delete'';
        options = {
          desc = "Close buffer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-w>";
        lua = true;
        action = ''require("mini.bufremove").delete'';
        options = {
          desc = "Close buffer";
          silent = true;
        };
      }
    ];
  };
}
