"==============================================================================
"  Description: Rainbow colors for parentheses, based on rainbow_parenthsis.vim
"               by Martin Krischik and others.
"               2011-10-12: Use less code.  Leave room for deeper levels.
"==============================================================================

let s:pairs = [
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
let s:pairs = exists('g:rbpt_colorpairs') ? g:rbpt_colorpairs : s:pairs
let s:max = exists('g:rbpt_max') ? g:rbpt_max : max([len(s:pairs), 16])
let s:loadtgl = exists('g:rbpt_loadcmd_toggle') ? g:rbpt_loadcmd_toggle : 0
let s:types = [['(',')'],['\[','\]'],['{','}'],['<','>']]

func! s:extend()
	if s:max > len(s:pairs)
		cal extend(s:pairs, s:pairs)
		cal s:extend()
	elseif s:max < len(s:pairs)
		cal remove(s:pairs, s:max, -1)
	endif
endfunc
cal s:extend()

func! rainbow_parentheses#activate()
	let [id, s:active] = [1, 1]
	for [ctermfg, guifg] in s:pairs
		exe 'hi default level'.id.'c ctermfg='.ctermfg.' guifg='.guifg
		let id += 1
	endfor
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
	let afunc = exists('s:active') && s:active ? 'clear' : 'activate'
	cal call('rainbow_parentheses#'.afunc, [])
endfunc

func! rainbow_parentheses#toggleall()
	if !exists('s:active')
		cal rainbow_parentheses#load(0)
		cal rainbow_parentheses#load(1)
		cal rainbow_parentheses#load(2)
	endif
	if exists('s:active') && s:active
		cal rainbow_parentheses#clear()
	else
		cal rainbow_parentheses#activate()
	endif
endfunc

func! s:cluster()
	let levels = join(map(range(1, s:max), '"level".v:val'), ',')
	exe 'sy cluster rainbow_parentheses contains=@TOP'.levels.',NoInParens'
endfunc
cal s:cluster()

func! rainbow_parentheses#load(...)
	let [level, grp, type] = ['', '', s:types[a:1]]
	let alllvls = map(range(1, s:max), '"level".v:val')
	if !exists('b:loaded')
		let b:loaded = [0,0,0,0]
	endif
	let b:loaded[a:1] = s:loadtgl && b:loaded[a:1] ? 0 : 1
	for each in range(1, s:max)
		let region = 'level'. each .(b:loaded[a:1] ? '' : 'none')
		let grp = b:loaded[a:1] ? 'level'.each.'c' : 'Normal'
		let cmd = 'sy region %s matchgroup=%s start=/%s/ end=/%s/ contains=TOP,%s,NoInParens'
		exe printf(cmd, region, grp, type[0], type[1], join(alllvls, ','))
		cal remove(alllvls, 0)
	endfor
endfunc

" vim:ts=2:sw=2:sts=2
