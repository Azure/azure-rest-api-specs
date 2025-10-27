#!/bin/bash
set -euo pipefail

# Armstrong Scenario Script
# Wrapper for running Armstrong validate/test/cleanup commands with configuration management

# Configuration
CONFIG_FILE="armstrong-scenario.conf"
LOG_FILE="armstrong-scenario.log"
DEFAULT_LOCATION="westus3"
DEFAULT_REPLICA_LOCATION="centralus"

# Default working directory is current directory
WORKING_DIR="."

# Initialize variables
SUBSCRIPTION_ID=""
RESOURCE_NAME=""
LOCATION=""
REPLICA_LOCATION=""
SWAGGER_PATH=""
ADMIN_PASSWORD=""
RESTORE_ADMIN_PASSWORD=""
REGENERATE_RESOURCES=false
NO_LOG=false

show_usage() {
    cat << EOF
Usage: $0 COMMAND [OPTIONS]

Commands:
    install     Install prerequisites for Armstrong and this script
    regenerate  Generate new configuration with resource names and passwords
    validate    Validate terraform configuration
    test        Run Armstrong test
    cleanup     Cleanup resources
    full        Run validate + test + cleanup

Options:
    --working-dir <path>        Terraform working directory (default: current directory)
    --subscription-id <id>      Azure subscription ID
    --regenerate-resources      Generate new resource names and passwords (for validate/test/cleanup/full)
    --resource-name <name>      Specific resource name to use
    --swagger-path <path>       Path to swagger file (default: auto-detect)
    --location <region>         Azure region (default: westus3)
    --replica-location <region> Replica region (default: centralus)
    --no-log                    Disable output logging for better interactive experience
    -h, --help                  Show this help message

Examples:
    # Install prerequisites
    ./armstrong-scenario.sh install

    # First time setup - generate configuration
    ./armstrong-scenario.sh regenerate --subscription-id 455f5b7e-620f-4f41-b67a-56513a1cdf29

    # Run test with existing config
    ./armstrong-scenario.sh test

    # Run with better interactive output (no logging)
    ./armstrong-scenario.sh test --no-log

    # Regenerate resources and run full cycle
    ./armstrong-scenario.sh full --regenerate-resources

    # Specify working directory
    ./armstrong-scenario.sh test --working-dir ./terraform
EOF
}

validate_working_dir() {
    local dir="${WORKING_DIR}"
    
    if [[ ! -d "$dir" ]]; then
        echo "❌ ERROR: Working directory does not exist: $dir"
        exit 1
    fi
    
    if [[ ! -f "$dir/testing.tf" ]]; then
        echo "❌ ERROR: No terraform files found in: $dir"
        echo "   Expected to find testing.tf in the working directory"
        echo "   Use --working-dir to specify the correct terraform directory"
        exit 1
    fi
    
    # Convert to absolute path
    WORKING_DIR=$(cd "$dir" && pwd)
    echo "📁 Working directory: $WORKING_DIR"
}

setup_swagger_path() {
    if [[ -z "${SWAGGER_PATH:-}" ]]; then
        # Auto-detect swagger path relative to working directory
        local auto_swagger="$WORKING_DIR/../mongoCluster.json"
        if [[ -f "$auto_swagger" ]]; then
            SWAGGER_PATH="$auto_swagger"
        else
            echo "❌ ERROR: mongoCluster.json not found at $auto_swagger"
            echo "   Please specify --swagger-path <path>"
            exit 1
        fi
    fi
    echo "📄 Swagger file: $SWAGGER_PATH"
}

load_config() {
    local config_path="$WORKING_DIR/$CONFIG_FILE"
    if [[ -f "$config_path" ]]; then
        echo "📖 Loading configuration from $CONFIG_FILE..."
        source "$config_path"
        return 0
    else
        return 1
    fi
}

save_config() {
    local config_path="$WORKING_DIR/$CONFIG_FILE"
    cat > "$config_path" << EOF
# Armstrong Scenario Configuration
# Generated automatically - modify as needed

SUBSCRIPTION_ID=${SUBSCRIPTION_ID}
RESOURCE_NAME=${RESOURCE_NAME}
LOCATION=${LOCATION:-$DEFAULT_LOCATION}
REPLICA_LOCATION=${REPLICA_LOCATION:-$DEFAULT_REPLICA_LOCATION}
SWAGGER_PATH=${SWAGGER_PATH}
ADMIN_PASSWORD=${ADMIN_PASSWORD}
RESTORE_ADMIN_PASSWORD=${RESTORE_ADMIN_PASSWORD}
LAST_UPDATED=$(date -Iseconds)
EOF
    echo "💾 Configuration saved to $CONFIG_FILE"
}

