"==============================================================================
"  Description: Rainbow colors for parentheses, based on rainbow_parenthsis.vim
"               by Martin Krischik and others.
"==============================================================================
"  GetLatestVimScripts: 3772 1 :AutoInstall: rainbow_parentheses.zip

com! RainbowParenthesesToggle       cal rainbow_parentheses#toggle()
com! RainbowParenthesesLoadSquare   cal rainbow_parentheses#load('[',']')
com! RainbowParenthesesLoadRound    cal rainbow_parentheses#load('(',')')
com! RainbowParenthesesLoadBraces   cal rainbow_parentheses#load('{','}')
com! RainbowParenthesesLoadChevrons cal rainbow_parentheses#load('<','>')
