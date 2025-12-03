"""
Comparison module for the Swagger equivalency checker.

This module implements strict semantic comparison as described in equiv_contract.md.
It builds canonical API models from canonicalized Swagger documents and compares
them for exact equivalency according to the contract rules.

According to equiv_contract.md, comparison covers three dimensions:
1. Paths + HTTP methods
2. Operations (parameters, request bodies, responses)
3. Schemas / definitions
"""

from dataclasses import dataclass
from enum import Enum
from typing import Any, Dict, FrozenSet, List, Optional, Set

from models import (
    CanonicalApi,
    CanonicalConstraints,
    CanonicalOperation,
    CanonicalParameter,
    CanonicalPath,
    CanonicalResponse,
    CanonicalSchema,
    ParameterLocation,
    build_canonical_api_from_swagger,
)

# Known renamed mappings between hand-authored and TSP-compiled swaggers
KNOWN_DEFINITION_RENAMES = {
    "WebApiParameters": "WebApiVectorizerParameters",
    "ServiceStatistics": "SearchServiceStatistics",
    "PathHierarchyTokenizerV2": "PathHierarchyTokenizer",
    "ClassicSimilarity": "ClassicSimilarityAlgorithm",
    "BM25Similarity": "BM25SimilarityAlgorithm",
    "Suggester": "SearchSuggester",
    "DataToExtract": "BlobIndexerDataToExtract",
}


class DifferenceType(Enum):
    """Types of differences that can be detected."""

    # Path-level differences
    MISSING_PATH = "missing_path"
    EXTRA_PATH = "extra_path"

    # Method-level differences
    MISSING_METHOD = "missing_method"
    EXTRA_METHOD = "extra_method"

    # Operation-level differences
    OPERATION_ID_MISMATCH = "operation_id_mismatch"
    PATH_INCONSISTENCY = "path_inconsistency"
    OPERATION_ID_INCONSISTENCY = "operation_id_inconsistency"
    MISSING_PARAMETER = "missing_parameter"
    EXTRA_PARAMETER = "extra_parameter"
    PARAMETER_MISMATCH = "parameter_mismatch"
    PARAMETER_MISMATCH_NAME_CASE = "parameter_mismatch_name_case"
    REQUEST_BODY_MISMATCH = "request_body_mismatch"
    CONSUMES_MISMATCH = "consumes_mismatch"
    PRODUCES_MISMATCH = "produces_mismatch"

    # Response-level differences
    MISSING_RESPONSE = "missing_response"
    EXTRA_RESPONSE = "extra_response"
    RESPONSE_SCHEMA_MISMATCH = "response_schema_mismatch"
    RESPONSE_HEADERS_MISMATCH = "response_headers_mismatch"

    # Definition-level differences
    MISSING_DEFINITION = "missing_definition"
    EXTRA_DEFINITION = "extra_definition"
    DEFINITION_MISMATCH = "definition_mismatch"

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
    MISSING_GLOBAL_PARAMETER = "missing_global_parameter"
    EXTRA_GLOBAL_PARAMETER = "extra_global_parameter"
    GLOBAL_PARAMETER_MISMATCH = "global_parameter_mismatch"
    MISSING_GLOBAL_RESPONSE = "missing_global_response"
    EXTRA_GLOBAL_RESPONSE = "extra_global_response"
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


