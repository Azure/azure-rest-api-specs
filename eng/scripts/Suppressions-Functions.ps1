<#
.DESCRIPTION
  Returns the suppressions for a tool applicable to a path.  Walks up the directory tree to find all files named
  "suppressions.yaml", parses and validates the contents, and returns the suppressions matching the tool and path.
  Suppressions are ordered by file (closest to path is first), then within the file (closest to top is first).

.PARAMETER Tool
  Name of tool. Matched against property "tool" in suppressions.yaml.

.PARAMETER Path
  Path to file or directory under analysis.

.OUTPUTS
  Hashtable[]
    Array of suppressions matching tool and path (may be empty).  See the "get-suppressions" tool for the definition
    of the suppression object.
#>
function Get-Suppressions {
  param (
    [string]$Tool,
    [string]$Path
  )

  # -NoEnumerate to prevent single-element arrays from being collapsed to a single object
  # -AsHashtable is closer to raw JSON than PSCustomObject
  $suppressions = npm exec --no -- get-suppressions $Tool $Path | ConvertFrom-Json -NoEnumerate -AsHashtable

  if ($LASTEXITCODE -ne 0) {
    throw "Failure running 'npm exec get-suppressions'"
  }

  return $suppressions;
}

<#
.DESCRIPTION
  Returns the first suppression for a tool applicable to a path.  Walks up the directory tree to find all files named
  "suppressions.yaml", parses and validates the contents, and returns the first suppression matching the tool and path.
  Suppressions are ordered by file (closest to path is first), then within the file (closest to top is first).

.PARAMETER Tool
  Name of tool. Matched against property "tool" in suppressions.yaml.

.PARAMETER Path
  Path to file or directory under analysis.

.OUTPUTS
  Hashtable
    First suppressions matching tool and path (may be null).  See the "get-suppressions" tool for the definition
    of the suppression object.
#>
function Get-Suppression {
  param (
    [string]$Tool,
    [string]$Path
  )

  $suppressions = @(Get-Suppressions $Tool $Path)
  return $suppressions ? $suppressions[0] : $null;
}
