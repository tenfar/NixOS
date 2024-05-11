{ config, lib, ... }:
let
  inherit (lib) mkIf;
in
{
  programs.nixvim = {
    plugins = {
      noice = {
        enable = true;

        cmdline = {
          format =
            let
              no_top_text = {
                opts = {
                  border = {
                    text = {
                      top = "";
                    };
                  };
                };
              };
            in
            {
              cmdline = no_top_text;
              filter = no_top_text;
              lua = no_top_text;
              search_down = no_top_text;
              search_up = no_top_text;
            };
        };

        messages = {
          view = "mini";
          viewError = "mini";
          viewWarn = "mini";
        };

        lsp = {
          override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
            "cmp.entry.get_documentation" = true;
          };

          progress.enabled = true;
          signature.enabled = true;
        };

        popupmenu.backend = "cmp";

        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
          inc_rename = true;
          lsp_doc_border = false;
        };

        routes = [
          {
            filter = {
              event = "msg_show";
              kind = "search_count";
            };
            opts = {
              skip = true;
            };
          }
          {
            # skip progress messages from noisy servers
            filter = {
              event = "lsp";
              kind = "progress";
              cond.__raw = # lua
                ''
                  function(message)
                    local client = vim.tbl_get(message.opts, 'progress', 'client')
                    local servers = { 'jdtls' }

                    for index, value in ipairs(servers) do
                        if value == client then
                            return true
                        end
                    end
                  end
                '';
            };
            opts = {
              skip = true;
            };
          }
        ];

        views = {
          cmdline_popup = {
            border = {
              style = "single";
            };
          };

          confirm = {
            border = {
              style = "single";
              text = {
                top = "";
              };
            };
          };
        };
      };

      notify = {
        enable = true;
      };
    };

    keymaps = mkIf config.programs.nixvim.plugins.telescope.enable [
      {
        mode = "n";
        key = "<leader>fn";
        action = ":Telescope noice<CR>";
        options = {
          desc = "Find notifications";
          silent = true;
        };
      }
    ];
  };
}