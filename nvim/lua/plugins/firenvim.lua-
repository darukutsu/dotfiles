vim.cmd([[
  let g:firenvim_config = {
      \ 'globalSettings': {
	  \ 'alt': 'all',
      \  },
      \ 'localSettings': {
	  \ '.*': {
	      \ 'cmdline': 'neovim',
	      \ 'content': 'text',
	      \ 'priority': 0,
	      \ 'selector': 'textarea',
	      \ 'takeover': 'always',
	  \ },
      \ }
  \ }
  let fc = g:firenvim_config['localSettings']
  "let fc['https://discord\.com.+'] = { 'takeover': 'never', 'priority': 1 }
  let fc['https?://.*'] = { 'takeover': 'never'}
]])
