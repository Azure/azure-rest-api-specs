"""
False Positive Filter for Swagger Equivalency Checker.

This module provides functionality to filter out known false positive differences
from the comparison results. False positives are differences that are expected
and don't indicate actual semantic differences between the APIs.
"""

import re
from dataclasses import dataclass
from typing import Any, Callable, Dict, List, Optional, Set

from compare import Difference, DifferenceType


@dataclass
class FalsePositiveRule:
    """
    Represents a rule for identifying false positive differences.

    Attributes:
        name: Human-readable name for the rule
        description: Description of what this rule filters
        matcher: Function that returns True if a difference matches this rule
        enabled: Whether this rule is active
    """

    name: str
    description: str
    matcher: Callable[[Difference], bool]
    enabled: bool = True


class FalsePositiveFilter:
    """
    Manages and applies false positive filtering rules to comparison results.
    """

    def __init__(self):
        """Initialize the filter with default rules."""
        self.rules: List[FalsePositiveRule] = []
        self._init_default_rules()

    def _init_default_rules(self) -> None:
        """Initialize the default set of false positive rules."""

        # Parameter-related rules
        self.add_rule(
            FalsePositiveRule(
                name="api_version_min_length",
                description="Ignore min_length constraint differences on api-version parameter",
                matcher=self._match_api_version_min_length,
            )
        )

        self.add_rule(
            FalsePositiveRule(
                name="path_parameter_extra_in_tsp",
                description="Ignore extra path parameters in TypeSpec (indexName, knowledgeBaseName, etc.)",
                matcher=self._match_path_parameter_extra_in_tsp,
            )
        )

        # Global parameter mapping rules
        self.add_rule(
            FalsePositiveRule(
                name="global_parameter_azure_core_mapping",
                description="Ignore global parameter name differences for Azure.Core mappings",
                matcher=self._match_global_parameter_azure_core_mapping,
            )
        )

        # Response-related rules
        self.add_rule(
            FalsePositiveRule(
                name="error_response_common_types_ref",
                description="Ignore ErrorResponse reference differences (common-types vs local)",
                matcher=self._match_error_response_common_types,
            )
        )

        self.add_rule(
            FalsePositiveRule(
                name="service_statistics_schema_name",
                description="Ignore ServiceStatistics vs SearchServiceStatistics naming differences",
                matcher=self._match_service_statistics_schema_name,
            )
        )

        # Add more rules as needed
        self.add_rule(
            FalsePositiveRule(
                name="definition_name_prefix_search",
                description="Ignore definition name differences with Search prefix",
                matcher=self._match_definition_name_prefix,
            )
        )

        # Missing global parameters that are known to be in hand-authored but not TypeSpec
        self.add_rule(
            FalsePositiveRule(
                name="missing_global_parameters",
                description="Ignore known missing global parameters in TypeSpec",
                matcher=self._match_missing_global_parameters,
            )
        )

        # Body parameter schema mismatches for specific operations
        self.add_rule(
            FalsePositiveRule(
                name="body_parameter_schema_mismatch",
                description="Ignore known body parameter schema mismatches",
                matcher=self._match_body_parameter_schema_mismatch,
            )
        )

        # Body parameter naming differences (generic "body" vs specific request names)
        self.add_rule(
            FalsePositiveRule(
                name="body_parameter_naming_differences",
                description="Ignore body parameter naming differences (body vs *Request)",
                matcher=self._match_body_parameter_naming,
            )
        )

        # x-nullable: false vs missing x-nullable (they are equivalent in OpenAPI 2.0)
        self.add_rule(
            FalsePositiveRule(
                name="x_nullable_false_vs_missing",
                description="Ignore x-nullable: false vs missing x-nullable (both mean not nullable)",
                matcher=self._match_x_nullable_false_vs_missing,
            )
        )

    def add_rule(self, rule: FalsePositiveRule) -> None:
        """
        Add a false positive rule to the filter.

        Args:
            rule: The rule to add
        """
        self.rules.append(rule)

    def remove_rule(self, rule_name: str) -> bool:
        """
        Remove a rule by name.

        Args:
            rule_name: Name of the rule to remove

        Returns:
            True if rule was removed, False if not found
        """
        initial_count = len(self.rules)
        self.rules = [r for r in self.rules if r.name != rule_name]
        return len(self.rules) < initial_count

    def enable_rule(self, rule_name: str) -> bool:
        """
        Enable a rule by name.

        Args:
            rule_name: Name of the rule to enable

        Returns:
            True if rule was found and enabled
        """
        for rule in self.rules:
            if rule.name == rule_name:
                rule.enabled = True
                return True
        return False

    def disable_rule(self, rule_name: str) -> bool:
        """
        Disable a rule by name.

        Args:
            rule_name: Name of the rule to disable

        Returns:
            True if rule was found and disabled
        """
        for rule in self.rules:
            if rule.name == rule_name:
                rule.enabled = False
                return True
        return False

    def filter_differences(
        self, differences: List[Difference], return_filtered_out: bool = False
    ) -> tuple[List[Difference], List[Difference]]:
        """
        Filter out false positive differences from a list.

        Args:
            differences: List of differences to filter
            return_filtered_out: If True, also return the filtered differences

        Returns:
            Tuple of (remaining_differences, filtered_out_differences)
            If return_filtered_out is False, second element will be empty list
        """
        remaining = []
        filtered_out = []

        for diff in differences:
            if self._is_false_positive(diff):
                filtered_out.append(diff)
            else:
                remaining.append(diff)

        if return_filtered_out:
            return remaining, filtered_out
        return remaining, []

    def _is_false_positive(self, difference: Difference) -> bool:
        """
        Check if a difference matches any false positive rule.

        Args:
            difference: The difference to check

        Returns:
            True if the difference is a false positive
        """
        for rule in self.rules:
            if rule.enabled and rule.matcher(difference):
                return True
        return False

    def get_statistics(self, differences: List[Difference]) -> Dict[str, int]:
        """
        Get statistics about which rules would filter which differences.

        Args:
            differences: List of differences to analyze

        Returns:
            Dictionary mapping rule names to count of differences they would filter
        """
        stats = {rule.name: 0 for rule in self.rules if rule.enabled}

        for diff in differences:
            for rule in self.rules:
                if rule.enabled and rule.matcher(diff):
                    stats[rule.name] += 1
                    break  # Count each difference only once

        return stats

    # Matcher methods for specific false positive patterns

    def _match_api_version_min_length(self, diff: Difference) -> bool:
        """Match api-version parameter min_length constraint differences."""
        if diff.type != DifferenceType.PARAMETER_MISMATCH:
            return False

        # Check if message is about api-version and min_length
        if (
            "api-version" in diff.message.lower()
            and "min_length" in diff.message.lower()
        ):
            return True

        # Check context for api-version parameter
        if diff.context and "api-version" in diff.context.lower():
            if (
                "min_length" in diff.message.lower()
                or "constraints" in diff.message.lower()
            ):
                return True

        return False

    def _match_path_parameter_extra_in_tsp(self, diff: Difference) -> bool:
        """Match extra path parameters in TypeSpec that are known."""
        if diff.type != DifferenceType.EXTRA_PARAMETER:
            return False

        # Known path parameter names that appear as "extra" in TypeSpec
        known_path_params = {
            "indexName",
            "indexname",
            "knowledgeBaseName",
            "knowledgebasename",
            "dataSourceName",
            "datasourcename",
            "indexerName",
            "indexername",
            "skillsetName",
            "skillsetname",
            "synonymMapName",
            "synonymmapname",
            "aliasName",
            "aliasname",
            "sourceName",
            "sourcename",
        }

        # Check if the message indicates a path parameter
        if ", path" in diff.message.lower() or "in: path" in diff.message.lower():
            # Extract parameter name from message
            for param_name in known_path_params:
                if param_name.lower() in diff.message.lower():
                    return True

        return False

    def _match_global_parameter_azure_core_mapping(self, diff: Difference) -> bool:
        """Match global parameter differences that are Azure.Core mappings."""
        if diff.type not in [
            DifferenceType.MISSING_GLOBAL_PARAMETER,
            DifferenceType.EXTRA_GLOBAL_PARAMETER,
            DifferenceType.GLOBAL_PARAMETER_MISMATCH,
        ]:
            return False

        # Known Azure.Core global parameter mappings
        mappings = {
            ("ApiVersionParameter", "Azure.Core.Foundations.ApiVersionParameter"),
            ("ClientRequestIdParameter", "Azure.Core.ClientRequestIdHeader"),
        }

        message_lower = diff.message.lower()
        context_lower = (diff.context or "").lower()

        for old_name, new_name in mappings:
            old_lower = old_name.lower()
            new_lower = new_name.lower()

            # Check if old parameter name appears in message or context
            if old_lower in message_lower or old_lower in context_lower:
                # For mismatch type, check if the new name also appears (indicating Azure.Core mapping)
                if diff.type == DifferenceType.GLOBAL_PARAMETER_MISMATCH:
                    if new_lower in context_lower or "azure.core" in context_lower:
                        return True
                else:
                    # For missing/extra, just matching the old name is enough
                    return True

            # Also check reverse mapping (in case the order is swapped)
            if new_lower in message_lower or new_lower in context_lower:
                if diff.type == DifferenceType.GLOBAL_PARAMETER_MISMATCH:
                    if old_lower in context_lower:
                        return True

        return False

    def _match_error_response_common_types(self, diff: Difference) -> bool:
        """Match ErrorResponse reference differences between common-types and local."""
        if diff.type != DifferenceType.RESPONSE_SCHEMA_MISMATCH:
            return False

        message_lower = diff.message.lower()

        # Check for ErrorResponse and common-types reference pattern
        if "errorresponse" in message_lower:
            if "common-types" in message_lower or "types.json" in message_lower:
                return True

        # Check for default response with ErrorResponse
        if "default" in diff.message and "errorresponse" in message_lower:
            return True

        return False

    def _match_service_statistics_schema_name(self, diff: Difference) -> bool:
        """Match ServiceStatistics vs SearchServiceStatistics naming differences."""
        if diff.type not in [
            DifferenceType.RESPONSE_SCHEMA_MISMATCH,
            DifferenceType.DEFINITION_MISMATCH,
        ]:
            return False

        message_lower = diff.message.lower()

        # Check for both names in the message
        if (
            "servicestatistics" in message_lower
            and "searchservicestatistics" in message_lower
        ):
            return True

        return False

    def _match_definition_name_prefix(self, diff: Difference) -> bool:
        """Match definition name differences with Search prefix."""
        if diff.type not in [
            DifferenceType.MISSING_DEFINITION,
            DifferenceType.EXTRA_DEFINITION,
            DifferenceType.DEFINITION_MISMATCH,
        ]:
            return False

        # Pattern: one name is prefix of another with "Search" added
        # e.g., "IndexStatistics" vs "SearchIndexStatistics"
        if "search" in diff.message.lower():
            # Extract two definition names being compared
            if " vs " in diff.message or " vs. " in diff.message:
                parts = re.split(r"\s+vs\.?\s+", diff.message, flags=re.IGNORECASE)
                if len(parts) >= 2:
                    name1 = parts[0].strip().split()[-1].strip("\"':")
                    name2 = parts[1].strip().split()[0].strip("\"':")

                    # Check if one is "Search" + other
                    if name1.lower().replace("search", "") == name2.lower().replace(
                        "search", ""
                    ):
                        return True

        return False

    def _match_missing_global_parameters(self, diff: Difference) -> bool:
        """Match known missing global parameters in TypeSpec."""
        if diff.type != DifferenceType.MISSING_GLOBAL_PARAMETER:
            return False

        # Known global parameters that are missing in TypeSpec
        # These are defined as global parameters in hand-authored swagger but as inline operation parameters in TSP
        # NOTE: Only include parameters that are ALWAYS inline in TSP (path parameters, etc.)
        # Do NOT include parameters that should be matched if they exist inline
        known_missing_params = {
            "IfMatchParameter",
            "IfNoneMatchParameter",
            "PreferHeaderParameter",
            "EndpointParameter",
            "IndexNameParameter",
            "KnowledgeBaseNameParameter",
            "QuerySourceAuthorizationParameter",
            "DisableCacheReprocessingChangeDetectionParameter",
            "IgnoreResetRequirementsParameter",
            "EnableElevatedReadParameter",
        }

        message_lower = diff.message.lower()

        # Check if message matches pattern: "Global parameter missing in tsp: <name>"
        if "global parameter missing in tsp:" in message_lower:
            for param_name in known_missing_params:
                if param_name.lower() in message_lower:
                    return True

        return False

    def _match_body_parameter_schema_mismatch(self, diff: Difference) -> bool:
        """Match known body parameter schema mismatches."""
        if diff.type != DifferenceType.PARAMETER_MISMATCH:
            return False

        message_lower = diff.message.lower()
        context_lower = (diff.context or "").lower()

        # Known operation IDs and their body parameters with schema mismatches
        known_mismatches = [
            ("indexers_resetdocs", "keysOrIds"),
            ("skillsets_resetskills", "skillNames"),
        ]

        # Check if this is a body parameter schema mismatch
        if "body parameter schemas mismatch" not in message_lower:
            return False

        # Check if it matches one of the known mismatches
        for operation_id, param_name in known_mismatches:
            if operation_id in context_lower or operation_id in message_lower:
                if (
                    param_name.lower() in message_lower
                    or param_name.lower() in context_lower
                ):
                    return True

        return False

    def _match_body_parameter_naming(self, diff: Difference) -> bool:
        """Match body parameter naming differences between hand-authored and TypeSpec."""
        if diff.type not in [
            DifferenceType.MISSING_PARAMETER,
            DifferenceType.EXTRA_PARAMETER,
        ]:
            return False

        message_lower = diff.message.lower()
        context_lower = (diff.context or "").lower()

        # Known operations with body parameter naming differences
        # Hand-authored uses specific names like "autocompleteRequest"
        # TypeSpec uses generic "body"
        known_operations = [
            "documents_autocompletepost",
            "documents_searchpost",
            "documents_suggestpost",
        ]

        # Check if this is about a body parameter
        if ", body" not in message_lower and "in: body" not in message_lower:
            return False

        # Check if it's one of the known operations
        for operation in known_operations:
            if operation in context_lower or operation in message_lower:
                # For EXTRA_PARAMETER: "body, body" in TypeSpec
                if (
                    diff.type == DifferenceType.EXTRA_PARAMETER
                    and "body" in message_lower
                ):
                    return True
                # For MISSING_PARAMETER: specific request names like "autocompleteRequest"
                if diff.type == DifferenceType.MISSING_PARAMETER:
                    if any(
                        req in message_lower
                        for req in [
                            "autocompleterequest",
                            "searchrequest",
                            "suggestrequest",
                        ]
                    ):
                        return True

        return False

    def _match_x_nullable_false_vs_missing(self, diff: Difference) -> bool:
        """
        Match x-nullable differences where one side is False and other is None.
        In OpenAPI 2.0, x-nullable: false is equivalent to missing x-nullable.
        We only care about differences involving x-nullable: true.
        """
        if diff.type != DifferenceType.PARAMETER_MISMATCH:
            return False

        message = diff.message

        # Check if this is an x-nullable mismatch
        if "x-nullable:" not in message:
            return False

        # Parse the message to extract the x-nullable values
        # Format: "... x-nullable: hand_authored=<value> vs tsp=<value>"
        import re

        match = re.search(
            r"x-nullable:\s*hand_authored=(False|None|True)\s+vs\s+tsp=(False|None|True)",
            message,
        )
        if not match:
            return False

        hand_value = match.group(1)
        tsp_value = match.group(2)

        # Convert string representations to actual values
        def parse_value(val: str) -> Optional[bool]:
            if val == "None":
                return None
            elif val == "True":
                return True
            elif val == "False":
                return False
            return None

        hand = parse_value(hand_value)
        tsp = parse_value(tsp_value)

        # Filter out if:
        # - One is False and the other is None (equivalent)
        # - Both are False or both are None (equivalent)
        # We DON'T filter if either side is True (that's a real difference)
        if hand is True or tsp is True:
            return False  # Real difference - don't filter

        # If we get here, both are False or None - these are equivalent
        return True


# Convenience function for use in CLI
def create_default_filter() -> FalsePositiveFilter:
    """
    Create a FalsePositiveFilter with all default rules enabled.

    Returns:
        Configured FalsePositiveFilter instance
    """
    return FalsePositiveFilter()


def filter_results(
    differences: List[Difference],
    custom_rules: Optional[List[FalsePositiveRule]] = None,
) -> tuple[List[Difference], List[Difference], Dict[str, int]]:
    """
    High-level function to filter differences with optional custom rules.

    Args:
        differences: List of differences to filter
        custom_rules: Optional list of additional custom rules

    Returns:
        Tuple of (remaining_differences, filtered_differences, statistics)
    """
    filter_obj = create_default_filter()

    # Add custom rules if provided
    if custom_rules:
        for rule in custom_rules:
            filter_obj.add_rule(rule)

    remaining, filtered = filter_obj.filter_differences(
        differences, return_filtered_out=True
    )
    stats = filter_obj.get_statistics(differences)

    return remaining, filtered, stats