generate_resource_name() {
    echo "acctest$(date +%s)"
}

generate_passwords() {
    local timestamp=$(date +%s)
    ADMIN_PASSWORD="terraformTest@2025-${timestamp}!"
    RESTORE_ADMIN_PASSWORD="restoreTest@2025-${timestamp}!"
}

handle_regenerate_resources() {
    if [[ "${REGENERATE_RESOURCES:-false}" == "true" ]]; then
        echo "🔄 Regenerating resources and passwords..."
        RESOURCE_NAME=$(generate_resource_name)
        generate_passwords
        echo "✅ Generated new resource name: $RESOURCE_NAME"
    fi
}

setup_environment() {
    export ARM_SUBSCRIPTION_ID="$SUBSCRIPTION_ID"
    export TF_VAR_resource_name="$RESOURCE_NAME"
    export TF_VAR_location="${LOCATION:-$DEFAULT_LOCATION}"
    export TF_VAR_replica_location="${REPLICA_LOCATION:-$DEFAULT_REPLICA_LOCATION}"
    export TF_VAR_admin_password="$ADMIN_PASSWORD"
    export TF_VAR_restore_admin_password="$RESTORE_ADMIN_PASSWORD"
    
    echo "🔧 Environment configured:"
    echo "   Subscription: $SUBSCRIPTION_ID"
    echo "   Resource Name: $RESOURCE_NAME"
    echo "   Location: ${LOCATION:-$DEFAULT_LOCATION}"
    echo "   Replica Location: ${REPLICA_LOCATION:-$DEFAULT_REPLICA_LOCATION}"
    echo "   Working Dir: $WORKING_DIR"
}

setup_logging() {
    local command="$1"
    local log_path="$WORKING_DIR/$LOG_FILE"
    echo "$(date -Iseconds) - Starting Armstrong scenario: $command" | tee -a "$log_path"
}

run_with_logging() {
    local command="$1"
    local log_path="$WORKING_DIR/$LOG_FILE"
    
    # Helper function for direct execution (no tee)
    run_direct() {
        local prefix="$1"
        echo "$prefix Executing: $command"
        if eval "$command"; then
            [[ "$NO_LOG" != "true" ]] && echo "$(date -Iseconds) - Command completed successfully" >> "$log_path"
            return 0
        else
            local exit_code=$?
            [[ "$NO_LOG" != "true" ]] && echo "$(date -Iseconds) - Command failed with exit code: $exit_code" >> "$log_path"
            return $exit_code
        fi
    }
    
    # No logging mode - pure interactive
    if [[ "$NO_LOG" == "true" ]]; then
        run_direct "🚀"
        return $?
    fi
    
    # Logging mode
    echo "$(date -Iseconds) - Executing: $command" | tee -a "$log_path"
    
    # Try unbuffer for colored output, fallback to direct execution
    if command -v unbuffer >/dev/null 2>&1; then
        if unbuffer bash -c "$command" 2>&1 | tee -a "$log_path"; then
            echo "$(date -Iseconds) - Command completed successfully" | tee -a "$log_path"
            return 0
        else
            local exit_code=${PIPESTATUS[0]}
            echo "$(date -Iseconds) - Command failed with exit code: $exit_code" | tee -a "$log_path"
            return $exit_code
        fi
    else
        echo "🔔 Note: Install 'expect' package for better log formatting" >&2
        # Log command execution for records
        echo "$(date -Iseconds) - Executed: $command (output not captured due to missing unbuffer)" >> "$log_path"
        run_direct "🚀"
        return $?
    fi
}

# Detect package manager
detect_package_manager() {
    if command -v apt-get >/dev/null 2>&1; then
        echo "apt"
    elif command -v yum >/dev/null 2>&1; then
        echo "yum"
    elif command -v dnf >/dev/null 2>&1; then
        echo "dnf"
    else
        echo "unknown"
    fi
}

