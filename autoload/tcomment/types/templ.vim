if &rtp =~ 'tcomment'
  call tcomment#type#Define('templ',        '// %s')
  call tcomment#type#Define('templ_block',  g:tcomment#block_fmt_c)
  call tcomment#type#Define('templ_inline', g:tcomment#inline_fmt_c)
  let g:tcomment#filetype#guess_templ=1
endif
