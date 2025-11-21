"""
Canonical data models for the Swagger equivalency checker.

This module defines immutable data structures that capture only the fields
that matter for semantic equivalency checking as defined in equiv_contract.md.

The models are designed to:
- Capture only behavioral API contract fields (not documentation)
- Use immutable structures for reliable equality comparison
- Encapsulate the canonical representation for easy comparison
"""

from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Dict, FrozenSet, List, Optional, Set, Tuple


class ParameterLocation(Enum):
    """Parameter location enumeration."""

    QUERY = "query"
    PATH = "path"
    HEADER = "header"
    FORM_DATA = "formData"
    BODY = "body"


@dataclass(frozen=True)
class CanonicalConstraints:
    """Represents validation constraints for parameters and schemas."""

    minimum: Optional[float] = None
    maximum: Optional[float] = None
    exclusive_minimum: Optional[bool] = None
    exclusive_maximum: Optional[bool] = None
    min_length: Optional[int] = None
    max_length: Optional[int] = None
    pattern: Optional[str] = None
    min_items: Optional[int] = None
    max_items: Optional[int] = None
    unique_items: Optional[bool] = None
    enum: Optional[FrozenSet[str]] = None
    default: Optional[Any] = None
    swagger_source: Optional[str] = None


@dataclass(frozen=True)
class CanonicalSchema:
    """
    Represents a canonical schema definition.

    According to equiv_contract.md section 4, schemas must match on:
    - type, format (no coercion)
    - For objects: property sets, required sets, additionalProperties
    - For arrays: items schema, array constraints
    - For enums: enum sets (ordering ignored)
    - References: $ref values
    - Composed schemas: allOf/oneOf/anyOf component counts and schemas
    """

    type: Optional[str] = None
    format: Optional[str] = None
    ref: Optional[str] = None  # For $ref

    # Object schema fields
    properties: Optional[Dict[str, "CanonicalSchema"]] = None
    required: Optional[FrozenSet[str]] = None
    additional_properties: Optional[Any] = None  # bool or CanonicalSchema

    # Array schema fields
    items: Optional["CanonicalSchema"] = None

    # Constraints
    constraints: Optional[CanonicalConstraints] = None

    # Composed schemas
    all_of: Optional[List["CanonicalSchema"]] = None
    one_of: Optional[List["CanonicalSchema"]] = None
    any_of: Optional[List["CanonicalSchema"]] = None

    # Source tracking
    swagger_source: Optional[str] = None


@dataclass(frozen=True)
class CanonicalParameter:
    """
    Represents a canonical parameter definition.

    According to equiv_contract.md section 3.2.2, parameters are keyed by (in, name)
    and must match on: in, name, required, full schema for body params,
    type/format/constraints for non-body params, enum, default.
    """

    name: str
    location: ParameterLocation  # 'in' field
    required: bool = False
    schema: Optional[CanonicalSchema] = None  # For body parameters
    param_type: Optional[str] = None  # For non-body parameters ('type' field)
    param_format: Optional[str] = None  # For non-body parameters
    constraints: Optional[CanonicalConstraints] = None
    swagger_source: Optional[str] = None

    @property
    def key(self) -> Tuple[str, str]:
        """Return the parameter key (location, name) for comparison."""
        return (self.location.value, self.name)


@dataclass(frozen=True)
class CanonicalResponse:
    """Represents a canonical response definition."""

    schema: Optional[CanonicalSchema] = None
    headers: Optional[Dict[str, CanonicalSchema]] = None
    content_types: Optional[FrozenSet[str]] = None  # 'produces' for this response
    swagger_source: Optional[str] = None