class ApiComparator:
    """
    Main class for comparing two canonical APIs for semantic equivalency.

    Implements the strict comparison rules from equiv_contract.md.
    """

    def __init__(self):
        """
        Initialize the comparator.
        """
        self.differences: List[Difference] = []

    def compare_apis(self, api1: CanonicalApi, api2: CanonicalApi) -> EquivalencyResult:
        """
        Compare two canonical APIs for semantic equivalency.

        Args:
            api1: First API to compare
            api2: Second API to compare

        Returns:
            EquivalencyResult indicating whether APIs are equivalent
        """
        self.differences = []

        # According to equiv_contract.md and the expanded CanonicalApi model,
        # we check the following dimensions:

        # 1. Paths + HTTP methods
        print("------- Comparison start -------")

        print("\nComparing paths and methods...")
        self._compare_paths_and_methods(api1, api2)

        # 2. Operations (parameters, request bodies, responses)
        print("\nComparing operations...")
        self._compare_operations(api1, api2)

        # 3. Schemas / definitions
        print("\nComparing definitions...")
        self._compare_definitions(api1, api2)

        # 4. Global parameters
        print("Comparing global parameters...")
        self._compare_global_parameters(api1, api2)

        # 5. Global responses
        print("\nComparing global responses...")
        self._compare_global_responses(api1, api2)

        # 6. Global API configuration (DISABLED)
        # print("\nComparing global API configuration...")
        # self._compare_global_configuration(api1, api2)

        print("------- Comparison complete -------")

        return EquivalencyResult(
            equivalent=len(self.differences) == 0, differences=self.differences.copy()
        )

    def _compare_paths_and_methods(
        self, api1: CanonicalApi, api2: CanonicalApi
    ) -> None:
        """Compare path sets and method sets per path."""
        paths1 = api1.path_set
        paths2 = api2.path_set

        # Check for missing/extra paths
        missing_paths = paths1 - paths2
        extra_paths = paths2 - paths1

        # Find potential matches between missing and extra paths
        path_matches = self._find_path_matches(missing_paths, extra_paths)

        # Promote high-confidence matches to prevent duplicate reporting
        promoted_path_matches = []
        for match in path_matches:
            missing_path, extra_path, similarity = match
            # High similarity (> 0.85) or simple substitution differences
            if similarity > 0.85:
                promoted_path_matches.append((missing_path, extra_path))

        # Remove promoted matches from missing/extra
        for missing_path, extra_path in promoted_path_matches:
            missing_paths.discard(missing_path)
            extra_paths.discard(extra_path)
            # Report as potential match
            print(f"Potential path match\t {missing_path} ~ {extra_path}")
            # Compare methods for these matched paths
            path1 = api1.paths[missing_path]
            path2 = api2.paths[extra_path]
            self._compare_methods(
                path1,
                api1.swagger_source,
                path2,
                api2.swagger_source,
                f"{missing_path} ~ {extra_path}",
            )

        for path in missing_paths:
            # Check if this missing path has a potential match
            matches = [match for match in path_matches if match[0] == path]
            possible_match = matches[0][1] if matches else ""

            self.differences.append(
                Difference(
                    type=DifferenceType.MISSING_PATH,
                    message=f"Path missing in {api2.swagger_source}: {path}",
                    context=f"||{path}|||{possible_match}",
                )
            )

        if missing_paths:
            print(f"Missing paths in {api2.swagger_source}\t {len(missing_paths)}")

        for path in extra_paths:
            # Check if this extra path has a potential match
            matches = [match for match in path_matches if match[1] == path]
            possible_match = matches[0][0] if matches else ""

            self.differences.append(
                Difference(
                    type=DifferenceType.EXTRA_PATH,
                    message=f"Extra path in {api2.swagger_source}: {path}",
                    context=f"||{path}|||{possible_match}",
                )
            )

        if extra_paths:
            print(f"Extra paths in {api2.swagger_source}\t {len(extra_paths)}")

        # For common paths, check method sets
        common_paths = paths1 & paths2
        for path in common_paths:
            path1 = api1.paths[path]
            path2 = api2.paths[path]
            self._compare_methods(
                path1, api1.swagger_source, path2, api2.swagger_source, path
            )

    def _compare_methods(
        self,
        path1: CanonicalPath,
        source1: str,
        path2: CanonicalPath,
        source2: str,
        path_str: str,
    ) -> None:
        """Compare HTTP method sets for a specific path."""
        methods1 = path1.methods
        methods2 = path2.methods

        missing_methods = methods1 - methods2
        extra_methods = methods2 - methods1

        for method in missing_methods:
            self.differences.append(
                Difference(
                    type=DifferenceType.MISSING_METHOD,
                    message=f"HTTP method {method} missing in {source2}",
                    context=f"{path_str} {method}",
                )
            )

        if missing_methods:
            print(
                f"Missing methods in {source2}\t  {path_str}\t {len(missing_methods)}"
            )

        for method in extra_methods:
            self.differences.append(
                Difference(
                    type=DifferenceType.EXTRA_METHOD,
                    message=f"Extra HTTP method {method} in {source2}",
                    context=f"{path_str} {method}",
                )
            )

        if extra_methods:
            print(f"Extra methods in {source2}\t {path_str}\t {len(extra_methods)}")

    def _compare_operations(self, api1: CanonicalApi, api2: CanonicalApi) -> None:
        """Compare operations using path + method matching."""
        # Build operation mappings for both APIs
        ops1_by_path_method = {}  # {(path, method): operation}

        for path, path_obj in api1.paths.items():
            for method, operation in path_obj.operations.items():
                ops1_by_path_method[(path, method)] = operation

        ops2_by_path_method = {}  # {(path, method): operation}

        for path, path_obj in api2.paths.items():
            for method, operation in path_obj.operations.items():
                ops2_by_path_method[(path, method)] = operation

        # Match by path + method
        for (path, method), op1 in ops1_by_path_method.items():
            if (path, method) in ops2_by_path_method:
                op2 = ops2_by_path_method[(path, method)]
                # Build structured context with operation_id, path+method, suffix
                operation_id = op1.operation_id or op2.operation_id or "<unknown>"
                path_method = f"{path} {method}"
                context = f"{operation_id}||{path_method}||"

                self._compare_operation(
                    op1, op2, context, api1.swagger_source, api2.swagger_source
                )

    def _compare_operation(
        self,
        op1: CanonicalOperation,
        op2: CanonicalOperation,
        context: str,
        source1: str,
        source2: str,
    ) -> None:
        """
        Compare two operations according to equiv_contract.md section 3.2.

        Args:
            op1: First operation
            op2: Second operation
            context: Context for error messages
            source1: Swagger Source identifier for first operation
            source2: Swagger Source identifier for second operation
        """
        # Extract context components
        context_parts = (
            context.split("||") if "||" in context else ["<unknown>", context, ""]
        )
        operation_id, path_method, _ = (
            context_parts[0],
            context_parts[1],
            context_parts[2],
        )

        # 3.2.1 operationId - must match exactly
        if op1.operation_id != op2.operation_id:
            mismatch_context = f"{operation_id}||{path_method}||operation_id_mismatch"
            self.differences.append(
                Difference(
                    type=DifferenceType.OPERATION_ID_MISMATCH,
                    message=f"Operation ID mismatch: {source1} {op1.operation_id} vs {source2} {op2.operation_id}",
                    context=mismatch_context,
                )
            )
            print(
                f"Operation ID mismatch\t {mismatch_context}\t {source1} {op1.operation_id} vs {source2} {op2.operation_id}"
            )

        # 3.2.2 Parameters - keyed by (in, name)
        self._compare_parameters(
            op1.parameters, op2.parameters, context, source1, source2
        )

        # 3.2.3 Request Body
        if not self._schemas_equal(op1.request_body_schema, op2.request_body_schema):
            body_context = f"{operation_id}||{path_method}||request_body_mismatch"
            self.differences.append(
                Difference(
                    type=DifferenceType.REQUEST_BODY_MISMATCH,
                    message="Request body schemas mismatch",
                    context=body_context,
                )
            )
            print(
                f"Request body schemas mismatch\t {body_context}\t {source1} vs {source2}"
            )

        # Content types for request
        if op1.consumes != op2.consumes:
            consumes_context = f"{operation_id}||{path_method}||consumes_mismatch"
            self.differences.append(
                Difference(
                    type=DifferenceType.CONSUMES_MISMATCH,
                    message=f"Request content types mismatch: {source1} {op1.consumes} vs {source2} {op2.consumes}",
                    context=consumes_context,
                )
            )
            print(
                f"Request content types mismatch\t {consumes_context}\t {source1} {op1.consumes} vs {source2} {op2.consumes}"
            )

        # 3.2.4 Responses
        self._compare_responses(op1.responses, op2.responses, context, source1, source2)

        # Content types for responses
        if op1.produces != op2.produces:
            produces_context = f"{operation_id}||{path_method}||produces_mismatch"
            self.differences.append(
                Difference(
                    type=DifferenceType.PRODUCES_MISMATCH,
                    message=f"Response content types mismatch: {source1} {op1.produces} vs {source2} {op2.produces}",
                    context=produces_context,
                )
            )
            print(
                f"Response content types mismatch\t {produces_context}\t {source1} {op1.produces} vs {source2} {op2.produces}"
            )

    def _compare_parameters(
        self,
        params1: Optional[Dict],
        params2: Optional[Dict],
        context: str,
        source1: str,
        source2: str,
    ) -> None:
        """Compare parameter dictionaries keyed by (in, name)."""
        params1 = params1 or {}
        params2 = params2 or {}

        keys1 = set(params1.keys())
        keys2 = set(params2.keys())

        # Check for missing/extra parameters
        missing_keys = keys1 - keys2
        extra_keys = keys2 - keys1

        # Extract context components
        context_parts = (
            context.split("||") if "||" in context else ["<unknown>", context, ""]
        )
        operation_id, path_method = context_parts[0], context_parts[1]

        # Check for case mismatches in parameter names
        case_mismatches = self._find_parameter_name_case_mismatches(
            missing_keys, extra_keys, params1, params2
        )

        # Find potential fuzzy matches for missing/extra parameters
        param_matches = self._find_parameter_matches(
            missing_keys, extra_keys, params1, params2
        )

        # Promote high-confidence fuzzy matches for comparison
        promoted_param_matches = []
        for match in param_matches:
            if len(match) >= 3:  # Ensure it's a 3-tuple with similarity
                missing_key, extra_key, similarity = (
                    match[0],
                    match[1],
                    match[2] if len(match) > 2 else 0,
                )
                # High similarity or simple prefix differences like "$" in OData
                param1_name = (
                    params1[missing_key].name if missing_key in params1 else ""
                )
                param2_name = params2[extra_key].name if extra_key in params2 else ""
                if (
                    similarity > 0.85
                    or param1_name.lstrip("$") == param2_name
                    or param2_name.lstrip("$") == param1_name
                ):
                    promoted_param_matches.append((missing_key, extra_key))

        # Remove promoted matches and compare them
        for missing_key, extra_key in promoted_param_matches:
            if missing_key in missing_keys and extra_key in extra_keys:
                missing_keys.discard(missing_key)
                extra_keys.discard(extra_key)
                param1 = params1[missing_key]
                param2 = params2[extra_key]
                param_context = (
                    f"{operation_id}||{path_method}||{param1.name} ~ {param2.name}"
                )
                print(f"Potential parameter match\t {param_context}")
                # Compare the matched parameters
                self._compare_parameter(param1, param2, context, source1, source2)

        # Filter out case mismatches from missing/extra keys
        filtered_missing_keys = missing_keys.copy()
        filtered_extra_keys = extra_keys.copy()

        for missing_key, extra_key in case_mismatches:
            filtered_missing_keys.discard(missing_key)
            filtered_extra_keys.discard(extra_key)
            # Report as case mismatch instead of missing/extra
            param1 = params1[missing_key]
            param2 = params2[extra_key]
            param_context = (
                f"{operation_id}||{path_method}||{param1.name}, {param1.location.value}"
            )
            self.differences.append(
                Difference(
                    type=DifferenceType.PARAMETER_MISMATCH_NAME_CASE,
                    message=f"Parameter name case mismatch: {source1} '{param1.name}' vs {source2} '{param2.name}'",
                    context=param_context,
                )
            )
            print(
                f"Parameter name case mismatch\t {param_context}\t {source1} '{param1.name}' vs {source2} '{param2.name}'"
            )

        for key in filtered_missing_keys:
            param = params1[key]
            param_context = (
                f"{operation_id}||{path_method}||{param.name}, {param.location.value}"
            )

            # Check if this missing parameter has a potential match
            matches = [match for match in param_matches if match[0] == key]
            possible_match = matches[0][1] if matches else ""
            param_context_with_match = f"{param_context}||{possible_match}"

            self.differences.append(
                Difference(
                    type=DifferenceType.MISSING_PARAMETER,
                    message=f"Parameter missing in {source2}: {param.name}, {param.location.value}",
                    context=param_context_with_match,
                )
            )
            print(
                f"Missing parameter in {source2}\t {param_context}\t {param.name}, {param.location.value}"
                + (f"\t|| Possible Match: {possible_match}" if possible_match else "")
            )

        for key in filtered_extra_keys:
            param = params2[key]
            param_context = (
                f"{operation_id}||{path_method}||{param.name}, {param.location.value}"
            )

            # Check if this extra parameter has a potential match
            matches = [match for match in param_matches if match[1] == param.name]
            possible_match = matches[0][0][1] if matches and len(matches[0]) > 0 else ""
            param_context_with_match = f"{param_context}||{possible_match}"

            self.differences.append(
                Difference(
                    type=DifferenceType.EXTRA_PARAMETER,
                    message=f"Extra parameter in {source2}: {param.name}, {param.location.value}",
                    context=param_context_with_match,
                )
            )
            print(
                f"Extra parameter in {source2}\t {param_context}\t {param.name}, {param.location.value}"
                + (f"\t|| Possible Match: {possible_match}" if possible_match else "")
            )

        # Compare common parameters
        common_keys = keys1 & keys2
        for key in common_keys:
            param1 = params1[key]
            param2 = params2[key]
            self._compare_parameter(param1, param2, context, source1, source2)

    def _compare_parameter(
        self,
        param1: CanonicalParameter,
        param2: CanonicalParameter,
        context: str,
        source1: str,
        source2: str,
    ) -> None:
        """Compare two parameters according to equiv_contract.md section 3.2.2."""
        # Extract context components
        context_parts = (
            context.split("||") if "||" in context else ["<unknown>", context, ""]
        )
        operation_id, path_method = context_parts[0], context_parts[1]
        param_context = (
            f"{operation_id}||{path_method}||{param1.name}, {param1.location.value}"
        )

        # Basic fields must match
        if param1.required != param2.required:
            self.differences.append(
                Difference(
                    type=DifferenceType.PARAMETER_MISMATCH,
                    message=f"Parameter required mismatch: {source1} {param1.required} vs {source2} {param2.required}",
                    context=param_context,
                )
            )
            print(
                f"Parameter required mismatch\t {param_context}\t {source1} {param1.required} vs {source2} {param2.required}"
            )

        # For body parameters, compare schemas
        if param1.location == ParameterLocation.BODY:
            if not self._schemas_equal(param1.schema, param2.schema):
                # Get detailed schema differences
                schema_diffs = self._get_schema_differences(
                    param1.schema, param2.schema
                )
                diff_details = (
                    "; ".join(schema_diffs) if schema_diffs else "unknown differences"
                )

                self.differences.append(
                    Difference(
                        type=DifferenceType.PARAMETER_MISMATCH,
                        message=f"Body parameter schemas mismatch: {diff_details}",
                        context=param_context,
                    )
                )
                print(
                    f"Body parameter schemas mismatch\t {param_context}\t {diff_details}"
                )
        else:
            # For non-body parameters, compare type, format, constraints
            if param1.param_type != param2.param_type:
                self.differences.append(
                    Difference(
                        type=DifferenceType.PARAMETER_MISMATCH,
                        message=f"Parameter type mismatch: {source1} {param1.param_type} vs {source2} {param2.param_type}",
                        context=param_context,
                    )
                )
                print(
                    f"Parameter type mismatch\t {param_context}\t {source1} {param1.param_type} vs {source2} {param2.param_type}"
                )

            if param1.param_format != param2.param_format:
                self.differences.append(
                    Difference(
                        type=DifferenceType.PARAMETER_MISMATCH,
                        message=f"Parameter format mismatch: {source1} {param1.param_format} vs {source2} {param2.param_format}",
                        context=param_context,
                    )
                )
                print(
                    f"Parameter format mismatch\t {param_context}\t {source1} {param1.param_format} vs {source2} {param2.param_format}"
                )

            if not self._constraints_equal(param1.constraints, param2.constraints):
                # Get detailed constraint differences
                constraint_diffs = self._get_constraint_differences(
                    param1.constraints, param2.constraints
                )
                diff_details = (
                    "; ".join(constraint_diffs)
                    if constraint_diffs
                    else "unknown differences"
                )

                self.differences.append(
                    Difference(
                        type=DifferenceType.PARAMETER_MISMATCH,
                        message=f"Parameter constraints mismatch: {diff_details}",
                        context=param_context,
                    )
                )
                print(
                    f"Parameter constraints mismatch\t {param_context}\t {diff_details}"
                )

    def _compare_responses(
        self,
        responses1: Optional[Dict],
        responses2: Optional[Dict],
        context: str,
        source1: str,
        source2: str,
    ) -> None:
        """Compare response dictionaries keyed by status code."""
        responses1 = responses1 or {}
        responses2 = responses2 or {}

        status_codes1 = set(responses1.keys())
        status_codes2 = set(responses2.keys())

        # Check for missing/extra status codes
        missing_codes = status_codes1 - status_codes2
        extra_codes = status_codes2 - status_codes1

        # Find potential matches between missing and extra response codes
        response_matches = self._find_response_matches(missing_codes, extra_codes)

        # Promote high-confidence matches (like 200 vs "200", or close status codes)
        promoted_response_matches = []
        for match in response_matches:
            missing_code, extra_code, similarity = match
            # Very high similarity for response codes (they're usually exact or very close)
            if similarity > 0.9:
                promoted_response_matches.append((missing_code, extra_code))

        # Remove promoted matches from response_matches to avoid duplicate hints
        promoted_response_codes = {(m, e) for m, e in promoted_response_matches}
        response_matches = [
            m for m in response_matches if (m[0], m[1]) not in promoted_response_codes
        ]

        # Remove promoted matches and compare them
        for missing_code, extra_code in promoted_response_matches:
            missing_codes.discard(missing_code)
            extra_codes.discard(extra_code)
            print(
                f"Potential response match\t {context}\t {missing_code} vs {extra_code}"
            )
            # Compare the matched responses
            response1 = responses1[missing_code]
            response2 = responses2[extra_code]
            context_parts = (
                context.split("||") if "||" in context else ["<unknown>", context, ""]
            )
            operation_id, path_method = context_parts[0], context_parts[1]
            response_context = (
                f"{operation_id}||{path_method}||{missing_code} vs {extra_code}"
            )
            self._compare_response(
                response1, response2, response_context, source1, source2
            )

        for code in missing_codes:
            # Check if this missing response has a potential match
            matches = [match for match in response_matches if match[0] == code]
            possible_match = matches[0][1] if matches else ""
            context_with_match = f"{context}||{possible_match}"

            self.differences.append(
                Difference(
                    type=DifferenceType.MISSING_RESPONSE,
                    message=f"Response status code missing in {source1}: {code}",
                    context=context_with_match,
                )
            )
            print(
                f"Response status code missing\t {context}\t {source1}: {code}"
                + (f"\t|| Possible Match: {possible_match}" if possible_match else "")
            )

        for code in extra_codes:
            # Check if this extra response has a potential match
            matches = [match for match in response_matches if match[1] == code]
            possible_match = matches[0][0] if matches else ""
            context_with_match = f"{context}||{possible_match}"

            self.differences.append(
                Difference(
                    type=DifferenceType.EXTRA_RESPONSE,
                    message=f"Extra response status code in {source2}: {code}",
                    context=context_with_match,
                )
            )
            print(
                f"Extra response status code in {source2} \t {context}\t {code}"
                + (f"\t|| Possible Match: {possible_match}" if possible_match else "")
            )

        # Compare common responses
        common_codes = status_codes1 & status_codes2
        for code in common_codes:
            response1 = responses1[code]
            response2 = responses2[code]
            # Extract context components for structured format
            context_parts = (
                context.split("||") if "||" in context else ["<unknown>", context, ""]
            )
            operation_id, path_method = context_parts[0], context_parts[1]
            response_context = f"{operation_id}||{path_method}||{code}"
            self._compare_response(
                response1, response2, response_context, source1, source2
            )

    def _compare_response(
        self,
        resp1: CanonicalResponse,
        resp2: CanonicalResponse,
        context: str,
        source1: str,
        source2: str,
    ) -> None:
        """Compare two responses according to equiv_contract.md section 3.2.4."""

        # Response schemas must match
        if not self._schemas_equal(resp1.schema, resp2.schema):
            # Get detailed schema differences
            schema_diffs = self._get_schema_differences(resp1.schema, resp2.schema)

            # Check for ErrorResponse ref path differences
            message = "Response schemas mismatch"
            if (
                context.endswith("||default")
                and resp1.schema
                and resp2.schema
                and resp1.schema.ref
                and resp2.schema.ref
            ):
                ref1 = resp1.schema.ref
                ref2 = resp2.schema.ref
                # Check if both refs point to ErrorResponse but with different paths
                if (
                    ref1.endswith("/definitions/ErrorResponse")
                    and ref2.endswith("/definitions/ErrorResponse")
                    and ref1 != ref2
                ):
                    message = "Response schemas mismatch for /definitions/ErrorResponse"

            # Add detailed differences to message if available
            if schema_diffs:
                diff_details = "; ".join(schema_diffs)
                message = f"{message}: {diff_details}"

            self.differences.append(
                Difference(
                    type=DifferenceType.RESPONSE_SCHEMA_MISMATCH,
                    message=message,
                    context=context,
                )
            )
            print(
                f"Response schemas mismatch \t {context}\t {'; '.join(schema_diffs) if schema_diffs else 'unknown differences'}"
            )

        # Response headers must match
        if not self._headers_equal(resp1.headers, resp2.headers):
            # Get detailed header differences
            header_diffs = self._get_header_differences(resp1.headers, resp2.headers)
            diff_details = (
                "; ".join(header_diffs) if header_diffs else "unknown differences"
            )

            self.differences.append(
                Difference(
                    type=DifferenceType.RESPONSE_HEADERS_MISMATCH,
                    message=f"Response headers mismatch: {diff_details}",
                    context=context,
                )
            )
            print(f"Response headers mismatch \t {context}\t {diff_details}")
        # Content types must match
        if resp1.content_types != resp2.content_types:
            self.differences.append(
                Difference(
                    type=DifferenceType.RESPONSE_HEADERS_MISMATCH,
                    message=f"Response content types mismatch: {resp1.content_types} vs {resp2.content_types}",
                    context=context,
                )
            )
            print(
                f"Response content types mismatch \t {context}\t {resp1.content_types} vs {resp2.content_types}"
            )

    def _compare_definitions(self, api1: CanonicalApi, api2: CanonicalApi) -> None:
        """Compare definition dictionaries according to equiv_contract.md section 4.7."""
        defs1 = set(api1.definitions.keys())
        defs2 = set(api2.definitions.keys())

        # Definition name sets must match
        missing_defs = defs1 - defs2
        extra_defs = defs2 - defs1

        # Find potential matches between missing and extra definitions
        potential_matches = self._find_definition_matches(
            missing_defs, extra_defs, api1, api2
        )

        # Promote high-confidence matches to compare instead of reporting as missing/extra
        promoted_def_matches = []
        for match in potential_matches:
            missing_def, extra_def, similarity = match
            # High similarity threshold for definitions (0.75 to catch suffix additions like "Algorithm")
            if similarity > 0.75:
                promoted_def_matches.append((missing_def, extra_def))

        # Remove promoted matches from potential_matches to avoid duplicate "Possible Match" hints
        promoted_def_names = {(m, e) for m, e in promoted_def_matches}
        potential_matches = [
            m for m in potential_matches if (m[0], m[1]) not in promoted_def_names
        ]

        # Context format: operation_id || path_method || context_suffix || possible_match
        # Remove promoted matches and compare them
        for missing_def, extra_def in promoted_def_matches:
            missing_defs.discard(missing_def)
            extra_defs.discard(extra_def)
            print(f"Potential definition match\t {missing_def} vs {extra_def}")
            # Compare the matched definitions
            schema1 = api1.definitions[missing_def]
            schema2 = api2.definitions[extra_def]
            if not self._schemas_equal(schema1, schema2):
                schema_diffs = self._get_schema_differences(schema1, schema2)
                diff_details = (
                    "\n    - " + "\n    - ".join(schema_diffs)
                    if schema_diffs
                    else "unknown differences"
                )
                message = f"Definition '{missing_def}' (matched with '{extra_def}') has schema differences:{diff_details}"
                self.differences.append(
                    Difference(
                        type=DifferenceType.DEFINITION_MISMATCH,
                        message=message,
                        context=f" ||{missing_def} || ||{extra_def}",
                    )
                )
                print(
                    f"Definition schemas mismatch (potential match)\t {missing_def} ~ {extra_def}\n{diff_details}"
                )

        for def_name in missing_defs:
            # Check if this missing definition has a potential match
            matches = [match for match in potential_matches if match[0] == def_name]
            possible_match = matches[0][1] if matches else ""

            self.differences.append(
                Difference(
                    type=DifferenceType.MISSING_DEFINITION,
                    message=f"Definition missing in {api2.swagger_source} : {def_name}",
                    context=f" || {def_name} ||  || {possible_match}",
                )
            )
            print(
                f"Definition missing in {api2.swagger_source} \t {def_name}"
                + (f"\t|| Possible Match: {possible_match}" if possible_match else "")
            )

        for def_name in extra_defs:
            # Check if this extra definition has a potential match
            matches = [match for match in potential_matches if match[1] == def_name]
            possible_match = matches[0][0] if matches else ""

            self.differences.append(
                Difference(
                    type=DifferenceType.EXTRA_DEFINITION,
                    message=f"Extra definition in {api2.swagger_source}: {def_name}",
                    context=f" || {def_name} ||  || {possible_match}",
                )
            )
            print(
                f"Extra definition in {api2.swagger_source} \t {def_name}"
                + (f"\t|| Possible Match: {possible_match}" if possible_match else "")
            )

        # Compare common definitions
        common_defs = defs1 & defs2
        for def_name in common_defs:
            schema1 = api1.definitions[def_name]
            schema2 = api2.definitions[def_name]
            if not self._schemas_equal(schema1, schema2):
                # Get detailed schema differences
                schema_diffs = self._get_schema_differences(schema1, schema2)
                diff_details = (
                    "\n    - " + "\n    - ".join(schema_diffs)
                    if schema_diffs
                    else "unknown differences"
                )
                message = (
                    f"Definition '{def_name}' has schema differences:{diff_details}"
                )

                self.differences.append(
                    Difference(
                        type=DifferenceType.DEFINITION_MISMATCH,
                        message=message,
                        context=f" || {def_name} ||  || ",
                    )
                )
                print(f"Definition schemas mismatch \t {def_name}\n{diff_details}")

    def _get_schema_differences(
        self, schema1: Optional[CanonicalSchema], schema2: Optional[CanonicalSchema]
    ) -> List[str]:
        """Get list of specific schema differences."""
        if schema1 is None and schema2 is None:
            return []
        if schema1 is None:
            return ["schema missing in first spec"]
        if schema2 is None:
            return ["schema missing in second spec"]

        differences = []

        # Core schema fields
        if schema1.type != schema2.type:
            differences.append(f"type: {schema1.type} vs {schema2.type}")
        if schema1.format != schema2.format:
            differences.append(f"format: {schema1.format} vs {schema2.format}")
        if schema1.ref != schema2.ref:
            differences.append(f"ref: {schema1.ref} vs {schema2.ref}")

        # Object schema differences
        if not self._object_schemas_equal(schema1, schema2):
            props1 = schema1.properties or {}
            props2 = schema2.properties or {}
            if set(props1.keys()) != set(props2.keys()):
                missing_props = set(props1.keys()) - set(props2.keys())
                extra_props = set(props2.keys()) - set(props1.keys())
                if missing_props:
                    differences.append(
                        f"missing properties: {', '.join(sorted(missing_props))}"
                    )
                if extra_props:
                    differences.append(
                        f"extra properties: {', '.join(sorted(extra_props))}"
                    )

            # Compare property schemas for common properties
            common_props = set(props1.keys()) & set(props2.keys())
            for prop_name in sorted(common_props):
                if not self._schemas_equal(props1[prop_name], props2[prop_name]):
                    prop_diffs = self._get_schema_differences(
                        props1[prop_name], props2[prop_name]
                    )
                    if prop_diffs:
                        differences.append(
                            f"property '{prop_name}': {'; '.join(prop_diffs)}"
                        )

            if schema1.required != schema2.required:
                req1 = schema1.required or frozenset()
                req2 = schema2.required or frozenset()
                missing_required = req1 - req2
                extra_required = req2 - req1
                if missing_required:
                    differences.append(
                        f"missing required fields: {', '.join(sorted(missing_required))}"
                    )
                if extra_required:
                    differences.append(
                        f"extra required fields: {', '.join(sorted(extra_required))}"
                    )

            if schema1.additional_properties != schema2.additional_properties:
                differences.append(
                    f"additionalProperties: {schema1.additional_properties} vs {schema2.additional_properties}"
                )

        # Array schema differences
        if not self._array_schemas_equal(schema1, schema2):
            if (schema1.items is None) != (schema2.items is None):
                differences.append(
                    f"items schema: {schema1.items is not None} vs {schema2.items is not None}"
                )

        # Constraint differences
        if not self._constraints_equal(schema1.constraints, schema2.constraints):
            constraint_diffs = self._get_constraint_differences(
                schema1.constraints, schema2.constraints
            )
            differences.extend([f"constraint {diff}" for diff in constraint_diffs])

        # Composed schema differences
        if not self._composed_schemas_equal(schema1, schema2):
            if (schema1.all_of is None) != (schema2.all_of is None):
                differences.append(
                    f"allOf: {schema1.all_of is not None} vs {schema2.all_of is not None}"
                )
            if (schema1.one_of is None) != (schema2.one_of is None):
                differences.append(
                    f"oneOf: {schema1.one_of is not None} vs {schema2.one_of is not None}"
                )
            if (schema1.any_of is None) != (schema2.any_of is None):
                differences.append(
                    f"anyOf: {schema1.any_of is not None} vs {schema2.any_of is not None}"
                )

        return differences

    def _get_header_differences(
        self, headers1: Optional[Dict], headers2: Optional[Dict]
    ) -> List[str]:
        """Get list of specific header differences."""
        headers1 = headers1 or {}
        headers2 = headers2 or {}

        differences = []

        # Check for missing/extra headers
        missing_headers = set(headers1.keys()) - set(headers2.keys())
        extra_headers = set(headers2.keys()) - set(headers1.keys())

        if missing_headers:
            differences.append(f"missing headers: {', '.join(sorted(missing_headers))}")
        if extra_headers:
            differences.append(f"extra headers: {', '.join(sorted(extra_headers))}")

        # Check for schema differences in common headers
        common_headers = set(headers1.keys()) & set(headers2.keys())
        for header_name in common_headers:
            if not self._schemas_equal(headers1[header_name], headers2[header_name]):
                schema_diffs = self._get_schema_differences(
                    headers1[header_name], headers2[header_name]
                )
                if schema_diffs:
                    differences.append(
                        f"header '{header_name}' schema: {'; '.join(schema_diffs)}"
                    )

        return differences

    def _schemas_equal(
        self, schema1: Optional[CanonicalSchema], schema2: Optional[CanonicalSchema]
    ) -> bool:
        """
        Compare two schemas for equality according to equiv_contract.md section 4.

        Schemas are compared recursively and must match on:
        - Core schema fields (type, format - no coercion)
        - Object schemas (properties, required, additionalProperties)
        - Array schemas (items, constraints)
        - Enums (sets must match exactly, ordering ignored)
        - References ($ref values)
        - Composed schemas (allOf/oneOf/anyOf component counts and schemas)
        """
        # Handle None cases
        if schema1 is None and schema2 is None:
            return True
        if schema1 is None or schema2 is None:
            return False

        # 4.1 Core Schema Fields - type and format must match exactly (no coercion)
        if schema1.type != schema2.type:
            return False
        if schema1.format != schema2.format:
            return False

        # 4.5 References - $ref values must match exactly
        if schema1.ref != schema2.ref:
            return False

        # 4.2 Object Schemas
        if not self._object_schemas_equal(schema1, schema2):
            return False

        # 4.3 Array Schemas
        if not self._array_schemas_equal(schema1, schema2):
            return False

        # Constraints (including 4.4 Enums)
        if not self._constraints_equal(schema1.constraints, schema2.constraints):
            return False

        # 4.6 Composed Schemas
        if not self._composed_schemas_equal(schema1, schema2):
            return False

        return True

    def _object_schemas_equal(
        self, schema1: CanonicalSchema, schema2: CanonicalSchema
    ) -> bool:
        """Compare object schema fields."""
        # Property sets must match exactly
        props1 = schema1.properties or {}
        props2 = schema2.properties or {}

        if set(props1.keys()) != set(props2.keys()):
            return False

        # Each property schema must be equivalent
        for prop_name in props1.keys():
            if not self._schemas_equal(props1[prop_name], props2[prop_name]):
                return False

        # Required sets must match
        if schema1.required != schema2.required:
            return False

        # additionalProperties must match
        add_props1 = schema1.additional_properties
        add_props2 = schema2.additional_properties

        if type(add_props1) is not type(add_props2):
            return False

        if isinstance(add_props1, CanonicalSchema):
            if not self._schemas_equal(add_props1, add_props2):
                return False
        elif add_props1 != add_props2:
            return False

        return True

    def _array_schemas_equal(
        self, schema1: CanonicalSchema, schema2: CanonicalSchema
    ) -> bool:
        """Compare array schema fields."""
        # Items schema must match
        if not self._schemas_equal(schema1.items, schema2.items):
            return False

        # Array constraints are handled in _constraints_equal
        return True

    def _constraints_equal(
        self,
        constraints1: Optional[CanonicalConstraints],
        constraints2: Optional[CanonicalConstraints],
    ) -> bool:
        """Compare constraint objects including enums."""
        if constraints1 is None and constraints2 is None:
            return True
        if constraints1 is None or constraints2 is None:
            return False

        # All constraint fields must match exactly
        return (
            constraints1.minimum == constraints2.minimum
            and constraints1.maximum == constraints2.maximum
            and constraints1.exclusive_minimum == constraints2.exclusive_minimum
            and constraints1.exclusive_maximum == constraints2.exclusive_maximum
            and constraints1.min_length == constraints2.min_length
            and constraints1.max_length == constraints2.max_length
            and constraints1.pattern == constraints2.pattern
            and constraints1.min_items == constraints2.min_items
            and constraints1.max_items == constraints2.max_items
            and constraints1.unique_items == constraints2.unique_items
            and constraints1.enum == constraints2.enum  # Frozensets handle ordering
            and constraints1.default == constraints2.default
        )

    def _get_constraint_differences(
        self,
        constraints1: Optional[CanonicalConstraints],
        constraints2: Optional[CanonicalConstraints],
    ) -> List[str]:
        """Get list of specific constraint differences."""
        if constraints1 is None and constraints2 is None:
            return []
        if constraints1 is None:
            return ["constraints missing in first spec"]
        if constraints2 is None:
            return ["constraints missing in second spec"]

        differences = []

        if constraints1.minimum != constraints2.minimum:
            differences.append(
                f"minimum: {constraints1.minimum} vs {constraints2.minimum}"
            )
        if constraints1.maximum != constraints2.maximum:
            differences.append(
                f"maximum: {constraints1.maximum} vs {constraints2.maximum}"
            )
        if constraints1.exclusive_minimum != constraints2.exclusive_minimum:
            differences.append(
                f"exclusive_minimum: {constraints1.exclusive_minimum} vs {constraints2.exclusive_minimum}"
            )
        if constraints1.exclusive_maximum != constraints2.exclusive_maximum:
            differences.append(
                f"exclusive_maximum: {constraints1.exclusive_maximum} vs {constraints2.exclusive_maximum}"
            )
        if constraints1.min_length != constraints2.min_length:
            differences.append(
                f"min_length: {constraints1.min_length} vs {constraints2.min_length}"
            )
        if constraints1.max_length != constraints2.max_length:
            differences.append(
                f"max_length: {constraints1.max_length} vs {constraints2.max_length}"
            )
        if constraints1.pattern != constraints2.pattern:
            differences.append(
                f"pattern: '{constraints1.pattern}' vs '{constraints2.pattern}'"
            )
        if constraints1.min_items != constraints2.min_items:
            differences.append(
                f"min_items: {constraints1.min_items} vs {constraints2.min_items}"
            )
        if constraints1.max_items != constraints2.max_items:
            differences.append(
                f"max_items: {constraints1.max_items} vs {constraints2.max_items}"
            )
        if constraints1.unique_items != constraints2.unique_items:
            differences.append(
                f"unique_items: {constraints1.unique_items} vs {constraints2.unique_items}"
            )
        if constraints1.enum != constraints2.enum:
            # Show enum differences in a more readable way
            enum1 = set(constraints1.enum) if constraints1.enum else set()
            enum2 = set(constraints2.enum) if constraints2.enum else set()

            if enum1 and enum2:
                missing_values = enum1 - enum2
                extra_values = enum2 - enum1
                if missing_values or extra_values:
                    enum_diff_parts = []
                    if missing_values:
                        enum_diff_parts.append(
                            f"missing values: [{', '.join(sorted(missing_values))}]"
                        )
                    if extra_values:
                        enum_diff_parts.append(
                            f"extra values: [{', '.join(sorted(extra_values))}]"
                        )
                    differences.append(f"enum: {'; '.join(enum_diff_parts)}")
                else:
                    # Same values, likely ordering difference (shouldn't happen with sets)
                    differences.append(f"enum: ordering difference")
            else:
                enum1_str = ", ".join(sorted(enum1)) if enum1 else "None"
                enum2_str = ", ".join(sorted(enum2)) if enum2 else "None"
                differences.append(f"enum: [{enum1_str}] vs [{enum2_str}]")
        if constraints1.default != constraints2.default:
            differences.append(
                f"default: {constraints1.default} vs {constraints2.default}"
            )

        return differences

    def _composed_schemas_equal(
        self, schema1: CanonicalSchema, schema2: CanonicalSchema
    ) -> bool:
        """Compare composed schema fields (allOf, oneOf, anyOf)."""
        # Component counts must match, and component schemas must match
        if not self._schema_lists_equal(schema1.all_of, schema2.all_of):
            return False
        if not self._schema_lists_equal(schema1.one_of, schema2.one_of):
            return False
        if not self._schema_lists_equal(schema1.any_of, schema2.any_of):
            return False

        return True

    def _schema_lists_equal(
        self,
        list1: Optional[List[CanonicalSchema]],
        list2: Optional[List[CanonicalSchema]],
    ) -> bool:
        """Compare lists of schemas."""
        if list1 is None and list2 is None:
            return True
        if list1 is None or list2 is None:
            return False
        if len(list1) != len(list2):
            return False

        # Component schemas must match (treating as ordered lists)
        for i in range(len(list1)):
            if not self._schemas_equal(list1[i], list2[i]):
                return False

        return True

    def _headers_equal(
        self, headers1: Optional[Dict], headers2: Optional[Dict]
    ) -> bool:
        """Compare response headers dictionaries."""
        headers1 = headers1 or {}
        headers2 = headers2 or {}

        if set(headers1.keys()) != set(headers2.keys()):
            return False

        for header_name in headers1.keys():
            if not self._schemas_equal(headers1[header_name], headers2[header_name]):
                return False

        return True

    def _compare_global_parameters(
        self, api1: CanonicalApi, api2: CanonicalApi
    ) -> None:
        """Compare global parameter definitions with support for parameter grouping."""
        params1 = api1.parameters or {}
        params2 = api2.parameters or {}

        # Extract grouping information for both APIs
        # Note: Hand-authored specs typically have SearchOptions/SuggestOptions parameters
        # defined inline in operations with x-ms-parameter-grouping, while TSP-compiled
        # specs have them as global parameters with dot notation (SearchOptions.xxx).
        # We only compare parameter groups that exist in the global parameters section.
        ungrouped1, grouped1 = self._extract_parameter_grouping(params1)
        ungrouped2, grouped2 = self._extract_parameter_grouping(params2)

        # Compare parameter groups (SearchOptions and SuggestOptions)
        # Handle cross-level comparison: global parameters in one spec vs operation-level in another
        for group_name in ["SearchOptions", "SuggestOptions"]:
            group1_params = grouped1.get(group_name, [])
            group2_params = grouped2.get(group_name, [])

            if group1_params and group2_params:
                # Both have the group in global parameters, perform detailed comparison
                print(
                    f"Comparing {group_name} parameter group: {len(group1_params)} params in {api1.swagger_source} vs {len(group2_params)} in {api2.swagger_source}"
                )
                self._compare_parameter_group(
                    group1_params,
                    group2_params,
                    group_name,
                    api1.swagger_source,
                    api2.swagger_source,
                )
            elif not group1_params and group2_params:
                # API2 has the group in global params, check if API1 has them in operations
                print(
                    f"Extracting {group_name} parameters from {api1.swagger_source} operations for cross-level comparison..."
                )
                operation_level_groups1 = (
                    self._extract_operation_level_grouped_parameters(api1)
                )
                op_group1_params = operation_level_groups1.get(group_name, [])

                if op_group1_params:
                    print(
                        f"Comparing {group_name} parameter group (cross-level): {len(op_group1_params)} params in {api1.swagger_source} operations vs {len(group2_params)} in {api2.swagger_source} global"
                    )
                    self._compare_parameter_group(
                        op_group1_params,
                        group2_params,
                        group_name,
                        api1.swagger_source,
                        api2.swagger_source,
                    )
                else:
                    print(
                        f"Note: {group_name} parameters not found in {api1.swagger_source} (neither global nor operations)"
                    )
            elif group1_params and not group2_params:
                # API1 has the group in global params, check if API2 has them in operations
                print(
                    f"Extracting {group_name} parameters from {api2.swagger_source} operations for cross-level comparison..."
                )
                operation_level_groups2 = (
                    self._extract_operation_level_grouped_parameters(api2)
                )
                op_group2_params = operation_level_groups2.get(group_name, [])

                if op_group2_params:
                    print(
                        f"Comparing {group_name} parameter group (cross-level): {len(group1_params)} params in {api1.swagger_source} global vs {len(op_group2_params)} in {api2.swagger_source} operations"
                    )
                    self._compare_parameter_group(
                        group1_params,
                        op_group2_params,
                        group_name,
                        api1.swagger_source,
                        api2.swagger_source,
                    )
                else:
                    print(
                        f"Note: {group_name} parameters not found in {api2.swagger_source} (neither global nor operations)"
                    )

        # Compare ungrouped parameters using existing logic
        param_names1 = set(ungrouped1.keys())
        param_names2 = set(ungrouped2.keys())

        # Check for missing/extra ungrouped global parameters
        missing_params = param_names1 - param_names2
        extra_params = param_names2 - param_names1

        # Find potential fuzzy matches for ungrouped global parameters
        global_param_matches = self._find_string_matches(
            missing_params, extra_params, threshold=0.6
        )

        # Also check for Parameter suffix matches even if not in fuzzy matches
        # This handles cases where parameter exists in operations but not in global parameters
        # NOTE: Some parameters like DisableCacheReprocessingChangeDetectionParameter are defined
        # as global parameters in hand-authored swagger but as inline operation parameters in TSP.
        # These won't match here and should be filtered as false positives.
        parameter_suffix_matches = []
        for missing_param in missing_params:
            if missing_param.endswith("Parameter"):
                base_name = missing_param[: -len("Parameter")]
                camel_case_name = (
                    base_name[0].lower() + base_name[1:] if base_name else ""
                )
                # Check if this camelCase name exists in extra_params
                if camel_case_name in extra_params:
                    parameter_suffix_matches.append(
                        (missing_param, camel_case_name, 1.0)
                    )

        for extra_param in extra_params:
            if extra_param.endswith("Parameter"):
                base_name = extra_param[: -len("Parameter")]
                camel_case_name = (
                    base_name[0].lower() + base_name[1:] if base_name else ""
                )
                # Check if this camelCase name exists in missing_params
                if camel_case_name in missing_params:
                    parameter_suffix_matches.append((camel_case_name, extra_param, 1.0))

        # Promote high-confidence matches for comparison
        promoted_global_param_matches = []
        for match in global_param_matches:
            missing_param, extra_param, similarity = match
            # High similarity or OData-style differences
            if (
                similarity > 0.85
                or missing_param.lstrip("$") == extra_param
                or extra_param.lstrip("$") == missing_param
            ):
                promoted_global_param_matches.append((missing_param, extra_param))
            # Pattern-based matching for Azure.Core.* parameters
            # e.g., ApiVersionParameter <-> Azure.Core.Foundations.ApiVersionParameter
            # e.g., ClientRequestIdParameter <-> Azure.Core.ClientRequestIdHeader
            elif (
                (
                    missing_param in extra_param
                    or missing_param.replace("Parameter", "") in extra_param
                    or missing_param.replace("Parameter", "Header") in extra_param
                )
                and "Azure.Core" in extra_param
                and similarity > 0.6
            ) or (
                (
                    extra_param in missing_param
                    or extra_param.replace("Header", "") in missing_param
                    or extra_param.replace("Header", "Parameter") in missing_param
                )
                and "Azure.Core" in missing_param
                and similarity > 0.6
            ):
                promoted_global_param_matches.append((missing_param, extra_param))
            # Check if removing "Parameter" suffix gives a camelCase match
            # e.g., DisableCacheReprocessingChangeDetectionParameter -> disableCacheReprocessingChangeDetection
            # e.g., IgnoreResetRequirementsParameter -> ignoreResetRequirements
            elif missing_param.endswith("Parameter"):
                base_name = missing_param[: -len("Parameter")]
                # Convert PascalCase to camelCase for comparison
                camel_case_name = (
                    base_name[0].lower() + base_name[1:] if base_name else ""
                )
                if camel_case_name == extra_param and similarity > 0.7:
                    promoted_global_param_matches.append((missing_param, extra_param))
            elif extra_param.endswith("Parameter"):
                base_name = extra_param[: -len("Parameter")]
                # Convert PascalCase to camelCase for comparison
                camel_case_name = (
                    base_name[0].lower() + base_name[1:] if base_name else ""
                )
                if camel_case_name == missing_param and similarity > 0.7:
                    promoted_global_param_matches.append((missing_param, extra_param))

        # Add parameter suffix matches to promoted matches
        for missing_param, extra_param, _ in parameter_suffix_matches:
            if (missing_param, extra_param) not in promoted_global_param_matches:
                promoted_global_param_matches.append((missing_param, extra_param))

        # Remove promoted matches from global_param_matches to avoid duplicate hints
        promoted_global_param_names = {(m, e) for m, e in promoted_global_param_matches}
        global_param_matches = [
            m
            for m in global_param_matches
            if (m[0], m[1]) not in promoted_global_param_names
        ]

        # Remove promoted matches and compare them
        for missing_param, extra_param in promoted_global_param_matches:
            missing_params.discard(missing_param)
            extra_params.discard(extra_param)
            print(f"Potential global parameter match\t{missing_param} ~ {extra_param}")

            # Add to differences for Excel export
            self.differences.append(
                Difference(
                    type=DifferenceType.GLOBAL_PARAMETER_MISMATCH,
                    message=f"Global parameter: {missing_param}",
                    context=f"||global_parameter||{missing_param}||{extra_param}",
                )
            )

            # Compare the matched parameters
            param1 = params1[missing_param]
            param2 = params2[extra_param]
            self._compare_parameter(
                param1,
                param2,
                f"global_parameter:{missing_param}~{extra_param}",
                api1.swagger_source,
                api2.swagger_source,
            )

        for param_name in missing_params:
            # Check if this missing parameter has a potential match
            matches = [
                match for match in global_param_matches if match[0] == param_name
            ]
            possible_match = matches[0][1] if matches else ""

            self.differences.append(
                Difference(
                    type=DifferenceType.MISSING_GLOBAL_PARAMETER,
                    message=f"Global parameter missing in {api2.swagger_source}: {param_name}",
                    context=f"||{param_name}||{possible_match}",
                )
            )
            print(
                f"Global parameter missing in {api2.swagger_source}\t{param_name}"
                + (f"\t|| Possible Match: {possible_match}" if possible_match else "")
            )

        for param_name in extra_params:
            # Check if this extra parameter has a potential match
            matches = [
                match for match in global_param_matches if match[1] == param_name
            ]
            possible_match = matches[0][0] if matches else ""

            self.differences.append(
                Difference(
                    type=DifferenceType.EXTRA_GLOBAL_PARAMETER,
                    message=f"Extra global parameter in {api2.swagger_source}: {param_name}",
                    context=f"||{param_name}|||{possible_match}",
                )
            )
            print(
                f"Extra global parameter in {api2.swagger_source}\t{param_name}"
                + (f"\t|| Possible Match: {possible_match}" if possible_match else "")
            )

        # Compare common global parameters
        common_params = param_names1 & param_names2
        for param_name in common_params:
            param1 = params1[param_name]
            param2 = params2[param_name]
            self._compare_parameter(param1, param2, f"global_parameter:{param_name}")

    def _compare_global_responses(self, api1: CanonicalApi, api2: CanonicalApi) -> None:
        """Compare global response definitions."""
        responses1 = api1.responses or {}
        responses2 = api2.responses or {}

        response_names1 = set(responses1.keys())
        response_names2 = set(responses2.keys())

        # Check for missing/extra global responses
        missing_responses = response_names1 - response_names2
        extra_responses = response_names2 - response_names1

        for response_name in missing_responses:
            self.differences.append(
                Difference(
                    type=DifferenceType.MISSING_GLOBAL_RESPONSE,
                    message=f"Global response missing in {api2.swagger_source}: {response_name}",
                    context=f"global_response: {response_name}",
                )
            )
            print(f"Global response missing in {api2.swagger_source}\t {response_name}")

        for response_name in extra_responses:
            self.differences.append(
                Difference(
                    type=DifferenceType.EXTRA_GLOBAL_RESPONSE,
                    message=f"Extra global response in {api2.swagger_source}: {response_name}",
                    context=f"global_response: {response_name}",
                )
            )
            print(f"Extra global response in {api2.swagger_source}\t {response_name}")

        # Compare common global responses
        common_responses = response_names1 & response_names2
        for response_name in common_responses:
            response1 = responses1[response_name]
            response2 = responses2[response_name]
            self._compare_response(
                response1, response2, f"global_response: {response_name}"
            )

    def _compare_global_configuration(
        self, api1: CanonicalApi, api2: CanonicalApi
    ) -> None:
        """Compare global API configuration fields."""
        # Swagger version
        if api1.swagger_version != api2.swagger_version:
            self.differences.append(
                Difference(
                    type=DifferenceType.SWAGGER_VERSION_MISMATCH,
                    message=f"Swagger version mismatch: '{api1.swagger_version}' vs '{api2.swagger_version}'",
                    context="global_config",
                )
            )
            print(
                f"Swagger version mismatch\t '{api1.swagger_version}' vs '{api2.swagger_version}'"
            )

        # Info section
        if api1.info != api2.info:
            self.differences.append(
                Difference(
                    type=DifferenceType.INFO_MISMATCH,
                    message="Info sections mismatch",
                    context="global_config",
                )
            )
            print("Info sections mismatch")

        # Global content types
        if api1.consumes != api2.consumes:
            self.differences.append(
                Difference(
                    type=DifferenceType.GLOBAL_CONSUMES_MISMATCH,
                    message=f"Global consumes mismatch: {api1.consumes} vs {api2.consumes}",
                    context="global_config",
                )
            )
            print(f"Global consumes mismatch\t {api1.consumes} vs {api2.consumes}")
        if api1.produces != api2.produces:
            self.differences.append(
                Difference(
                    type=DifferenceType.GLOBAL_PRODUCES_MISMATCH,
                    message=f"Global produces mismatch: {api1.produces} vs {api2.produces}",
                    context="global_config",
                )
            )
            print(f"Global produces mismatch\t {api1.produces} vs {api2.produces}")

        # Connection configuration
        if api1.schemes != api2.schemes:
            self.differences.append(
                Difference(
                    type=DifferenceType.SCHEMES_MISMATCH,
                    message=f"Schemes mismatch: {api1.schemes} vs {api2.schemes}",
                    context="global_config",
                )
            )
            print(f"Schemes mismatch\t {api1.schemes} vs {api2.schemes}")

        if api1.host != api2.host:
            self.differences.append(
                Difference(
                    type=DifferenceType.HOST_MISMATCH,
                    message=f"Host mismatch: '{api1.host}' vs '{api2.host}'",
                    context="global_config",
                )
            )
            print(f"Host mismatch\t '{api1.host}' vs '{api2.host}'")

        if api1.base_path != api2.base_path:
            self.differences.append(
                Difference(
                    type=DifferenceType.BASE_PATH_MISMATCH,
                    message=f"Base path mismatch: '{api1.base_path}' vs '{api2.base_path}'",
                    context="global_config",
                )
            )
            print(f"Base path mismatch: '{api1.base_path}' vs '{api2.base_path}'")

        # Azure/Microsoft-specific extensions
        if api1.x_ms_parameterized_host != api2.x_ms_parameterized_host:
            self.differences.append(
                Difference(
                    type=DifferenceType.X_MS_PARAMETERIZED_HOST_MISMATCH,
                    message="x-ms-parameterized-host mismatch",
                    context="global_config",
                )
            )
            print("x-ms-parameterized-host mismatch")

        if api1.x_ms_code_generation_settings != api2.x_ms_code_generation_settings:
            self.differences.append(
                Difference(
                    type=DifferenceType.X_MS_CODE_GENERATION_SETTINGS_MISMATCH,
                    message="x-ms-code-generation-settings mismatch",
                    context="global_config",
                )
            )
            print("x-ms-code-generation-settings mismatch")

        # Security configuration
        if api1.security_definitions != api2.security_definitions:
            self.differences.append(
                Difference(
                    type=DifferenceType.SECURITY_DEFINITIONS_MISMATCH,
                    message="Security definitions mismatch",
                    context="global_config",
                )
            )
            print("Security definitions mismatch")

        if api1.security != api2.security:
            self.differences.append(
                Difference(
                    type=DifferenceType.SECURITY_MISMATCH,
                    message="Security requirements mismatch",
                    context="global_config",
                )
            )
            print("Security requirements mismatch")

    def _extract_parameter_grouping(self, params_dict):
        """Extract parameter grouping information for SearchOptions and SuggestOptions.

        Returns:
            - ungrouped_params: Dict of parameters not in SearchOptions/SuggestOptions groups
            - grouped_params: Dict with group names as keys and list of parameter dicts as values
                Each parameter dict contains 'full_name', 'base_name', and 'param' (CanonicalParameter object)
        """
        ungrouped_params = {}
        grouped_params = {"SearchOptions": [], "SuggestOptions": []}

        for param_name, param in params_dict.items():
            # Check if parameter follows SearchOptions.<name> or SuggestOptions.<name> pattern (TSP style)
            if param_name.startswith("SearchOptions."):
                # Always use the actual parameter name from the definition (e.g., "$filter")
                # This ensures consistent comparison: SearchOptions.$filter vs SearchOptions.$filter
                base_name = (
                    param.name if param.name else param_name[len("SearchOptions.") :]
                )
                # Build full_name using actual parameter name from definition
                full_name = f"SearchOptions.{base_name}"
                grouped_params["SearchOptions"].append(
                    {"full_name": full_name, "base_name": base_name, "param": param}
                )
            elif param_name.startswith("SuggestOptions."):
                # Always use the actual parameter name from the definition (e.g., "$filter")
                # This ensures consistent comparison: SuggestOptions.$filter vs SuggestOptions.$filter
                base_name = (
                    param.name if param.name else param_name[len("SuggestOptions.") :]
                )
                # Build full_name using actual parameter name from definition
                full_name = f"SuggestOptions.{base_name}"
                grouped_params["SuggestOptions"].append(
                    {"full_name": full_name, "base_name": base_name, "param": param}
                )
            else:
                # For hand-authored swagger, check x-ms-parameter-grouping
                if param.x_ms_parameter_grouping:
                    group_name = param.x_ms_parameter_grouping.get("name")
                    if group_name in ["SearchOptions", "SuggestOptions"]:
                        # Always use the actual parameter name from definition (not x-ms-client-name)
                        # This ensures consistent comparison with TSP-compiled swagger
                        base_name = param.name if param.name else param_name
                        # Build full_name using actual parameter name from definition
                        full_name = f"{group_name}.{base_name}"
                        grouped_params[group_name].append(
                            {
                                "full_name": full_name,
                                "base_name": base_name,
                                "param": param,
                            }
                        )
                        continue
                # Check if this might be a grouped parameter that we missed
                if param.name in [
                    "$count",
                    "$filter",
                    "$orderby",
                    "$search",
                    "$select",
                    "$skip",
                    "$top",
                ]:
                    print(
                        f"    DEBUG: Ungrouped param '{param_name}' (name={param.name}), x_ms_parameter_grouping={param.x_ms_parameter_grouping}, x_ms_client_name={param.x_ms_client_name}"
                    )
                ungrouped_params[param_name] = param

        return ungrouped_params, grouped_params

    def _extract_operation_level_grouped_parameters(self, api: CanonicalApi):
        """Extract parameters with x-ms-parameter-grouping from all operations.

        This is used to find SearchOptions/SuggestOptions parameters that are defined
        inline in operations (typical in hand-authored swagger) rather than as global
        parameters (typical in TSP-compiled swagger).

        Returns:
            Dict with group names as keys and list of parameter dicts as values.
            Each parameter dict contains 'full_name', 'base_name', 'param', and 'operations'
            where 'operations' is a list of operation IDs that use this parameter.
        """
        grouped_params = {"SearchOptions": {}, "SuggestOptions": {}}

        for path, path_obj in api.paths.items():
            for method, operation in path_obj.operations.items():
                for param_key, param in (operation.parameters or {}).items():
                    if param.x_ms_parameter_grouping:
                        group_name = param.x_ms_parameter_grouping.get("name")
                        if group_name in ["SearchOptions", "SuggestOptions"]:
                            # Always use the actual parameter name from definition (not x-ms-client-name)
                            # This ensures consistent comparison with TSP-compiled swagger
                            actual_name = param.name if param.name else param_key
                            extended_name = f"{group_name}.{actual_name}"

                            # Use lowercase for matching
                            base_name = actual_name.lower()

                            if base_name not in grouped_params[group_name]:
                                grouped_params[group_name][base_name] = {
                                    "full_name": extended_name,
                                    "base_name": actual_name,
                                    "param": param,
                                    "operations": [],
                                }
                            grouped_params[group_name][base_name]["operations"].append(
                                operation.operation_id or f"{path} {method}"
                            )

        # Convert to list format for consistency with _extract_parameter_grouping
        result = {}
        for group_name, params_dict in grouped_params.items():
            result[group_name] = list(params_dict.values())

        return result

    def _compare_parameter_group(
        self, group1_params, group2_params, group_name, source1, source2
    ):
        """Compare parameters within a parameter group with fuzzy matching and detailed comparison.

        Args:
            group1_params: List of parameter dicts from first API (each has 'full_name', 'base_name', 'param')
            group2_params: List of parameter dicts from second API
            group_name: Name of the parameter group (e.g., 'SearchOptions')
            source1: Swagger source identifier for first API
            source2: Swagger source identifier for second API
        """
        # Build mappings using actual parameter names from definitions
        # Step 1: Build case-sensitive mappings first
        group1_original = {}
        group1_by_lowercase = {}
        for p in group1_params:
            # Always use base_name which is already set to param.name in extraction
            base_name = p.get("base_name", p.get("full_name", ""))
            group1_original[base_name] = p
            group1_by_lowercase[base_name.lower()] = p

        group2_original = {}
        group2_by_lowercase = {}
        for p in group2_params:
            # Always use base_name which is already set to param.name in extraction
            base_name = p.get("base_name", p.get("full_name", ""))
            group2_original[base_name] = p
            group2_by_lowercase[base_name.lower()] = p

        # Step 2: Find exact case-sensitive matches
        keys1_original = set(group1_original.keys())
        keys2_original = set(group2_original.keys())
        exact_matches = keys1_original & keys2_original

        # Step 3: Find case-insensitive matches (but not exact)
        keys1_lower = set(group1_by_lowercase.keys())
        keys2_lower = set(group2_by_lowercase.keys())
        case_insensitive_matches = []

        for key1_lower in keys1_lower:
            if key1_lower in keys2_lower:
                # Find original case versions
                key1_original = None
                key2_original = None
                for k in keys1_original:
                    if k.lower() == key1_lower:
                        key1_original = k
                        break
                for k in keys2_original:
                    if k.lower() == key1_lower:
                        key2_original = k
                        break

                # If they differ in case, it's a case-insensitive match
                if key1_original and key2_original and key1_original != key2_original:
                    case_insensitive_matches.append((key1_original, key2_original))
                    exact_matches.discard(key1_original)

        # Step 4: Find remaining missing/extra parameters (after case-insensitive matching)
        matched_keys1 = exact_matches | {m[0] for m in case_insensitive_matches}
        matched_keys2 = exact_matches | {m[1] for m in case_insensitive_matches}

        missing_keys_original = keys1_original - matched_keys1
        extra_keys_original = keys2_original - matched_keys2

        # Convert to lowercase for fuzzy matching
        missing_keys = {k.lower() for k in missing_keys_original}
        extra_keys = {k.lower() for k in extra_keys_original}

        # Find fuzzy matches only for remaining missing/extra parameters
        fuzzy_matches = self._find_string_matches(
            missing_keys, extra_keys, threshold=0.6
        )

        # Process fuzzy matches and promote high-confidence ones
        promoted_matches = []
        for match in fuzzy_matches:
            missing_key, extra_key, similarity = match

            # High confidence if:
            # 1. One is substring of other
            # 2. They differ only by $ prefix
            # 3. High similarity score (> 0.85)
            if (
                similarity > 0.85
                or missing_key in extra_key
                or extra_key in missing_key
                or missing_key.lstrip("$") == extra_key
                or extra_key.lstrip("$") == missing_key
                or missing_key == extra_key.lstrip("$")
                or extra_key == missing_key.lstrip("$")
            ):
                promoted_matches.append((missing_key, extra_key, similarity))

        # Remove promoted matches from missing/extra
        for missing_key, extra_key, _ in promoted_matches:
            missing_keys.discard(missing_key)
            extra_keys.discard(extra_key)
            # We'll handle these specially - compare them as potential matches

        # Process case-insensitive matches first (these are likely just casing differences)
        for key1_original, key2_original in case_insensitive_matches:
            p_info1 = group1_original[key1_original]
            p_info2 = group2_original[key2_original]

            full_name1 = p_info1["full_name"]
            full_name2 = p_info2["full_name"]
            param1 = p_info1["param"]
            param2 = p_info2["param"]

            # Get actual parameter names
            actual_name1 = param1.name if param1 and param1.name else key1_original
            actual_name2 = param2.name if param2 and param2.name else key2_original

            print(
                f"Case mismatch in {group_name}\t {full_name1} (name: {actual_name1}) vs {full_name2} (name: {actual_name2})"
            )

            # Add to differences for Excel export
            self.differences.append(
                Difference(
                    type=DifferenceType.GLOBAL_PARAMETER_MISMATCH,
                    message=f"Parameter in {group_name}: {full_name1} (case mismatch with {full_name2})",
                    context=f"||{group_name}||{full_name1}||{full_name2}",
                )
            )

            context = f"parameter_group:{group_name}:{key1_original.lower()}"
            self._compare_grouped_parameter(
                param1, param2, full_name1, full_name2, context, source1, source2
            )

        # Compare promoted fuzzy matches (high-confidence matches like $ prefix differences)
        for missing_key, extra_key, similarity in promoted_matches:
            # Find original case keys
            key1_original = None
            key2_original = None
            for k in missing_keys_original:
                if k.lower() == missing_key:
                    key1_original = k
                    break
            for k in extra_keys_original:
                if k.lower() == extra_key:
                    key2_original = k
                    break

            if not key1_original or not key2_original:
                continue

            p_info1 = group1_original[key1_original]
            p_info2 = group2_original[key2_original]

            full_name1 = p_info1["full_name"]
            full_name2 = p_info2["full_name"]
            param1 = p_info1["param"]
            param2 = p_info2["param"]

            # Get actual parameter names for better reporting
            actual_name1 = param1.name if param1 and param1.name else key1_original
            actual_name2 = param2.name if param2 and param2.name else key2_original

            # Determine match type
            if (
                missing_key.lstrip("$") == extra_key
                or extra_key.lstrip("$") == missing_key
            ):
                match_type = "match ($ prefix difference)"
            elif actual_name1.lower() == actual_name2.lower():
                match_type = "match (name difference)"
            else:
                match_type = f"fuzzy match (similarity: {similarity:.2f})"

            print(
                f"Potential parameter {match_type} in {group_name}\t {full_name1} (name: {actual_name1}) ~ {full_name2} (name: {actual_name2})"
            )

            # Add to differences for Excel export with more detail
            self.differences.append(
                Difference(
                    type=DifferenceType.GLOBAL_PARAMETER_MISMATCH,
                    message=f"Parameter in {group_name}: {full_name1} (possible match: {full_name2}, similarity: {similarity:.2f})",
                    context=f"||{group_name}||{full_name1}||{full_name2}",
                )
            )

            context = f"parameter_group:{group_name}:{missing_key}~{extra_key}"
            self._compare_grouped_parameter(
                param1, param2, full_name1, full_name2, context, source1, source2
            )

        # Report missing parameters with improved fuzzy matching info
        for key_original in missing_keys_original:
            if key_original.lower() not in missing_keys:
                continue  # Already handled in promoted matches

            p_info = group1_original[key_original]
            full_name = p_info["full_name"]
            param = p_info.get("param")
            actual_name = param.name if param and param.name else key_original

            # Check for fuzzy match with similarity score
            key_lower = key_original.lower()
            matches = [match for match in fuzzy_matches if match[0] == key_lower]
            possible_match = ""
            similarity = 0
            if matches:
                possible_match = matches[0][1]
                similarity = matches[0][2] if len(matches[0]) > 2 else 0

            message = (
                f"Parameter missing in {source2} from {group_name} group: {full_name}"
            )
            if actual_name != key_original:
                message += f" (name: {actual_name})"
            if possible_match:
                message += (
                    f" (possible match: {possible_match}, similarity: {similarity:.2f})"
                )

            self.differences.append(
                Difference(
                    type=DifferenceType.MISSING_GLOBAL_PARAMETER,
                    message=message,
                    context=f"||{group_name}||{full_name}||{possible_match}",
                )
            )
            print(
                f"Parameter missing in {source2} from {group_name}\t {full_name} (name: {actual_name})"
                + (
                    f"\t|| Possible Match: {possible_match} (similarity: {similarity:.2f})"
                    if possible_match
                    else ""
                )
            )

        # Report extra parameters with improved fuzzy matching info
        for key_original in extra_keys_original:
            if key_original.lower() not in extra_keys:
                continue  # Already handled in promoted matches

            p_info = group2_original[key_original]
            full_name = p_info["full_name"]
            param = p_info.get("param")
            actual_name = param.name if param and param.name else key_original

            # Check for fuzzy match with similarity score
            key_lower = key_original.lower()
            matches = [match for match in fuzzy_matches if match[1] == key_lower]
            possible_match = ""
            similarity = 0
            if matches:
                possible_match = matches[0][0]
                similarity = matches[0][2] if len(matches[0]) > 2 else 0

            message = f"Extra parameter in {source2} in {group_name} group: {full_name}"
            if actual_name != key_original:
                message += f" (name: {actual_name})"
            if possible_match:
                message += (
                    f" (possible match: {possible_match}, similarity: {similarity:.2f})"
                )

            self.differences.append(
                Difference(
                    type=DifferenceType.EXTRA_GLOBAL_PARAMETER,
                    message=message,
                    context=f"||{group_name}||{full_name}||{possible_match}",
                )
            )
            print(
                f"Extra parameter in {source2} in {group_name}\t {full_name} (name: {actual_name})"
                + (
                    f"\t|| Possible Match: {possible_match} (similarity: {similarity:.2f})"
                    if possible_match
                    else ""
                )
            )

        # Compare exact match parameters in detail
        for key_exact in exact_matches:
            p1_info = group1_original[key_exact]
            p2_info = group2_original[key_exact]
            param1 = p1_info["param"]
            param2 = p2_info["param"]
            full_name1 = p1_info["full_name"]
            full_name2 = p2_info["full_name"]

            # Compare the actual parameter properties
            context = f"parameter_group:{group_name}:{key_exact.lower()}"
            self._compare_grouped_parameter(
                param1, param2, full_name1, full_name2, context, source1, source2
            )

    def _compare_grouped_parameter(
        self, param1, param2, full_name1, full_name2, context, source1, source2
    ):
        """Compare two parameters from a parameter group, checking for property mismatches.

        This checks for differences like:
        - Missing x-nullable
        - Different x-ms-client-name casing
        - Type, format, constraints mismatches
        """
        differences_found = []

        # Check x-nullable
        x_nullable1 = param1.constraints.x_nullable if param1.constraints else None
        x_nullable2 = param2.constraints.x_nullable if param2.constraints else None

        if x_nullable1 != x_nullable2:
            differences_found.append(
                f"x-nullable: {source1}={x_nullable1} vs {source2}={x_nullable2}"
            )

        # Check if this is comparing with different naming conventions
        # The full_name1 might have x-ms-client-name, full_name2 might be SearchOptions.camelCase
        if full_name1 != full_name2:
            # This is expected - hand-authored uses x-ms-client-name, TSP uses dot notation
            # We'll note this but not report as error since we matched by base name
            pass

        # Compare basic parameter properties (reuse existing logic)
        if param1.required != param2.required:
            differences_found.append(
                f"required: {source1}={param1.required} vs {source2}={param2.required}"
            )

        # For non-body parameters, compare type, format, constraints
        if param1.location != ParameterLocation.BODY:
            if param1.param_type != param2.param_type:
                differences_found.append(
                    f"type: {source1}={param1.param_type} vs {source2}={param2.param_type}"
                )

            if param1.param_format != param2.param_format:
                differences_found.append(
                    f"format: {source1}={param1.param_format} vs {source2}={param2.param_format}"
                )

            if not self._constraints_equal(param1.constraints, param2.constraints):
                constraint_diffs = self._get_constraint_differences(
                    param1.constraints, param2.constraints
                )
                differences_found.extend(
                    [f"constraint: {diff}" for diff in constraint_diffs]
                )
        else:
            # For body parameters, compare schemas
            if not self._schemas_equal(param1.schema, param2.schema):
                schema_diffs = self._get_schema_differences(
                    param1.schema, param2.schema
                )
                differences_found.extend([f"schema: {diff}" for diff in schema_diffs])

        # Report all differences found
        if differences_found:
            diff_summary = "; ".join(differences_found)
            self.differences.append(
                Difference(
                    type=DifferenceType.GLOBAL_PARAMETER_MISMATCH,
                    message=f"Parameter property mismatch: {full_name1} <-> {full_name2}: {diff_summary}",
                    context=context,
                )
            )
            print(f"Parameter property mismatch\t {context}\t {diff_summary}")

    def _find_string_matches(self, missing_items, extra_items, threshold=0.6):
        """Find potential matches between missing and extra string items using similarity."""
        from difflib import SequenceMatcher

        matches = []

        for missing_item in missing_items:
            best_match = None
            best_similarity = 0

            for extra_item in extra_items:
                # Calculate similarity
                similarity = SequenceMatcher(
                    None, str(missing_item).lower(), str(extra_item).lower()
                ).ratio()

                if similarity > best_similarity and similarity >= threshold:
                    best_similarity = similarity
                    best_match = extra_item

            if best_match:
                matches.append((missing_item, best_match, best_similarity))

        return matches

    def _find_parameter_matches(self, missing_keys, extra_keys, params1, params2):
        """Find potential matches between missing and extra parameters using name similarity."""
        from difflib import SequenceMatcher

        matches = []
        threshold = 0.6  # Similarity threshold for potential matches

        for missing_key in missing_keys:
            missing_param = params1[missing_key]
            missing_name = missing_param.name
            missing_location = missing_param.location.value
            best_match = None
            best_similarity = 0

            for extra_key in extra_keys:
                extra_param = params2[extra_key]
                extra_name = extra_param.name
                extra_location = extra_param.location.value

                # Only match parameters in the same location
                if missing_location == extra_location:
                    # Calculate name similarity
                    similarity = SequenceMatcher(
                        None, missing_name.lower(), extra_name.lower()
                    ).ratio()

                    if similarity > best_similarity and similarity >= threshold:
                        best_similarity = similarity
                        best_match = extra_name

            if best_match:
                matches.append((missing_key, best_match, best_similarity))

        return matches

    def _find_response_matches(self, missing_codes, extra_codes):
        """Find potential matches between missing and extra response codes."""
        from difflib import SequenceMatcher

        matches = []
        threshold = 0.7  # Higher threshold for response codes

        for missing_code in missing_codes:
            best_match = None
            best_similarity = 0

            for extra_code in extra_codes:
                # Calculate similarity
                similarity = SequenceMatcher(
                    None, str(missing_code).lower(), str(extra_code).lower()
                ).ratio()

                if similarity > best_similarity and similarity >= threshold:
                    best_similarity = similarity
                    best_match = extra_code

            if best_match:
                matches.append((missing_code, best_match, best_similarity))

        return matches

    def _find_definition_matches(self, missing_defs, extra_defs, api1, api2):
        """Find potential matches between missing and extra definitions using known mappings and name similarity."""
        from difflib import SequenceMatcher

        matches = []
        threshold = 0.7  # Similarity threshold for potential matches
        matched_missing = set()
        matched_extra = set()

        # First, check known renamed mappings
        for missing_name in missing_defs:
            if missing_name in KNOWN_DEFINITION_RENAMES:
                known_match = KNOWN_DEFINITION_RENAMES[missing_name]
                if known_match in extra_defs:
                    # Perfect match via known mapping - use 1.0 similarity
                    matches.append((missing_name, known_match, 1.0))
                    matched_missing.add(missing_name)
                    matched_extra.add(known_match)

        # Then use similarity matching for remaining definitions
        remaining_missing = missing_defs - matched_missing
        remaining_extra = extra_defs - matched_extra

        for missing_name in remaining_missing:
            best_match = None
            best_similarity = 0

            for extra_name in remaining_extra:
                # Calculate name similarity
                similarity = SequenceMatcher(
                    None, missing_name.lower(), extra_name.lower()
                ).ratio()

                if similarity > best_similarity and similarity >= threshold:
                    best_similarity = similarity
                    best_match = extra_name

            if best_match:
                matches.append((missing_name, best_match, best_similarity))

        return matches

    def _find_path_matches(self, missing_paths, extra_paths):
        """Find potential matches between missing and extra paths using similarity."""
        from difflib import SequenceMatcher

        matches = []
        threshold = 0.6  # Lower threshold for paths as they can vary more

        for missing_path in missing_paths:
            best_match = None
            best_similarity = 0

            for extra_path in extra_paths:
                # Calculate path similarity
                similarity = SequenceMatcher(
                    None, missing_path.lower(), extra_path.lower()
                ).ratio()

                if similarity > best_similarity and similarity >= threshold:
                    best_similarity = similarity
                    best_match = extra_path

            if best_match:
                matches.append((missing_path, best_match, best_similarity))

        return matches

    def _find_parameter_name_case_mismatches(
        self, missing_keys, extra_keys, params1, params2
    ):
        """Find bi-directional case mismatches in parameter names."""
        case_mismatches = []

        for missing_key in missing_keys:
            missing_param = params1[missing_key]
            missing_location = missing_param.location.value
            missing_name = missing_param.name

            for extra_key in extra_keys:
                extra_param = params2[extra_key]
                extra_location = extra_param.location.value
                extra_name = extra_param.name

                # Check if same location and case-insensitive name match
                if (
                    missing_location == extra_location
                    and missing_name.lower() == extra_name.lower()
                    and missing_name != extra_name
                ):
                    case_mismatches.append((missing_key, extra_key))
                    break

        return case_mismatches


def compare_swagger_specs(
    hand_authored_swagger: Dict[str, Any], typespec_swagger: Dict[str, Any]
) -> EquivalencyResult:
    """
    High-level function to compare two canonicalized Swagger specifications.

    Args:
        hand_authored_swagger: Canonicalized hand-authored Swagger
        typespec_swagger: Canonicalized TypeSpec-compiled Swagger

    Returns:
        EquivalencyResult indicating whether the specs are equivalent
    """
    # Build canonical APIs
    api1 = build_canonical_api_from_swagger(
        hand_authored_swagger, swagger_source="hand_authored"
    )
    api2 = build_canonical_api_from_swagger(typespec_swagger, swagger_source="tsp")

    # Compare them
    comparator = ApiComparator()
    return comparator.compare_apis(api1, api2)
