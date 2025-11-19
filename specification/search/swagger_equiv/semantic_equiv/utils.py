"""
Utility module for the Swagger equivalency checker.

This module combines configuration loading, file loading, and merging functionality
that was previously split across config.py, loader.py, and merge.py.

Handles reading and validating config.yaml, loading and parsing JSON files,
and merging hand-authored Swagger specifications according to equiv_impl_guide.md.
"""

import os
import yaml
import json
import copy
import pandas as pd
from typing import Dict, Any, List, Tuple
from dataclasses import dataclass, field
from pathlib import Path
from datetime import datetime


# Global merge log to track smart merging operations
merge_log: List[Dict[str, Any]] = []


def log_merge_operation(operation_type: str, context: str, details: Dict[str, Any]) -> None:
    """Log a merge operation for later output to merge.log"""
    global merge_log
    merge_log.append({
        'timestamp': datetime.now().isoformat(),
        'operation_type': operation_type,
        'context': context,
        'details': details
    })


def write_merge_log(output_path: str) -> None:
    """Write merge log to file"""
    global merge_log
    if not merge_log:
        return

    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    log_file = Path(output_path) / f"merge_{timestamp}.log"
    log_file.parent.mkdir(parents=True, exist_ok=True)

    with open(log_file, 'w', encoding='utf-8') as f:
        f.write("# Swagger Merge Operations Log\n")
        f.write(f"# Generated on {datetime.now().isoformat()}\n\n")

        for entry in merge_log:
            f.write(f"[{entry['timestamp']}] {entry['operation_type']}: {entry['context']}\n")
            if entry['details']:
                for key, value in entry['details'].items():
                    f.write(f"  {key}: {value}\n")
            f.write("\n")


def write_differences_excel(differences: List[Dict[str, Any]], output_path: str) -> None:
    """Write differences to Excel file with categorized sheets"""
    if not differences:
        return

    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    excel_file = Path(output_path) / f"diff_{timestamp}.xlsx"
    excel_file.parent.mkdir(parents=True, exist_ok=True)

    # Categorize differences
    categories = {
        'Paths': [],
        'Parameters': [],
        'Responses': [],
        'Definitions': [],
        'Operations': [],
        'Other': []
    }

    for diff in differences:
        description = diff.get('description', '').lower()
        category = 'Other'  # default

        if 'path' in description and ('missing' in description or 'extra' in description):
            category = 'Paths'
        elif 'parameter' in description or 'param:' in description:
            category = 'Parameters'
        elif 'response' in description:
            category = 'Responses'
        elif 'definition:' in description:
            category = 'Definitions'
        elif 'operation' in description:
            category = 'Operations'

        categories[category].append(diff)

    # Create Excel writer
    with pd.ExcelWriter(excel_file, engine='openpyxl') as writer:
        # Summary sheet
        summary_data = []
        for category, items in categories.items():
            summary_data.append({
                'Category': category,
                'Count': len(items),
                'Percentage': f"{len(items)/len(differences)*100:.1f}%" if differences else "0%"
            })

        summary_df = pd.DataFrame(summary_data)
        summary_df.to_excel(writer, sheet_name='Summary', index=False)

        # Individual category sheets
        for category, items in categories.items():
            if not items:
                continue

            df_data = []
            for item in items:
                df_data.append({
                    'Path': item.get('path', ''),
                    'Method': item.get('method', ''),
                    'Operation ID': item.get('operation_id', ''),
                    'Parameter': item.get('parameter', ''),
                    'Response': item.get('response', ''),
                    'Source': item.get('source', ''),
                    'Description': item.get('description', ''),
                    'Details': item.get('details', '')
                })

            df = pd.DataFrame(df_data)
            df.to_excel(writer, sheet_name=category, index=False)

        # All differences sheet
        all_data = []
        for i, diff in enumerate(differences, 1):
            all_data.append({
                'ID': i,
                'Path': diff.get('path', ''),
                'Method': diff.get('method', ''),
                'Operation ID': diff.get('operation_id', ''),
                'Parameter': diff.get('parameter', ''),
                'Response': diff.get('response', ''),
                'Source': diff.get('source', ''),
                'Description': diff.get('description', ''),
                'Details': diff.get('details', '')
            })

        all_df = pd.DataFrame(all_data)
        all_df.to_excel(writer, sheet_name='All Differences', index=False)


