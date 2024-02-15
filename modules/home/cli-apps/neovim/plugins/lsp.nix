{ lib, pkgs, ... }:
let
  inherit (lib) getExe;
in
{
  programs.nixvim = {
    plugins = {
      lsp-format = {
        enable = true;
      };

      lsp = {
        enable = true;

        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "<leader>lp" = "goto_prev";
            "<leader>ln" = "goto_next";
          };

          lspBuf = {
            "<leader>la" = "code_action";
            "<leader>ld" = "definition";
            "<leader>lD" = "references";
            "<leader>lt" = "type_definition";
            "<leader>li" = "implementation";
            "<leader>lh" = "hover";
            "<leader>lr" = "rename";
          };
        };

        servers = {
          bashls = {
            enable = true;
            filetypes = [ "sh" "bash" ];
          };
          ccls = {
            enable = true;
            filetypes = [ "c" "cpp" "objc" "objcpp" ];
          };
          clangd = {
            enable = true;
            filetypes = [ "c" "cpp" "objc" "objcpp" ];
          };
          csharp-ls = {
            enable = true;
            filetypes = [ "cs" ];
          };
          dockerls = {
            enable = true;
            filetypes = [ "dockerfile" ];
          };
          eslint = {
            enable = true;
            filetypes = [ "javascript" "javascriptreact" "typescript" "typescriptreact" ];
          };
          html = {
            enable = true;
            filetypes = [ "html" ];
          };
          java-language-server = {
            enable = true;
            filetypes = [ "java" ];
          };
          jsonls = {
            enable = true;
            filetypes = [ "json" ];
          };
          lua-ls = {
            enable = true;
            filetypes = [ "lua" ];
          };
          nil_ls = {
            enable = true;
            filetypes = [ "nix" ];
            settings.formatting.command = [ "${getExe pkgs.nixpkgs-fmt}" ];
          };
          pyright = {
            enable = true;
            filetypes = [ "python" ];
          };
          rust-analyzer = {
            enable = true;
            filetypes = [ "rust" ];
            installCargo = true;
            installRustc = true;
          };
          tsserver = {
            enable = true;
            filetypes = [ "javascript" "javascriptreact" "typescript" "typescriptreact" ];
          };
          yamlls = {
            enable = true;
            filetypes = [ "yaml" ];
          };
        };
      };
    };
  };
}