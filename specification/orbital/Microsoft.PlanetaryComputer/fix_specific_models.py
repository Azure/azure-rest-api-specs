#!/usr/bin/env python3
"""
Fix multi-line descriptions in specific TypeSpec models only.
"""

import re
import sys

# Target models to fix (without the leading dot)
TARGET_MODELS = {
    # Enums
    'FilterLanguage',
    'LegendConfigType', 
    'PixelSelection',
    # Models
    'BandStatistics',
    'RenderOption',
    'RenderOptionLegend',
    'StacAsset',
    'StacCatalogCollections',
    'StacCollection',
    'StacCollectionTemporalExtent',
    'StacConformanceClasses',
    'StacContextExtension',
    'StacExtensionExtent',
    'StacExtensionSpatialExtent',
    'StacItemAsset',
    'StacItemCollection',
    'StacItemProperties',
    'StacLandingPage',
    'StacLink',
    'StacProvider',
    'StacSearchParameters',
    'StacSortExtension',
    'TileJsonMetadata',
    'TileMatrix',
    'TileMatrixSet',
    'TilerCoreModelsResponsesPoint',
    'TilerStacSearchDefinition',
    'TilerStacSearchRegistration',
    'TileSettings',
}

def fix_multiline_doc_comment(content):
    """Find and fix multi-line doc comments to be single-line."""
    
    # Pattern to match model/enum declarations and their doc comments
    # We'll look for: /** ... */ followed by model/enum Name
    pattern = r'(/\*\*\s*\n(?:\s*\*[^\n]*\n)+\s*\*/)\s*\n(\s*)(model|enum|union)\s+(\w+)'
    
    changes = []
    
    def process_match(match):
        doc_comment = match.group(1)
        indent = match.group(2)  # Capture the indentation before keyword
        keyword = match.group(3)  # model, enum, or union
        model_name = match.group(4)
        
        # Only process if this model is in our target list
        if model_name not in TARGET_MODELS:
            return match.group(0)  # Return unchanged
        
        # Check if doc comment has blank lines (lines with just *)
        # These are safe for Sphinx and should be preserved
        has_blank_lines = False
        for line in doc_comment.split('\n'):
            stripped = line.strip()
            if stripped == '*':
                has_blank_lines = True
                break
        
        # If has blank lines, keep as-is (safe for Sphinx)
        if has_blank_lines:
            return match.group(0)
        
        # Extract lines from doc comment
        lines = []
        for line in doc_comment.split('\n'):
            line = line.strip()
            # Skip opening and closing markers
            if line in ('/**', '*/'):
                continue
            # Remove leading * and whitespace
            if line.startswith('*'):
                line = line[1:].strip()
            if line:
                lines.append(line)
        
        # If only one line, return as-is
        if len(lines) <= 1:
            return match.group(0)
        
        # Combine into single line
        combined = ' '.join(lines)
        
        # Record change
        changes.append({
            'model': model_name,
            'type': keyword,
            'lines': len(lines),
            'text': combined[:80] + ('...' if len(combined) > 80 else '')
        })
        
        # Create single-line comment with preserved indentation
        single_line = f'/**\n{indent} * {combined}\n{indent} */\n{indent}{keyword} {model_name}'
        
        return single_line
    
    new_content = re.sub(pattern, process_match, content)
    
    # Also fix properties within target models
    # This is more complex - need to track if we're inside a target model
    return new_content, changes


def fix_properties_in_models(content):
    """Fix multi-line doc comments for properties within target models."""
    
    # Temporarily disabled due to bugs - only model-level comments will be fixed
    return content, []


def process_file(file_path, dry_run=True):
    """Process a single TypeSpec file."""
    print(f"\nProcessing: {file_path}")
    print("="*80)
    
    with open(file_path, 'r', encoding='utf-8') as f:
        original_content = f.read()
    
    # First pass: fix model-level doc comments
    new_content, model_changes = fix_multiline_doc_comment(original_content)
    
    # Second pass: fix property-level doc comments
    new_content, prop_changes = fix_properties_in_models(new_content)
    
    all_changes = model_changes + prop_changes
    
    if not all_changes:
        print("✓ No changes needed for target models")
        return 0
    
    print(f"\nFound {len(all_changes)} multi-line doc comments to fix:")
    for i, change in enumerate(all_changes, 1):
        if 'property' in change:
            print(f"  {i}. {change['model']}.{change['property']}: {change['lines']} lines → 1 line")
        else:
            print(f"  {i}. {change['type']} {change['model']}: {change['lines']} lines → 1 line")
        print(f"     {change['text']}")
    
    if dry_run:
        print(f"\n[DRY RUN] Would update {len(all_changes)} doc comments")
    else:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"\n✓ Updated {len(all_changes)} doc comments")
    
    return len(all_changes)


def main():
    dry_run = '--apply' not in sys.argv
    
    if dry_run:
        print("="*80)
        print("DRY RUN MODE - No files will be modified")
        print("Use --apply flag to actually update files")
        print("="*80)
    else:
        print("="*80)
        print("APPLY MODE - Files will be modified")
        print("="*80)
    
    print(f"\nTarget models: {len(TARGET_MODELS)}")
    for model in sorted(TARGET_MODELS):
        print(f"  - {model}")
    
    # Process the specific files that contain these models
    files_to_process = [
        'models.stac.spec.tsp',
        'models.stac.config.tsp',
        'models.tiler.common.tsp',
        'models.tiler.items.tsp',
        'models.tiler.mosaics.tsp',
        'models.tiler.tile-matrix-sets.tsp',
    ]
    
    total_changes = 0
    for file_path in files_to_process:
        changes = process_file(file_path, dry_run=dry_run)
        total_changes += changes
    
    print("\n" + "="*80)
    print("SUMMARY")
    print("="*80)
    print(f"Total changes: {total_changes}")
    
    if dry_run and total_changes > 0:
        print("\nRun with --apply flag to update files")
    elif not dry_run and total_changes > 0:
        print(f"\n✓ Successfully updated files")


if __name__ == '__main__':
    main()
