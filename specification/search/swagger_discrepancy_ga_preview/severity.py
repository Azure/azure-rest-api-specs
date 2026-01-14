"""
Severity classification module.

Classifies differences between GA and Preview as:
- breaking: Changes that break existing clients (removed operations/parameters, stricter constraints)
- non-breaking: Additions or relaxations (new operations/parameters, optional parameters)
- unknown: Changes requiring manual review
"""

from enum import Enum
from typing import Set


class SeverityLevel(Enum):
    """Severity levels for differences."""

    BREAKING = "breaking"
    NON_BREAKING = "non-breaking"
    UNKNOWN = "unknown"


# Difference types that are definitely breaking
BREAKING_TYPES: Set[str] = {
    "missing_path",  # Removed path
    "missing_method",  # Removed HTTP method
    "missing_parameter",  # Removed parameter (especially if required)
    "missing_response",  # Removed response code
    "missing_definition",  # Removed schema/model
    "parameter_required_changed",  # Making parameter required (when changed from False to True)
    "schema_type_changed",  # Type changes are usually breaking
    "schema_required_added",  # Adding required fields is breaking
    "schema_properties_removed",  # Removing properties is breaking
}


# Difference types that are non-breaking additions
NON_BREAKING_TYPES: Set[str] = {
    "extra_path",  # New path
    "extra_method",  # New HTTP method
    "extra_parameter",  # New parameter (if optional)
    "extra_response",  # New response code
    "extra_definition",  # New schema/model
    "schema_properties_added",  # Adding optional properties
    "schema_required_removed",  # Making fields optional
}


# Difference types requiring manual review
UNKNOWN_TYPES: Set[str] = {
    "operation_id_mismatch",
    "parameter_type_changed",
    "parameter_format_changed",
    "schema_format_changed",
    "schema_ref_changed",
    "schema_inline_to_ref",  # Converting inline to ref needs review
    "schema_ref_to_inline",  # Converting ref to inline needs review
    "schema_presence_changed",
    "consumes_changed",
    "produces_changed",
}


def classify_severity(diff_type: str, message: str, context: str) -> str:
    """
    Classify the severity of a difference.

    Args:
        diff_type: Type of difference
        message: Detailed message
        context: Context information

    Returns:
        Severity level: 'breaking', 'non-breaking', or 'unknown'
    """
    # Check for explicit breaking changes
    if diff_type in BREAKING_TYPES:
        # Special case: extra parameter is non-breaking if optional
        if diff_type == "missing_parameter":
            return SeverityLevel.BREAKING.value

        # Special case: parameter_required_changed
        if diff_type == "parameter_required_changed":
            # Making required = True is breaking, False is non-breaking
            if "False -> True" in message:
                return SeverityLevel.BREAKING.value
            elif "True -> False" in message:
                return SeverityLevel.NON_BREAKING.value

        return SeverityLevel.BREAKING.value

    # Check for non-breaking additions
    if diff_type in NON_BREAKING_TYPES:
        # Special case: extra parameter is breaking if required
        if diff_type == "extra_parameter":
            if "required: True" in message:
                return SeverityLevel.BREAKING.value
            return SeverityLevel.NON_BREAKING.value

        return SeverityLevel.NON_BREAKING.value

    # Everything else requires manual review
    return SeverityLevel.UNKNOWN.value
