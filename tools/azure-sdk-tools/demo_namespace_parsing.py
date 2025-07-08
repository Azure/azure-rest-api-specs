#!/usr/bin/env python3
"""Demonstration script showing the difference between old and new namespace parsing."""

import os
import sys

# Add the tools directory to the path so we can import our modules
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))

from tests.test_parse_functionality import parse_pyproject


def old_parse_pyproject(package_name):
    """Old implementation that simply replaces - with ."""
    return {"namespace": package_name.replace('-', '.')}


def main():
    """Demonstrate the difference between old and new namespace parsing."""
    
    print("Namespace Parsing Comparison")
    print("=" * 50)
    
    # Test cases
    test_cases = [
        "azure-eventhub-checkpointstoreblob",
        "azure-simple-package",
        "azure-mgmt-compute"
    ]
    
    for package_name in test_cases:
        print(f"\nPackage: {package_name}")
        print("-" * 30)
        
        # Old method
        old_result = old_parse_pyproject(package_name)
        print(f"Old method: {old_result['namespace']}")
        
        # New method - try to use actual directory if it exists
        tools_dir = os.path.dirname(__file__)
        repo_root = os.path.dirname(os.path.dirname(tools_dir))
        sdk_path = os.path.join(
            repo_root,
            "sdk", 
            "eventhub" if "eventhub" in package_name else "unknown",
            package_name
        )
        
        new_result = parse_pyproject(package_name, sdk_path)
        print(f"New method: {new_result['namespace']}")
        
        if old_result['namespace'] != new_result['namespace']:
            print(f"✓ DIFFERENCE DETECTED: Namespace parsing improved!")
        else:
            print("Same result (expected for packages without complex structure)")


if __name__ == "__main__":
    main()