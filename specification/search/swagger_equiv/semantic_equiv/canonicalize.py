"""
Canonicalization module for the Swagger equivalency checker.

This module implements the canonicalization rules from equiv_contract.md:
- Remove documentation-only fields (description, summary, externalDocs, example, examples, x-ms-examples)
- Remove doc-only x-ms-* fields
- Remove non-behavioral tags
- Normalize set-like arrays by deduplicating and sorting
- Normalize object key ordering for deterministic comparison

The goal is to remove all fields that don't affect API runtime behavior while
preserving the exact API contract for strict comparison.
"""

import copy
from typing import Dict, Any, List, Set, Union


# Fields to remove during canonicalization according to equiv_contract.md section 2.1
DOCUMENTATION_FIELDS = {
    'description',
    'summary',
    'externalDocs'
}

# Example fields to remove according to equiv_contract.md section 2.2
EXAMPLE_FIELDS = {
    'example',
    'examples',
    'x-ms-examples'
}

# Tag fields to remove according to equiv_contract.md section 2.3
TAG_FIELDS = {
    'tags'  # Both top-level and per-operation tags
}

# Documentation-only vendor extensions according to equiv_contract.md section 2.4
DOC_ONLY_VENDOR_EXTENSIONS = {
    'x-ms-summary'
    # Note: "Other doc-only x-ms-* fields" - this set can be expanded as needed
}

# Set-like arrays that should be deduplicated and sorted according to section 2.5
SET_LIKE_ARRAYS = {
    'consumes',
    'produces',
    'schemes',
    'security'
    # Note: "Other set-like arrays as designated" - can be expanded
}


class CanonicalizationError(Exception):
    """Exception raised for canonicalization-related errors."""
    pass


def should_remove_field(field_name: str, field_value: Any) -> bool:
    """
    Determine if a field should be removed during canonicalization.

    Args:
        field_name: Name of the field to check
        field_value: Value of the field (unused but kept for potential future logic)

    Returns:
        True if the field should be removed, False otherwise
    """
    # Documentation fields
    if field_name in DOCUMENTATION_FIELDS:
        return True

    # Example fields
    if field_name in EXAMPLE_FIELDS:
        return True

    # Tag fields
    if field_name in TAG_FIELDS:
        return True

    # Documentation-only vendor extensions
    if field_name in DOC_ONLY_VENDOR_EXTENSIONS:
        return True

    return False


def normalize_set_like_array(array_value: List[str]) -> List[str]:
    """
    Normalize set-like arrays by deduplicating and sorting.

    Args:
        array_value: List of strings to normalize

    Returns:
        Deduplicated and sorted list
    """
    if not isinstance(array_value, list):
        return array_value

    # Deduplicate while preserving string type
    unique_items = list(set(str(item) for item in array_value))
    # Sort for deterministic ordering
    unique_items.sort()
    return unique_items


def canonicalize_object(obj: Dict[str, Any]) -> Dict[str, Any]:
    """
    Canonicalize a dictionary object by removing documentation fields
    and normalizing set-like arrays.

    Args:
        obj: Dictionary to canonicalize

    Returns:
        New canonicalized dictionary
    """
    if not isinstance(obj, dict):
        return obj

    canonical = {}

    # Process each field in deterministic order (sorted keys)
    for key in sorted(obj.keys()):
        value = obj[key]

        # Skip fields that should be removed
        if should_remove_field(key, value):
            continue

        # Recursively canonicalize nested objects
        if isinstance(value, dict):
            canonical_value = canonicalize_object(value)
            # Only include non-empty objects
            if canonical_value:
                canonical[key] = canonical_value
        elif isinstance(value, list):
            # Handle arrays - check if it's a set-like array
            if key in SET_LIKE_ARRAYS:
                canonical[key] = normalize_set_like_array(value)
            else:
                # For non-set-like arrays, canonicalize each item but preserve order
                canonical_items = []
                for item in value:
                    if isinstance(item, dict):
                        canonical_item = canonicalize_object(item)
                        if canonical_item:  # Only include non-empty objects
                            canonical_items.append(canonical_item)
                    else:
                        canonical_items.append(item)

                if canonical_items:  # Only include non-empty arrays
                    canonical[key] = canonical_items
        else:
            # For scalar values, include as-is
            canonical[key] = value

    return canonical


