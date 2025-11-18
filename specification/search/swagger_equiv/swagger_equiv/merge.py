"""
Merge module for combining hand-authored Swagger specifications.

According to equiv_impl_guide.md, this module is responsible for merging
three hand-authored Swagger dictionaries (plus common types) into a single
Swagger dictionary representing the original API surface.

Rules from equiv_impl_guide.md:
- Combine 'paths' from searchservice, searchindex, and knowledgebase into single paths object
- Combine 'definitions' from all input files, including common_types, into single definitions object
- Surface conflicts as explicit errors (not expected in clean migration scenario)
- Do not remove any fields here; leave canonicalization to canonicalize.py
"""

import copy
from typing import Dict, Any, List, Tuple


class MergeError(Exception):
    """Exception raised for merge-related errors."""
    pass


def merge_objects(target: Dict[str, Any], source: Dict[str, Any],
                 context: str, allow_conflicts: bool = False) -> None:
    """
    Merge source dictionary into target dictionary.

    Args:
        target: Dictionary to merge into (modified in place)
        source: Dictionary to merge from
        context: Description of what's being merged (for error messages)
        allow_conflicts: Whether to allow overwriting existing keys

    Raises:
        MergeError: If there are conflicting keys and allow_conflicts is False
    """
    conflicts = []

    for key, value in source.items():
        if key in target:
            if not allow_conflicts:
                # Check if the values are actually different
                if target[key] != value:
                    conflicts.append(f"  - {key}: different values found")
                # If values are identical, no conflict
            else:
                target[key] = value
        else:
            target[key] = value

    if conflicts:
        raise MergeError(f"Conflicts found while merging {context}:\n" + "\n".join(conflicts))


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
                                merge_objects(merged_section, source_section,
                                            f"{section_name} from {source_name}")
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