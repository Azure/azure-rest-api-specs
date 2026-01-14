"""
Comparison module for swagger files.

This module implements deep comparison logic mirroring semantic_equiv:
1. Compare paths and HTTP methods
2. Compare operations (parameters, request/response bodies)
3. Compare schemas/definitions (type, format, properties, constraints)
4. Detect added/removed/changed elements

The comparison is strict on behavioral contract while ignoring doc-only differences.
"""

from dataclasses import dataclass, field
from typing import Any, Dict, List, Optional, Set, Tuple

from severity import classify_severity


@dataclass
class Difference:
    """Represents a single difference between GA and Preview."""

    type: str  # e.g., 'missing_path', 'parameter_mismatch'
    message: str
    context: str = ""  # e.g., path, method, parameter name
    severity: str = "unknown"  # 'breaking', 'non-breaking', 'unknown'


@dataclass
class ComparisonResult:
    """Result of comparing GA vs Preview swagger files."""

    differences: List[Dict[str, Any]] = field(default_factory=list)

    @property
    def has_breaking_changes(self) -> bool:
        return any(d["severity"] == "breaking" for d in self.differences)


class SwaggerComparator:
    """Main comparator class mirroring semantic_equiv logic."""

    def __init__(self, ga_name: str = "GA", preview_name: str = "Preview"):
        self.ga_name = ga_name
        self.preview_name = preview_name
        self.differences: List[Difference] = []

    def compare(
        self, ga_swagger: Dict[str, Any], preview_swagger: Dict[str, Any]
    ) -> ComparisonResult:
        """
        Compare two canonicalized swagger documents.

        Comparison dimensions (mirroring semantic_equiv):
        1. Paths + HTTP methods
        2. Operations (parameters, request bodies, responses)
        3. Schemas / definitions
        """
        self.differences = []

        # 1. Compare paths and methods
        self._compare_paths_and_methods(ga_swagger, preview_swagger)

        # 2. Compare operations for common paths
        self._compare_operations(ga_swagger, preview_swagger)

        # 3. Compare definitions/schemas
        self._compare_definitions(ga_swagger, preview_swagger)

        # Convert to dict format with severity classification
        result_diffs = []
        for diff in self.differences:
            diff_dict = {
                "type": diff.type,
                "message": diff.message,
                "context": diff.context,
                "severity": classify_severity(diff.type, diff.message, diff.context),
            }
            result_diffs.append(diff_dict)

        return ComparisonResult(differences=result_diffs)

    def _compare_paths_and_methods(self, ga_swagger: Dict, preview_swagger: Dict):
        """Compare path sets and method sets per path."""
        ga_paths = ga_swagger.get("paths", {})
        preview_paths = preview_swagger.get("paths", {})

        ga_path_set = set(ga_paths.keys())
        preview_path_set = set(preview_paths.keys())

        # Missing paths in preview (potentially breaking)
        missing_paths = ga_path_set - preview_path_set
        for path in sorted(missing_paths):
            self.differences.append(
                Difference(
                    type="missing_path",
                    message=f"Path missing in {self.preview_name}: {path}",
                    context=path,
                )
            )

        # Extra paths in preview (non-breaking addition)
        extra_paths = preview_path_set - ga_path_set
        for path in sorted(extra_paths):
            self.differences.append(
                Difference(
                    type="extra_path",
                    message=f"Extra path in {self.preview_name}: {path}",
                    context=path,
                )
            )

        # Compare methods for common paths
        common_paths = ga_path_set & preview_path_set
        for path in sorted(common_paths):
            self._compare_methods(path, ga_paths[path], preview_paths[path])

    def _compare_methods(self, path: str, ga_path_obj: Dict, preview_path_obj: Dict):
        """Compare HTTP method sets for a specific path."""
        # Get method sets (excluding non-method fields like 'parameters')
        http_methods = {"get", "post", "put", "delete", "patch", "options", "head"}

        ga_methods = {k for k in ga_path_obj.keys() if k.lower() in http_methods}
        preview_methods = {
            k for k in preview_path_obj.keys() if k.lower() in http_methods
        }

        # Missing methods in preview (potentially breaking)
        missing_methods = ga_methods - preview_methods
        for method in sorted(missing_methods):
            self.differences.append(
                Difference(
                    type="missing_method",
                    message=f"Method missing in {self.preview_name}: {method}",
                    context=f"{path} [{method}]",
                )
            )

        # Extra methods in preview (non-breaking)
        extra_methods = preview_methods - ga_methods
        for method in sorted(extra_methods):
            self.differences.append(
                Difference(
                    type="extra_method",
                    message=f"Extra method in {self.preview_name}: {method}",
                    context=f"{path} [{method}]",
                )
            )

    def _compare_operations(self, ga_swagger: Dict, preview_swagger: Dict):
        """Compare operations for common paths and methods."""
        ga_paths = ga_swagger.get("paths", {})
        preview_paths = preview_swagger.get("paths", {})

        # Only compare common paths
        common_paths = set(ga_paths.keys()) & set(preview_paths.keys())

        for path in sorted(common_paths):
            ga_path_obj = ga_paths[path]
            preview_path_obj = preview_paths[path]

            http_methods = {"get", "post", "put", "delete", "patch", "options", "head"}
            common_methods = {
                k for k in ga_path_obj.keys() if k.lower() in http_methods
            } & {k for k in preview_path_obj.keys() if k.lower() in http_methods}

            for method in sorted(common_methods):
                ga_op = ga_path_obj[method]
                preview_op = preview_path_obj[method]
                context = f"{path} [{method}]"

                # Compare operation ID
                ga_op_id = ga_op.get("operationId")
                preview_op_id = preview_op.get("operationId")
                if ga_op_id != preview_op_id:
                    self.differences.append(
                        Difference(
                            type="operation_id_mismatch",
                            message=f"Operation ID changed: {ga_op_id} -> {preview_op_id}",
                            context=context,
                        )
                    )

                # Compare parameters
                self._compare_parameters(ga_op, preview_op, context)

                # Compare request body
                self._compare_request_body(ga_op, preview_op, context)

                # Compare responses
                self._compare_responses(ga_op, preview_op, context)

                # Compare consumes/produces
                self._compare_content_types(ga_op, preview_op, context)

    def _compare_parameters(self, ga_op: Dict, preview_op: Dict, context: str):
        """Compare operation parameters."""
        ga_params = ga_op.get("parameters", [])
        preview_params = preview_op.get("parameters", [])

        # Create parameter keys (location, name)
        def make_param_key(param: Dict) -> Tuple[str, str]:
            return (param.get("in", ""), param.get("name", ""))

        ga_param_map = {make_param_key(p): p for p in ga_params}
        preview_param_map = {make_param_key(p): p for p in preview_params}

        ga_keys = set(ga_param_map.keys())
        preview_keys = set(preview_param_map.keys())

        # Missing parameters in preview (potentially breaking)
        missing_params = ga_keys - preview_keys
        for key in sorted(missing_params):
            param = ga_param_map[key]
            self.differences.append(
                Difference(
                    type="missing_parameter",
                    message=f"Parameter missing in {self.preview_name}: {param.get('name')} (in: {param.get('in')})",
                    context=f"{context} param:{param.get('name')}",
                )
            )

        # Extra parameters in preview (non-breaking if optional)
        extra_params = preview_keys - ga_keys
        for key in sorted(extra_params):
            param = preview_param_map[key]
            self.differences.append(
                Difference(
                    type="extra_parameter",
                    message=f"Extra parameter in {self.preview_name}: {param.get('name')} (in: {param.get('in')}, required: {param.get('required', False)})",
                    context=f"{context} param:{param.get('name')}",
                )
            )

        # Compare common parameters
        common_keys = ga_keys & preview_keys
        for key in sorted(common_keys):
            ga_param = ga_param_map[key]
            preview_param = preview_param_map[key]
            param_context = f"{context} param:{ga_param.get('name')}"

            # Compare required flag
            ga_required = ga_param.get("required", False)
            preview_required = preview_param.get("required", False)
            if ga_required != preview_required:
                self.differences.append(
                    Difference(
                        type="parameter_required_changed",
                        message=f"Parameter 'required' changed: {ga_required} -> {preview_required}",
                        context=param_context,
                    )
                )

            # Compare type/format for non-body parameters
            if ga_param.get("in") != "body":
                if ga_param.get("type") != preview_param.get("type"):
                    self.differences.append(
                        Difference(
                            type="parameter_type_changed",
                            message=f"Parameter type changed: {ga_param.get('type')} -> {preview_param.get('type')}",
                            context=param_context,
                        )
                    )

                if ga_param.get("format") != preview_param.get("format"):
                    self.differences.append(
                        Difference(
                            type="parameter_format_changed",
                            message=f"Parameter format changed: {ga_param.get('format')} -> {preview_param.get('format')}",
                            context=param_context,
                        )
                    )

            # Compare schema for body parameters
            if ga_param.get("in") == "body":
                self._compare_schemas(
                    ga_param.get("schema"),
                    preview_param.get("schema"),
                    param_context + " schema",
                )

    def _compare_request_body(self, ga_op: Dict, preview_op: Dict, context: str):
        """Compare request body schemas (from body parameters)."""
        # Request body is typically in a 'body' parameter
        ga_body_params = [
            p for p in ga_op.get("parameters", []) if p.get("in") == "body"
        ]
        preview_body_params = [
            p for p in preview_op.get("parameters", []) if p.get("in") == "body"
        ]

        ga_body_schema = ga_body_params[0].get("schema") if ga_body_params else None
        preview_body_schema = (
            preview_body_params[0].get("schema") if preview_body_params else None
        )

        if ga_body_schema or preview_body_schema:
            self._compare_schemas(
                ga_body_schema, preview_body_schema, f"{context} request_body"
            )

    def _compare_responses(self, ga_op: Dict, preview_op: Dict, context: str):
        """Compare operation responses."""
        ga_responses = ga_op.get("responses", {})
        preview_responses = preview_op.get("responses", {})

        ga_codes = set(ga_responses.keys())
        preview_codes = set(preview_responses.keys())

        # Missing response codes in preview
        missing_codes = ga_codes - preview_codes
        for code in sorted(missing_codes):
            self.differences.append(
                Difference(
                    type="missing_response",
                    message=f"Response code missing in {self.preview_name}: {code}",
                    context=f"{context} response:{code}",
                )
            )

        # Extra response codes in preview
        extra_codes = preview_codes - ga_codes
        for code in sorted(extra_codes):
            self.differences.append(
                Difference(
                    type="extra_response",
                    message=f"Extra response code in {self.preview_name}: {code}",
                    context=f"{context} response:{code}",
                )
            )

        # Compare common responses
        common_codes = ga_codes & preview_codes
        for code in sorted(common_codes):
            ga_resp = ga_responses[code]
            preview_resp = preview_responses[code]
            resp_context = f"{context} response:{code}"

            # Compare response schemas
            self._compare_schemas(
                ga_resp.get("schema"),
                preview_resp.get("schema"),
                resp_context + " schema",
            )

    def _compare_content_types(self, ga_op: Dict, preview_op: Dict, context: str):
        """Compare consumes/produces content types."""
        ga_consumes = set(ga_op.get("consumes", []))
        preview_consumes = set(preview_op.get("consumes", []))

        if ga_consumes != preview_consumes:
            self.differences.append(
                Difference(
                    type="consumes_changed",
                    message=f"Request content types changed: {sorted(ga_consumes)} -> {sorted(preview_consumes)}",
                    context=context,
                )
            )

        ga_produces = set(ga_op.get("produces", []))
        preview_produces = set(preview_op.get("produces", []))

        if ga_produces != preview_produces:
            self.differences.append(
                Difference(
                    type="produces_changed",
                    message=f"Response content types changed: {sorted(ga_produces)} -> {sorted(preview_produces)}",
                    context=context,
                )
            )

    def _compare_schemas(
        self, ga_schema: Optional[Dict], preview_schema: Optional[Dict], context: str
    ):
        """
        Deep compare two schemas.

        Compares: type, format, properties, required, additionalProperties, items, $ref
        """
        if ga_schema is None and preview_schema is None:
            return

        if ga_schema is None or preview_schema is None:
            self.differences.append(
                Difference(
                    type="schema_presence_changed",
                    message=f"Schema presence changed: {ga_schema is not None} -> {preview_schema is not None}",
                    context=context,
                )
            )
            return

        # Detect inline-to-ref or ref-to-inline conversions
        ga_type = ga_schema.get("type")
        preview_type = preview_schema.get("type")
        ga_ref = ga_schema.get("$ref")
        preview_ref = preview_schema.get("$ref")

        # Check for inline object/array -> $ref conversion (or vice versa)
        ga_is_inline = ga_type is not None and ga_ref is None
        preview_is_ref = preview_ref is not None and preview_type is None
        preview_is_inline = preview_type is not None and preview_ref is None
        ga_is_ref = ga_ref is not None and ga_type is None

        if ga_is_inline and preview_is_ref:
            # Inline schema converted to reference
            self.differences.append(
                Difference(
                    type="schema_inline_to_ref",
                    message=f"Schema changed from inline {ga_type} to reference {preview_ref}",
                    context=context,
                )
            )
        elif ga_is_ref and preview_is_inline:
            # Reference converted to inline schema
            self.differences.append(
                Difference(
                    type="schema_ref_to_inline",
                    message=f"Schema changed from reference {ga_ref} to inline {preview_type}",
                    context=context,
                )
            )
        else:
            # Report type and $ref changes separately only if not an inline<->ref conversion
            if ga_type != preview_type:
                self.differences.append(
                    Difference(
                        type="schema_type_changed",
                        message=f"Schema type changed: {ga_type} -> {preview_type}",
                        context=context,
                    )
                )

            if ga_ref != preview_ref:
                self.differences.append(
                    Difference(
                        type="schema_ref_changed",
                        message=f"Schema $ref changed: {ga_ref} -> {preview_ref}",
                        context=context,
                    )
                )

        # Compare format
        ga_format = ga_schema.get("format")
        preview_format = preview_schema.get("format")
        if ga_format != preview_format:
            self.differences.append(
                Difference(
                    type="schema_format_changed",
                    message=f"Schema format changed: {ga_format} -> {preview_format}",
                    context=context,
                )
            )

        # Compare properties (for object types)
        if (
            ga_type == "object"
            or "properties" in ga_schema
            or "properties" in preview_schema
        ):
            self._compare_schema_properties(ga_schema, preview_schema, context)

        # Compare items (for array types)
        if ga_type == "array" or "items" in ga_schema or "items" in preview_schema:
            self._compare_schemas(
                ga_schema.get("items"), preview_schema.get("items"), context + " items"
            )

        # Compare required fields
        ga_required = set(ga_schema.get("required", []))
        preview_required = set(preview_schema.get("required", []))

        if ga_required != preview_required:
            added_required = preview_required - ga_required
            removed_required = ga_required - preview_required

            if added_required:
                self.differences.append(
                    Difference(
                        type="schema_required_added",
                        message=f"Required fields added: {sorted(added_required)}",
                        context=context,
                    )
                )

            if removed_required:
                self.differences.append(
                    Difference(
                        type="schema_required_removed",
                        message=f"Required fields removed: {sorted(removed_required)}",
                        context=context,
                    )
                )

    def _compare_schema_properties(
        self, ga_schema: Dict, preview_schema: Dict, context: str
    ):
        """Compare object schema properties."""
        ga_props = ga_schema.get("properties", {})
        preview_props = preview_schema.get("properties", {})

        ga_prop_names = set(ga_props.keys())
        preview_prop_names = set(preview_props.keys())

        # Missing properties in preview
        missing_props = ga_prop_names - preview_prop_names
        if missing_props:
            self.differences.append(
                Difference(
                    type="schema_properties_removed",
                    message=f"Properties removed: {sorted(missing_props)}",
                    context=context,
                )
            )

        # Extra properties in preview
        extra_props = preview_prop_names - ga_prop_names
        if extra_props:
            self.differences.append(
                Difference(
                    type="schema_properties_added",
                    message=f"Properties added: {sorted(extra_props)}",
                    context=context,
                )
            )

        # Compare common properties (recursively)
        common_props = ga_prop_names & preview_prop_names
        for prop_name in sorted(common_props):
            self._compare_schemas(
                ga_props[prop_name],
                preview_props[prop_name],
                f"{context} property:{prop_name}",
            )

    def _compare_definitions(self, ga_swagger: Dict, preview_swagger: Dict):
        """Compare definitions/models."""
        ga_defs = ga_swagger.get("definitions", {})
        preview_defs = preview_swagger.get("definitions", {})

        ga_def_names = set(ga_defs.keys())
        preview_def_names = set(preview_defs.keys())

        # Missing definitions in preview
        missing_defs = ga_def_names - preview_def_names
        for def_name in sorted(missing_defs):
            self.differences.append(
                Difference(
                    type="missing_definition",
                    message=f"Definition missing in {self.preview_name}: {def_name}",
                    context=f"definition:{def_name}",
                )
            )

        # Extra definitions in preview
        extra_defs = preview_def_names - ga_def_names
        for def_name in sorted(extra_defs):
            self.differences.append(
                Difference(
                    type="extra_definition",
                    message=f"Extra definition in {self.preview_name}: {def_name}",
                    context=f"definition:{def_name}",
                )
            )

        # Compare common definitions
        common_defs = ga_def_names & preview_def_names
        for def_name in sorted(common_defs):
            self._compare_schemas(
                ga_defs[def_name], preview_defs[def_name], f"definition:{def_name}"
            )


def compare_swagger_files(
    ga_swagger: Dict[str, Any],
    preview_swagger: Dict[str, Any],
    ga_name: str = "GA",
    preview_name: str = "Preview",
) -> ComparisonResult:
    """
    Compare two swagger documents and return structured results.

    Args:
        ga_swagger: Canonicalized GA swagger
        preview_swagger: Canonicalized Preview swagger
        ga_name: Name for GA version in messages
        preview_name: Name for Preview version in messages

    Returns:
        ComparisonResult with all differences and severity classifications
    """
    comparator = SwaggerComparator(ga_name, preview_name)
    return comparator.compare(ga_swagger, preview_swagger)
    return comparator.compare(ga_swagger, preview_swagger)