def canonicalize_paths(paths: Dict[str, Any]) -> Dict[str, Any]:
    """
    Canonicalize the paths section of a Swagger document.

    Args:
        paths: Paths dictionary from Swagger document

    Returns:
        Canonicalized paths dictionary
    """
    if not isinstance(paths, dict):
        return paths

    canonical_paths = {}

    # Process paths in deterministic order
    for path_key in sorted(paths.keys()):
        path_obj = paths[path_key]

        if isinstance(path_obj, dict):
            canonical_path = {}

            # Process each HTTP method in deterministic order
            for method in sorted(path_obj.keys()):
                operation = path_obj[method]

                if isinstance(operation, dict):
                    canonical_operation = canonicalize_object(operation)
                    if canonical_operation:
                        canonical_path[method] = canonical_operation
                else:
                    # Non-operation fields (like parameters at path level)
                    if not should_remove_field(method, operation):
                        canonical_path[method] = operation

            if canonical_path:
                canonical_paths[path_key] = canonical_path

    return canonical_paths


def canonicalize_definitions(definitions: Dict[str, Any]) -> Dict[str, Any]:
    """
    Canonicalize the definitions section of a Swagger document.

    Args:
        definitions: Definitions dictionary from Swagger document

    Returns:
        Canonicalized definitions dictionary
    """
    if not isinstance(definitions, dict):
        return definitions

    canonical_definitions = {}

    # Process definitions in deterministic order
    for def_name in sorted(definitions.keys()):
        definition = definitions[def_name]

        if isinstance(definition, dict):
            canonical_def = canonicalize_object(definition)
            if canonical_def:
                canonical_definitions[def_name] = canonical_def
        else:
            canonical_definitions[def_name] = definition

    return canonical_definitions


def canonicalize_swagger(swagger_dict: Dict[str, Any]) -> Dict[str, Any]:
    """
    Canonicalize a complete Swagger document according to equiv_contract.md rules.

    This function implements the canonicalization rules specified in section 2
    of equiv_contract.md:
    - Remove documentation-only fields
    - Remove example fields
    - Remove non-behavioral tags
    - Remove doc-only vendor extensions
    - Normalize set-like arrays by sorting and deduplicating
    - Ensure deterministic object key ordering

    Args:
        swagger_dict: Complete Swagger document as dictionary

    Returns:
        Canonicalized Swagger document containing only behavioral API contract fields

    Raises:
        CanonicalizationError: If canonicalization fails
    """
    try:
        # Deep copy to avoid modifying the original
        canonical = {}

        # Process top-level fields in deterministic order
        for key in sorted(swagger_dict.keys()):
            value = swagger_dict[key]

            # Skip fields that should be removed
            if should_remove_field(key, value):
                continue

            # Special handling for major sections
            if key == 'paths':
                canonical_value = canonicalize_paths(value)
                if canonical_value:
                    canonical[key] = canonical_value
            elif key == 'definitions':
                canonical_value = canonicalize_definitions(value)
                if canonical_value:
                    canonical[key] = canonical_value
            elif isinstance(value, dict):
                canonical_value = canonicalize_object(value)
                if canonical_value:
                    canonical[key] = canonical_value
            elif isinstance(value, list) and key in SET_LIKE_ARRAYS:
                canonical[key] = normalize_set_like_array(value)
            else:
                canonical[key] = value

        return canonical

    except Exception as e:
        raise CanonicalizationError(f"Failed to canonicalize Swagger document: {e}")


def canonicalize_both_specs(
    hand_authored_swagger: Dict[str, Any],
    typespec_swagger: Dict[str, Any]
) -> tuple[Dict[str, Any], Dict[str, Any]]:
    """
    Canonicalize both the hand-authored and TypeSpec-compiled Swagger documents.

    Args:
        hand_authored_swagger: Merged hand-authored Swagger document
        typespec_swagger: TypeSpec-compiled Swagger document

    Returns:
        Tuple of (canonicalized_hand_authored, canonicalized_typespec)

    Raises:
        CanonicalizationError: If canonicalization of either spec fails
    """
    try:
        canonical_hand_authored = canonicalize_swagger(hand_authored_swagger)
    except Exception as e:
        raise CanonicalizationError(f"Failed to canonicalize hand-authored spec: {e}")

    try:
        canonical_typespec = canonicalize_swagger(typespec_swagger)
    except Exception as e:
        raise CanonicalizationError(f"Failed to canonicalize TypeSpec-compiled spec: {e}")

    return canonical_hand_authored, canonical_typespec