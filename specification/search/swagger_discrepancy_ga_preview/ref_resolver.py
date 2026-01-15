"""
Reference resolution module for swagger schemas.

This module provides utilities to resolve $ref references in swagger/OpenAPI schemas
and normalize schemas for comparison. It handles:
- Local references: #/definitions/... and #/components/schemas/...
- Transitive resolution: ref -> ref -> actual schema
- Cycle detection and max depth limits
- Schema normalization for shape-based comparison
"""

import copy
from typing import Any, Dict, Optional, Set, Tuple


class RefResolver:
    """Resolves $ref references in swagger schemas."""

    def __init__(self, swagger_doc: Dict[str, Any], max_depth: int = 10):
        """
        Initialize the resolver.

        Args:
            swagger_doc: The complete swagger document
            max_depth: Maximum depth for resolving nested refs (default: 10)
        """
        self.swagger_doc = swagger_doc
        self.max_depth = max_depth

    def resolve_ref(
        self,
        schema: Optional[Dict[str, Any]],
        depth: int = 0,
        visited: Optional[Set[str]] = None,
    ) -> Optional[Dict[str, Any]]:
        """
        Resolve a schema that may contain $ref references.

        Args:
            schema: The schema to resolve (may contain $ref)
            depth: Current recursion depth
            visited: Set of visited $ref paths (for cycle detection)

        Returns:
            Resolved schema with $ref replaced by actual definition
            Returns None if schema is None
        """
        if schema is None:
            return None

        if visited is None:
            visited = set()

        # Check depth limit
        if depth > self.max_depth:
            # Return unresolved schema to avoid infinite recursion
            return schema

        # If no $ref, return as-is
        ref_path = schema.get("$ref")
        if not ref_path:
            return schema

        # Check for cycles
        if ref_path in visited:
            # Cycle detected - return a marker
            return {"type": "object", "_cycle_detected": ref_path}

        visited.add(ref_path)

        # Resolve the reference
        resolved = self._lookup_ref(ref_path)
        if resolved is None:
            # Reference not found, return original
            return schema

        # Make a copy to avoid modifying the original
        resolved = copy.deepcopy(resolved)

        # Merge properties from the referencing schema (except $ref itself)
        # This handles cases like: {"$ref": "...", "readOnly": true}
        for key, value in schema.items():
            if key != "$ref" and key not in resolved:
                resolved[key] = value

        # Recursively resolve nested refs
        if "$ref" in resolved:
            resolved = self.resolve_ref(resolved, depth + 1, visited)

        return resolved

    def _lookup_ref(self, ref_path: str) -> Optional[Dict[str, Any]]:
        """
        Look up a reference path in the swagger document.

        Supports:
        - #/definitions/ModelName (Swagger 2.0)
        - #/components/schemas/ModelName (OpenAPI 3.0)

        Args:
            ref_path: The $ref path (e.g., "#/definitions/FacetResult")

        Returns:
            The referenced schema, or None if not found
        """
        if not ref_path.startswith("#/"):
            # External refs not supported
            return None

        # Remove leading "#/"
        path = ref_path[2:]
        parts = path.split("/")

        # Navigate through the document
        current = self.swagger_doc
        for part in parts:
            if isinstance(current, dict) and part in current:
                current = current[part]
            else:
                return None

        return current if isinstance(current, dict) else None


def normalize_schema(schema: Optional[Dict[str, Any]]) -> Optional[Dict[str, Any]]:
    """
    Normalize a resolved schema for shape-based comparison.

    Keeps only the structural/behavioral properties:
    - type, format
    - properties, required, additionalProperties
    - items (for arrays)
    - enum
    - allOf, oneOf, anyOf

    Removes cosmetic/documentation properties:
    - description, title, example
    - readOnly, writeOnly (these don't change the shape)
    - x-ms-* extensions (unless they affect behavior)

    Args:
        schema: The schema to normalize (should be already resolved)

    Returns:
        Normalized schema containing only structural properties
    """
    if schema is None:
        return None

    if not isinstance(schema, dict):
        return schema

    # Fields that define the schema "shape"
    shape_fields = {
        "type",
        "format",
        "properties",
        "required",
        "additionalProperties",
        "items",
        "enum",
        "allOf",
        "oneOf",
        "anyOf",
        "minimum",
        "maximum",
        "minLength",
        "maxLength",
        "minItems",
        "maxItems",
        "pattern",
        "uniqueItems",
        "multipleOf",
        "discriminator",
        # Note: $ref should already be resolved, but keep it just in case
        "$ref",
        "_cycle_detected",  # Marker for cycles
    }

    normalized = {}

    for key, value in schema.items():
        if key not in shape_fields:
            continue

        # Recursively normalize nested schemas
        if key == "properties" and isinstance(value, dict):
            normalized[key] = {
                prop_name: normalize_schema(prop_schema)
                for prop_name, prop_schema in value.items()
            }
        elif key == "items" and isinstance(value, dict):
            normalized[key] = normalize_schema(value)
        elif key == "additionalProperties" and isinstance(value, dict):
            normalized[key] = normalize_schema(value)
        elif key in ["allOf", "oneOf", "anyOf"] and isinstance(value, list):
            normalized[key] = [
                normalize_schema(item) if isinstance(item, dict) else item
                for item in value
            ]
        else:
            normalized[key] = value

    return normalized if normalized else None


def schemas_equivalent(
    schema1: Optional[Dict[str, Any]],
    schema2: Optional[Dict[str, Any]],
    swagger1: Dict[str, Any],
    swagger2: Dict[str, Any],
) -> Tuple[bool, Optional[str]]:
    """
    Check if two schemas are equivalent after resolving refs and normalizing.

    Args:
        schema1: First schema (may contain $ref)
        schema2: Second schema (may contain $ref)
        swagger1: Complete swagger document containing schema1
        swagger2: Complete swagger document containing schema2

    Returns:
        Tuple of (are_equivalent, difference_message)
        - are_equivalent: True if schemas have the same shape
        - difference_message: None if equivalent, otherwise a description of the difference
    """
    # Resolve refs
    resolver1 = RefResolver(swagger1)
    resolver2 = RefResolver(swagger2)

    resolved1 = resolver1.resolve_ref(schema1)
    resolved2 = resolver2.resolve_ref(schema2)

    # Normalize for comparison
    norm1 = normalize_schema(resolved1)
    norm2 = normalize_schema(resolved2)

    # Compare normalized schemas
    if norm1 == norm2:
        return True, None

    # Not equivalent - try to provide a helpful message
    if norm1 is None and norm2 is None:
        return True, None
    elif norm1 is None:
        return False, "Schema removed"
    elif norm2 is None:
        return False, "Schema added"

    # Check specific differences
    type1 = norm1.get("type") if isinstance(norm1, dict) else None
    type2 = norm2.get("type") if isinstance(norm2, dict) else None

    if type1 != type2:
        return False, f"Type changed: {type1} -> {type2}"

    # If same type but different structure, provide generic message
    return False, "Schema structure differs"
