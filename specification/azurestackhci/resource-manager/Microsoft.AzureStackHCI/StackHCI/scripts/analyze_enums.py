#!/usr/bin/env python3
"""
Script to analyze provisioning state enums from a JSON file.
Iterates over all sub-objects and identifies which resource has the most enum values.
"""

import json
import sys
from typing import Dict, List, Tuple


def load_json_file(file_path: str) -> Dict:
    """Load and parse JSON file."""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            return json.load(f)
    except FileNotFoundError:
        print(f"Error: File '{file_path}' not found.")
        sys.exit(1)
    except json.JSONDecodeError as e:
        print(f"Error: Invalid JSON in file '{file_path}': {e}")
        sys.exit(1)


def analyze_enums(data: Dict) -> List[Tuple[str, int, List[str]]]:
    """
    Analyze enum values for each resource.
    
    Returns:
        List of tuples containing (resource_name, enum_count, enum_values)
    """
    results = []
    
    for resource_name, resource_data in data.items():
        if isinstance(resource_data, dict) and 'enum' in resource_data:
            enum_values = resource_data['enum']
            enum_count = len(enum_values)
            results.append((resource_name, enum_count, enum_values))
    
    return results


def compare_enum_coverage(results: List[Tuple[str, int, List[str]]]) -> None:
    """Compare arcSettings enum values with all other resources to find missing values."""
    # Find arcSettings
    arc_settings = None
    for resource_name, enum_count, enum_values in results:
        if resource_name == "arcSettings":
            arc_settings = (resource_name, enum_count, set(enum_values))
            break
    
    if not arc_settings:
        print("\n⚠️  arcSettings not found in the data.")
        return
    
    print("\n" + "=" * 80)
    print("ARCSETTINGS ENUM COVERAGE ANALYSIS")
    print("=" * 80)
    print(f"\narcSettings has {arc_settings[1]} enum values.")
    print("\nChecking if arcSettings is missing any enum values from other resources...")
    print()
    
    arc_enum_set = arc_settings[2]
    all_missing = {}
    
    for resource_name, enum_count, enum_values in results:
        if resource_name == "arcSettings":
            continue
        
        resource_enum_set = set(enum_values)
        missing_from_arc = resource_enum_set - arc_enum_set
        
        if missing_from_arc:
            all_missing[resource_name] = sorted(missing_from_arc)
    
    if all_missing:
        print("❌ arcSettings is MISSING the following enum values:\n")
        for resource_name, missing_values in all_missing.items():
            print(f"   From {resource_name}:")
            for value in missing_values:
                print(f"      - {value}")
            print()
    else:
        print("✅ arcSettings contains ALL enum values from all other resources!")
    
    # Also check what arcSettings has that others don't
    print("\n" + "-" * 80)
    print("UNIQUE VALUES IN ARCSETTINGS")
    print("-" * 80)
    
    all_other_enums = set()
    for resource_name, enum_count, enum_values in results:
        if resource_name != "arcSettings":
            all_other_enums.update(enum_values)
    
    unique_to_arc = arc_enum_set - all_other_enums
    
    if unique_to_arc:
        print(f"\narcSettings has {len(unique_to_arc)} unique value(s) not found in any other resource:")
        for value in sorted(unique_to_arc):
            print(f"   - {value}")
    else:
        print("\narcSettings has no unique values - all its values exist in other resources.")

def print_analysis(results: List[Tuple[str, int, List[str]]]) -> None:
    """Print the analysis results in a formatted way."""
    if not results:
        print("No enum values found in the JSON file.")
        return
    
    # Sort by enum count (descending)
    sorted_results = sorted(results, key=lambda x: x[1], reverse=True)
    
    print("=" * 80)
    print("PROVISIONING STATE ENUM ANALYSIS")
    print("=" * 80)
    print()
    
    # Print summary table
    print(f"{'Resource Name':<30} {'Enum Count':>15}")
    print("-" * 80)
    for resource_name, enum_count, _ in sorted_results:
        print(f"{resource_name:<30} {enum_count:>15}")
    
    print()
    print("=" * 80)
    
    # Identify resource with most enum values
    max_resource = sorted_results[0]
    print(f"\n🏆 RESOURCE WITH MOST ENUM VALUES:")
    print(f"   Resource: {max_resource[0]}")
    print(f"   Count: {max_resource[1]} enum values")
    print(f"\n   Enum values:")
    for i, value in enumerate(max_resource[2], 1):
        print(f"      {i}. {value}")
    
    print()
    print("=" * 80)
    
    # Detailed breakdown for all resources
    print("\nDETAILED BREAKDOWN:")
    print("=" * 80)
    for resource_name, enum_count, enum_values in sorted_results:
        print(f"\n📋 {resource_name} ({enum_count} values):")
        for i, value in enumerate(enum_values, 1):
            print(f"   {i:2}. {value}")
    
    # Add comparison analysis for arcSettings
    compare_enum_coverage(results)
    
    # Add specific comparison between arcSettings and clusters
    compare_arc_vs_clusters(results)


def compare_arc_vs_clusters(results: List[Tuple[str, int, List[str]]]) -> None:
    """Compare arcSettings with clusters to find differences."""
    arc_settings = None
    clusters = None
    
    for resource_name, enum_count, enum_values in results:
        if resource_name == "arcSettings":
            arc_settings = (resource_name, enum_count, set(enum_values))
        elif resource_name == "clusters":
            clusters = (resource_name, enum_count, set(enum_values))
    
    if not arc_settings or not clusters:
        print("\n⚠️  Could not find both arcSettings and clusters in the data.")
        return
    
    print("\n" + "=" * 80)
    print("ARCSETTINGS VS CLUSTERS COMPARISON")
    print("=" * 80)
    
    arc_enum_set = arc_settings[2]
    clusters_enum_set = clusters[2]
    
    # What arcSettings has that clusters doesn't
    in_arc_not_clusters = arc_enum_set - clusters_enum_set
    # What clusters has that arcSettings doesn't
    in_clusters_not_arc = clusters_enum_set - arc_enum_set
    
    print(f"\narcSettings has {len(arc_enum_set)} enum values")
    print(f"clusters has {len(clusters_enum_set)} enum values")
    print()
    
    if in_arc_not_clusters:
        print(f"✨ Values in arcSettings but NOT in clusters ({len(in_arc_not_clusters)}):")
        for value in sorted(in_arc_not_clusters):
            print(f"   ➤ {value}")
        print()
    else:
        print("✅ No values in arcSettings that are missing from clusters")
        print()
    
    if in_clusters_not_arc:
        print(f"⚠️  Values in clusters but NOT in arcSettings ({len(in_clusters_not_arc)}):")
        for value in sorted(in_clusters_not_arc):
            print(f"   ➤ {value}")
        print()
    else:
        print("✅ No values in clusters that are missing from arcSettings")
        print()
    
    # Common values
    common = arc_enum_set & clusters_enum_set
    print(f"📊 Common values: {len(common)} out of {len(arc_enum_set | clusters_enum_set)} total unique values")

def main():
    """Main function to run the analysis."""
    # File path
    file_path = r"C:\Users\abaranwal\OneDrive - Microsoft\provisioningStateEnums.json"
    
    print(f"Loading JSON file: {file_path}")
    print()
    
    # Load JSON data
    data = load_json_file(file_path)
    
    # Analyze enums
    results = analyze_enums(data)
    
    # Print results
    print_analysis(results)


if __name__ == "__main__":
    main()