# Configuration classes and functions (from config.py)

@dataclass
class HandAuthoredConfig:
    """Configuration for hand-authored Swagger files."""
    searchservice_path: str
    searchindex_path: str
    knowledgebase_path: str
    common_types_path: str


@dataclass
class Config:
    """Main configuration object for the equivalency checker."""
    typespec_compiled_path: str
    hand_authored: HandAuthoredConfig
    output_path: str

    def resolve_paths(self, base_dir: Path) -> 'Config':
        """Resolve relative paths against the base directory."""
        return Config(
            typespec_compiled_path=str(base_dir / self.typespec_compiled_path),
            hand_authored=HandAuthoredConfig(
                searchservice_path=str(base_dir / self.hand_authored.searchservice_path),
                searchindex_path=str(base_dir / self.hand_authored.searchindex_path),
                knowledgebase_path=str(base_dir / self.hand_authored.knowledgebase_path),
                common_types_path=str(base_dir / self.hand_authored.common_types_path),
            ),
            output_path=str(base_dir / self.output_path)
        )


class ConfigError(Exception):
    """Exception raised for configuration-related errors."""
    pass


class LoaderError(Exception):
    """Exception raised for file loading and parsing errors."""
    pass


class MergeError(Exception):
    """Exception raised for merge-related errors."""
    pass


def load_config(config_path: str) -> Config:
    """
    Load and validate configuration from a YAML file.

    Args:
        config_path: Path to the config.yaml file

    Returns:
        Validated Config object

    Raises:
        ConfigError: If the config file is invalid or missing required fields
    """
    if not os.path.exists(config_path):
        raise ConfigError(f"Configuration file not found: {config_path}")

    try:
        with open(config_path, 'r', encoding='utf-8') as f:
            raw_config = yaml.safe_load(f)
    except yaml.YAMLError as e:
        raise ConfigError(f"Invalid YAML in configuration file: {e}")
    except Exception as e:
        raise ConfigError(f"Error reading configuration file: {e}")

    # Validate structure
    if not isinstance(raw_config, dict):
        raise ConfigError("Configuration must be a YAML object")

    # Extract and validate typespec_compiled
    typespec_compiled = raw_config.get('typespec_compiled', {})
    if not isinstance(typespec_compiled, dict) or 'path' not in typespec_compiled:
        raise ConfigError("Missing or invalid 'typespec_compiled.path' in configuration")

    # Extract and validate hand_authored
    hand_authored = raw_config.get('hand_authored', {})
    if not isinstance(hand_authored, dict):
        raise ConfigError("Missing or invalid 'hand_authored' section in configuration")

    required_hand_authored_keys = ['searchservice', 'searchindex', 'knowledgebase', 'common_types']
    for key in required_hand_authored_keys:
        if key not in hand_authored or not isinstance(hand_authored[key], dict):
            raise ConfigError(f"Missing or invalid 'hand_authored.{key}' in configuration")
        if 'path' not in hand_authored[key]:
            raise ConfigError(f"Missing 'hand_authored.{key}.path' in configuration")

    # Extract and validate output
    output = raw_config.get('output', {})
    if not isinstance(output, dict) or 'path' not in output:
        raise ConfigError("Missing or invalid 'output.path' in configuration")

    # Build config object
    try:
        config = Config(
            typespec_compiled_path=typespec_compiled['path'],
            hand_authored=HandAuthoredConfig(
                searchservice_path=hand_authored['searchservice']['path'],
                searchindex_path=hand_authored['searchindex']['path'],
                knowledgebase_path=hand_authored['knowledgebase']['path'],
                common_types_path=hand_authored['common_types']['path'],
            ),
            output_path=output['path']
        )

        # Resolve relative paths against config file directory
        config_dir = Path(config_path).parent
        return config.resolve_paths(config_dir)

    except Exception as e:
        raise ConfigError(f"Error building configuration object: {e}")