@dataclass(frozen=True)
class CanonicalOperation:
    """
    Represents a canonical operation definition.

    According to equiv_contract.md section 3.2, operations must match on:
    - operationId (unless configured otherwise)
    - Parameters (keyed by in+name)
    - Request body (consumes + schema)
    - Responses (status codes + schemas + headers)
    """

    operation_id: Optional[str] = None
    parameters: Optional[Dict[Tuple[str, str], CanonicalParameter]] = (
        None  # Keyed by (in, name)
    )
    request_body_schema: Optional[CanonicalSchema] = None
    consumes: Optional[FrozenSet[str]] = None  # Content types for request
    responses: Optional[Dict[str, CanonicalResponse]] = None  # Keyed by status code
    produces: Optional[FrozenSet[str]] = None  # Content types for responses
    swagger_source: Optional[str] = None


@dataclass(frozen=True)
class CanonicalPath:
    """Represents a canonical path definition."""

    operations: Dict[str, CanonicalOperation] = field(
        default_factory=dict
    )  # Keyed by HTTP method
    swagger_source: Optional[str] = None

    @property
    def methods(self) -> FrozenSet[str]:
        """Return the set of HTTP methods for this path."""
        return frozenset(self.operations.keys())


@dataclass(frozen=True)
class CanonicalApi:
    """
    Represents the complete canonical API definition.

    According to equiv_contract.md, APIs must match on:
    - Path sets and HTTP method sets per path
    - Complete operation definitions
    - Complete schema/definition sets
    - Global API configuration (consumes, produces, schemes, etc.)
    """

    # Core API structure
    paths: Dict[str, CanonicalPath] = field(default_factory=dict)
    definitions: Dict[str, CanonicalSchema] = field(default_factory=dict)

    # Global API configuration
    swagger_version: Optional[str] = None  # swagger field
    info: Optional[Dict[str, Any]] = None  # info section
    consumes: Optional[FrozenSet[str]] = None  # Global content types consumed
    produces: Optional[FrozenSet[str]] = None  # Global content types produced
    schemes: Optional[FrozenSet[str]] = None  # Supported protocols (http, https)
    host: Optional[str] = None  # Base host
    base_path: Optional[str] = None  # Base path

    # Azure/Microsoft-specific extensions
    x_ms_parameterized_host: Optional[Dict[str, Any]] = None  # x-ms-parameterized-host
    x_ms_code_generation_settings: Optional[Dict[str, Any]] = (
        None  # x-ms-code-generation-settings
    )

    # Security configuration
    security_definitions: Optional[Dict[str, Any]] = None  # securityDefinitions
    security: Optional[List[Dict[str, Any]]] = None  # security requirements

    # Additional metadata
    tags: Optional[List[Dict[str, Any]]] = None  # tags
    external_docs: Optional[Dict[str, Any]] = None  # externalDocs

    # Global parameter and response definitions
    parameters: Optional[Dict[str, CanonicalParameter]] = None  # Global parameters
    responses: Optional[Dict[str, CanonicalResponse]] = None  # Global responses

    # Source tracking
    swagger_source: Optional[str] = None

    @property
    def path_set(self) -> FrozenSet[str]:
        """Return the set of paths in this API."""
        return frozenset(self.paths.keys())


def build_constraints_from_dict(
    data: Dict[str, Any], swagger_source: Optional[str] = None
) -> Optional[CanonicalConstraints]:
    """Build CanonicalConstraints from a dictionary, handling enum specially."""
    if not data:
        return None

    enum_value = None
    if "enum" in data:
        enum_list = data["enum"]
        if isinstance(enum_list, list):
            # Convert to frozenset of strings for comparison
            enum_value = frozenset(str(item) for item in enum_list)

    return CanonicalConstraints(
        minimum=data.get("minimum"),
        maximum=data.get("maximum"),
        exclusive_minimum=data.get("exclusiveMinimum"),
        exclusive_maximum=data.get("exclusiveMaximum"),
        min_length=data.get("minLength"),
        max_length=data.get("maxLength"),
        pattern=data.get("pattern"),
        min_items=data.get("minItems"),
        max_items=data.get("maxItems"),
        unique_items=data.get("uniqueItems"),
        enum=enum_value,
        default=data.get("default"),
        swagger_source=swagger_source,
    )


