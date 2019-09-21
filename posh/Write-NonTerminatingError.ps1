# cerner_2^5_2019
#
# How to trigger $? being set to false within a function
# yet not force the function to end with a throw statement
# Write-Error will log the error, but not trigger $?, so what
# can we do? $PSCmdlet.WriteError saves the day
#
# Tested in PowerShell 5.1

function Write-ErrorWithoutExecutionStatus {
  [CmdletBinding()]
  param([Parameter(Mandatory = $true, ValueFromPipeline = $true)][int] $value)
  begin { $Error.Clear() }
  process {
    if ($value -eq 3) {
      Write-Error "Cannot process value of $value"
      return
    }
    $value
  }
}

function Write-NonTerminatingError {
  [CmdletBinding()]
  param([Parameter(Mandatory = $true, ValueFromPipeline = $true)][int] $value)
  begin { $Error.Clear() }
  process {
    if ($value -eq 3) {
      $PSCmdlet.WriteError([System.Management.Automation.ErrorRecord]::new(
          "Cannot process value of $value", # error text
          'InvalidValueof3', # error id
          [System.Management.Automation.ErrorCategory]::InvalidData, #error category
          $value))
      return
    }
    $value
  }
}

# Writing to standard error does not trigger the $? automatic
# variablet to be set to false within a pipeline

@(1, 2, 3, 4, 5) | Write-ErrorWithoutExecutionStatus 2>$null
if (-not $?) { $Error | Out-String }

# Throwing a nonterminating error using $PSCmdlet.WriteError
# allows you to create a more detailed ErrorRecord, as well as
# trigger $? being set to false, even if it was just a single
# process block that wrote the error from a set of values 
# in the pipeline.

@(1, 2, 3, 4, 5) | Write-NonTerminatingError 2>$null
if (-not $?) { $Error | Out-String }
