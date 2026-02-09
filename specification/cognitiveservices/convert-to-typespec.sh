#!/bin/bash
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

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
README_PATH="$SCRIPT_DIR/resource-manager/readme.md"
OUTPUT_DIR="$SCRIPT_DIR/resource-manager/Microsoft.CognitiveServices/CognitiveServices.Management"

echo "========================================"
echo "Cognitive Services Swagger to TypeSpec Conversion"
echo "========================================"
echo ""

# Check if readme.md exists
if [ ! -f "$README_PATH" ]; then
    echo "ERROR: Cannot find readme.md at $README_PATH"
    exit 1
fi

echo "Step 1: Installing dependencies..."
echo "This may take a few minutes on first run."
cd "$REPO_ROOT"
npm ci
echo "✓ Dependencies installed"
echo ""

echo "Step 2: Converting Swagger to TypeSpec..."
echo "Reading from: $README_PATH"
echo "Output directory: $OUTPUT_DIR"
echo ""

# Run the conversion
npx tsp-client convert --swagger-readme "$README_PATH"

echo ""
echo "========================================"
echo "Conversion Complete!"
echo "========================================"
echo ""
echo "Next steps:"
echo "1. Review the generated TypeSpec files in:"
echo "   $OUTPUT_DIR"
echo ""
echo "2. Follow the migration checklist to ensure the spec is correct:"
echo "   - Verify @service and @server definitions in main.tsp"
echo "   - Ensure @useAuth decorator is specified for security"
echo "   - Check that versioning is properly configured with @versioned"
echo "   - Add documentation to all models, properties, and operations"
echo "   - Review enum/union definitions"
echo ""
echo "3. Compile and validate the TypeSpec:"
echo "   cd $OUTPUT_DIR"
echo "   tsp compile ."
echo ""
echo "4. Review the generated OpenAPI files and compare with original Swagger"
echo ""
echo "For detailed migration guidance, see:"
echo "   $REPO_ROOT/.github/instructions/typespec-project.instructions.md"
echo "   $REPO_ROOT/.github/instructions/mgmt-migration.instructions.md"
echo ""
