# cerner_2^5_2019
#
# Basic advanced function that illustrates 
# how the different script blocks of a PowerShell 
# function act within a pipeline

function Run-BasicPipeline {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [int] $value
  )

  begin {
    Write-Verbose "The begin scriptblock is ran once when a function is called."
    Write-Verbose "Use this scriptblock to setup resources that will be reused by the main pipeline logic."
  }

  process {
    # Square the integer value provided and pass it off to the next stage in the pipeline if it exists
    $value * $value
  }

  end {
    Write-Verbose "The end scriptblock is ran once, at the end of the pipeline."
    Write-Verbose "Once all inputs from the pipeline have been processed, you can perform clean here." 
  }
}

@(1, 2, 3, 4, 5) | Run-BasicPipeline -Verbose`