def build_schema_from_dict(
    schema_dict: Dict[str, Any],
    definitions: Dict[str, Dict[str, Any]] = None,
    swagger_source: Optional[str] = None,
) -> CanonicalSchema:
    """
    Build a CanonicalSchema from a Swagger schema dictionary.

    Args:
        schema_dict: Schema definition from Swagger
        definitions: Available definitions for resolving references
        swagger_source: Source file name for tracking

    Returns:
        CanonicalSchema object
    """
    if not isinstance(schema_dict, dict):
        return CanonicalSchema(swagger_source=swagger_source)

    # Handle $ref
    if "$ref" in schema_dict:
        return CanonicalSchema(ref=schema_dict["$ref"], swagger_source=swagger_source)

    # Basic type and format
    schema_type = schema_dict.get("type")
    schema_format = schema_dict.get("format")

    # Build constraints
    constraints = build_constraints_from_dict(schema_dict, swagger_source)

    # Handle object schemas
    properties = None
    required = None
    additional_properties = None

    if schema_type == "object" or "properties" in schema_dict:
        props_dict = schema_dict.get("properties", {})
        if props_dict:
            properties = {}
            for prop_name, prop_schema in props_dict.items():
                properties[prop_name] = build_schema_from_dict(
                    prop_schema, definitions, swagger_source
                )

        required_list = schema_dict.get("required", [])
        if required_list:
            required = frozenset(required_list)

        if "additionalProperties" in schema_dict:
            add_props = schema_dict["additionalProperties"]
            if isinstance(add_props, bool):
                additional_properties = add_props
            elif isinstance(add_props, dict):
                additional_properties = build_schema_from_dict(
                    add_props, definitions, swagger_source
                )

    # Handle array schemas
    items = None
    if schema_type == "array" and "items" in schema_dict:
        items = build_schema_from_dict(
            schema_dict["items"], definitions, swagger_source
        )

    # Handle composed schemas
    all_of = None
    one_of = None
    any_of = None

    if "allOf" in schema_dict:
        all_of = [
            build_schema_from_dict(s, definitions, swagger_source)
            for s in schema_dict["allOf"]
        ]
    if "oneOf" in schema_dict:
        one_of = [
            build_schema_from_dict(s, definitions, swagger_source)
            for s in schema_dict["oneOf"]
        ]
    if "anyOf" in schema_dict:
        any_of = [
            build_schema_from_dict(s, definitions, swagger_source)
            for s in schema_dict["anyOf"]
        ]

    return CanonicalSchema(
        type=schema_type,
        format=schema_format,
        properties=properties,
        required=required,
        additional_properties=additional_properties,
        items=items,
        constraints=constraints,
        all_of=all_of,
        one_of=one_of,
        any_of=any_of,
        swagger_source=swagger_source,
    )


def resolve_parameter_ref(
    param_dict: Dict[str, Any], global_params: Dict[str, Dict[str, Any]]
) -> Dict[str, Any]:
    """Resolve parameter $ref to actual parameter definition."""
    if "$ref" in param_dict:
        ref_path = param_dict["$ref"]
        if ref_path.startswith("#/parameters/"):
            param_name = ref_path.replace("#/parameters/", "")
            if param_name in global_params:
                return global_params[param_name]
            else:
                # If reference not found, return original dict
                # This will likely cause an error later but prevents crashes
                return param_dict
    return param_dict


def build_parameter_from_dict(
    param_dict: Dict[str, Any],
    definitions: Dict[str, Dict[str, Any]] = None,
    swagger_source: Optional[str] = None,
) -> CanonicalParameter:
    """Build a CanonicalParameter from a Swagger parameter dictionary."""
    name = param_dict.get("name", "")
    location_str = param_dict.get("in", "query")

    # Map location string to enum
    location_map = {
        "query": ParameterLocation.QUERY,
        "path": ParameterLocation.PATH,
        "header": ParameterLocation.HEADER,
        "formData": ParameterLocation.FORM_DATA,
        "body": ParameterLocation.BODY,
    }
    location = location_map.get(location_str, ParameterLocation.QUERY)

    required = param_dict.get("required", False)

    # For body parameters, use schema
    schema = None
    param_type = None
    param_format = None
    constraints = None

    if location == ParameterLocation.BODY:
        if "schema" in param_dict:
            schema = build_schema_from_dict(
                param_dict["schema"], definitions, swagger_source
            )
    else:
        # For non-body parameters, use type/format/constraints
        param_type = param_dict.get("type")
        param_format = param_dict.get("format")
        constraints = build_constraints_from_dict(param_dict, swagger_source)

    return CanonicalParameter(
        name=name,
        location=location,
        required=required,
        schema=schema,
        param_type=param_type,
        param_format=param_format,
        constraints=constraints,
        swagger_source=swagger_source,
    )


