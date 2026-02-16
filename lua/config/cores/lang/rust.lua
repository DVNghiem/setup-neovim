local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()

vim.lsp.config('rust_analyzer', {
	capabilities = capabilities,
	cmd = {
		"rust-analyzer",
	},
	-- Set memory limit via environment
	cmd_env = {
		["RA_LRU_CAP"] = "64",  -- Limit LRU cache entries to reduce RAM
	},
	settings = {
		["rust-analyzer"] = {
			-- Only check on save, not while typing (saves CPU)
			checkOnSave = true,
			
			-- Use clippy but don't check dependencies
			check = {
				command = "clippy",
				extraArgs = { "--no-deps" }, -- Don't check dependencies to save resources
			},
			
			-- Diagnostics settings
			diagnostics = {
				enable = true,
				disabled = { "unresolved-proc-macro" }, -- Disable heavy diagnostics
				experimental = {
					enable = false, -- Disable experimental features
				},
			},
			
			-- Import settings
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			
			-- Cargo optimization
			cargo = {
				buildScripts = {
					enable = true,
				},
				allTargets = false, -- Only check the current target (saves RAM)
				features = "all", -- Use all features
				loadOutDirsFromCheck = true,
			},
			
			-- Proc macro settings
			procMacro = {
				enable = true,
				attributes = {
					enable = true,
				},
			},
			
			-- Cache priming (reduces repeated work)
			cachePriming = {
				enable = true,
				numThreads = 1, -- Limit to 1 thread to minimize CPU/RAM spikes
			},
			
			-- Disable heavy features
			lens = {
				enable = false, -- Disable code lens (saves CPU)
				run = { enable = false },
				debug = { enable = false },
				implementations = { enable = false },
				references = {
					adt = { enable = false },
					enumVariant = { enable = false },
					method = { enable = false },
					trait = { enable = false },
				},
			},
			
			-- Hover actions
			hover = {
				actions = {
					enable = true,
					references = { enable = false }, -- Disable to save resources
				},
				documentation = {
					enable = true,
				},
			},
			
			-- Inlay hints - disable or limit to reduce rendering overhead
			inlayHints = {
				enable = false, -- Disable inlay hints to save CPU/RAM
				-- If you want hints, uncomment below and set enable = true above
				-- bindingModeHints = { enable = false },
				-- chainingHints = { enable = false },
				-- closingBraceHints = { enable = false, minLines = 25 },
				-- closureReturnTypeHints = { enable = "never" },
				-- lifetimeElisionHints = { enable = "never" },
				-- parameterHints = { enable = false },
				-- typeHints = { enable = false },
			},
			
			-- Completion settings
			completion = {
				callable = {
					snippets = "add_parentheses",
				},
				autoimport = {
					enable = true,
				},
				postfix = {
					enable = false, -- Disable postfix completions to save resources
				},
			},
			
			-- Workspace symbol search limit
			workspace = {
				symbol = {
					search = {
						kind = "only_types",
						limit = 64, -- Reduced from 128 to save RAM
					},
				},
			},
			
			-- Files to exclude from analysis (reduces RAM usage)
			files = {
				excludeDirs = { 
					".git",
					"target",
					"node_modules",
					".direnv",
					".venv",
				},
			},
		},
	},
})
vim.lsp.enable({ 'rust_analyzer' })