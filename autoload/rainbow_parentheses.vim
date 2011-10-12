"==============================================================================
"  Description: Rainbow colors for parentheses, based on rainbow_parenthsis.vim
"               by Martin Krischik and others.
"               2011-10-12: Use less code.  Leave room for deeper levels.
"==============================================================================

let s:max = 16

func! rainbow_parentheses#activate()
	hi default level1c   ctermfg=brown        guifg=OrangeRed1
	hi default level2c   ctermfg=Darkblue     guifg=LightGoldenRod1
	hi default level3c   ctermfg=darkgray     guifg=DeepSkyBlue1
	hi default level4c   ctermfg=darkgreen    guifg=HotPink1
	hi default level5c   ctermfg=darkcyan     guifg=chartreuse1
	hi default level6c   ctermfg=darkred      guifg=OrangeRed1
	hi default level7c   ctermfg=darkmagenta  guifg=LightGoldenRod1
	hi default level8c   ctermfg=brown        guifg=DeepSkyBlue1
	hi default level9c   ctermfg=gray         guifg=HotPink1
	hi default level10c  ctermfg=black        guifg=chartreuse1
	hi default level11c  ctermfg=darkmagenta  guifg=OrangeRed1
	hi default level12c  ctermfg=Darkblue     guifg=LightGoldenRod1
	hi default level13c  ctermfg=darkgreen    guifg=DeepSkyBlue1
	hi default level14c  ctermfg=darkcyan     guifg=HotPink1
	hi default level15c  ctermfg=darkred      guifg=chartreuse1
	hi default level16c  ctermfg=red          guifg=Yellow
	let s:active = 1
endfunc

func! rainbow_parentheses#clear()
	for each in range(s:max)
		exe 'hi clear level'.each.'c'
	endfor
	let s:active = 0
endfunc

func! rainbow_parentheses#toggle()
	if !exists('s:active')
		cal rainbow_parentheses#load('(',')')
	endif
	if s:active != 0
		cal rainbow_parentheses#clear()
	else
		cal rainbow_parentheses#activate()
	endif
endfunc

func! s:cluster()
	let levels = ''
	for each in range(1, s:max)
		let levels .= ',level'.each
	endfor
	exe 'syn cluster rainbow_parentheses contains=@TOP'.levels.',NoInParens'
endfunc
cal s:cluster()

func! rainbow_parentheses#load(br1, br2)
	let [level, grp, alllvls] = ['', '', []]
	let [br1, br2] = [escape(a:br1, '['), escape(a:br2, ']')]
	for each in range(1, s:max)
		cal add(alllvls, 'level'.each)
	endfor
	for each in range(1, s:max)
		let cmd = 'syn region %s matchgroup=%s start=/%s/ end=/%s/ contains=TOP,%s,NoInParens'
		exe printf(cmd, 'level'.each, 'level'.each.'c', br1, br2, join(alllvls, ','))
		cal remove(alllvls, 0)
	endfor
	let s:active = 0
endfunc

" vim:ts=2:sw=2:sts=2
