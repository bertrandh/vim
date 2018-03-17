function! s:GetSID(func_name)
  redir => s:funs | silent! function | redir END
  let s:funs = split(s:funs, "\n")
  let s:idx =  match(s:funs, a:func_name)
  let s:sid_func = s:funs[s:idx]
  let s:func_sid = substitute(s:sid_func, '.*<SNR>\([0-9]\+\)_.*', '\1', '')
  return s:func_sid
endfunction

function! s:SidFuncName(func_name)
  return '<SNR>'.<SID>GetSID(a:func_name).'_'.a:func_name
endfunction

exe "noremap <SID>Operator :<c-u>call ".<SID>SidFuncName('SlimeStoreCurPos')."()<cr>:set opfunc=".<SID>SidFuncName('SlimeSendOp')."<cr>g@"

vnoremap ic :<c-u>execute "normal! ?^```{\rjV/^```\rk"<cr>
onoremap ic :normal Vic<cr>
nmap <unique> <silent> <Plug>SlimeChunkSend <SID>Operatoric

if !hasmapto('<Plug>SlimeChunkSend', 'n')
  nmap <c-k><c-k> <Plug>SlimeChunkSend
endif