# Install packages using detected package manager
install_packages() {
    local pkg_manager="$1"
    shift
    local packages=("$@")
    
    echo "📦 Installing packages: ${packages[*]}"
    
    case "$pkg_manager" in
        apt)
            sudo apt-get update
            sudo apt-get install -y "${packages[@]}"
            ;;
        yum)
            sudo yum install -y "${packages[@]}"
            ;;
        dnf)
            sudo dnf install -y "${packages[@]}"
            ;;
        *)
            echo "❌ ERROR: Unsupported package manager. Please install manually:"
            echo "   Packages needed: ${packages[*]}"
            return 1
            ;;
    esac
}

# Check if command exists
check_command() {
    local cmd="$1"
    local name="$2"
    
    if command -v "$cmd" >/dev/null 2>&1; then
        local version
        case "$cmd" in
            az) version=$(az version --output tsv | head -1) ;;
            terraform) version=$(terraform version | head -1) ;;
            go) version=$(go version) ;;
            node) version=$(node --version) ;;
            npm) version=$(npm --version) ;;
            oav) version=$(oav --version 2>/dev/null || echo "installed") ;;
            armstrong) version=$(armstrong --version 2>/dev/null || echo "installed") ;;
            unbuffer) version="installed" ;;
            *) version="installed" ;;
        esac
        echo "✅ $name: $version"
        return 0
    else
        echo "❌ $name: not found"
        return 1
    fi
}

