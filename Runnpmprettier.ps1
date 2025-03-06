# Define the path to the log/txt file
$logFilePath = "C:\Users\yosharma\Desktop\11.txt"

# Read all lines from the log file
$lines = Get-Content -Path $logFilePath

# Iterate through each line
foreach ($line in $lines) {
    # Check if the line contains 'npx prettier'
    if ($line -match "npx prettier") {
        # Extract the command to run
        #$command = $line.TrimStart('>').Trim()
        $command = $line.Substring(2).Trim()
        #$command = $line -replace '^>\s*', ''
        # Execute the command
        Write-Host $line.Substring(2).Trim()
        Invoke-Expression $command
    }
}