"""
Canonicalization module for the Swagger equivalency checker.

This module implements the canonicalization rules from doc/equiv_contract.md:
- Remove documentation-only fields (description, summary, externalDocs, example, examples, x-ms-examples)
- Remove doc-only x-ms-* fields
- Remove non-behavioral tags
- Normalize set-like arrays by deduplicating and sorting
- Normalize object key ordering for deterministic comparison

The goal is to remove all fields that don't affect API runtime behavior while
preserving the exact API contract for strict comparison.
"""

import copy
from pathlib import Path
from typing import Any, Dict, List, Optional, Set, Union

# Fields to remove during canonicalization according to doc/equiv_contract.md section 2.1
DOCUMENTATION_FIELDS = {"description", "summary", "externalDocs"}

# Example fields to remove according to doc/equiv_contract.md section 2.2
EXAMPLE_FIELDS = {"example", "examples", "x-ms-examples"}

# Tag fields to remove according to doc/equiv_contract.md section 2.3
TAG_FIELDS = {
    "tags"  # Both top-level and per-operation tags
}

# Documentation-only vendor extensions according to doc/equiv_contract.md section 2.4
DOC_ONLY_VENDOR_EXTENSIONS = {
    "x-ms-summary"
    # Note: "Other doc-only x-ms-* fields" - this set can be expanded as needed
}

