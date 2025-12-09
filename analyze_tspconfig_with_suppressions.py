import os
import yaml
from pathlib import Path
from typing import Dict, List, Set
from collections import defaultdict

def load_suppressions(suppressions_file: str) -> Dict[str, Dict[str, Set[str]]]:
    """
    Load suppressions from suppressions.yaml and organize by path and language.
    Returns: {path: {language: set(sub-rules)}}
    Also returns patterns for glob matching.
    """
    try:
        with open(suppressions_file, 'r', encoding='utf-8') as f:
            data = yaml.safe_load(f)
        
        # Dictionary to store suppressions by path
        # Format: {path: {language: set(sub-rules)}}
        suppressions_by_path = defaultdict(lambda: defaultdict(set))
        
        # Store patterns separately for glob matching
        pattern_suppressions = []
        
        if not data:
            return {}
        
        for item in data:
            if not isinstance(item, dict):
                continue
            
            # Only process TypeSpecValidation with SdkTspConfigValidation rules
            if item.get('tool') != 'TypeSpecValidation':
                continue
            
            rules = item.get('rules', [])
            if 'SdkTspConfigValidation' not in rules:
                continue
            
            sub_rules = item.get('sub-rules', [])
            paths = item.get('paths', [])
            
            # Parse sub-rules to extract language-specific suppressions
            for path in paths:
                # Check if path contains wildcards
                if '**' in path or '*' in path:
                    # Store as pattern for later matching
                    lang_suppressions = defaultdict(set)
                    for sub_rule in sub_rules:
                        if 'typespec-ts' in sub_rule:
                            lang_suppressions['ts'].add(sub_rule)
                        elif 'typespec-python' in sub_rule:
                            lang_suppressions['python'].add(sub_rule)
                        elif 'typespec-java' in sub_rule:
                            lang_suppressions['java'].add(sub_rule)
                        elif 'typespec-go' in sub_rule:
                            lang_suppressions['go'].add(sub_rule)
                    pattern_suppressions.append((path, lang_suppressions))
                else:
                    # Exact path match
                    for sub_rule in sub_rules:
                        if 'typespec-ts' in sub_rule:
                            suppressions_by_path[path]['ts'].add(sub_rule)
                        elif 'typespec-python' in sub_rule:
                            suppressions_by_path[path]['python'].add(sub_rule)
                        elif 'typespec-java' in sub_rule:
                            suppressions_by_path[path]['java'].add(sub_rule)
                        elif 'typespec-go' in sub_rule:
                            suppressions_by_path[path]['go'].add(sub_rule)
        
        # Store patterns in the dictionary with a special key
        suppressions_by_path['__patterns__'] = pattern_suppressions
        
        return suppressions_by_path
    except Exception as e:
        print(f"Error loading suppressions: {e}")
        return {}

def extract_language_config(config: Dict, language_key: str) -> Dict[str, any]:
    """
    Extract configuration for a specific language emitter.
    Returns a dict with specified configuration fields for each language.
    """
    options = config.get('options', {})
    language_config = options.get(language_key, {})
    
    result = {}
    
    # Define fields to collect for each language
    fields_to_collect = {
        '@azure-tools/typespec-ts': [
            'experimental-extensible-enums',
            'emitter-output-dir',
            'package-details.name'
        ],
        '@azure-tools/typespec-go': [
            'module',
            'containing-module',
            'service-dir',
            'emitter-output-dir',
            'generate-samples',
            'head-as-boolean',
            'generate-fakes',
            'inject-spans'
        ],
        '@azure-tools/typespec-python': [
            'emitter-output-dir',
            'generate-test',
            'generate-sample',
            'namespace',

        ], 
        '@azure-tools/typespec-java': [
            'emitter-output-dir',
            'namespace',
        ]  
    }
    
    # Get the fields to collect for this language
    fields = fields_to_collect.get(language_key, [])
    
    for field in fields:
        # Handle nested fields like package-details.name
        if '.' in field:
            parts = field.split('.', 1)
            parent_key = parts[0]
            child_key = parts[1]
            if parent_key in language_config and isinstance(language_config[parent_key], dict):
                if child_key in language_config[parent_key]:
                    result[field] = language_config[parent_key][child_key]
        else:
            # Simple field
            if field in language_config:
                result[field] = language_config[field]
    
    return result

def format_config_summary(config: Dict) -> str:
    """Format configuration as a compact string - only keys."""
    if not config:
        return "N/A"
    
    # Only return the keys, not the values
    keys = sorted(config.keys())
    return ", ".join(keys)

