from dataclasses import dataclass
from enum import Enum
from typing import Any, Dict, FrozenSet, List, Optional, Set


class DifferenceType(Enum):
    """Types of differences that can be detected."""

    # Path-level differences
    MISSING_PATH = "missing_path_in_tsp"
    EXTRA_PATH = "extra_path_in_tsp"

    # Method-level differences
    MISSING_METHOD = "missing_method_in_tsp"
    EXTRA_METHOD = "extra_method_in_tsp"

    # Operation-level differences
    OPERATION_ID_MISMATCH = "operation_id_mismatch"
    PATH_INCONSISTENCY = "path_inconsistency"
    OPERATION_ID_INCONSISTENCY = "operation_id_inconsistency"
    MISSING_PARAMETER = "missing_parameter_in_tsp"
    EXTRA_PARAMETER = "extra_parameter_in_tsp"
    PARAMETER_MISMATCH = "parameter_mismatch"
    PARAMETER_MISMATCH_NAME_CASE = "parameter_mismatch_name_case"
    REQUEST_BODY_MISMATCH = "request_body_mismatch"
    CONSUMES_MISMATCH = "consumes_mismatch"
    PRODUCES_MISMATCH = "produces_mismatch"

    # Response-level differences
    MISSING_RESPONSE = "missing_response_in_tsp"
    EXTRA_RESPONSE = "extra_response_in_tsp"
    RESPONSE_SCHEMA_MISMATCH = "response_schema_mismatch"
    RESPONSE_HEADERS_MISMATCH = "response_headers_mismatch"

    # Definition-level differences
    MISSING_DEFINITION = "missing_def_in_tsp"
    EXTRA_DEFINITION = "extra_def_in_tsp"
    DEFINITION_MISMATCH = "def_mismatch"
    DEFINITION_MISMATCH_TYPE = "def_mismatch_type"
    DEFINITION_MISMATCH_X_NULLABLE = "def_mismatch_x-nullable-true"
    DEFINITION_MISMATCH_ADDITIONAL_PROPERTIES = "def_mismatch_additionalProperties-true"
    DEFINITION_MISMATCH_DEFAULT = "def_mismatch_default-value"
    DEFINITION_MISMATCH_READONLY = "def_mismatch_readOnly-true"

    # Schema-level differences
    SCHEMA_TYPE_MISMATCH = "schema_type_mismatch"
    SCHEMA_FORMAT_MISMATCH = "schema_format_mismatch"
    SCHEMA_PROPERTIES_MISMATCH = "schema_properties_mismatch"
    SCHEMA_REQUIRED_MISMATCH = "schema_required_mismatch"
    SCHEMA_ADDITIONAL_PROPERTIES_MISMATCH = "schema_additional_properties_mismatch"
    SCHEMA_ITEMS_MISMATCH = "schema_items_mismatch"
    SCHEMA_CONSTRAINTS_MISMATCH = "schema_constraints_mismatch"
    SCHEMA_COMPOSITION_MISMATCH = "schema_composition_mismatch"

    # Global API configuration differences
    SWAGGER_VERSION_MISMATCH = "swagger_version_mismatch"
    INFO_MISMATCH = "info_mismatch"
    GLOBAL_CONSUMES_MISMATCH = "global_consumes_mismatch"
    GLOBAL_PRODUCES_MISMATCH = "global_produces_mismatch"
    SCHEMES_MISMATCH = "schemes_mismatch"
    HOST_MISMATCH = "host_mismatch"
    BASE_PATH_MISMATCH = "base_path_mismatch"
    X_MS_PARAMETERIZED_HOST_MISMATCH = "x_ms_parameterized_host_mismatch"
    X_MS_CODE_GENERATION_SETTINGS_MISMATCH = "x_ms_code_generation_settings_mismatch"
    SECURITY_DEFINITIONS_MISMATCH = "security_definitions_mismatch"
    SECURITY_MISMATCH = "security_mismatch"
    TAGS_MISMATCH = "tags_mismatch"
    EXTERNAL_DOCS_MISMATCH = "external_docs_mismatch"

    # Global parameter and response differences
    MISSING_GLOBAL_PARAMETER = "missing_global_parameter_in_tsp"
    EXTRA_GLOBAL_PARAMETER = "extra_global_parameter_in_tsp"
    GLOBAL_PARAMETER_MISMATCH = "global_parameter_mismatch"
    MISSING_GLOBAL_RESPONSE = "missing_global_response_in_tsp"
    EXTRA_GLOBAL_RESPONSE = "extra_global_response_in_tsp"
    GLOBAL_RESPONSE_MISMATCH = "global_response_mismatch"


@dataclass
class Difference:
    """Represents a single difference between two APIs."""

    type: DifferenceType
    message: str
    context: Optional[str] = None  # Path, method, parameter name, etc.

    def __str__(self) -> str:
        if self.context:
            return f"[{self.context}] {self.message}"
        return self.message


@dataclass
class EquivalencyResult:
    """Result of an equivalency comparison."""

    equivalent: bool
    differences: List[Difference]

    @property
    def difference_count(self) -> int:
        return len(self.differences)

    def get_summary(self) -> str:
        """Get a summary string of the comparison result."""
        if self.equivalent:
            return "APIs are semantically equivalent"
        else:
            return (
                f"APIs are NOT equivalent ({self.difference_count} differences found)"
            )
