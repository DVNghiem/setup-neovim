local lspconfig = require('lspconfig')
lspconfig.pyright.setup({
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    before_init = function(_, config)
        config.settings.python.pythonPath = "./venv/bin/python"
    end,
    settings={
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly",
            useLibraryCodeForTypes = true
          }
        }
      }
})
