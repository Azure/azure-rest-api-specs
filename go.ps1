Measure-Command -Expression { 
    ./eng/scripts/TypeSpec-Validation.ps1 `
        -CheckAll `
        -GitClean `
        -Verbose `
        -FolderCount 20 `
        -Parallelism 10
}


# No edits (10 folders): 
# TotalSeconds      : 84.0936245

# Basic parallelism and logging (10 folders):
# TotalSeconds      : 39.7942742

# Parallelism and logging (50 folders) (default parallelism):
# TotalSeconds      : 255.3325259

# No edits (50 folders): 
# TotalSeconds      : 416.8016576

# Parallelism 10 (50 folders) (INCLUDES AWS):
# TotalSeconds      : 237.0811563

# No parallelism (20 folders):
#

# Parallelism 10 (20 folders): 
# TotalSeconds      : 62.0577551