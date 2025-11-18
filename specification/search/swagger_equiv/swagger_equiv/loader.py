"""
File loading module for the Swagger equivalency checker.

Handles loading and parsing JSON files with clear error handling.
According to equiv_impl_guide.md, this module is responsible for raw loading
without any canonicalization or semantic checks.
"""

import json
import os
from typing import Dict, Any


class LoaderError(Exception):
    """Exception raised for file loading and parsing errors."""
    pass


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