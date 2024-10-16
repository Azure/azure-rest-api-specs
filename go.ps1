Measure-Command -Expression { 
    ./eng/scripts/TypeSpec-Validation.ps1 `
        -CheckAll `
        -GitClean `
        -Verbose `
        -FolderCount 50 `
        -Parallelism 10
}


# No edits (10 folders): 
# TotalSeconds      : 84.0936245

# Basic parallelism and logging (10 folders):
# TotalSeconds      : 39.7942742

# Parallelism and logging (50 folders) (default parallelism):
# TotalSeconds      : 255.3325259

# No edits (50 folders): 
# 

# Parallelism 10 (50 folders):
# 