def format_suppressions(suppressions: Set[str]) -> str:
    """Format suppressions as a compact string."""
    if not suppressions:
        return "None"
    
    # Check for wildcard suppressions (ending with .*)
    wildcards = [s for s in suppressions if s.endswith('.*')]
    
    if wildcards:
        return "ALL"
    
    # Extract property names after the language tool name
    # Format: options.@azure-tools/typespec-{lang}.{property}
    # Extract everything after the last occurrence of typespec-{lang}.
    props = []
    for s in suppressions:
        # Find the position after "typespec-ts.", "typespec-python.", etc.
        parts = s.split('.')
        # Find where the typespec-{lang} part ends
        for i, part in enumerate(parts):
            if 'typespec-' in part and i + 1 < len(parts):
                # Join everything after typespec-{lang}
                prop = '.'.join(parts[i+1:])
                props.append(prop)
                break
    
    return ", ".join(sorted(props)) if props else "Unknown"

def is_management_sdk(folder: str) -> bool:
    """判断是否为Management SDK"""
    return "/resource-manager/" in folder.replace("\\", "/") or ".Management" in folder

def analyze_tspconfig_with_suppressions(file_path: str, base_dir: str, suppressions_data: Dict) -> Dict:
    """Analyze a single tspconfig.yaml file with suppression information."""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            config = yaml.safe_load(f)
        
        # Get relative path
        rel_path = os.path.relpath(file_path, base_dir)
        rel_path_normalized = rel_path.replace(os.sep, '/')
        
        # Determine SDK type
        sdk_type = "mgmt" if is_management_sdk(file_path) else "dpg"
        
        # Check if languages are configured in emit or options
        emit_config = config.get('emit', []) if config else []
        options_config = config.get('options', {}) if config else {}
        
        # Language keys
        ts_key = '@azure-tools/typespec-ts'
        python_key = '@azure-tools/typespec-python'
        java_key = '@azure-tools/typespec-java'
        go_key = '@azure-tools/typespec-go'
        
        has_ts = ts_key in emit_config or ts_key in options_config
        has_python = python_key in emit_config or python_key in options_config
        has_java = java_key in emit_config or java_key in options_config
        has_go = go_key in emit_config or go_key in options_config
        
        # Extract language configurations
        ts_config = extract_language_config(config, ts_key) if has_ts else {}
        python_config = extract_language_config(config, python_key) if has_python else {}
        java_config = extract_language_config(config, java_key) if has_java else {}
        go_config = extract_language_config(config, go_key) if has_go else {}
        
        # Get suppressions for this path
        path_suppressions = suppressions_data.get(rel_path_normalized, {})
        ts_suppressions = set(path_suppressions.get('ts', set()))
        python_suppressions = set(path_suppressions.get('python', set()))
        java_suppressions = set(path_suppressions.get('java', set()))
        go_suppressions = set(path_suppressions.get('go', set()))
        
        # Check pattern-based suppressions
        patterns = suppressions_data.get('__patterns__', [])
        import re
        for pattern, lang_supps in patterns:
            # Convert glob pattern to regex
            # First escape special regex characters except * and /
            regex_pattern = pattern.replace('.', r'\.')
            # Replace ** with a placeholder to avoid interference
            regex_pattern = regex_pattern.replace('**', '__DOUBLESTAR__')
            # Replace single * with [^/]*
            regex_pattern = regex_pattern.replace('*', '[^/]*')
            # Replace placeholder with .*
            regex_pattern = regex_pattern.replace('__DOUBLESTAR__/', '.*')
            regex_pattern = '^' + regex_pattern + '$'
            
            if re.match(regex_pattern, rel_path_normalized):
                # This path matches the pattern, add suppressions
                ts_suppressions.update(lang_supps.get('ts', set()))
                python_suppressions.update(lang_supps.get('python', set()))
                java_suppressions.update(lang_supps.get('java', set()))
                go_suppressions.update(lang_supps.get('go', set()))
        
        return {
            'path': rel_path,
            'sdk_type': sdk_type,
            'has_ts': has_ts,
            'ts_config': ts_config,
            'ts_suppressions': ts_suppressions,
            'has_python': has_python,
            'python_config': python_config,
            'python_suppressions': python_suppressions,
            'has_java': has_java,
            'java_config': java_config,
            'java_suppressions': java_suppressions,
            'has_go': has_go,
            'go_config': go_config,
            'go_suppressions': go_suppressions,
        }
    except Exception as e:
        rel_path = os.path.relpath(file_path, base_dir)
        return {
            'path': rel_path,
            'sdk_type': 'error',
            'has_ts': False,
            'ts_config': {},
            'ts_suppressions': set(),
            'has_python': False,
            'python_config': {},
            'python_suppressions': set(),
            'has_java': False,
            'java_config': {},
            'java_suppressions': set(),
            'has_go': False,
            'go_config': {},
            'go_suppressions': set(),
            'error': str(e)
        }

