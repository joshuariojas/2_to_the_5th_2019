# cerner_2^5_2019
#
# The automatic variable $? demonstrates its usefulness when coupled with 
# cmdlets the throw non-termination errors. For instance, if you pipe (or send
# via parameter) an array of paths to Get-ChildItem and store the results, testing
# that the variable exists would not be suffice. You could check the count, or more 
# simply test $? to see if any errors were triggered.
#
# Test how $? interacts with some of the cmdlets you use in your scripts, and
# try to identify opportunties to simply/improve error handling that doesn't just
# wrap everything in a try/catch and hope for the best.
#
# Tested in PowerShell 5.1

$directories = @('C:\Users\', 'C:\Not\A\Directory') | Get-ChildItem -Directory

# We must use $? immediately after this statement. If we first test $directories,
# successfully using that variable will update $? to $true. Even printing the contents
# of $? successfully will change the value of $? to $true.

$?

if ($directories) {
  "Hey there were some results"
} else {
  "Hey you lied to me."
}

# Be aware, $? only has predictable results if the cmdlet raises a non-terminating error.
# Test-Path simply returns a boolean value if a path is missing, which implies Test-Path
# succeeded.  

if ( Test-Path -Path @('C:\Users\', 'C:\Not\A\Directory') ) {
  $?
  "Okay."
} else {
  $?
  "Nokay"
}
