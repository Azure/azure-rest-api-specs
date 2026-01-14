"""
Canonicalization module for swagger comparison.

This module implements canonicalization rules mirroring semantic_equiv:
- Remove documentation-only fields (description, summary, externalDocs, example, examples, x-ms-examples)
- Remove non-behavioral tags
- Normalize set-like arrays by deduplicating and sorting
- Normalize object key ordering for deterministic comparison

The goal is to remove fields that don't affect API runtime behavior while
preserving the exact API contract for comparison.
"""

import copy
from typing import Any, Dict, List, Set

# Fields to remove during canonicalization (mirroring semantic_equiv)
DOCUMENTATION_FIELDS = {"description", "summary", "externalDocs", "title"}
EXAMPLE_FIELDS = {"example", "examples", "x-ms-examples"}
TAG_FIELDS = {"tags"}
DOC_ONLY_VENDOR_EXTENSIONS = {"x-ms-summary"}

# Set-like arrays that should be deduplicated and sorted
SET_LIKE_ARRAYS = {"consumes", "produces", "schemes", "security"}


def should_remove_field(field_name: str) -> bool:
    """Determine if a field should be removed during canonicalization."""
    return (
        field_name in DOCUMENTATION_FIELDS
        or field_name in EXAMPLE_FIELDS
        or field_name in TAG_FIELDS
        or field_name in DOC_ONLY_VENDOR_EXTENSIONS
    )


def normalize_set_like_array(array_value: List[str]) -> List[str]:
    """Normalize set-like arrays by deduplicating and sorting."""
    if not isinstance(array_value, list):
        return array_value

    # Deduplicate and sort
    unique_items = sorted(set(str(item) for item in array_value))
    return unique_items


def canonicalize_object(obj: Dict[str, Any]) -> Dict[str, Any]:
    """
    Recursively canonicalize a dictionary object.

    Removes documentation fields and normalizes set-like arrays.
    Keys are sorted for deterministic ordering.
    """
    if not isinstance(obj, dict):
        return obj

    canonical = {}

    # Process fields in sorted order for determinism
    for key in sorted(obj.keys()):
        value = obj[key]

        # Skip fields that should be removed
        if should_remove_field(key):
            continue

        # Recursively canonicalize nested objects
        if isinstance(value, dict):
            canonical_value = canonicalize_object(value)
            if canonical_value:  # Only include non-empty objects
                canonical[key] = canonical_value

        elif isinstance(value, list):
            # Handle arrays - check if it's a set-like array
            if key in SET_LIKE_ARRAYS:
                canonical[key] = normalize_set_like_array(value)
            else:
                # Canonicalize each item but preserve order
                canonical_items = []
                for item in value:
                    if isinstance(item, dict):
                        canonical_item = canonicalize_object(item)
                        if canonical_item:
                            canonical_items.append(canonical_item)
                    else:
                        canonical_items.append(item)

                if canonical_items:
                    canonical[key] = canonical_items

        else:
            # Scalar values - include as-is
            canonical[key] = value

    return canonical


def canonicalize_swagger(swagger: Dict[str, Any]) -> Dict[str, Any]:
    """
    Canonicalize an entire swagger document.

    This is the main entry point that processes:
    - Top-level fields
    - Paths section
    - Definitions section
    - Parameters section
    - Responses section
    """
    canonical = {}

    # Process top-level fields
    for key in sorted(swagger.keys()):
        value = swagger[key]

        if should_remove_field(key):
            continue

        # Special handling for major sections
        if key == "paths":
            canonical[key] = canonicalize_paths(value)
        elif key == "definitions":
            canonical[key] = canonicalize_definitions(value)
        elif key == "parameters":
            canonical[key] = canonicalize_parameters(value)
        elif key == "responses":
            canonical[key] = canonicalize_responses(value)
        elif isinstance(value, dict):
            canonical_value = canonicalize_object(value)
            if canonical_value:
                canonical[key] = canonical_value
        elif isinstance(value, list):
            if key in SET_LIKE_ARRAYS:
                canonical[key] = normalize_set_like_array(value)
            else:
                canonical_items = [
                    canonicalize_object(item) if isinstance(item, dict) else item
                    for item in value
                ]
                if canonical_items:
                    canonical[key] = canonical_items
        else:
            canonical[key] = value

    return canonical


def canonicalize_paths(paths: Dict[str, Any]) -> Dict[str, Any]:
    """Canonicalize the paths section."""
    if not isinstance(paths, dict):
        return paths

    canonical_paths = {}

    for path_key in sorted(paths.keys()):
        path_obj = paths[path_key]

        if isinstance(path_obj, dict):
            canonical_path = {}

            # Process each HTTP method
            for method in sorted(path_obj.keys()):
                operation = path_obj[method]

                if isinstance(operation, dict):
                    canonical_operation = canonicalize_object(operation)
                    if canonical_operation:
                        canonical_path[method] = canonical_operation
                else:
                    if not should_remove_field(method):
                        canonical_path[method] = operation

            if canonical_path:
                canonical_paths[path_key] = canonical_path

    return canonical_paths


def canonicalize_definitions(definitions: Dict[str, Any]) -> Dict[str, Any]:
    """Canonicalize the definitions section."""
    if not isinstance(definitions, dict):
        return definitions

    canonical_defs = {}

    for def_name in sorted(definitions.keys()):
        definition = definitions[def_name]

        if isinstance(definition, dict):
            canonical_def = canonicalize_object(definition)
            if canonical_def:
                canonical_defs[def_name] = canonical_def

    return canonical_defs


def canonicalize_parameters(parameters: Dict[str, Any]) -> Dict[str, Any]:
    """Canonicalize the global parameters section."""
    if not isinstance(parameters, dict):
        return parameters

    canonical_params = {}

    for param_name in sorted(parameters.keys()):
        parameter = parameters[param_name]

        if isinstance(parameter, dict):
            canonical_param = canonicalize_object(parameter)
            if canonical_param:
                canonical_params[param_name] = canonical_param

    return canonical_params


def canonicalize_responses(responses: Dict[str, Any]) -> Dict[str, Any]:
    """Canonicalize the global responses section."""
    if not isinstance(responses, dict):
        return responses

    canonical_resps = {}

    for resp_name in sorted(responses.keys()):
        response = responses[resp_name]

        if isinstance(response, dict):
            canonical_resp = canonicalize_object(response)
            if canonical_resp:
                canonical_resps[resp_name] = canonical_resp

    return canonical_resps