def validate_paths(config: Config) -> None:
    """
    Validate that all configured file paths exist and are readable.

    Args:
        config: Configuration object to validate

    Raises:
        ConfigError: If any configured file path does not exist or is not readable
    """
    paths_to_check = [
        ('TypeSpec compiled file', config.typespec_compiled_path),
        ('Hand-authored searchservice file', config.hand_authored.searchservice_path),
        ('Hand-authored searchindex file', config.hand_authored.searchindex_path),
        ('Hand-authored knowledgebase file', config.hand_authored.knowledgebase_path),
        ('Common types file', config.hand_authored.common_types_path),
    ]

    missing_files = []
    for name, path in paths_to_check:
        if not os.path.exists(path):
            missing_files.append(f"{name}: {path}")
        elif not os.path.isfile(path):
            missing_files.append(f"{name} is not a file: {path}")

    if missing_files:
        raise ConfigError("Missing or invalid files:\n" + "\n".join(f"  - {f}" for f in missing_files))

    # Ensure output directory exists or can be created
    output_dir = Path(config.output_path)
    try:
        output_dir.mkdir(parents=True, exist_ok=True)
    except Exception as e:
        raise ConfigError(f"Cannot create output directory {config.output_path}: {e}")


# File loading functions (from loader.py)

def load_swagger_json(file_path: str) -> Dict[str, Any]:
    """
    Load a Swagger JSON file and return it as a Python dictionary.

    Args:
        file_path: Path to the JSON file to load

    Returns:
        Parsed JSON as a Python dictionary

    Raises:
        LoaderError: If the file cannot be found, read, or parsed as JSON
    """
    if not os.path.exists(file_path):
        raise LoaderError(f"File not found: {file_path}")

    if not os.path.isfile(file_path):
        raise LoaderError(f"Path is not a file: {file_path}")

    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        raise LoaderError(f"Error reading file {file_path}: {e}")

    if not content.strip():
        raise LoaderError(f"File is empty: {file_path}")

    try:
        data = json.loads(content)
    except json.JSONDecodeError as e:
        raise LoaderError(f"Invalid JSON in file {file_path}: {e}")

    if not isinstance(data, dict):
        raise LoaderError(f"JSON file must contain an object, not {type(data).__name__}: {file_path}")

    return data


def load_all_swagger_files(config) -> Dict[str, Dict[str, Any]]:
    """
    Load all Swagger files specified in the configuration.

    Args:
        config: Configuration object containing file paths

    Returns:
        Dictionary mapping file names to their parsed JSON content:
        - 'typespec_compiled': TypeSpec-compiled Swagger
        - 'searchservice': Hand-authored searchservice Swagger
        - 'searchindex': Hand-authored searchindex Swagger
        - 'knowledgebase': Hand-authored knowledgebase Swagger
        - 'common_types': Common types Swagger

    Raises:
        LoaderError: If any file cannot be loaded
    """
    files_to_load = [
        ('typespec_compiled', config.typespec_compiled_path),
        ('searchservice', config.hand_authored.searchservice_path),
        ('searchindex', config.hand_authored.searchindex_path),
        ('knowledgebase', config.hand_authored.knowledgebase_path),
        ('common_types', config.hand_authored.common_types_path),
    ]

    loaded_files = {}

    for name, path in files_to_load:
        try:
            loaded_files[name] = load_swagger_json(path)
        except LoaderError as e:
            # Re-raise with context about which file failed
            raise LoaderError(f"Failed to load {name}: {e}")

    return loaded_files


def validate_swagger_structure(swagger_dict: Dict[str, Any], file_name: str) -> None:
    """
    Validate that a loaded JSON dictionary has the basic structure of a Swagger file.

    Args:
        swagger_dict: Parsed Swagger JSON
        file_name: Name of the file (for error messages)

    Raises:
        LoaderError: If the structure is invalid
    """
    # Check for required top-level fields according to Swagger 2.0 spec
    required_fields = ['swagger', 'info']
    missing_fields = []

    for field in required_fields:
        if field not in swagger_dict:
            missing_fields.append(field)

    if missing_fields:
        raise LoaderError(
            f"Invalid Swagger structure in {file_name}: "
            f"missing required fields: {', '.join(missing_fields)}"
        )

    # Validate swagger version
    swagger_version = swagger_dict.get('swagger')
    if not isinstance(swagger_version, str) or not swagger_version.startswith('2.'):
        raise LoaderError(
            f"Unsupported Swagger version in {file_name}: "
            f"expected 2.x, got {swagger_version}"
        )

    # Validate info section
    info = swagger_dict.get('info')
    if not isinstance(info, dict):
        raise LoaderError(f"Invalid 'info' section in {file_name}: must be an object")

    # Optional: validate other common sections exist and are the right type
    optional_sections = {
        'paths': dict,
        'definitions': dict,
        'parameters': dict,
        'responses': dict,
        'schemes': list,
        'consumes': list,
        'produces': list,
        'tags': list,
    }

    for section_name, expected_type in optional_sections.items():
        if section_name in swagger_dict:
            section_value = swagger_dict[section_name]
            if not isinstance(section_value, expected_type):
                raise LoaderError(
                    f"Invalid '{section_name}' section in {file_name}: "
                    f"expected {expected_type.__name__}, got {type(section_value).__name__}"
                )


