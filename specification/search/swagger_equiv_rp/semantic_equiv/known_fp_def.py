"""
Known false positive definitions for Swagger equivalency checker.

This module contains a list of definition names and their mappings that are known
to produce false positive differences during ARM API comparison. These are typically:
- Renamed definitions between hand-authored and TypeSpec-compiled specs
- Inline vs reference differences that are semantically equivalent
- Type system differences that don't affect the actual API contract

This list should be updated based on actual comparison results for resource-manager specs.
"""

KNOWN_FALSE_POSITIVE_DEFINITIONS = [
    # Add ARM-specific false positive definitions here as they are discovered
    # Examples:
    # "ErrorResponse",
    # "Resource",
    # "ProxyResource",
]
