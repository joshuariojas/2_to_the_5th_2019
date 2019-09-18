# cerner_2^5_2019
#
# Basic advanced function that illustrates how the 
# continue keyword can be used to control early termination
# within an advanced function.
# 
# If the continue keyword is ran in any scriptblock in an advanced 
# function, the function will cease running, and the next part of the
# pipeline will start working on its available input.
#
# Tested in PowerShell 5.1

function Run-PipelineWithContinue {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [int] $value,
    [Switch] $DoBegin,
    [Switch] $DoEnd
  )

  begin {
    if (-not $DoBegin) { continue }
    Write-Verbose "Begin"
  }

  process {
    # Square the integer value provided and pass it off to the next stage in the pipeline
    $value * $value
  }

  end {
    if (-not $DoEnd) { continue }
    Write-Verbose "End"
  }
}

@(1, 2, 3, 4, 5) | Run-PipelineWithContinue -Verbose 
@(1, 2, 3, 4, 5) | Run-PipelineWithContinue -DoBegin -Verbose
@(1, 2, 3, 4, 5) | Run-PipelineWithContinue -DoBegin -DoEnd -Verbose
@(1, 2, 3, 4, 5) | Run-PipelineWithContinue -Verbose | % { $_ + 1 }
@(1, 2, 3, 4, 5) | Run-PipelineWithContinue -DoBegin -Verbose | % { $_ + 1 }