def load_and_validate_all_files(config) -> Dict[str, Dict[str, Any]]:
    """
    Load and validate all Swagger files specified in the configuration.

    This is a convenience function that combines loading and basic validation.

    Args:
        config: Configuration object containing file paths

    Returns:
        Dictionary mapping file names to their validated parsed JSON content

    Raises:
        LoaderError: If any file cannot be loaded or is invalid
    """
    loaded_files = load_all_swagger_files(config)

    # Validate each loaded file
    for name, swagger_dict in loaded_files.items():
        validate_swagger_structure(swagger_dict, name)

    return loaded_files


# Merging functions (from merge.py)

def _indent_text(text: str, indent_spaces: int) -> str:
    """
    Helper function to indent each line of text by a specified number of spaces.

    Args:
        text: The text to indent
        indent_spaces: Number of spaces to indent each line

    Returns:
        Indented text
    """
    indent = " " * indent_spaces
    return "\n".join(indent + line for line in text.split("\n"))


def merge_objects(target: Dict[str, Any], source: Dict[str, Any],
                 context: str, allow_conflicts: bool = False,
                 smart_merge: bool = False) -> None:
    """
    Merge source dictionary into target dictionary.

    Args:
        target: Dictionary to merge into (modified in place)
        source: Dictionary to merge from
        context: Description of what's being merged (for error messages)
        allow_conflicts: Whether to allow overwriting existing keys
        smart_merge: Whether to attempt intelligent merging of conflicting objects

    Raises:
        MergeError: If there are conflicting keys and allow_conflicts is False
    """
    import json
    conflicts = []

    for key, value in source.items():
        if key in target:
            if not allow_conflicts:
                # Check if the values are actually different
                if target[key] != value:
                    # Try smart merging for parameter definitions
                    if smart_merge and _can_smart_merge(target[key], value):
                        target[key] = _smart_merge_parameters(target[key], value, f"{context}.{key}")
                        continue

                    # Format the conflicting values for detailed output
                    try:
                        existing_value = json.dumps(target[key], indent=2)
                        new_value = json.dumps(value, indent=2)
                    except (TypeError, ValueError):
                        # Fallback to string representation if JSON serialization fails
                        existing_value = str(target[key])
                        new_value = str(value)

                    conflict_detail = f"  - {key}:\n"
                    conflict_detail += f"    Existing value:\n{_indent_text(existing_value, 6)}\n"
                    conflict_detail += f"    Conflicting value:\n{_indent_text(new_value, 6)}"
                    conflicts.append(conflict_detail)
                # If values are identical, no conflict
            else:
                target[key] = value
        else:
            target[key] = value

    if conflicts:
        raise MergeError(f"Conflicts found while merging {context}:\n" + "\n".join(conflicts))


def _can_smart_merge(existing: Any, new: Any) -> bool:
    """
    Check if two values can be smart merged (both are dicts with similar structure).
    """
    if not isinstance(existing, dict) or not isinstance(new, dict):
        return False

    # Both should have core parameter fields
    core_fields = {'name', 'in', 'required', 'type', 'description'}
    existing_fields = set(existing.keys())
    new_fields = set(new.keys())

    # Check if both have core parameter structure
    if core_fields.issubset(existing_fields) and core_fields.issubset(new_fields):
        # Check if core fields match (only extensions should differ)
        for field in core_fields:
            if existing.get(field) != new.get(field):
                return False
        return True

    return False


