"ALE {{
let g:ale_typescript_tslint_config_path = ''
let g:ale_typescript_tslint_executable = 'tslint'
let g:ale_completion_tsserver_autoimport = 1
let g:ale_typescript_tslint_use_global = 0
let g:jsx_ext_required = 1

"format code
let g:ale_fixers = {
\   '*': ['prettier','remove_trailing_lines', 'trim_whitespace'],
\   'python': ['autopep8'],
\   'javascript': ['prettier','eslint'],
\   'javascriptreact': ['prettier','eslint'],
\   'typescript': ['prettier','tslint'],
\   'typescriptreact': ['prettier','tslint'],
\   'rust': ['prettier','rustfmt'],
\}
let g:ale_linters = {
      \   'python': ['flake8', 'pylint'],	
      \   'javascript': ['eslint'],	
      \}

let g:ale_completion_enabled = 1

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1


