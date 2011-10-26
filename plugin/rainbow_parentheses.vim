"==============================================================================
"  Description: Rainbow colors for parentheses, based on rainbow_parenthsis.vim
"               by Martin Krischik and others.
"==============================================================================
"  GetLatestVimScripts: 3772 1 :AutoInstall: rainbow_parentheses.zip

com! RainbowParenthesesToggle       cal rainbow_parentheses#toggle()
com! RainbowParenthesesLoadRound    cal rainbow_parentheses#load(0)
com! RainbowParenthesesLoadSquare   cal rainbow_parentheses#load(1)
com! RainbowParenthesesLoadBraces   cal rainbow_parentheses#load(2)
com! RainbowParenthesesLoadChevrons cal rainbow_parentheses#load(3)