def _smart_merge_parameters(existing: Dict[str, Any], new: Dict[str, Any], context: str) -> Dict[str, Any]:
    """
    Intelligently merge two parameter definitions by combining their properties.
    Keeps all properties from both, with new taking precedence for conflicts.
    """
    merged = existing.copy()

    # Add all properties from new, keeping track of what we're adding
    added_properties = []
    modified_properties = []

    for key, value in new.items():
        if key not in merged:
            merged[key] = value
            added_properties.append(key)
        elif merged[key] != value:
            # For conflicts in non-core fields, prefer the new value
            old_value = merged[key]
            merged[key] = value
            modified_properties.append(f"{key}: {old_value} -> {value}")

    # Log the merge operation
    log_merge_operation(
        operation_type="Smart Parameter Merge",
        context=context,
        details={
            "added_properties": added_properties,
            "modified_properties": modified_properties,
            "parameter_name": existing.get('name', 'unknown'),
            "merged_properties_count": len(merged)
        }
    )

    print(f"ℹ️  Smart merged {context}: Added properties {added_properties}")
    return merged
def merge_paths(swagger_files: Dict[str, Dict[str, Any]]) -> Dict[str, Any]:
    """
    Merge paths from searchservice, searchindex, and knowledgebase.

    Args:
        swagger_files: Dictionary containing the loaded Swagger files

    Returns:
        Merged paths dictionary

    Raises:
        MergeError: If there are conflicting path definitions
    """
    merged_paths = {}

    # Files that should contain paths (excluding common_types)
    path_sources = ['searchservice', 'searchindex', 'knowledgebase']

    for source_name in path_sources:
        if source_name not in swagger_files:
            continue

        source_swagger = swagger_files[source_name]
        source_paths = source_swagger.get('paths', {})

        if not isinstance(source_paths, dict):
            raise MergeError(f"Invalid paths section in {source_name}: expected object, got {type(source_paths).__name__}")

        if source_paths:  # Only merge if there are actually paths
            try:
                merge_objects(merged_paths, source_paths, f"paths from {source_name}")
            except MergeError as e:
                raise MergeError(f"Path conflicts between existing paths and {source_name}: {e}")

    return merged_paths


def merge_definitions(swagger_files: Dict[str, Dict[str, Any]]) -> Dict[str, Any]:
    """
    Merge definitions from all input files, including common_types.

    Args:
        swagger_files: Dictionary containing the loaded Swagger files

    Returns:
        Merged definitions dictionary

    Raises:
        MergeError: If there are conflicting definition names with different content
    """
    merged_definitions = {}

    # All files can contribute definitions
    all_sources = ['searchservice', 'searchindex', 'knowledgebase', 'common_types']

    for source_name in all_sources:
        if source_name not in swagger_files:
            continue

        source_swagger = swagger_files[source_name]
        source_definitions = source_swagger.get('definitions', {})

        if not isinstance(source_definitions, dict):
            raise MergeError(f"Invalid definitions section in {source_name}: expected object, got {type(source_definitions).__name__}")

        if source_definitions:  # Only merge if there are actually definitions
            try:
                merge_objects(merged_definitions, source_definitions, f"definitions from {source_name}")
            except MergeError as e:
                raise MergeError(f"Definition conflicts between existing definitions and {source_name}: {e}")

    return merged_definitions


def merge_top_level_fields(swagger_files: Dict[str, Dict[str, Any]],
                          merged_swagger: Dict[str, Any]) -> None:
    """
    Merge top-level fields from the first available source.

    For fields like 'swagger', 'info', 'schemes', 'consumes', 'produces', etc.,
    we take them from the first file that has them. These should be consistent
    across all files in a well-formed API specification.

    Args:
        swagger_files: Dictionary containing the loaded Swagger files
        merged_swagger: Target dictionary to populate (modified in place)
    """
    # Standard Swagger 2.0 top-level fields
    top_level_fields = [
        'swagger', 'info', 'host', 'basePath', 'schemes', 'consumes', 'produces',
        'securityDefinitions', 'security', 'tags', 'externalDocs'
    ]

    # Files to check for top-level fields (excluding common_types which is for definitions only)
    sources = ['searchservice', 'searchindex', 'knowledgebase']

    for field_name in top_level_fields:
        field_value = None
        source_file = None

        # Find the first file that has this field
        for source_name in sources:
            if source_name in swagger_files:
                source_swagger = swagger_files[source_name]
                if field_name in source_swagger:
                    field_value = source_swagger[field_name]
                    source_file = source_name
                    break

        if field_value is not None:
            # For array fields like schemes, consumes, produces, we might want to merge
            # but for now, following the guide, we just take the first one
            merged_swagger[field_name] = copy.deepcopy(field_value)


