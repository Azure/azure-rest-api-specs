#
# Convert Cognitive Services control plane API definitions from Swagger to TypeSpec
#
# This script automates the conversion process using tsp-client convert command.
# It will:
# 1. Install required dependencies
# 2. Convert the Swagger specification to TypeSpec
# 3. Create the appropriate directory structure
# 4. Provide guidance for next steps
#

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Resolve-Path "$ScriptDir\..\.."
$ReadmePath = "$ScriptDir\resource-manager\readme.md"
$OutputDir = "$ScriptDir\resource-manager\Microsoft.CognitiveServices\CognitiveServices.Management"

Write-Host "========================================"
Write-Host "Cognitive Services Swagger to TypeSpec Conversion"
Write-Host "========================================"
Write-Host ""

# Check if readme.md exists
if (-not (Test-Path $ReadmePath)) {
    Write-Host "ERROR: Cannot find readme.md at $ReadmePath" -ForegroundColor Red
    exit 1
}

Write-Host "Step 1: Installing dependencies..."
Write-Host "This may take a few minutes on first run."
Push-Location $RepoRoot
try {
    npm ci
    Write-Host "✓ Dependencies installed" -ForegroundColor Green
    Write-Host ""
}
finally {
    Pop-Location
}

Write-Host "Step 2: Converting Swagger to TypeSpec..."
Write-Host "Reading from: $ReadmePath"
Write-Host "Output directory: $OutputDir"
Write-Host ""

# Run the conversion
# --arm: Indicates this is an ARM (Azure Resource Manager) specification
# --fully-compatible false: Generate idiomatic TypeSpec using standard patterns
Push-Location $RepoRoot
try {
    npx tsp-client convert --swagger-readme $ReadmePath --arm
}
finally {
    Pop-Location
}

Write-Host ""
Write-Host "========================================"
Write-Host "Conversion Complete!" -ForegroundColor Green
Write-Host "========================================"
Write-Host ""
Write-Host "Next steps:"
Write-Host "1. Review the generated TypeSpec files in:"
Write-Host "   $OutputDir"
Write-Host ""
Write-Host "2. Follow the migration checklist to ensure the spec is correct:"
Write-Host "   - Verify @service and @server definitions in main.tsp"
Write-Host "   - Ensure @useAuth decorator is specified for security"
Write-Host "   - Check that versioning is properly configured with @versioned"
Write-Host "   - Add documentation to all models, properties, and operations"
Write-Host "   - Review enum/union definitions"
Write-Host ""
Write-Host "3. Compile and validate the TypeSpec:"
Write-Host "   cd $OutputDir"
Write-Host "   tsp compile ."
Write-Host ""
Write-Host "4. Review the generated OpenAPI files and compare with original Swagger"
Write-Host ""
Write-Host "For detailed migration guidance, see:"
Write-Host "   $RepoRoot\.github\instructions\typespec-project.instructions.md"
Write-Host "   $RepoRoot\.github\instructions\mgmt-migration.instructions.md"
Write-Host ""