def main():
    # Load suppressions
    suppressions_file = Path("specification") / "suppressions.yaml"
    print(f"Loading suppressions from {suppressions_file}...")
    suppressions_data = load_suppressions(str(suppressions_file))
    print(f"Loaded suppressions for {len(suppressions_data)} paths\n")
    
    # Find all tspconfig.yaml files
    spec_dir = Path("specification")
    tspconfig_files = list(spec_dir.rglob("tspconfig.yaml"))
    
    print(f"Found {len(tspconfig_files)} tspconfig.yaml files\n")
    
    # Analyze all files
    results = []
    for file_path in tspconfig_files:
        result = analyze_tspconfig_with_suppressions(str(file_path), str(spec_dir), suppressions_data)
        results.append(result)
    
    # Sort results by path
    results.sort(key=lambda x: x['path'])
    
    # Print detailed results
    print("=" * 200)
    print(f"{'Path':<80} {'Type':<6} {'TS':<4} {'Py':<4} {'Java':<6} {'Go':<4}")
    print("=" * 200)
    
    for result in results:
        path = result['path']
        sdk_type = result['sdk_type']
        
        has_ts = "Yes" if result['has_ts'] else "No"
        has_python = "Yes" if result['has_python'] else "No"
        has_java = "Yes" if result['has_java'] else "No"
        has_go = "Yes" if result['has_go'] else "No"
        
        if 'error' in result:
            print(f"{path:<80} ERROR: {result['error']}")
        else:
            print(f"{path:<80} {sdk_type:<6} {has_ts:<4} {has_python:<4} {has_java:<6} {has_go:<4}")
    
    print("=" * 200)
    
    # Export to separate CSV files for each language
    languages = [
        ('ts', 'TypeScript', 'has_ts', 'ts_config', 'ts_suppressions'),
        ('python', 'Python', 'has_python', 'python_config', 'python_suppressions'),
        ('java', 'Java', 'has_java', 'java_config', 'java_suppressions'),
        ('go', 'Go', 'has_go', 'go_config', 'go_suppressions')
    ]
    
    for lang_code, lang_name, has_key, config_key, supp_key in languages:
        csv_file = f"tspconfig_{lang_code}.csv"
        with open(csv_file, 'w', encoding='utf-8-sig') as f:
            # Header
            f.write(f"Path,SDK Type,Has {lang_name},Config,Suppressions\n")
            
            for result in results:
                path = result['path']
                sdk_type = result['sdk_type']
                
                has_lang = "Yes" if result[has_key] else "No"
                # Show config only if language is configured, but always show suppressions
                config_str = format_config_summary(result.get(config_key, {})) if result[has_key] else "N/A"
                supp_str = format_suppressions(result.get(supp_key, set()))
                
                if 'error' in result:
                    f.write(f'"{path}",error,No,ERROR,N/A\n')
                else:
                    f.write(f'"{path}",{sdk_type},{has_lang},"{config_str}","{supp_str}"\n')
        
        print(f"Results exported to: {csv_file}")
    
    # Statistics
    total = len(results)
    has_ts_count = sum(1 for r in results if r['has_ts'])
    has_python_count = sum(1 for r in results if r['has_python'])
    has_java_count = sum(1 for r in results if r['has_java'])
    has_go_count = sum(1 for r in results if r['has_go'])
    mgmt_count = sum(1 for r in results if r['sdk_type'] == 'mgmt')
    dpg_count = sum(1 for r in results if r['sdk_type'] == 'dpg')
    
    ts_with_supp = sum(1 for r in results if r.get('ts_suppressions'))
    python_with_supp = sum(1 for r in results if r.get('python_suppressions'))
    java_with_supp = sum(1 for r in results if r.get('java_suppressions'))
    go_with_supp = sum(1 for r in results if r.get('go_suppressions'))
    
    print(f"\nStatistics:")
    print(f"Total tspconfig files: {total}")
    print(f"MGMT Type: {mgmt_count}")
    print(f"DPG Type: {dpg_count}")
    print(f"\nLanguage Support:")
    print(f"TypeScript: {has_ts_count} configured ({ts_with_supp} with suppressions)")
    print(f"Python: {has_python_count} configured ({python_with_supp} with suppressions)")
    print(f"Java: {has_java_count} configured ({java_with_supp} with suppressions)")
    print(f"Go: {has_go_count} configured ({go_with_supp} with suppressions)")

if __name__ == "__main__":
    main()
