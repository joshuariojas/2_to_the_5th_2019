# cerner_2^5_2019
# Conditional assignment and result from script block
#
# Tested in PowerShell 5.1

# Conditional assignment 

$condition = $true
$value = if ($condition) { 'value1' } else { 'value2' }
$value

# Using a conditionally selected result inline

$coolBrowser = $true
Get-Process -Name $( if ($coolBrowser) { 'vivaldi' } else { 'chrome' } )
