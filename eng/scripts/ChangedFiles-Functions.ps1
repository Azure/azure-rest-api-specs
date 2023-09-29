function Get-ChangedFiles($baseCommitish="HEAD^", $targetCommitish="HEAD", $diffFilter="d")
{
    # diff-filter=d is to exclude any deleted files as we don't generally 
    # want to do work against files that no longer exist.
    # https://git-scm.com/docs/git-diff#Documentation/git-diff.txt---diff-filterACDMRTUXB82308203

    # core.quotepath=off is to help avoid quoting in the returned paths
    # https://git-scm.com/docs/git-config/2.22.0#Documentation/git-config.txt-corequotePath

    # Get all the files that have changed between HEAD and the commit before head
    # For PR's that last commit is always a merge commit so HEAD^ will get the parent
    # commit of the base branch and as such will diff HEAD against HEAD^
    $changedFiles = git -c core.quotepath=off diff --name-only --diff-filter=$diffFilter $baseCommitish $targetCommitish

    Write-Verbose "Changed files:"
    $changedFiles | ForEach-Object { Write-Verbose "$_" }

    return $changedFiles
}

function Get-ChangedSwaggerFiles()
{
    $changedFiles = Get-ChangedFilesUnderSpecification

    $changedSwaggerFiles = $changedFiles | Where-Object { 
        $_.EndsWith(".json")
    }
    
    return $changedSwaggerFiles
}

function Get-ChangedFilesUnderSpecification($changedFiles = (Get-ChangedFiles))
{
    $changedFilesUnderSpecification = $changedFiles | Where-Object { 
        $_.StartsWith("specification")
    }
    
    return $changedFilesUnderSpecification
}

function Get-ChangedCoreFiles($changedFiles = (Get-ChangedFiles))
{
    $rootFiles = @(
        ".gitattributes",
        ".prettierrc.json",
        "package-lock.json",
        "package.json",
        "tsconfig.json"
    )

    $coreFiles = $changedFiles | Where-Object { 
        $_.StartsWith("eng/") -or
        $_.StartsWith("specification/common-types/") -or
        $_ -in $rootFiles
    }

    return $coreFiles
}