armstrong_install() {
    echo "🚀 Installing Armstrong prerequisites..."
    echo ""
    
    # Detect package manager
    local pkg_manager
    pkg_manager=$(detect_package_manager)
    echo "📋 Detected package manager: $pkg_manager"
    
    if [[ "$pkg_manager" == "unknown" ]]; then
        echo "❌ ERROR: Could not detect package manager (apt, yum, or dnf)"
        echo "   Please install prerequisites manually:"
        echo "   - Go, Terraform, expect package"
        exit 1
    fi
    
    echo ""
    echo "📊 Checking current installation status..."
    
    # Check current status
    local missing_basic=()
    local missing_tools=()
    
    check_command "expect" "expect package" || missing_basic+=("expect")
    check_command "terraform" "Terraform" || missing_tools+=("terraform")
    check_command "go" "Go" || echo "❌ Go: not found (required for Armstrong)"
    check_command "armstrong" "Armstrong" || echo "⚠️  Armstrong: will install latest version"
    check_command "oav" "OAV" || echo "⚠️  OAV: will install latest version"
    check_command "unbuffer" "unbuffer" # Already handled by expect
    
    echo ""
    echo "ℹ️  Note: This installer will install all required dependencies for Armstrong."
    echo "   Installing: Go, Terraform, expect, Armstrong, OAV"
    echo ""
    
    # Install missing basic packages
    if [[ ${#missing_basic[@]} -gt 0 ]]; then
        echo "🔧 Installing basic packages..."
        
        local basic_packages=()
        for pkg in "${missing_basic[@]}"; do
            case "$pkg" in
                "expect") basic_packages+=("expect") ;;
            esac
        done
        
        if [[ ${#basic_packages[@]} -gt 0 ]]; then
            install_packages "$pkg_manager" "${basic_packages[@]}"
        fi
        echo ""
    fi
    
    # Install Terraform if missing
    if [[ " ${missing_tools[*]} " =~ " terraform " ]]; then
        echo "🔧 Installing Terraform..."
        case "$pkg_manager" in
            apt)
                curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
                echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
                sudo apt-get update
                install_packages "$pkg_manager" "terraform"
                ;;
            yum|dnf)
                sudo yum install -y yum-utils
                sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
                install_packages "$pkg_manager" "terraform"
                ;;
        esac
        echo ""
    fi
    
    # Install Go if not present (required for Armstrong)
    if ! command -v go &> /dev/null; then
        echo "📦 Installing Go (required for Armstrong)..."
        case "$pkg_manager" in
            apt)
                sudo apt-get update
                sudo apt-get install -y golang-go
                ;;
            yum|dnf)
                install_packages "$pkg_manager" "golang"
                ;;
        esac
        echo ""
    fi
    
    # Install/Update Armstrong (always get latest version)
    echo "🚀 Installing/Updating Armstrong (latest version)..."
    echo ""
    
    # Install Armstrong
    if ! go install github.com/azure/armstrong@latest; then
        echo "❌ Failed to install Armstrong"
        return 1
    fi
    
    # Add Go bin to PATH if not already there
    GO_BIN_PATH="$(go env GOPATH)/bin"
    if [[ ":$PATH:" != *":$GO_BIN_PATH:"* ]]; then
        # Add to .bashrc for future sessions
        echo "export PATH=\$PATH:$GO_BIN_PATH" >> ~/.bashrc
        echo "✅ Added Go bin directory to PATH in .bashrc"
    fi
    
    # Install/Update OAV (OpenAPI Validator)
    echo "📦 Installing/Updating OAV (latest version)..."
    echo ""
    
    # Install OAV using npm
    if command -v npm >/dev/null 2>&1; then
        if npm install -g oav@latest; then
            echo "✅ OAV installed successfully"
        else
            echo "⚠️  Failed to install OAV via npm"
        fi
    else
        echo "⚠️  npm not found. Skipping OAV installation."
        echo "   To install OAV manually: npm install -g oav@latest"
    fi
    
    echo "🔧 Verifying installations..."
    echo ""
    
    # Final verification including Armstrong and OAV
    local all_good=true
    check_command "terraform" "Terraform" || all_good=false
    check_command "unbuffer" "unbuffer (expect)" || all_good=false
    check_command "go" "Go" || all_good=false
    check_command "armstrong" "Armstrong" || all_good=false
    check_command "oav" "OAV" || all_good=false
    
    echo ""
    
    if [[ "$all_good" == "true" ]]; then
        echo "✅ All prerequisites installed successfully!"
        echo ""
        echo "🔄 To use Armstrong and OAV in this terminal session, reload your shell configuration:"
        echo "   source ~/.bashrc"
        echo "   (or restart your terminal)"
        echo ""
        echo "🎯 Next steps:"
        echo "   1. Reload shell: source ~/.bashrc"
        echo "   2. Login to Azure: az login"
        echo "   3. Set subscription: az account set --subscription <your-subscription-id>"
        echo "   4. Generate config: ./armstrong-scenario.sh regenerate --subscription-id <id>"
        echo "   5. Run tests: ./armstrong-scenario.sh test"
    else
        echo "⚠️  Some core prerequisites failed to install. Please check the errors above."
        return 1
    fi
}

armstrong_regenerate() {
    validate_working_dir
    
    setup_logging "regenerate"
    
    # Validate required args for regenerate
    if [[ -z "$SUBSCRIPTION_ID" ]]; then
        echo "❌ ERROR: Subscription ID is required for regeneration"
        echo "   Use --subscription-id <id>"
        exit 1
    fi
    
    echo "🔄 Generating new configuration..."
    
    # Generate new resources
    RESOURCE_NAME=$(generate_resource_name)
    generate_passwords
    
    # Initialize defaults
    initialize_defaults
    
    # Save configuration
    save_config
    
    echo "✅ Configuration regenerated successfully:"
    echo "   Subscription: $SUBSCRIPTION_ID"
    echo "   Resource Name: $RESOURCE_NAME"
    echo "   Location: $LOCATION"
    echo "   Replica Location: $REPLICA_LOCATION"
    echo "   Config saved to: $CONFIG_FILE"
    echo ""
    echo "You can now run validate/test/cleanup/full commands."
}

armstrong_validate() {
    setup_environment
    validate_working_dir
    setup_swagger_path
    
    setup_logging "validate"
    
    # Run armstrong from the specified working directory
    (cd "$WORKING_DIR" && run_with_logging "armstrong validate")
}

armstrong_test() {
    setup_environment
    validate_working_dir
    setup_swagger_path
    
    setup_logging "test"
    
    # Run armstrong from the specified working directory
    (cd "$WORKING_DIR" && run_with_logging "armstrong test -swagger '$SWAGGER_PATH'")
    
    echo "✅ Test completed. Resources preserved for reuse."
    echo "📋 Full log available in: $LOG_FILE"
}

armstrong_cleanup() {
    setup_environment
    validate_working_dir
    
    setup_logging "cleanup"
    
    # Run armstrong from the specified working directory
    (cd "$WORKING_DIR" && run_with_logging "armstrong cleanup")
}

armstrong_full() {
    setup_logging "full"
    echo "🚀 Starting full Armstrong scenario..."
    
    if armstrong_validate; then
        if armstrong_test; then
            armstrong_cleanup
            echo "✅ Full scenario completed successfully"
        else
            echo "❌ Test failed. Skipping cleanup to preserve resources for debugging."
            return 1
        fi
    else
        echo "❌ Validation failed. Aborting."
        return 1
    fi
}

parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --working-dir)
                WORKING_DIR="$2"
                shift 2
                ;;
            --subscription-id)
                SUBSCRIPTION_ID="$2"
                shift 2
                ;;
            --regenerate-resources)
                REGENERATE_RESOURCES=true
                shift
                ;;
            --resource-name)
                RESOURCE_NAME="$2"
                shift 2
                ;;
            --swagger-path)
                SWAGGER_PATH="$2"
                shift 2
                ;;
            --location)
                LOCATION="$2"
                shift 2
                ;;
            --replica-location)
                REPLICA_LOCATION="$2"
                shift 2
                ;;
            --no-log)
                NO_LOG=true
                shift
                ;;
            -h|--help)
                show_usage
                exit 0
                ;;
            *)
                echo "❌ ERROR: Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done
}

