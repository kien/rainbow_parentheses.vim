"==============================================================================
"  Description: Rainbow colors for parentheses, based on rainbow_parenthsis.vim
"               by Martin Krischik and others.
"               2011-10-12: Use less code.  Leave room for deeper levels.
"==============================================================================

if !exists('g:rbpt_colorpairs')
	let s:colorpairs = [
				\ ['brown',       'OrangeRed1'],
				\ ['Darkblue',    'LightGoldenRod1'],
				\ ['darkgray',    'DeepSkyBlue1'],
				\ ['darkgreen',   'HotPink1'],
				\ ['darkcyan',    'chartreuse1'],
				\ ['darkred',     'OrangeRed1'],
				\ ['darkmagenta', 'LightGoldenRod1'],
				\ ['brown',       'DeepSkyBlue1'],
				\ ['gray',        'HotPink1'],
				\ ['black',       'chartreuse1'],
				\ ['darkmagenta', 'OrangeRed1'],
				\ ['Darkblue',    'LightGoldenRod1'],
				\ ['darkgreen',   'DeepSkyBlue1'],
				\ ['darkcyan',    'HotPink1'],
				\ ['darkred',     'chartreuse1'],
				\ ['red',         'Yellow'],
				\ ]
else
	let s:colorpairs = g:rbpt_colorpairs
	unl g:rbpt_colorpairs
endif

let s:max = len(s:colorpairs)

func! rainbow_parentheses#activate()
	let id = 1
	for [ctermbg, guibg] in s:colorpairs
		exe printf('hi default level%dc ctermfg=%s guifg=%s', id, ctermbg, guibg)
		let id += 1
	endfor
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
