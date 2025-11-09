vim.lsp.config('pyright', {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    before_init = function(_, config)
        -- config.settings.python.pythonPath = "./venv/bin/python"
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
vim.lsp.enable({ 'pyright' })