validate_required_args() {
    if [[ -z "$SUBSCRIPTION_ID" ]]; then
        echo "❌ ERROR: Subscription ID is required"
        echo "   Use --subscription-id <id> or set it in the config file"
        exit 1
    fi
    
    if [[ -z "$RESOURCE_NAME" ]]; then
        echo "❌ ERROR: Resource name is required"
        echo "   Run 'regenerate' command first or use --regenerate-resources"
        exit 1
    fi
    
    if [[ -z "$ADMIN_PASSWORD" ]]; then
        echo "❌ ERROR: Admin password is required"
        echo "   Run 'regenerate' command first or use --regenerate-resources"
        exit 1
    fi
    
    if [[ -z "$RESTORE_ADMIN_PASSWORD" ]]; then
        echo "❌ ERROR: Restore admin password is required"
        echo "   Run 'regenerate' command first or use --regenerate-resources"
        exit 1
    fi
}

initialize_defaults() {
    # Set default locations if not provided
    LOCATION="${LOCATION:-$DEFAULT_LOCATION}"
    REPLICA_LOCATION="${REPLICA_LOCATION:-$DEFAULT_REPLICA_LOCATION}"
}

check_config_required() {
    local config_path="$WORKING_DIR/$CONFIG_FILE"
    
    # If config doesn't exist and we're not regenerating, require regeneration
    if [[ ! -f "$config_path" ]] && [[ "$REGENERATE_RESOURCES" != "true" ]]; then
        echo "❌ ERROR: No configuration file found at $CONFIG_FILE"
        echo "   This is your first time running the script in this directory."
        echo ""
        echo "   Choose one of these options:"
        echo "   1. Generate new configuration: ./armstrong-scenario.sh regenerate --subscription-id <id>"
        echo "   2. Use --regenerate-resources flag with your command"
        echo ""
        exit 1
    fi
}
main() {
    local command="${1:-}"
    
    if [[ -z "$command" ]]; then
        echo "❌ ERROR: Command is required"
        show_usage
        exit 1
    fi
    
    case "$command" in
        install)
            # Install prerequisites
            armstrong_install
            ;;
        regenerate)
            # Parse arguments
            parse_args "${@:2}"
            
            # Execute regenerate command
            armstrong_regenerate
            ;;
        validate|test|cleanup|full)
            # Parse arguments
            parse_args "${@:2}"
            
            # Check if config is required
            check_config_required
            
            # Load existing configuration (may fail if regenerating)
            if ! load_config && [[ "$REGENERATE_RESOURCES" != "true" ]]; then
                echo "❌ ERROR: Failed to load configuration"
                exit 1
            fi
            
            # Handle resource regeneration
            handle_regenerate_resources
            
            # Initialize defaults
            initialize_defaults
            
            # Validate required arguments
            validate_required_args
            
            # Save configuration
            save_config
            
            # Execute command
            "armstrong_$command"
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            echo "❌ ERROR: Unknown command: $command"
            show_usage
            exit 1
            ;;
    esac
}

# Run main function with all arguments
main "$@"