# Set-like arrays that should be deduplicated and sorted according to section 2.5
SET_LIKE_ARRAYS = {
    "consumes",
    "produces",
    "schemes",
    "security",
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
    # Preserve source tracking field
    if field_name == "_swagger_source":
        return False

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


def resolve_global_parameters(swagger_dict: Dict[str, Any]) -> Dict[str, Any]:
    """
    Resolve all global parameter references ($ref to #/parameters/...) by inlining them.

    This is necessary for ARM specs where hand-authored swaggers use global parameters
    (ApiVersionParameter, SubscriptionIdParameter, etc.) but TSP inlines all parameters.

    Args:
        swagger_dict: Swagger document that may contain global parameter references

    Returns:
        Swagger document with all parameter $refs resolved to inline parameters
    """
    # Deep copy to avoid modifying the original
    resolved = copy.deepcopy(swagger_dict)

    # Get global parameters if they exist
    global_params = resolved.get("parameters", {})
    if not global_params or not isinstance(global_params, dict):
        return resolved  # No global parameters to resolve

    # Helper function to resolve a single parameter reference
    def resolve_param_ref(param: Any) -> Any:
        if not isinstance(param, dict):
            return param

        # Check if this is a $ref to a global parameter
        ref = param.get("$ref", "")
        if ref.startswith("#/parameters/"):
            param_name = ref.split("/")[-1]
            if param_name in global_params:
                # Return a deep copy of the global parameter definition
                return copy.deepcopy(global_params[param_name])

        return param

    # Resolve parameters in all operations
    if "paths" in resolved and isinstance(resolved["paths"], dict):
        for path_key, path_obj in resolved["paths"].items():
            if not isinstance(path_obj, dict):
                continue

            # Resolve path-level parameters
            if "parameters" in path_obj and isinstance(path_obj["parameters"], list):
                path_obj["parameters"] = [
                    resolve_param_ref(p) for p in path_obj["parameters"]
                ]

            # Resolve operation-level parameters for each HTTP method
            for method in ["get", "post", "put", "delete", "patch", "head", "options"]:
                if method in path_obj and isinstance(path_obj[method], dict):
                    operation = path_obj[method]
                    if "parameters" in operation and isinstance(operation["parameters"], list):
                        operation["parameters"] = [
                            resolve_param_ref(p) for p in operation["parameters"]
                        ]

    return resolved


def resolve_external_common_types_refs(
    swagger_dict: Dict[str, Any], swagger_file_path: Optional[Path] = None
) -> Dict[str, Any]:
    """
    Resolve external common-types parameter/definition references to inline definitions.

    This handles TSP-compiled specs that reference external common-types files like:
    ../../../../../../common-types/resource-management/v6/types.json#/parameters/ApiVersionParameter

    For comparison with hand-authored specs that use local refs like:
    #/parameters/ApiVersionParameter

    Args:
        swagger_dict: Swagger document that may contain external common-types references
        swagger_file_path: Path to the swagger file (needed to resolve relative paths)

    Returns:
        Swagger document with external common-types refs resolved to inline definitions
    """
    # Deep copy to avoid modifying the original
    resolved = copy.deepcopy(swagger_dict)

    # Cache for loaded common-types files to avoid re-reading
    common_types_cache: Dict[str, Dict[str, Any]] = {}

    def load_common_types_file(ref_path: str) -> Optional[Dict[str, Any]]:
        """Load a common-types file and cache it."""
        # Use just the file path (before #) as cache key
        file_path_only = ref_path.split("#")[0]

        if file_path_only in common_types_cache:
            return common_types_cache[file_path_only]

        if not swagger_file_path:
            return None

        try:
            # Resolve the relative path
            common_types_file = swagger_file_path.parent / file_path_only
            if common_types_file.exists():
                import json

                with open(common_types_file, "r", encoding="utf-8") as f:
                    content = json.load(f)
                    common_types_cache[file_path_only] = content
                    return content
        except Exception as e:
            print(f"Warning: Failed to load common-types file {ref_path}: {e}")

        return None

    def resolve_ref(ref_obj: Any, context: str = "", depth: int = 0, visited_path: Set[str] = None) -> Any:
        """
        Resolve a single $ref, handling both local and external common-types refs.
        Recursively resolves nested refs within the resolved object.

        Args:
            ref_obj: Object that may contain a $ref field
            context: Context for debugging (parameter/definition)
            depth: Current recursion depth to prevent infinite loops
            visited_path: Set of refs in current resolution path (for circular detection)

        Returns:
            Resolved object with $ref inlined and nested refs resolved
        """
        if not isinstance(ref_obj, dict):
            return ref_obj

        ref = ref_obj.get("$ref", "")
        if not ref:
            # No $ref, but still need to recursively resolve any nested refs
            return walk_and_resolve(ref_obj, context, depth, visited_path)

        # Initialize visited path if not provided
        if visited_path is None:
            visited_path = set()

        # Prevent infinite recursion with circular refs
        if depth > 100:
            print(f"Warning: Maximum recursion depth reached resolving {ref}")
            return {"$circular_ref": ref}

        # Check if this ref is already in our current resolution path (circular)
        if ref in visited_path:
            return {"$circular_ref": ref}

        # Add to visited path for this resolution chain
        visited_path = visited_path | {ref}

        resolved_obj = None

        # Handle external common-types references (v5, v6, etc.)
        if "common-types/resource-management/" in ref:
            # Extract file path and fragment
            parts = ref.split("#")
            if len(parts) == 2:
                file_path, fragment = parts
                # Load the common-types file
                common_types_doc = load_common_types_file(file_path)
                if common_types_doc:
                    # Navigate to the referenced definition
                    # Fragment is like /parameters/ApiVersionParameter or /definitions/ErrorResponse
                    fragment_parts = fragment.lstrip("/").split("/")
                    if len(fragment_parts) >= 2:
                        section = fragment_parts[0]  # "parameters" or "definitions"
                        name = fragment_parts[1]

                        if section in common_types_doc and name in common_types_doc[section]:
                            # Get a deep copy of the referenced definition
                            resolved_obj = copy.deepcopy(common_types_doc[section][name])

        # Handle local references to definitions in the same file
        elif ref.startswith("#/definitions/"):
            def_name = ref.split("/")[-1]
            if "definitions" in resolved and def_name in resolved["definitions"]:
                resolved_obj = copy.deepcopy(resolved["definitions"][def_name])

        # Handle local references to parameters
        elif ref.startswith("#/parameters/"):
            param_name = ref.split("/")[-1]
            if "parameters" in resolved and param_name in resolved["parameters"]:
                resolved_obj = copy.deepcopy(resolved["parameters"][param_name])

        # If we resolved the ref, recursively resolve any nested refs within it
        if resolved_obj is not None:
            # Merge any additional properties from ref_obj (beyond $ref)
            for key, value in ref_obj.items():
                if key != "$ref" and key not in resolved_obj:
                    resolved_obj[key] = value

            # Recursively resolve nested refs in the resolved object with updated path
            return walk_and_resolve(resolved_obj, f"{context}→{ref}", depth + 1, visited_path)

        # If we couldn't resolve, return the ref as-is
        return ref_obj

    def walk_and_resolve(obj: Any, context: str = "", depth: int = 0, visited_path: Set[str] = None) -> Any:
        """Recursively walk the swagger document and resolve all refs."""
        if isinstance(obj, dict):
            # Check if this dict has a $ref
            if "$ref" in obj:
                return resolve_ref(obj, context, depth, visited_path)

            # Recursively process all fields
            result = {}
            for key, value in obj.items():
                result[key] = walk_and_resolve(value, f"{context}.{key}", depth, visited_path)
            return result

        elif isinstance(obj, list):
            return [walk_and_resolve(item, f"{context}[]", depth, visited_path) for item in obj]

        else:
            return obj

    # Walk the entire document and resolve refs
    resolved = walk_and_resolve(resolved)

    return resolved


def canonicalize_swagger(
    swagger_dict: Dict[str, Any], swagger_file_path: Optional[Path] = None
) -> Dict[str, Any]:
    """
    Canonicalize a complete Swagger document according to doc/equiv_contract.md rules.

    This function implements the canonicalization rules specified in section 2
    of doc/equiv_contract.md:
    - Resolve global parameter references (ARM pattern) to inline parameters first
    - Resolve external common-types references (TSP pattern) to inline definitions
    - Remove documentation-only fields
    - Remove example fields
    - Remove non-behavioral tags
    - Remove doc-only vendor extensions
    - Normalize set-like arrays by sorting and deduplicating
    - Ensure deterministic object key ordering

    Args:
        swagger_dict: Complete Swagger document as dictionary
        swagger_file_path: Path to swagger file (needed for resolving external refs)

    Returns:
        Canonicalized Swagger document containing only behavioral API contract fields

    Raises:
        CanonicalizationError: If canonicalization fails
    """
    try:
        # STEP 1: Resolve external common-types references
        # This must happen first to inline external parameter/definition refs
        # used by TSP-compiled specs
        resolved = resolve_external_common_types_refs(swagger_dict, swagger_file_path)

        # STEP 2: Resolve global parameter references to inline parameters
        # This is critical for ARM specs where hand-authored uses global params
        # but TSP inlines all parameters
        resolved = resolve_global_parameters(resolved)

        # STEP 3: Canonicalize the resolved document
        canonical = {}

        # Process top-level fields in deterministic order
        for key in sorted(resolved.keys()):
            value = resolved[key]

            # Skip fields that should be removed
            if should_remove_field(key, value):
                continue

            # Skip the global parameters section - we've already inlined them
            if key == "parameters":
                continue

            # Special handling for major sections
            if key == "paths":
                canonical_value = canonicalize_paths(value)
                if canonical_value:
                    canonical[key] = canonical_value
            elif key == "definitions":
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
    typespec_swagger: Dict[str, Any],
    hand_authored_path: Optional[Path] = None,
    typespec_path: Optional[Path] = None,
) -> tuple[Dict[str, Any], Dict[str, Any]]:
    """
    Canonicalize both the hand-authored and TypeSpec-compiled Swagger documents.

    Args:
        hand_authored_swagger: Merged hand-authored Swagger document
        typespec_swagger: TypeSpec-compiled Swagger document
        hand_authored_path: Path to hand-authored swagger file (for resolving refs)
        typespec_path: Path to TypeSpec swagger file (for resolving refs)

    Returns:
        Tuple of (canonicalized_hand_authored, canonicalized_typespec)

    Raises:
        CanonicalizationError: If canonicalization of either spec fails
    """
    try:
        canonical_hand_authored = canonicalize_swagger(
            hand_authored_swagger, hand_authored_path
        )
    except Exception as e:
        raise CanonicalizationError(f"Failed to canonicalize hand-authored spec: {e}")

    try:
        canonical_typespec = canonicalize_swagger(typespec_swagger, typespec_path)
    except Exception as e:
        raise CanonicalizationError(
            f"Failed to canonicalize TypeSpec-compiled spec: {e}"
        )

    return canonical_hand_authored, canonical_typespec
