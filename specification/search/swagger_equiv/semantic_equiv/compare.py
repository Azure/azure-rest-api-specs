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

        # 6. Global API configuration
        print("\nComparing global API configuration...")
        self._compare_global_configuration(api1, api2)

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

        for path in missing_paths:
            # Check if this missing path has a potential match
            matches = [match for match in path_matches if match[0] == path]
            match_hint = f" (possible match: {matches[0][1]})" if matches else ""

            self.differences.append(
                Difference(
                    type=DifferenceType.MISSING_PATH,
                    message=f"Path missing in {api2.swagger_source}: {path}{match_hint}",
                    context=path,
                )
            )

        if missing_paths:
            print(f"Missing paths in {api2.swagger_source}\t {len(missing_paths)}")

        for path in extra_paths:
            # Check if this extra path has a potential match
            matches = [match for match in path_matches if match[1] == path]
            match_hint = f" (possible match: {matches[0][0]})" if matches else ""

            self.differences.append(
                Difference(
                    type=DifferenceType.EXTRA_PATH,
                    message=f"Extra path in {api2.swagger_source}: {path}{match_hint}",
                    context=path,
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
                context = f"{path} {method}"

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
        # 3.2.1 operationId - must match exactly
        if op1.operation_id != op2.operation_id:
            self.differences.append(
                Difference(
                    type=DifferenceType.OPERATION_ID_MISMATCH,
                    message=f"Operation ID mismatch: {source1} {op1.operation_id} vs {source2} {op2.operation_id}",
                    context=context,
                )
            )
            print(
                f"Operation ID mismatch\t {context}\t {source1} {op1.operation_id} vs {source2} {op2.operation_id}"
            )

        # 3.2.2 Parameters - keyed by (in, name)
        self._compare_parameters(
            op1.parameters, op2.parameters, context, source1, source2
        )

        # 3.2.3 Request Body
        if not self._schemas_equal(op1.request_body_schema, op2.request_body_schema):
            self.differences.append(
                Difference(
                    type=DifferenceType.REQUEST_BODY_MISMATCH,
                    message=f"Request body schemas mismatch",
                    context=context,
                )
            )
            print(f"Request body schemas mismatch\t {context}\t {source1} vs {source2}")

        # Content types for request
        if op1.consumes != op2.consumes:
            self.differences.append(
                Difference(
                    type=DifferenceType.CONSUMES_MISMATCH,
                    message=f"Request content types mismatch: {source1} {op1.consumes} vs {source2} {op2.consumes}",
                    context=context,
                )
            )
            print(
                f"Request content types mismatch\t {context}\t {source1} {op1.consumes} vs {source2} {op2.consumes}"
            )

        # 3.2.4 Responses
        self._compare_responses(op1.responses, op2.responses, context, source1, source2)

        # Content types for responses
        if op1.produces != op2.produces:
            self.differences.append(
                Difference(
                    type=DifferenceType.PRODUCES_MISMATCH,
                    message=f"Response content types mismatch: {source1} {op1.produces} vs {source2} {op2.produces}",
                    context=context,
                )
            )
            print(
                f"Response content types mismatch\t {context}\t {source1} {op1.produces} vs {source2} {op2.produces}"
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

        for key in missing_keys:
            param = params1[key]
            self.differences.append(
                Difference(
                    type=DifferenceType.MISSING_PARAMETER,
                    message=f"Parameter missing in {source2}: {param.name}, {param.location.value}",
                    context=context,
                )
            )
            print(
                f"Missing parameter in {source2}\t {context}\t {param.name}, {param.location.value}"
            )

        for key in extra_keys:
            param = params2[key]
            self.differences.append(
                Difference(
                    type=DifferenceType.EXTRA_PARAMETER,
                    message=f"Extra parameter in {source2}: {param.name}, {param.location.value}",
                    context=context,
                )
            )
            print(
                f"Extra parameter in {source2}\t {context}\t {param.name}, {param.location.value}"
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
        param_context = f"{context} param:{param1.name}"

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
                self.differences.append(
                    Difference(
                        type=DifferenceType.PARAMETER_MISMATCH,
                        message=f"Body parameter schemas mismatch",
                        context=param_context,
                    )
                )
                print(
                    f"Body parameter schemas mismatch\t {param_context}\t {source1} vs {source2}"
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
                self.differences.append(
                    Difference(
                        type=DifferenceType.PARAMETER_MISMATCH,
                        message=f"Parameter constraints mismatch",
                        context=param_context,
                    )
                )
                print(
                    f"Parameter constraints mismatch\t {param_context}\t {source1} vs {source2}"
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

        for code in missing_codes:
            self.differences.append(
                Difference(
                    type=DifferenceType.MISSING_RESPONSE,
                    message=f"Response status code missing in {source1}: {code}",
                    context=context,
                )
            )
            print(f"Response status code missing\t {context}\t {source1}: {code}")

        for code in extra_codes:
            self.differences.append(
                Difference(
                    type=DifferenceType.EXTRA_RESPONSE,
                    message=f"Extra response status code in {source2}: {code}",
                    context=context,
                )
            )
            print(f"Extra response status code in {source2} \t {context}\t {code}")

        # Compare common responses
        common_codes = status_codes1 & status_codes2
        for code in common_codes:
            response1 = responses1[code]
            response2 = responses2[code]
            self._compare_response(
                response1, response2, f"{context} {code}", source1, source2
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
            self.differences.append(
                Difference(
                    type=DifferenceType.RESPONSE_SCHEMA_MISMATCH,
                    message="Response schemas mismatch",
                    context=context,
                )
            )
            print(f"Response schemas mismatch \t {context}\t ")

        # Response headers must match
        if not self._headers_equal(resp1.headers, resp2.headers):
            self.differences.append(
                Difference(
                    type=DifferenceType.RESPONSE_HEADERS_MISMATCH,
                    message="Response headers mismatch",
                    context=context,
                )
            )
            print(f"Response headers mismatch \t {context}\t ")
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

        for def_name in missing_defs:
            # Check if this missing definition has a potential match
            matches = [match for match in potential_matches if match[0] == def_name]
            match_hint = f" (possible match: {matches[0][1]})" if matches else ""

            self.differences.append(
                Difference(
                    type=DifferenceType.MISSING_DEFINITION,
                    message=f"Definition missing in {api2.swagger_source} : {def_name}{match_hint}",
                    context=def_name,
                )
            )
            print(
                f"Definition missing in {api2.swagger_source} \t {def_name}{match_hint}"
            )

        for def_name in extra_defs:
            # Check if this extra definition has a potential match
            matches = [match for match in potential_matches if match[1] == def_name]
            match_hint = f" (possible match: {matches[0][0]})" if matches else ""

            self.differences.append(
                Difference(
                    type=DifferenceType.EXTRA_DEFINITION,
                    message=f"Extra definition in {api2.swagger_source}: {def_name}{match_hint}",
                    context=def_name,
                )
            )
            print(
                f"Extra definition in {api2.swagger_source} \t {def_name}{match_hint}"
            )
        # Compare common definitions
        common_defs = defs1 & defs2
        for def_name in common_defs:
            schema1 = api1.definitions[def_name]
            schema2 = api2.definitions[def_name]
            if not self._schemas_equal(schema1, schema2):
                self.differences.append(
                    Difference(
                        type=DifferenceType.DEFINITION_MISMATCH,
                        message=f"Definition schemas mismatch: {def_name}",
                        context=def_name,
                    )
                )
                print(f"Definition schemas mismatch \t {def_name}")

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
        """Compare global parameter definitions."""
        params1 = api1.parameters or {}
        params2 = api2.parameters or {}

        param_names1 = set(params1.keys())
        param_names2 = set(params2.keys())

        # Check for missing/extra global parameters
        missing_params = param_names1 - param_names2
        extra_params = param_names2 - param_names1

        for param_name in missing_params:
            self.differences.append(
                Difference(
                    type=DifferenceType.MISSING_GLOBAL_PARAMETER,
                    message=f"Global parameter missing in {api2.swagger_source}: {param_name}",
                    context=f"global_parameter:{param_name}",
                )
            )
            print(f"Global parameter missing in {api2.swagger_source}\t {param_name}")

        for param_name in extra_params:
            self.differences.append(
                Difference(
                    type=DifferenceType.EXTRA_GLOBAL_PARAMETER,
                    message=f"Extra global parameter in {api2.swagger_source}: {param_name}",
                    context=f"global_parameter:{param_name}",
                )
            )
            print(f"Extra global parameter in {api2.swagger_source}\t {param_name}")

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
                    context=f"global_response:{response_name}",
                )
            )
            print(f"Global response missing in {api2.swagger_source}\t {response_name}")

        for response_name in extra_responses:
            self.differences.append(
                Difference(
                    type=DifferenceType.EXTRA_GLOBAL_RESPONSE,
                    message=f"Extra global response in {api2.swagger_source}: {response_name}",
                    context=f"global_response:{response_name}",
                )
            )
            print(f"Extra global response in {api2.swagger_source}\t {response_name}")

        # Compare common global responses
        common_responses = response_names1 & response_names2
        for response_name in common_responses:
            response1 = responses1[response_name]
            response2 = responses2[response_name]
            self._compare_response(
                response1, response2, f"global_response:{response_name}"
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

    def _find_definition_matches(self, missing_defs, extra_defs, api1, api2):
        """Find potential matches between missing and extra definitions using name similarity."""
        from difflib import SequenceMatcher

        matches = []
        threshold = 0.7  # Similarity threshold for potential matches

        for missing_name in missing_defs:
            best_match = None
            best_similarity = 0

            for extra_name in extra_defs:
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
