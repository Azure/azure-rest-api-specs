Measure-Command -Expression { 
    ./eng/scripts/TypeSpec-Validation.ps1 `
        -CheckAll `
        -GitClean `
        -Verbose `
        -FolderCount 10
}


# No edits: 
# TotalSeconds      : 84.0936245

# Basic parallelism and logging:
# TotalSeconds      : 39.7942742