def merge_hand_authored_specs(swagger_files: Dict[str, Dict[str, Any]]) -> Dict[str, Any]:
    """
    Merge three hand-authored Swagger files plus common types into a single Swagger dictionary.

    This function implements the merging rules specified in equiv_impl_guide.md:
    - Combine paths from searchservice, searchindex, and knowledgebase
    - Combine definitions from all input files including common_types
    - Surface conflicts as explicit errors
    - Preserve all fields without canonicalization

    Args:
        swagger_files: Dictionary containing loaded Swagger files with keys:
            - 'searchservice': Hand-authored searchservice Swagger
            - 'searchindex': Hand-authored searchindex Swagger
            - 'knowledgebase': Hand-authored knowledgebase Swagger
            - 'common_types': Common types Swagger

    Returns:
        Single merged Swagger dictionary representing the complete hand-authored API surface

    Raises:
        MergeError: If there are conflicting definitions or paths
    """
    # Validate that we have the expected files
    expected_files = ['searchservice', 'searchindex', 'knowledgebase', 'common_types']
    missing_files = [f for f in expected_files if f not in swagger_files]
    if missing_files:
        raise MergeError(f"Missing required files for merging: {', '.join(missing_files)}")

    # Initialize the merged Swagger document
    merged_swagger = {}

    try:
        # Merge top-level fields first (swagger, info, etc.)
        merge_top_level_fields(swagger_files, merged_swagger)

        # Merge paths from the three main API files
        merged_paths = merge_paths(swagger_files)
        if merged_paths:
            merged_swagger['paths'] = merged_paths

        # Merge definitions from all files including common_types
        merged_definitions = merge_definitions(swagger_files)
        if merged_definitions:
            merged_swagger['definitions'] = merged_definitions

        # Merge other sections that might exist (parameters, responses, etc.)
        # These are less common but can exist in Swagger 2.0
        other_sections = ['parameters', 'responses']
        for section_name in other_sections:
            merged_section = {}
            sources = ['searchservice', 'searchindex', 'knowledgebase', 'common_types']

            for source_name in sources:
                if source_name in swagger_files:
                    source_swagger = swagger_files[source_name]
                    if section_name in source_swagger:
                        source_section = source_swagger[section_name]
                        if isinstance(source_section, dict) and source_section:
                            try:
                                # Use smart merging for parameters section
                                use_smart_merge = (section_name == 'parameters')
                                merge_objects(merged_section, source_section,
                                            f"{section_name} from {source_name}",
                                            smart_merge=use_smart_merge)
                            except MergeError as e:
                                raise MergeError(f"Conflicts in {section_name}: {e}")

            if merged_section:
                merged_swagger[section_name] = merged_section

        return merged_swagger

    except Exception as e:
        if isinstance(e, MergeError):
            raise
        else:
            raise MergeError(f"Unexpected error during merge: {e}")


def validate_merged_swagger(merged_swagger: Dict[str, Any]) -> None:
    """
    Validate the structure of the merged Swagger document.

    Args:
        merged_swagger: The merged Swagger dictionary to validate

    Raises:
        MergeError: If the merged document has invalid structure
    """
    # Basic validation that required fields are present
    required_fields = ['swagger', 'info']
    missing_fields = [f for f in required_fields if f not in merged_swagger]
    if missing_fields:
        raise MergeError(f"Merged Swagger missing required fields: {', '.join(missing_fields)}")

    # Validate that paths exist (API should have some endpoints)
    if 'paths' not in merged_swagger or not merged_swagger['paths']:
        raise MergeError("Merged Swagger has no paths - this suggests a merge error")

    # Validate paths structure
    paths = merged_swagger['paths']
    if not isinstance(paths, dict):
        raise MergeError(f"Merged paths must be an object, got {type(paths).__name__}")

    # Validate definitions structure if present
    if 'definitions' in merged_swagger:
        definitions = merged_swagger['definitions']
        if not isinstance(definitions, dict):
            raise MergeError(f"Merged definitions must be an object, got {type(definitions).__name__}")