def build_response_from_dict(
    response_dict: Dict[str, Any],
    definitions: Dict[str, Dict[str, Any]] = None,
    produces: Optional[List[str]] = None,
    swagger_source: Optional[str] = None,
) -> CanonicalResponse:
    """Build a CanonicalResponse from a Swagger response dictionary."""
    schema = None
    if "schema" in response_dict:
        schema = build_schema_from_dict(
            response_dict["schema"], definitions, swagger_source
        )

    headers = None
    if "headers" in response_dict:
        headers_dict = response_dict["headers"]
        if isinstance(headers_dict, dict):
            headers = {}
            for header_name, header_def in headers_dict.items():
                headers[header_name] = build_schema_from_dict(
                    header_def, definitions, swagger_source
                )

    content_types = None
    if produces:
        content_types = frozenset(produces)

    return CanonicalResponse(
        schema=schema,
        headers=headers,
        content_types=content_types,
        swagger_source=swagger_source,
    )


def build_operation_from_dict(
    operation_dict: Dict[str, Any],
    definitions: Dict[str, Dict[str, Any]] = None,
    swagger_source: Optional[str] = None,
) -> CanonicalOperation:
    """Build a CanonicalOperation from a Swagger operation dictionary."""
    operation_id = operation_dict.get("operationId")

    # Build parameters dictionary keyed by (in, name)
    parameters = None
    if "parameters" in operation_dict:
        param_list = operation_dict["parameters"]
        if isinstance(param_list, list):
            parameters = {}
            # Get global parameters from the main swagger document for reference resolution
            global_params = (
                definitions.get("__global_parameters", {}) if definitions else {}
            )
            for param_dict in param_list:
                if isinstance(param_dict, dict):
                    # Resolve parameter reference if it's a $ref
                    resolved_param_dict = resolve_parameter_ref(
                        param_dict, global_params
                    )
                    param = build_parameter_from_dict(
                        resolved_param_dict, definitions, swagger_source
                    )
                    parameters[param.key] = param

    # Handle request body (from body parameter)
    request_body_schema = None
    if parameters:
        for param in parameters.values():
            if param.location == ParameterLocation.BODY and param.schema:
                request_body_schema = param.schema
                break

    # Content types
    consumes = None
    if "consumes" in operation_dict:
        consumes_list = operation_dict["consumes"]
        if isinstance(consumes_list, list):
            consumes = frozenset(consumes_list)

    produces = None
    if "produces" in operation_dict:
        produces_list = operation_dict["produces"]
        if isinstance(produces_list, list):
            produces = frozenset(produces_list)

    # Build responses dictionary
    responses = None
    if "responses" in operation_dict:
        responses_dict = operation_dict["responses"]
        if isinstance(responses_dict, dict):
            responses = {}
            for status_code, response_dict in responses_dict.items():
                if isinstance(response_dict, dict):
                    response = build_response_from_dict(
                        response_dict,
                        definitions,
                        list(produces) if produces else None,
                        swagger_source,
                    )
                    responses[status_code] = response

    return CanonicalOperation(
        operation_id=operation_id,
        parameters=parameters,
        request_body_schema=request_body_schema,
        consumes=consumes,
        responses=responses,
        produces=produces,
        swagger_source=swagger_source,
    )


