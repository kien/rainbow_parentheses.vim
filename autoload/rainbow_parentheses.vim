"==============================================================================
"  Description: Rainbow colors for parentheses, based on rainbow_parenthsis.vim
"               by Martin Krischik and others.
"               2011-10-12: Use less code.  Leave room for deeper levels.
"==============================================================================

if !exists('g:rbpt_colorpairs')
	let s:colorpairs = [
				\ ['brown',       'RoyalBlue3'],
				\ ['Darkblue',    'SeaGreen3'],
				\ ['darkgray',    'DarkOrchid3'],
				\ ['darkgreen',   'firebrick3'],
				\ ['darkcyan',    'RoyalBlue3'],
				\ ['darkred',     'SeaGreen3'],
				\ ['darkmagenta', 'DarkOrchid3'],
				\ ['brown',       'firebrick3'],
				\ ['gray',        'RoyalBlue3'],
				\ ['black',       'SeaGreen3'],
				\ ['darkmagenta', 'DarkOrchid3'],
				\ ['Darkblue',    'firebrick3'],
				\ ['darkgreen',   'RoyalBlue3'],
				\ ['darkcyan',    'SeaGreen3'],
				\ ['darkred',     'DarkOrchid3'],
				\ ['red',         'firebrick3'],
				\ ]
else
	let s:colorpairs = g:rbpt_colorpairs
	unl g:rbpt_colorpairs
endif

if !exists('g:rbpt_max')
	let s:max = len(s:colorpairs)
else
	let s:max = g:rbpt_max
	unl g:rbpt_max
endif

func! s:extend()
	if s:max > len(s:colorpairs)
		cal extend(s:colorpairs, s:colorpairs)
		cal s:extend()
	elseif s:max < len(s:colorpairs)
		cal remove(s:colorpairs, s:max, -1)
	endif
endfunc
cal s:extend()

func! rainbow_parentheses#activate()
	let id = 1
	for [ctermfg, guifg] in s:colorpairs
		exe 'hi default level'.id.'c ctermfg='.ctermfg.' guifg='.guifg
		let id += 1
	endfor
	let s:active = 1
endfunc

func! rainbow_parentheses#clear()
	for each in range(1, s:max)
		exe 'hi clear level'.each.'c'
	endfor
	let s:active = 0
endfunc

func! rainbow_parentheses#toggle()
	if !exists('s:active')
		cal rainbow_parentheses#load(0)
	endif
	if exists('s:active') && s:active
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

let s:types = [['(',')'],['\[','\]'],['{','}'],['<','>']]

func! rainbow_parentheses#load(...)
	let [level, grp, alllvls, type] = ['', '', [], s:types[a:1]]
	for each in range(1, s:max)
		cal add(alllvls, 'level'.each)
	endfor
	if !exists('b:loaded')
		let b:loaded = [0,0,0,0]
	endif
	let b:loaded[a:1] = b:loaded[a:1] ? 0 : 1
	for each in range(1, s:max)
		let region = b:loaded[a:1] ? 'level'.each : 'level'.each.'none'
		let grp = b:loaded[a:1] ? 'level'.each.'c' : 'Normal'
		let cmd = 'syn region %s matchgroup=%s start=/%s/ end=/%s/ contains=TOP,%s,NoInParens'
		exe printf(cmd, region, grp, type[0], type[1], join(alllvls, ','))
		cal remove(alllvls, 0)
	endfor
endfunc

" vim:ts=2:sw=2:sts=2
