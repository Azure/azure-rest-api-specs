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
from typing import Dict, Any, List, Optional, Set, FrozenSet
from enum import Enum

from models import (
    CanonicalApi, CanonicalPath, CanonicalOperation, CanonicalParameter,
    CanonicalResponse, CanonicalSchema, CanonicalConstraints, ParameterLocation,
    build_canonical_api_from_swagger
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
            return f"APIs are NOT equivalent ({self.difference_count} differences found)"


class ApiComparator:
    """
    Main class for comparing two canonical APIs for semantic equivalency.

    Implements the strict comparison rules from equiv_contract.md.
    """

    def __init__(self, ignore_operation_id: bool = False):
        """
        Initialize the comparator.

        Args:
            ignore_operation_id: Whether to ignore operationId mismatches
        """
        self.ignore_operation_id = ignore_operation_id
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

        # According to equiv_contract.md, we check three dimensions:
        # 1. Paths + HTTP methods
        self._compare_paths_and_methods(api1, api2)

        # 2. Operations (parameters, request bodies, responses)
        self._compare_operations(api1, api2)

        # 3. Schemas / definitions
        self._compare_definitions(api1, api2)

        return EquivalencyResult(
            equivalent=len(self.differences) == 0,
            differences=self.differences.copy()
        )

    def _compare_paths_and_methods(self, api1: CanonicalApi, api2: CanonicalApi) -> None:
        """Compare path sets and method sets per path."""
        paths1 = api1.path_set
        paths2 = api2.path_set

        # Check for missing/extra paths
        missing_paths = paths1 - paths2
        extra_paths = paths2 - paths1

        for path in missing_paths:
            self.differences.append(Difference(
                type=DifferenceType.MISSING_PATH,
                message=f"Path missing in second API: {path}",
                context=path
            ))

        for path in extra_paths:
            self.differences.append(Difference(
                type=DifferenceType.EXTRA_PATH,
                message=f"Extra path in second API: {path}",
                context=path
            ))

        # For common paths, check method sets
        common_paths = paths1 & paths2
        for path in common_paths:
            path1 = api1.paths[path]
            path2 = api2.paths[path]
            self._compare_methods(path1, path2, path)

    def _compare_methods(self, path1: CanonicalPath, path2: CanonicalPath, path_context: str) -> None:
        """Compare HTTP method sets for a specific path."""
        methods1 = path1.methods
        methods2 = path2.methods

        missing_methods = methods1 - methods2
        extra_methods = methods2 - methods1

        for method in missing_methods:
            self.differences.append(Difference(
                type=DifferenceType.MISSING_METHOD,
                message=f"HTTP method {method} missing in second API",
                context=f"{path_context} {method}"
            ))

        for method in extra_methods:
            self.differences.append(Difference(
                type=DifferenceType.EXTRA_METHOD,
                message=f"Extra HTTP method {method} in second API",
                context=f"{path_context} {method}"
            ))

    def _compare_operations(self, api1: CanonicalApi, api2: CanonicalApi) -> None:
        """Compare operations using both operation ID + method and path + method matching."""
        # Build operation mappings for both APIs
        ops1_by_id_method = {}  # {(operation_id, method): (path, operation)}
        ops1_by_path_method = {}  # {(path, method): operation}

        for path, path_obj in api1.paths.items():
            for method, operation in path_obj.operations.items():
                if operation.operation_id:
                    ops1_by_id_method[(operation.operation_id, method)] = (path, operation)
                ops1_by_path_method[(path, method)] = operation

        ops2_by_id_method = {}  # {(operation_id, method): (path, operation)}
        ops2_by_path_method = {}  # {(path, method): operation}

        for path, path_obj in api2.paths.items():
            for method, operation in path_obj.operations.items():
                if operation.operation_id:
                    ops2_by_id_method[(operation.operation_id, method)] = (path, operation)
                ops2_by_path_method[(path, method)] = operation

        # Track which operations we've already compared to avoid duplicates
        compared_pairs = set()

        # Strategy 1: Match by operation ID + method
        for (op_id, method), (path1, op1) in ops1_by_id_method.items():
            if (op_id, method) in ops2_by_id_method:
                path2, op2 = ops2_by_id_method[(op_id, method)]
                context = f"{op_id} {method}"

                # Cross-reference validation: If paths are different, note the inconsistency
                if path1 != path2:
                    self.differences.append(Difference(
                        type=DifferenceType.PATH_INCONSISTENCY,
                        message=f"Path inconsistency: operation '{op_id}' {method} found at different paths '{path1}' vs '{path2}'",
                        context=context
                    ))

                self._compare_operation(op1, op2, context, check_operation_id=False, matching_strategy="operationId+method")
                compared_pairs.add((path1, method, path2, method))

        # Strategy 2: Match by path + method (excluding already compared operations)
        for (path, method), op1 in ops1_by_path_method.items():
            if (path, method) in ops2_by_path_method:
                op2 = ops2_by_path_method[(path, method)]

                # Skip if we already compared these operations by operation ID
                already_compared = any(
                    (p1, m1, p2, m2) in compared_pairs
                    for p1, m1, p2, m2 in compared_pairs
                    if p1 == path and m1 == method and p2 == path and m2 == method
                )

                if not already_compared:
                    context = f"[Strategy B: path+method] {path} {method}"

                    # Cross-reference validation: If operation IDs are different, note the inconsistency
                    if op1.operation_id != op2.operation_id:
                        self.differences.append(Difference(
                            type=DifferenceType.OPERATION_ID_INCONSISTENCY,
                            message=f"OperationId inconsistency: path '{path}' {method} has different operationIds '{op1.operation_id}' vs '{op2.operation_id}'",
                            context=context
                        ))

                    self._compare_operation(op1, op2, context, check_operation_id=False, matching_strategy="path+method")

    def _compare_operation(
        self,
        op1: CanonicalOperation,
        op2: CanonicalOperation,
        context: str,
        check_operation_id: bool = True,
        matching_strategy: str = None
    ) -> None:
        """
        Compare two operations according to equiv_contract.md section 3.2.

        Args:
            op1: First operation
            op2: Second operation
            context: Context for error messages (includes strategy information)
            check_operation_id: Whether to check operation ID equality
            matching_strategy: The matching strategy used (e.g., "operationId+method", "path+method")
        """
        # Include matching strategy in context if available
        if matching_strategy:
            enhanced_context = f"{context} (matched via {matching_strategy})"
        else:
            enhanced_context = context

        # 3.2.1 operationId - must match exactly unless configured otherwise
        if check_operation_id and not self.ignore_operation_id:
            if op1.operation_id != op2.operation_id:
                self.differences.append(Difference(
                    type=DifferenceType.OPERATION_ID_MISMATCH,
                    message=f"Operation ID mismatch: '{op1.operation_id}' vs '{op2.operation_id}'",
                    context=enhanced_context
                ))

        # 3.2.2 Parameters - keyed by (in, name)
        self._compare_parameters(op1.parameters, op2.parameters, enhanced_context)

        # 3.2.3 Request Body
        if not self._schemas_equal(op1.request_body_schema, op2.request_body_schema):
            self.differences.append(Difference(
                type=DifferenceType.REQUEST_BODY_MISMATCH,
                message="Request body schemas do not match",
                context=enhanced_context
            ))

        # Content types for request
        if op1.consumes != op2.consumes:
            self.differences.append(Difference(
                type=DifferenceType.CONSUMES_MISMATCH,
                message=f"Request content types mismatch: {op1.consumes} vs {op2.consumes}",
                context=enhanced_context
            ))

        # 3.2.4 Responses
        self._compare_responses(op1.responses, op2.responses, enhanced_context)

        # Content types for responses
        if op1.produces != op2.produces:
            self.differences.append(Difference(
                type=DifferenceType.PRODUCES_MISMATCH,
                message=f"Response content types mismatch: {op1.produces} vs {op2.produces}",
                context=enhanced_context
            ))

    def _compare_parameters(self, params1: Optional[Dict], params2: Optional[Dict], context: str) -> None:
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
            self.differences.append(Difference(
                type=DifferenceType.MISSING_PARAMETER,
                message=f"Parameter missing in second API: {param.name} (in: {param.location.value})",
                context=context
            ))

        for key in extra_keys:
            param = params2[key]
            self.differences.append(Difference(
                type=DifferenceType.EXTRA_PARAMETER,
                message=f"Extra parameter in second API: {param.name} (in: {param.location.value})",
                context=context
            ))

        # Compare common parameters
        common_keys = keys1 & keys2
        for key in common_keys:
            param1 = params1[key]
            param2 = params2[key]
            self._compare_parameter(param1, param2, context)

    def _compare_parameter(self, param1: CanonicalParameter, param2: CanonicalParameter, context: str) -> None:
        """Compare two parameters according to equiv_contract.md section 3.2.2."""
        param_context = f"{context} param:{param1.name}"

        # Basic fields must match
        if param1.required != param2.required:
            self.differences.append(Difference(
                type=DifferenceType.PARAMETER_MISMATCH,
                message=f"Parameter required mismatch: {param1.required} vs {param2.required}",
                context=param_context
            ))

        # For body parameters, compare schemas
        if param1.location == ParameterLocation.BODY:
            if not self._schemas_equal(param1.schema, param2.schema):
                self.differences.append(Difference(
                    type=DifferenceType.PARAMETER_MISMATCH,
                    message="Body parameter schemas do not match",
                    context=param_context
                ))
        else:
            # For non-body parameters, compare type, format, constraints
            if param1.param_type != param2.param_type:
                self.differences.append(Difference(
                    type=DifferenceType.PARAMETER_MISMATCH,
                    message=f"Parameter type mismatch: {param1.param_type} vs {param2.param_type}",
                    context=param_context
                ))

            if param1.param_format != param2.param_format:
                self.differences.append(Difference(
                    type=DifferenceType.PARAMETER_MISMATCH,
                    message=f"Parameter format mismatch: {param1.param_format} vs {param2.param_format}",
                    context=param_context
                ))

            if not self._constraints_equal(param1.constraints, param2.constraints):
                self.differences.append(Difference(
                    type=DifferenceType.PARAMETER_MISMATCH,
                    message="Parameter constraints do not match",
                    context=param_context
                ))

    def _compare_responses(self, responses1: Optional[Dict], responses2: Optional[Dict], context: str) -> None:
        """Compare response dictionaries keyed by status code."""
        responses1 = responses1 or {}
        responses2 = responses2 or {}

        status_codes1 = set(responses1.keys())
        status_codes2 = set(responses2.keys())

        # Check for missing/extra status codes
        missing_codes = status_codes1 - status_codes2
        extra_codes = status_codes2 - status_codes1

        for code in missing_codes:
            self.differences.append(Difference(
                type=DifferenceType.MISSING_RESPONSE,
                message=f"Response status code missing in second API: {code}",
                context=context
            ))

        for code in extra_codes:
            self.differences.append(Difference(
                type=DifferenceType.EXTRA_RESPONSE,
                message=f"Extra response status code in second API: {code}",
                context=context
            ))

        # Compare common responses
        common_codes = status_codes1 & status_codes2
        for code in common_codes:
            response1 = responses1[code]
            response2 = responses2[code]
            self._compare_response(response1, response2, f"{context} {code}")

    def _compare_response(self, resp1: CanonicalResponse, resp2: CanonicalResponse, context: str) -> None:
        """Compare two responses according to equiv_contract.md section 3.2.4."""

        # Response schemas must match
        if not self._schemas_equal(resp1.schema, resp2.schema):
            self.differences.append(Difference(
                type=DifferenceType.RESPONSE_SCHEMA_MISMATCH,
                message="Response schemas do not match",
                context=context
            ))

        # Response headers must match
        if not self._headers_equal(resp1.headers, resp2.headers):
            self.differences.append(Difference(
                type=DifferenceType.RESPONSE_HEADERS_MISMATCH,
                message="Response headers do not match",
                context=context
            ))

        # Content types must match
        if resp1.content_types != resp2.content_types:
            self.differences.append(Difference(
                type=DifferenceType.RESPONSE_HEADERS_MISMATCH,
                message=f"Response content types mismatch: {resp1.content_types} vs {resp2.content_types}",
                context=context
            ))

    def _compare_definitions(self, api1: CanonicalApi, api2: CanonicalApi) -> None:
        """Compare definition dictionaries according to equiv_contract.md section 4.7."""
        defs1 = set(api1.definitions.keys())
        defs2 = set(api2.definitions.keys())

        # Definition name sets must match
        missing_defs = defs1 - defs2
        extra_defs = defs2 - defs1

        for def_name in missing_defs:
            self.differences.append(Difference(
                type=DifferenceType.MISSING_DEFINITION,
                message=f"Definition missing in second API: {def_name}",
                context=f"definition:{def_name}"
            ))

        for def_name in extra_defs:
            self.differences.append(Difference(
                type=DifferenceType.EXTRA_DEFINITION,
                message=f"Extra definition in second API: {def_name}",
                context=f"definition:{def_name}"
            ))

        # Compare common definitions
        common_defs = defs1 & defs2
        for def_name in common_defs:
            schema1 = api1.definitions[def_name]
            schema2 = api2.definitions[def_name]
            if not self._schemas_equal(schema1, schema2):
                self.differences.append(Difference(
                    type=DifferenceType.DEFINITION_MISMATCH,
                    message=f"Definition schemas do not match: {def_name}",
                    context=f"definition:{def_name}"
                ))

    def _schemas_equal(self, schema1: Optional[CanonicalSchema], schema2: Optional[CanonicalSchema]) -> bool:
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

    def _object_schemas_equal(self, schema1: CanonicalSchema, schema2: CanonicalSchema) -> bool:
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

        if type(add_props1) != type(add_props2):
            return False

        if isinstance(add_props1, CanonicalSchema):
            if not self._schemas_equal(add_props1, add_props2):
                return False
        elif add_props1 != add_props2:
            return False

        return True

    def _array_schemas_equal(self, schema1: CanonicalSchema, schema2: CanonicalSchema) -> bool:
        """Compare array schema fields."""
        # Items schema must match
        if not self._schemas_equal(schema1.items, schema2.items):
            return False

        # Array constraints are handled in _constraints_equal
        return True

    def _constraints_equal(
        self,
        constraints1: Optional[CanonicalConstraints],
        constraints2: Optional[CanonicalConstraints]
    ) -> bool:
        """Compare constraint objects including enums."""
        if constraints1 is None and constraints2 is None:
            return True
        if constraints1 is None or constraints2 is None:
            return False

        # All constraint fields must match exactly
        return (
            constraints1.minimum == constraints2.minimum and
            constraints1.maximum == constraints2.maximum and
            constraints1.exclusive_minimum == constraints2.exclusive_minimum and
            constraints1.exclusive_maximum == constraints2.exclusive_maximum and
            constraints1.min_length == constraints2.min_length and
            constraints1.max_length == constraints2.max_length and
            constraints1.pattern == constraints2.pattern and
            constraints1.min_items == constraints2.min_items and
            constraints1.max_items == constraints2.max_items and
            constraints1.unique_items == constraints2.unique_items and
            constraints1.enum == constraints2.enum and  # Frozensets handle ordering
            constraints1.default == constraints2.default
        )

    def _composed_schemas_equal(self, schema1: CanonicalSchema, schema2: CanonicalSchema) -> bool:
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
        list2: Optional[List[CanonicalSchema]]
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

    def _headers_equal(self, headers1: Optional[Dict], headers2: Optional[Dict]) -> bool:
        """Compare response headers dictionaries."""
        headers1 = headers1 or {}
        headers2 = headers2 or {}

        if set(headers1.keys()) != set(headers2.keys()):
            return False

        for header_name in headers1.keys():
            if not self._schemas_equal(headers1[header_name], headers2[header_name]):
                return False

        return True


def compare_swagger_specs(
    hand_authored_swagger: Dict[str, Any],
    typespec_swagger: Dict[str, Any],
    ignore_operation_id: bool = False
) -> EquivalencyResult:
    """
    High-level function to compare two canonicalized Swagger specifications.

    Args:
        hand_authored_swagger: Canonicalized hand-authored Swagger
        typespec_swagger: Canonicalized TypeSpec-compiled Swagger
        ignore_operation_id: Whether to ignore operationId mismatches

    Returns:
        EquivalencyResult indicating whether the specs are equivalent
    """
    # Build canonical APIs
    api1 = build_canonical_api_from_swagger(hand_authored_swagger)
    api2 = build_canonical_api_from_swagger(typespec_swagger)

    # Compare them
    comparator = ApiComparator(ignore_operation_id=ignore_operation_id)
    return comparator.compare_apis(api1, api2)