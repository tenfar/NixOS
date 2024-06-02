_: {
  programs.nixvim = {
    plugins = {
      mini = {
        enable = true;

        modules = {
          map = {
            # __raw = lua code
            # __unkeyed.* = no key, just the value
            integrations = {
              "__unkeyed.builtin_search".__raw = # lua
                "require('mini.map').gen_integration.builtin_search()";
              "__unkeyed.gitsigns".__raw = # lua
                "require('mini.map').gen_integration.gitsigns()";
              "__unkeyed.diagnostic".__raw = # lua
                "require('mini.map').gen_integration.diagnostic()";
            };

            window = {
              winblend = 0;
            };
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>um";
        action.__raw = # lua
          "MiniMap.toggle";
        options = {
          desc = "Toggle MiniMap";
          silent = true;
        };
      }
    ];
  };
}
