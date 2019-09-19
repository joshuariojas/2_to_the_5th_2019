# cerner_2^5_2019
#
# Basic advanced function that illustrates how the 
# continue keyword can be used to control early termination
# within an advanced function.
# 
# If the continue keyword is ran in any scriptblock in an advanced 
# function, only that scriptblock will cease running, and the next scriptblock
# will proceed. Notice how this can be used to conditionally skip returning
# output within the process block.
#
# Tested in PowerShell 5.1

function Run-PipelineWithReturn {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [int] $value,
    [Switch] $DoBegin,
    [Switch] $ReturnProcess,
    [Switch] $DoEnd
  )

  begin {
    if (-not $DoBegin) { return }
    Write-Verbose "Begin"
  }

  process {
    # Do to how PowerShell functions return everything that has been written to standard output
    # be sure that you control what information gets written to standard out. If you need to 
    # write output to the user, consider using Write-Verbose, or the new(er) output stream 
    # Write-Information. Using Write-Output, invoking variables, and not assigning
    # the result of expression to a variable, will all build up the output to standard output,
    # which will get send further down the pipeline.
    
    if ($ReturnProcess -and $value -eq 3) { return }
    
    # Square the integer value provided and pass it off to the next stage in the pipeline
    $value * $value
  }

  end {
    if (-not $DoEnd) { return }
    Write-Verbose "End"
  }
}

@(1, 2, 3, 4, 5) | Run-PipelineWithReturn -Verbose 
@(1, 2, 3, 4, 5) | Run-PipelineWithReturn -DoBegin -Verbose
@(1, 2, 3, 4, 5) | Run-PipelineWithReturn -DoBegin -DoEnd -Verbose
@(1, 2, 3, 4, 5) | Run-PipelineWithReturn -ReturnProcess -Verbose | % { $_ + 1 }