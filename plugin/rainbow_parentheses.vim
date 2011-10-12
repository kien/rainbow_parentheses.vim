"==============================================================================
"  Description: Rainbow colors for parentheses, based on rainbow_parenthsis.vim
"               by Martin Krischik and others.
"               2011-10-12: Use less code.  Leave room for deeper levels.
"==============================================================================

com! RainbowParenthesesToggle       cal rainbow_parentheses#toggle()
com! RainbowParenthesesLoadSquare   cal rainbow_parentheses#load('[',']')
com! RainbowParenthesesLoadRound    cal rainbow_parentheses#load('(',')')
com! RainbowParenthesesLoadBraces   cal rainbow_parentheses#load('{','}')
com! RainbowParenthesesLoadChevrons cal rainbow_parentheses#load('<','>')
