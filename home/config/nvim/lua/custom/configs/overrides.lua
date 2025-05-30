local M = {}

M.treesitter = {
    ensure_installed = {
        "vim",
        "vimdoc",
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "c",
        "markdown",
        "markdown_inline",
        "rust",
        "python",
        "toml",
        "json",
        "yaml",
        "bash",
        "nix",
        "sql",
    },
    indent = {
        enable = true,
        disable = {
            "yaml",
        },
    },
}

M.mason = {
    ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",

        -- web dev stuff
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "deno",
        "prettier",

        -- c/cpp stuff
        "clangd",
        "clang-format",

        -- Python stuff
        "pyright",
        "black",
        "ruff",
        "mypy",
        "debugpy",

        -- Rust stuff
        "rust-analyzer",

        -- Go stuff
        "gopls",

        -- Docker
        "docker-compose-language-service",
        "dockerfile-language-server",

        -- PHP
        "phpactor",

        -- Markup
        "taplo",
        "yamlls",
    },
}

-- git support in nvimtree
M.nvimtree = {
    git = {
        enable = true,
    },

    renderer = {
        highlight_git = true,
        icons = {
            show = {
                git = true,
            },
        },
        root_folder_label = false,
    },
    view = {
        hide_root_folder = nil,
    },
}

return M