def build_canonical_api_from_swagger(
    swagger_dict: Dict[str, Any], swagger_source: str
) -> CanonicalApi:
    """
    Build a CanonicalApi from a canonicalized Swagger dictionary.

    This function converts the canonicalized Swagger into the internal
    canonical representation for comparison.

    Args:
        swagger_dict: Canonicalized Swagger dictionary
        swagger_source: Source identifier for the Swagger document
    Returns:
        CanonicalApi object ready for comparison
    """

    # Extract global API information
    swagger_version = swagger_dict.get("swagger")
    info = swagger_dict.get("info")
    host = swagger_dict.get("host")
    base_path = swagger_dict.get("basePath")

    # Extract Azure/Microsoft-specific extensions
    x_ms_parameterized_host = swagger_dict.get("x-ms-parameterized-host")
    x_ms_code_generation_settings = swagger_dict.get("x-ms-code-generation-settings")

    # Extract security configuration
    security_definitions = swagger_dict.get("securityDefinitions")
    security = swagger_dict.get("security")

    # Extract additional metadata
    tags = swagger_dict.get("tags")
    external_docs = swagger_dict.get("externalDocs")

    # Extract global content types and schemes
    consumes = None
    if "consumes" in swagger_dict and isinstance(swagger_dict["consumes"], list):
        consumes = frozenset(swagger_dict["consumes"])

    produces = None
    if "produces" in swagger_dict and isinstance(swagger_dict["produces"], list):
        produces = frozenset(swagger_dict["produces"])

    schemes = None
    if "schemes" in swagger_dict and isinstance(swagger_dict["schemes"], list):
        schemes = frozenset(swagger_dict["schemes"])

    # Build canonical definitions
    definitions_dict = swagger_dict.get("definitions", {})
    definitions = {}
    for def_name, def_schema in definitions_dict.items():
        if isinstance(def_schema, dict):
            definitions[def_name] = build_schema_from_dict(
                def_schema, definitions_dict, swagger_source
            )

    # Build global parameters
    parameters = None
    parameters_dict = swagger_dict.get("parameters", {})
    if parameters_dict:
        parameters = {}
        for param_name, param_def in parameters_dict.items():
            if isinstance(param_def, dict):
                parameters[param_name] = build_parameter_from_dict(
                    param_def, definitions_dict, swagger_source
                )

        # Store global parameters in definitions for reference resolution
        definitions_dict["__global_parameters"] = parameters_dict

    # Build global responses
    responses = None
    responses_dict = swagger_dict.get("responses", {})
    if responses_dict:
        responses = {}
        for response_name, response_def in responses_dict.items():
            if isinstance(response_def, dict):
                responses[response_name] = build_response_from_dict(
                    response_def,
                    definitions_dict,
                    list(produces) if produces else None,
                    swagger_source,
                )

    # Build canonical paths
    paths = {}
    paths_dict = swagger_dict.get("paths", {})

    for path_pattern, path_dict in paths_dict.items():
        if isinstance(path_dict, dict):
            operations = {}

            # HTTP methods
            http_methods = ["get", "post", "put", "delete", "patch", "head", "options"]
            for method in http_methods:
                if method in path_dict:
                    operation_dict = path_dict[method]
                    if isinstance(operation_dict, dict):
                        # Pass definitions_dict which now includes __global_parameters
                        operations[method.upper()] = build_operation_from_dict(
                            operation_dict, definitions_dict, swagger_source
                        )

            if operations:
                paths[path_pattern] = CanonicalPath(
                    operations=operations, swagger_source=swagger_source
                )

    return CanonicalApi(
        paths=paths,
        definitions=definitions,
        swagger_version=swagger_version,
        info=info,
        consumes=consumes,
        produces=produces,
        schemes=schemes,
        host=host,
        base_path=base_path,
        x_ms_parameterized_host=x_ms_parameterized_host,
        x_ms_code_generation_settings=x_ms_code_generation_settings,
        security_definitions=security_definitions,
        security=security,
        tags=tags,
        external_docs=external_docs,
        parameters=parameters,
        responses=responses,
        swagger_source=swagger_source,
    )
