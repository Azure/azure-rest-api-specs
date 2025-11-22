"""
Utility module for the Swagger equivalency checker.

This module combines configuration loading, file loading, and merging functionality
that was previously split across config.py, loader.py, and merge.py.

Handles reading and validating config.yaml, loading and parsing JSON files,
and merging hand-authored Swagger specifications according to equiv_impl_guide.md.
"""

import copy
import json
import os
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path
from typing import Any, Dict, List

import pandas as pd
import yaml


def write_diffs_excel(
    diffs: List[Dict[str, Any]],
    output_path: str,
    hand_authored_canonical: dict = None,
    typespec_canonical: dict = None,
) -> None:
    """Write differences to Excel file with side-by-side comparison format"""

    # Debug prints
    print(
        f"hand_authored_canonical is {'available' if hand_authored_canonical else 'None'}"
    )
    print(f"typespec_canonical is {'available' if typespec_canonical else 'None'}")
    if hand_authored_canonical:
        print(
            f"hand_authored paths count: {len(hand_authored_canonical.get('paths', {}))}"
        )
    if typespec_canonical:
        print(f"typespec paths count: {len(typespec_canonical.get('paths', {}))}")

    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    excel_file = Path(output_path) / f"diff_{timestamp}.xlsx"
    excel_file.parent.mkdir(parents=True, exist_ok=True)

    # Categorize differences
    categories = {
        "Paths": [],
        "Parameters": [],
        "Responses": [],
        "Definitions": [],
        "Operations": [],
        "Other": [],
    }

    for diff in diffs:
        description = diff.get("description", "").lower()
        category = "Other"  # default

        if "path" in description and (
            "missing" in description or "extra" in description
        ):
            category = "Paths"
        elif "parameter" in description or "param:" in description:
            category = "Parameters"
        elif "response" in description:
            category = "Responses"
        elif "definition:" in description:
            category = "Definitions"
        elif "operation" in description:
            category = "Operations"

        categories[category].append(diff)

    # Create side-by-side comparison data
    def create_comparison_data(hand_authored_canonical, typespec_canonical):
        """Create comprehensive comparison data including equal and different items"""
        comparison_data = {
            "Paths": [],
            "Parameters": [],
            "Responses": [],
            "Definitions": [],
            "Other": [],
        }

        if not hand_authored_canonical or not typespec_canonical:
            return comparison_data

        # Helper function to create comparison key
        def create_comparison_key(full_url, method, operation_id):
            """Create a unique key for operation comparison"""
            return f"{full_url}#{method.upper()}#{operation_id}"

        # 1. Compare Paths and Operations
        hand_paths = {}
        tsp_paths = {}

        # Extract paths and operations from hand-authored spec
        if "paths" in hand_authored_canonical:
            for path, path_methods in hand_authored_canonical["paths"].items():
                if isinstance(path_methods, dict):
                    # Paths are already full URLs from the build_full_paths step
                    full_url = path
                    # Extract source information if available
                    path_source = path_methods.get("_swagger_source", "unknown")

                    for method, operation in path_methods.items():
                        if isinstance(operation, dict) and method.lower() in [
                            "get",
                            "post",
                            "put",
                            "delete",
                            "patch",
                            "head",
                            "options",
                        ]:
                            operation_id = operation.get("operationId", "")
                            operation_source = operation.get(
                                "_swagger_source", path_source
                            )
                            # Use full URL + method + operation ID as the key for comparison
                            comparison_key = create_comparison_key(
                                full_url, method, operation_id
                            )
                            hand_paths[comparison_key] = {
                                "operation_id": operation_id,
                                "parameters": operation.get("parameters", []),
                                "responses": operation.get("responses", {}),
                                "original_path": path,  # Keep track of original path
                                "full_url": full_url,
                                "method": method.upper(),
                                "swagger_source": operation_source,  # Use tracked source instead of heuristic
                            }

        # Extract paths and operations from typespec spec
        if "paths" in typespec_canonical:
            for path, path_methods in typespec_canonical["paths"].items():
                if isinstance(path_methods, dict):
                    # Paths are already full URLs from the build_full_paths step
                    full_url = path
                    for method, operation in path_methods.items():
                        if isinstance(operation, dict):
                            operation_id = operation.get("operationId", "")
                            # Use full URL + method + operation ID as the key for comparison
                            comparison_key = create_comparison_key(
                                full_url, method, operation_id
                            )
                            tsp_paths[comparison_key] = {
                                "operation_id": operation_id,
                                "parameters": operation.get("parameters", []),
                                "responses": operation.get("responses", {}),
                                "original_path": path,  # Keep track of original path
                                "full_url": full_url,
                                "method": method.upper(),
                            }

        # Create path/operation comparisons
        all_comparison_keys = set(hand_paths.keys()).union(set(tsp_paths.keys()))
        for comparison_key in all_comparison_keys:
            hand_op = hand_paths.get(comparison_key)
            tsp_op = tsp_paths.get(comparison_key)

            if hand_op and tsp_op:
                # Both exist - compare details
                # Use tracked source information instead of heuristic pattern matching
                swagger_source = hand_op.get("swagger_source", "unknown")
                if hand_op["operation_id"] == tsp_op["operation_id"]:
                    diff_type = "Equal"
                    diff_details = ""
                else:
                    diff_type = "Different"
                    diff_details = f"OperationId: '{hand_op['operation_id']}' vs '{tsp_op['operation_id']}'"

                # Add to Paths
                comparison_data["Paths"].append(
                    {
                        "Swagger": swagger_source,
                        "Full Path": hand_op["full_url"],  # Already full URL
                        "Method": hand_op["method"],
                        "Operation ID": hand_op["operation_id"],
                        "TSP Full Path": tsp_op[
                            "original_path"
                        ],  # Path from TSP-compiled JSON
                        "TSP Method": tsp_op["method"],
                        "TSP Operation ID": tsp_op["operation_id"],
                        "Diff Type": diff_type,
                        "Diff Details": diff_details,
                    }
                )

            elif hand_op and not tsp_op:
                # Missing in TSP
                swagger_source = hand_op.get("swagger_source", "unknown")
                diff_type = "Missing in TSP"
                diff_details = "Operation exists in Swagger but not in TSP"

                comparison_data["Paths"].append(
                    {
                        "Swagger": swagger_source,
                        "Full Path": hand_op["full_url"],  # Already full URL
                        "Method": hand_op["method"],
                        "Operation ID": hand_op["operation_id"],
                        "TSP Full Path": "",
                        "TSP Method": "",
                        "TSP Operation ID": "",
                        "Diff Type": diff_type,
                        "Diff Details": diff_details,
                    }
                )

            elif not hand_op and tsp_op:
                # Extra in TSP
                diff_type = "Extra in TSP"
                diff_details = "Operation exists in TSP but not in Swagger"

                comparison_data["Paths"].append(
                    {
                        "Swagger": "",
                        "Full Path": "",
                        "Method": "",
                        "Operation ID": "",
                        "TSP Full Path": tsp_op[
                            "original_path"
                        ],  # Path from TSP-compiled JSON
                        "TSP Method": tsp_op["method"],
                        "TSP Operation ID": tsp_op["operation_id"],
                        "Diff Type": diff_type,
                        "Diff Details": diff_details,
                    }
                )

        # 2. Compare Parameters for matched operations only
        for comparison_key, hand_op in hand_paths.items():
            tsp_op = tsp_paths.get(comparison_key)

            # Only compare parameters for operations that exist in both specs
            if not tsp_op:
                continue

            swagger_source = (
                "knowledgebase"
                if "/knowledgebases(" in hand_op["full_url"]
                and hand_op["full_url"].endswith("/retrieve")
                else "searchindex"
                if "/docs" in hand_op["full_url"]
                else "searchservice"
            )
            path = hand_op["original_path"]
            method = hand_op["method"]
            hand_params = {
                (p.get("name", ""), p.get("in", "query")): p
                for p in hand_op.get("parameters", [])
            }
            tsp_params = {
                (p.get("name", ""), p.get("in", "query")): p
                for p in tsp_op.get("parameters", [])
            }

            all_param_keys = set(hand_params.keys()).union(set(tsp_params.keys()))

            for param_key in all_param_keys:
                param_name, param_location = param_key
                hand_param = hand_params.get(param_key)
                tsp_param = tsp_params.get(param_key)

                if hand_param and tsp_param:
                    # Both exist - compare details
                    swagger_type = hand_param.get("type", "")
                    swagger_required = hand_param.get("required", False)
                    tsp_type = tsp_param.get("type", "")
                    tsp_required = tsp_param.get("required", False)

                    if swagger_type == tsp_type and swagger_required == tsp_required:
                        diff_type = "Equal"
                        diff_details = ""
                    else:
                        diff_type = "Different"
                        details = []
                        if swagger_type != tsp_type:
                            details.append(f"Type: '{swagger_type}' vs '{tsp_type}'")
                        if swagger_required != tsp_required:
                            details.append(
                                f"Required: {swagger_required} vs {tsp_required}"
                            )
                        diff_details = "; ".join(details)

                    comparison_data["Parameters"].append(
                        {
                            "Swagger Source": swagger_source,
                            "Path": path,
                            "Method": method,
                            "Parameter": param_name,
                            "Swagger Type": swagger_type,
                            "Swagger Required": swagger_required,
                            "TSP Type": tsp_type,
                            "TSP Required": tsp_required,
                            "Diff Type": diff_type,
                            "Diff Details": diff_details,
                        }
                    )

                elif hand_param and not tsp_param:
                    # Missing in TSP
                    comparison_data["Parameters"].append(
                        {
                            "Swagger Source": swagger_source,
                            "Path": path,
                            "Method": method,
                            "Parameter": param_name,
                            "Swagger Type": hand_param.get("type", ""),
                            "Swagger Required": hand_param.get("required", False),
                            "TSP Type": "",
                            "TSP Required": "",
                            "Diff Type": "Missing in TSP",
                            "Diff Details": f"Parameter '{param_name}' exists in Swagger but not in TSP",
                        }
                    )

                elif not hand_param and tsp_param:
                    # Extra in TSP
                    comparison_data["Parameters"].append(
                        {
                            "Swagger Source": swagger_source,
                            "Path": path,
                            "Method": method,
                            "Parameter": param_name,
                            "Swagger Type": "",
                            "Swagger Required": "",
                            "TSP Type": tsp_param.get("type", ""),
                            "TSP Required": tsp_param.get("required", False),
                            "Diff Type": "Extra in TSP",
                            "Diff Details": f"Parameter '{param_name}' exists in TSP but not in Swagger",
                        }
                    )

        # 3. Compare Responses for matched operations only
        for comparison_key, hand_op in hand_paths.items():
            tsp_op = tsp_paths.get(comparison_key)

            # Only compare responses for operations that exist in both specs
            if not tsp_op:
                continue

            swagger_source = (
                "knowledgebase"
                if "/knowledgebases(" in hand_op["full_url"]
                and hand_op["full_url"].endswith("/retrieve")
                else "searchindex"
                if "/docs" in hand_op["full_url"]
                else "searchservice"
            )
            path = hand_op["original_path"]
            method = hand_op["method"]
            hand_responses = hand_op.get("responses", {})
            tsp_responses = tsp_op.get("responses", {})

            all_response_codes = set(hand_responses.keys()).union(
                set(tsp_responses.keys())
            )

            for response_code in all_response_codes:
                hand_response = hand_responses.get(response_code)
                tsp_response = tsp_responses.get(response_code)

                if hand_response and tsp_response:
                    # Both exist - compare schemas
                    hand_schema = hand_response.get("schema", {})
                    tsp_schema = tsp_response.get("schema", {})

                    hand_schema_str = str(hand_schema)[:100] + (
                        "..." if len(str(hand_schema)) > 100 else ""
                    )
                    tsp_schema_str = str(tsp_schema)[:100] + (
                        "..." if len(str(tsp_schema)) > 100 else ""
                    )

                    if hand_schema == tsp_schema:
                        diff_type = "Equal"
                        diff_details = ""
                    else:
                        diff_type = "Different"
                        diff_details = "Response schemas differ"

                    comparison_data["Responses"].append(
                        {
                            "Swagger Source": swagger_source,
                            "Path": path,
                            "Method": method,
                            "Response Code": response_code,
                            "Swagger Schema": hand_schema_str,
                            "TSP Schema": tsp_schema_str,
                            "Diff Type": diff_type,
                            "Diff Details": diff_details,
                        }
                    )

                elif hand_response and not tsp_response:
                    # Missing in TSP
                    hand_schema = hand_response.get("schema", {})
                    hand_schema_str = str(hand_schema)[:100] + (
                        "..." if len(str(hand_schema)) > 100 else ""
                    )

                    comparison_data["Responses"].append(
                        {
                            "Swagger Source": swagger_source,
                            "Path": path,
                            "Method": method,
                            "Response Code": response_code,
                            "Swagger Schema": hand_schema_str,
                            "TSP Schema": "",
                            "Diff Type": "Missing in TSP",
                            "Diff Details": f"Response '{response_code}' exists in Swagger but not in TSP",
                        }
                    )

                elif not hand_response and tsp_response:
                    # Extra in TSP
                    tsp_schema = tsp_response.get("schema", {})
                    tsp_schema_str = str(tsp_schema)[:100] + (
                        "..." if len(str(tsp_schema)) > 100 else ""
                    )

                    comparison_data["Responses"].append(
                        {
                            "Swagger Source": swagger_source,
                            "Path": path,
                            "Method": method,
                            "Response Code": response_code,
                            "Swagger Schema": "",
                            "TSP Schema": tsp_schema_str,
                            "Diff Type": "Extra in TSP",
                            "Diff Details": f"Response '{response_code}' exists in TSP but not in Swagger",
                        }
                    )

        # Helper function for definition source
        def get_definition_source(def_name):
            """Determine which swagger file likely contains this definition based on naming patterns"""
            # Simple pattern-based detection since we don't have original files context
            if (
                "index" in def_name.lower()
                or "search" in def_name.lower()
                or "document" in def_name.lower()
            ):
                return "searchindex"
            elif "knowledge" in def_name.lower() or "retrieve" in def_name.lower():
                return "knowledgebase"
            elif "error" in def_name.lower() or "common" in def_name.lower():
                return "common_types"
            else:
                return "searchservice"  # default fallback

        # 4. Compare Definitions
        hand_definitions = hand_authored_canonical.get("definitions", {})
        tsp_definitions = typespec_canonical.get("definitions", {})

        all_definition_names = set(hand_definitions.keys()).union(
            set(tsp_definitions.keys())
        )

        for def_name in all_definition_names:
            hand_def = hand_definitions.get(def_name)
            tsp_def = tsp_definitions.get(def_name)

            swagger_source = get_definition_source(def_name)

            if hand_def and tsp_def:
                # Both exist - compare
                hand_type = hand_def.get("type", "")
                tsp_type = tsp_def.get("type", "")
                hand_props = list(hand_def.get("properties", {}).keys())
                tsp_props = list(tsp_def.get("properties", {}).keys())

                if hand_type == tsp_type and set(hand_props) == set(tsp_props):
                    diff_type = "Equal"
                    diff_details = ""
                else:
                    diff_type = "Different"
                    details = []
                    if hand_type != tsp_type:
                        details.append(f"Type: '{hand_type}' vs '{tsp_type}'")
                    if set(hand_props) != set(tsp_props):
                        details.append("Properties differ")
                    diff_details = "; ".join(details)

                comparison_data["Definitions"].append(
                    {
                        "Swagger Source": swagger_source,
                        "Definition Name": def_name,
                        "Swagger Type": hand_type,
                        "Swagger Properties": ", ".join(hand_props[:5])
                        + ("..." if len(hand_props) > 5 else ""),
                        "TSP Type": tsp_type,
                        "TSP Properties": ", ".join(tsp_props[:5])
                        + ("..." if len(tsp_props) > 5 else ""),
                        "Diff Type": diff_type,
                        "Diff Details": diff_details,
                    }
                )

            elif hand_def and not tsp_def:
                # Missing in TSP
                hand_type = hand_def.get("type", "")
                hand_props = list(hand_def.get("properties", {}).keys())

                comparison_data["Definitions"].append(
                    {
                        "Swagger Source": swagger_source,
                        "Definition Name": def_name,
                        "Swagger Type": hand_type,
                        "Swagger Properties": ", ".join(hand_props[:5])
                        + ("..." if len(hand_props) > 5 else ""),
                        "TSP Type": "",
                        "TSP Properties": "",
                        "Diff Type": "Missing in TSP",
                        "Diff Details": f"Definition '{def_name}' exists in Swagger but not in TSP",
                    }
                )

            elif not hand_def and tsp_def:
                # Extra in TSP
                tsp_type = tsp_def.get("type", "")
                tsp_props = list(tsp_def.get("properties", {}).keys())

                comparison_data["Definitions"].append(
                    {
                        "Swagger Source": "",
                        "Definition Name": def_name,
                        "Swagger Type": "",
                        "Swagger Properties": "",
                        "TSP Type": tsp_type,
                        "TSP Properties": ", ".join(tsp_props[:5])
                        + ("..." if len(tsp_props) > 5 else ""),
                        "Diff Type": "Extra in TSP",
                        "Diff Details": f"Definition '{def_name}' exists in TSP but not in Swagger",
                    }
                )

        return comparison_data  # Create Excel writer

    with pd.ExcelWriter(excel_file, engine="openpyxl") as writer:
        # Summary sheet (without percentage, with total)
        summary_data = []
        total_count = 0
        for category, items in categories.items():
            count = len(items)
            total_count += count
            summary_data.append({"Category": category, "Count": count})

        # Add total row
        summary_data.append({"Category": "Total", "Count": total_count})

        summary_df = pd.DataFrame(summary_data)
        summary_df.to_excel(writer, sheet_name="Summary", index=False)

        # Get comparison data
        comparison_data = create_comparison_data(
            hand_authored_canonical, typespec_canonical
        )
        print(f"comparison_data keys: {list(comparison_data.keys())}")
        print(f"Paths data count: {len(comparison_data['Paths'])}")
        print(f"Parameters data count: {len(comparison_data['Parameters'])}")

        # Paths sheet
        if comparison_data["Paths"]:
            print(f"Creating Paths sheet with {len(comparison_data['Paths'])} rows")
            paths_df = pd.DataFrame(comparison_data["Paths"])
            paths_df.to_excel(
                writer, sheet_name="Paths", index=False
            )  # Parameters sheet
        if comparison_data["Parameters"]:
            params_df = pd.DataFrame(comparison_data["Parameters"])
            params_df.to_excel(writer, sheet_name="Parameters", index=False)

        # Responses sheet
        if comparison_data["Responses"]:
            responses_df = pd.DataFrame(comparison_data["Responses"])
            responses_df.to_excel(writer, sheet_name="Responses", index=False)

        # Definitions sheet
        if comparison_data["Definitions"]:
            definitions_df = pd.DataFrame(comparison_data["Definitions"])
            definitions_df.to_excel(writer, sheet_name="Definitions", index=False)

        # Other sheet - for any remaining differences that don't fit other categories
        other_data = []
        for diff in categories["Other"]:
            swagger_source = diff.get("swagger_source", "searchservice")
            other_data.append(
                {
                    "Swagger": swagger_source,
                    "Item Type": "Other",
                    "Item Name": diff.get("description", "")[:50],
                    "Item Value": "",
                    "TSP Item Type": "",
                    "TSP Item Name": "",
                    "TSP Item Value": "",
                    "Diff Type": "Different",
                    "Diff Details": diff.get("description", ""),
                }
            )

        if other_data:
            other_df = pd.DataFrame(other_data)
            other_df.to_excel(writer, sheet_name="Other", index=False)


# Configuration classes and functions


@dataclass
class HandAuthoredConfig:
    """Configuration for hand-authored Swagger files."""

    searchservice_path: str
    searchindex_path: str
    knowledgebase_path: str
    common_types_path: str


@dataclass
class Config:
    """Main configuration object for the equivalency checker."""

    typespec_compiled_path: str
    hand_authored: HandAuthoredConfig
    output_path: str

    def resolve_paths(self, base_dir: Path) -> "Config":
        """Resolve relative paths against the base directory."""
        return Config(
            typespec_compiled_path=str(base_dir / self.typespec_compiled_path),
            hand_authored=HandAuthoredConfig(
                searchservice_path=str(
                    base_dir / self.hand_authored.searchservice_path
                ),
                searchindex_path=str(base_dir / self.hand_authored.searchindex_path),
                knowledgebase_path=str(
                    base_dir / self.hand_authored.knowledgebase_path
                ),
                common_types_path=str(base_dir / self.hand_authored.common_types_path),
            ),
            output_path=str(base_dir / self.output_path),
        )


# Error classes


class ConfigError(Exception):
    """Exception raised for configuration-related errors."""

    pass


class LoaderError(Exception):
    """Exception raised for file loading and parsing errors."""

    pass


class MergeError(Exception):
    """Exception raised for merge-related errors."""

    pass


def load_config(config_path: str) -> Config:
    """
    Load and validate configuration from a YAML file.

    Args:
        config_path: Path to the config.yaml file

    Returns:
        Validated Config object

    Raises:
        ConfigError: If the config file is invalid or missing required fields
    """
    if not os.path.exists(config_path):
        raise ConfigError(f"Configuration file not found: {config_path}")

    try:
        with open(config_path, "r", encoding="utf-8") as f:
            raw_config = yaml.safe_load(f)
    except yaml.YAMLError as e:
        raise ConfigError(f"Invalid YAML in configuration file: {e}")
    except Exception as e:
        raise ConfigError(f"Error reading configuration file: {e}")

    # Validate structure
    if not isinstance(raw_config, dict):
        raise ConfigError("Configuration must be a YAML object")

    # Extract and validate typespec_compiled
    typespec_compiled = raw_config.get("typespec_compiled", {})
    if not isinstance(typespec_compiled, dict) or "path" not in typespec_compiled:
        raise ConfigError(
            "Missing or invalid 'typespec_compiled.path' in configuration"
        )

    # Extract and validate hand_authored
    hand_authored = raw_config.get("hand_authored", {})
    if not isinstance(hand_authored, dict):
        raise ConfigError("Missing or invalid 'hand_authored' section in configuration")

    required_hand_authored_keys = [
        "searchservice",
        "searchindex",
        "knowledgebase",
        "common_types",
    ]
    for key in required_hand_authored_keys:
        if key not in hand_authored or not isinstance(hand_authored[key], dict):
            raise ConfigError(
                f"Missing or invalid 'hand_authored.{key}' in configuration"
            )
        if "path" not in hand_authored[key]:
            raise ConfigError(f"Missing 'hand_authored.{key}.path' in configuration")

    # Extract and validate output
    output = raw_config.get("output", {})
    if not isinstance(output, dict) or "path" not in output:
        raise ConfigError("Missing or invalid 'output.path' in configuration")

    # Build config object
    try:
        config = Config(
            typespec_compiled_path=typespec_compiled["path"],
            hand_authored=HandAuthoredConfig(
                searchservice_path=hand_authored["searchservice"]["path"],
                searchindex_path=hand_authored["searchindex"]["path"],
                knowledgebase_path=hand_authored["knowledgebase"]["path"],
                common_types_path=hand_authored["common_types"]["path"],
            ),
            output_path=output["path"],
        )

        # Resolve relative paths against config file directory
        config_dir = Path(config_path).parent
        return config.resolve_paths(config_dir)

    except Exception as e:
        raise ConfigError(f"Error building configuration object: {e}")


def validate_paths(config: Config) -> None:
    """
    Validate that all configured file paths exist and are readable.

    Args:
        config: Configuration object to validate

    Raises:
        ConfigError: If any configured file path does not exist or is not readable
    """
    paths_to_check = [
        ("TypeSpec compiled file", config.typespec_compiled_path),
        ("Hand-authored searchservice file", config.hand_authored.searchservice_path),
        ("Hand-authored searchindex file", config.hand_authored.searchindex_path),
        ("Hand-authored knowledgebase file", config.hand_authored.knowledgebase_path),
        ("Common types file", config.hand_authored.common_types_path),
    ]

    missing_files = []
    for name, path in paths_to_check:
        if not os.path.exists(path):
            missing_files.append(f"{name}: {path}")
        elif not os.path.isfile(path):
            missing_files.append(f"{name} is not a file: {path}")

    if missing_files:
        raise ConfigError(
            "Missing or invalid files:\n" + "\n".join(f"  - {f}" for f in missing_files)
        )

    # Ensure output directory exists or can be created
    output_dir = Path(config.output_path)
    try:
        output_dir.mkdir(parents=True, exist_ok=True)
    except Exception as e:
        raise ConfigError(f"Cannot create output directory {config.output_path}: {e}")


# Loader functions


def load_swagger_json(file_path: str) -> Dict[str, Any]:
    """
    Load a Swagger JSON file and return it as a Python dictionary.

    Args:
        file_path: Path to the JSON file to load

    Returns:
        Parsed JSON as a Python dictionary

    Raises:
        LoaderError: If the file cannot be found, read, or parsed as JSON
    """
    if not os.path.exists(file_path):
        raise LoaderError(f"File not found: {file_path}")

    if not os.path.isfile(file_path):
        raise LoaderError(f"Path is not a file: {file_path}")

    try:
        with open(file_path, "r", encoding="utf-8") as f:
            content = f.read()
    except Exception as e:
        raise LoaderError(f"Error reading file {file_path}: {e}")

    if not content.strip():
        raise LoaderError(f"File is empty: {file_path}")

    try:
        data = json.loads(content)
    except json.JSONDecodeError as e:
        raise LoaderError(f"Invalid JSON in file {file_path}: {e}")

    if not isinstance(data, dict):
        raise LoaderError(
            f"JSON file must contain an object, not {type(data).__name__}: {file_path}"
        )

    return data


def load_all_swagger_files(config) -> Dict[str, Dict[str, Any]]:
    """
    Load all Swagger files specified in the configuration.

    Args:
        config: Configuration object containing file paths

    Returns:
        Dictionary mapping file names to their parsed JSON content:
        - 'typespec_compiled': TypeSpec-compiled Swagger
        - 'searchservice': Hand-authored searchservice Swagger
        - 'searchindex': Hand-authored searchindex Swagger
        - 'knowledgebase': Hand-authored knowledgebase Swagger
        - 'common_types': Common types Swagger

        Each loaded swagger dictionary includes a '_swagger_source' field
        indicating the source file name.

    Raises:
        LoaderError: If any file cannot be loaded
    """
    files_to_load = [
        ("typespec_compiled", config.typespec_compiled_path),
        ("searchservice", config.hand_authored.searchservice_path),
        ("searchindex", config.hand_authored.searchindex_path),
        ("knowledgebase", config.hand_authored.knowledgebase_path),
        ("common_types", config.hand_authored.common_types_path),
    ]

    loaded_files = {}

    for name, path in files_to_load:
        try:
            swagger_dict = load_swagger_json(path)
            # Add source information to the swagger dictionary
            swagger_dict["_swagger_source"] = name
            loaded_files[name] = swagger_dict
        except LoaderError as e:
            # Re-raise with context about which file failed
            raise LoaderError(f"Failed to load {name}: {e}")

    return loaded_files


def validate_swagger_structure(swagger_dict: Dict[str, Any], file_name: str) -> None:
    """
    Validate that a loaded JSON dictionary has the basic structure of a Swagger file.

    Args:
        swagger_dict: Parsed Swagger JSON
        file_name: Name of the file (for error messages)

    Raises:
        LoaderError: If the structure is invalid
    """
    # Check for required top-level fields according to Swagger 2.0 spec
    required_fields = ["swagger", "info"]
    missing_fields = []

    for required_field in required_fields:
        if required_field not in swagger_dict:
            missing_fields.append(required_field)

    if missing_fields:
        raise LoaderError(
            f"Invalid Swagger structure in {file_name}: "
            f"missing required fields: {', '.join(missing_fields)}"
        )

    # Validate swagger version
    swagger_version = swagger_dict.get("swagger")
    if not isinstance(swagger_version, str) or not swagger_version.startswith("2."):
        raise LoaderError(
            f"Unsupported Swagger version in {file_name}: "
            f"expected 2.x, got {swagger_version}"
        )

    # Validate info section
    info = swagger_dict.get("info")
    if not isinstance(info, dict):
        raise LoaderError(f"Invalid 'info' section in {file_name}: must be an object")

    # Optional: validate other common sections exist and are the right type
    optional_sections = {
        "paths": dict,
        "definitions": dict,
        "parameters": dict,
        "responses": dict,
        "schemes": list,
        "consumes": list,
        "produces": list,
        "tags": list,
    }

    for section_name, expected_type in optional_sections.items():
        if section_name in swagger_dict:
            section_value = swagger_dict[section_name]
            if not isinstance(section_value, expected_type):
                raise LoaderError(
                    f"Invalid '{section_name}' section in {file_name}: "
                    f"expected {expected_type.__name__}, got {type(section_value).__name__}"
                )
    print(f"Validated Swagger structure for {file_name}")


def build_full_paths_for_all_files(
    loaded_files: Dict[str, Dict[str, Any]],
) -> Dict[str, Dict[str, Any]]:
    """
    Build full paths for all loaded Swagger files that use x-ms-parameterized-host.

    This function processes each loaded file and transforms paths by combining
    the hostTemplate with the original paths to create full URLs.

    Args:
        loaded_files: Dictionary mapping file names to their parsed JSON content

    Returns:
        Dictionary with the same structure but with full paths constructed
    """
    print("Building full paths for loaded files")

    def build_full_url(spec, path):
        """Build full URL by combining host template with path"""
        if (
            "x-ms-parameterized-host" in spec
            and "hostTemplate" in spec["x-ms-parameterized-host"]
        ):
            host_template = spec["x-ms-parameterized-host"]["hostTemplate"]
            # Extract path segment from host template (everything after the endpoint)
            # e.g., "{endpoint}/knowledgebases('{knowledgeBaseName}')" -> "/knowledgebases('{knowledgeBaseName}')"
            if "}/" in host_template:
                host_path_segment = "/" + host_template.split("}/", 1)[1]
                # If the current path doesn't start with this segment, prepend it
                if not path.startswith(host_path_segment):
                    return host_path_segment + path
                else:
                    return path
            else:
                # Host template doesn't have additional path, just return the path
                return path
        else:
            # No parameterized host, return path as-is
            return path

    def transform_spec_paths(spec):
        """Transform all paths in a single spec to use full URLs"""
        if "paths" not in spec or not isinstance(spec["paths"], dict):
            return spec

        # Create a new spec with transformed paths
        transformed_spec = spec.copy()
        new_paths = {}

        for original_path, path_methods in spec["paths"].items():
            full_path = build_full_url(spec, original_path)
            new_paths[full_path] = path_methods

            # Log the transformation if it changed
            if full_path != original_path:
                print(f"  Transformed: {original_path} -> {full_path}")

        transformed_spec["paths"] = new_paths
        return transformed_spec

    # Process each loaded file
    transformed_files = {}
    for file_name, spec in loaded_files.items():
        if file_name == "typespec_compiled":
            # TypeSpec compiled files should already have full paths, but transform anyway for consistency
            transformed_files[file_name] = transform_spec_paths(spec)
        else:
            # Hand-authored files need path transformation
            print(f"  Processing {file_name}...")
            transformed_files[file_name] = transform_spec_paths(spec)

    print(f"Completed building full paths for {len(transformed_files)} files")
    return transformed_files


def load_and_validate_all_files(config) -> Dict[str, Dict[str, Any]]:
    """
    Load and validate all Swagger files specified in the configuration.

    This is a convenience function that combines loading and basic validation.

    Args:
        config: Configuration object containing file paths

    Returns:
        Dictionary mapping file names to their validated parsed JSON content

    Raises:
        LoaderError: If any file cannot be loaded or is invalid
    """
    loaded_files = load_all_swagger_files(config)
    print(f"Loaded Swagger files: {list(loaded_files.keys())}")

    # Validate each loaded file
    for name, swagger_dict in loaded_files.items():
        validate_swagger_structure(swagger_dict, name)

    return loaded_files


# Merging functions


def _indent_text(text: str, indent_spaces: int) -> str:
    """
    Helper function to indent each line of text by a specified number of spaces.

    Args:
        text: The text to indent
        indent_spaces: Number of spaces to indent each line

    Returns:
        Indented text
    """
    indent = " " * indent_spaces
    return "\n".join(indent + line for line in text.split("\n"))


def merge_objects(
    target: Dict[str, Any],
    source: Dict[str, Any],
    context: str,
    allow_conflicts: bool = False,
    smart_merge: bool = False,
) -> None:
    """
    Merge source dictionary into target dictionary.

    Args:
        target: Dictionary to merge into (modified in place)
        source: Dictionary to merge from
        context: Description of what's being merged (for error messages)
        allow_conflicts: Whether to allow overwriting existing keys
        smart_merge: Whether to attempt intelligent merging of conflicting objects

    Raises:
        MergeError: If there are conflicting keys and allow_conflicts is False
    """
    conflicts = []

    for key, value in source.items():
        if key in target:
            if not allow_conflicts:
                # Check if the values are actually different
                if target[key] != value:
                    # Try smart merging for parameter definitions
                    if smart_merge and _can_smart_merge(target[key], value):
                        target[key] = _smart_merge_parameters(
                            target[key], value, f"{context}.{key}"
                        )
                        continue

                    # Format the conflicting values for detailed output
                    try:
                        existing_value = json.dumps(target[key], indent=2)
                        new_value = json.dumps(value, indent=2)
                    except (TypeError, ValueError):
                        # Fallback to string representation if JSON serialization fails
                        existing_value = str(target[key])
                        new_value = str(value)

                    conflict_detail = f"  - {key}:\n"
                    conflict_detail += (
                        f"    Existing value:\n{_indent_text(existing_value, 6)}\n"
                    )
                    conflict_detail += (
                        f"    Conflicting value:\n{_indent_text(new_value, 6)}"
                    )
                    conflicts.append(conflict_detail)
                # If values are identical, no conflict
            else:
                target[key] = value
        else:
            target[key] = value

    if conflicts:
        raise MergeError(
            f"Conflicts found while merging {context}:\n" + "\n".join(conflicts)
        )


def _can_smart_merge(existing: Any, new: Any) -> bool:
    """
    Check if two values can be smart merged (both are dicts with similar structure).
    """
    if not isinstance(existing, dict) or not isinstance(new, dict):
        return False

    # Both should have core parameter fields
    core_fields = {"name", "in", "required", "type", "description"}
    existing_fields = set(existing.keys())
    new_fields = set(new.keys())

    # Check if both have core parameter structure
    if core_fields.issubset(existing_fields) and core_fields.issubset(new_fields):
        # Check if core fields match (only extensions should differ)
        for field in core_fields:
            if existing.get(field) != new.get(field):
                return False
        return True

    return False


def _smart_merge_parameters(
    existing: Dict[str, Any], new: Dict[str, Any], context: str
) -> Dict[str, Any]:
    """
    Intelligently merge two parameter definitions by combining their properties.
    Keeps all properties from both, with new taking precedence for conflicts.
    """
    merged = existing.copy()

    # Add all properties from new, keeping track of what we're adding
    added_properties = []
    modified_properties = []

    for key, value in new.items():
        if key not in merged:
            merged[key] = value
            added_properties.append(key)
        elif merged[key] != value:
            # For conflicts in non-core fields, prefer the new value
            old_value = merged[key]
            merged[key] = value
            modified_properties.append(f"{key}: {old_value} -> {value}")

    print(f"Smart merged {context}: Added properties {added_properties}")
    return merged


def merge_paths(swagger_files: Dict[str, Dict[str, Any]]) -> Dict[str, Any]:
    """
    Merge paths from searchservice, searchindex, and knowledgebase.
    Each path will include source information.

    Args:
        swagger_files: Dictionary containing the loaded Swagger files

    Returns:
        Merged paths dictionary with source information embedded

    Raises:
        MergeError: If there are conflicting path definitions
    """
    merged_paths = {}

    # Files that should contain paths (excluding common_types)
    path_sources = ["searchservice", "searchindex", "knowledgebase"]

    for source_name in path_sources:
        if source_name not in swagger_files:
            continue

        source_swagger = swagger_files[source_name]
        source_paths = source_swagger.get("paths", {})

        if not isinstance(source_paths, dict):
            raise MergeError(
                f"Invalid paths section in {source_name}: expected object, got {type(source_paths).__name__}"
            )

        # Add source information to each path and operation
        for path_pattern, path_obj in source_paths.items():
            if path_pattern in merged_paths:
                raise MergeError(
                    f"Conflicting path {path_pattern} found in {source_name} and previously merged files"
                )

            # Deep copy the path object and add source information
            path_with_source = copy.deepcopy(path_obj)
            path_with_source["_swagger_source"] = source_name

            # Also add source to each operation within the path
            if isinstance(path_with_source, dict):
                for method, operation in path_with_source.items():
                    if method.lower() in [
                        "get",
                        "post",
                        "put",
                        "delete",
                        "patch",
                        "head",
                        "options",
                    ] and isinstance(operation, dict):
                        operation["_swagger_source"] = source_name

            merged_paths[path_pattern] = path_with_source

    return merged_paths


def merge_definitions(swagger_files: Dict[str, Dict[str, Any]]) -> Dict[str, Any]:
    """
    Merge definitions from all input files, including common_types.
    Each definition will include source information.

    Args:
        swagger_files: Dictionary containing the loaded Swagger files

    Returns:
        Merged definitions dictionary with source information embedded

    Raises:
        MergeError: If there are conflicting definition names with different content
    """
    merged_definitions = {}

    # All files can contribute definitions
    all_sources = ["searchservice", "searchindex", "knowledgebase", "common_types"]

    for source_name in all_sources:
        if source_name not in swagger_files:
            continue

        source_swagger = swagger_files[source_name]
        source_definitions = source_swagger.get("definitions", {})

        if not isinstance(source_definitions, dict):
            raise MergeError(
                f"Invalid definitions section in {source_name}: expected object, got {type(source_definitions).__name__}"
            )

        # Add source information to each definition
        for def_name, def_obj in source_definitions.items():
            if def_name in merged_definitions:
                # Check if they're actually different before raising an error
                existing_def = copy.deepcopy(merged_definitions[def_name])
                new_def = copy.deepcopy(def_obj)

                # Remove source information for comparison
                existing_def.pop("_swagger_source", None)
                new_def.pop("_swagger_source", None)

                if existing_def != new_def:
                    raise MergeError(
                        f"Conflicting definition {def_name} found in {source_name} and {merged_definitions[def_name].get('_swagger_source', 'unknown')}"
                    )
                # If they're identical, keep the existing one (first wins)
                continue

            # Deep copy the definition and add source information
            def_with_source = copy.deepcopy(def_obj)
            def_with_source["_swagger_source"] = source_name
            merged_definitions[def_name] = def_with_source

    return merged_definitions


def merge_top_level_fields(
    swagger_files: Dict[str, Dict[str, Any]], merged_swagger: Dict[str, Any]
) -> None:
    """
    Merge top-level fields from the first available source.

    For fields like 'swagger', 'info', 'schemes', 'consumes', 'produces', etc.,
    we take them from the first file that has them. These should be consistent
    across all files in a well-formed API specification.

    Args:
        swagger_files: Dictionary containing the loaded Swagger files
        merged_swagger: Target dictionary to populate (modified in place)
    """
    # Standard Swagger 2.0 top-level fields
    top_level_fields = [
        "swagger",
        "info",
        "host",
        "basePath",
        "schemes",
        "consumes",
        "produces",
        "securityDefinitions",
        "security",
        "tags",
        "externalDocs",
        # Microsoft Azure extensions
        "x-ms-parameterized-host",
        "x-ms-code-generation-settings",
    ]

    # Files to check for top-level fields (excluding common_types which is for definitions only)
    sources = ["searchservice", "searchindex", "knowledgebase"]

    for field_name in top_level_fields:
        field_value = None
        source_file = None

        # Find the first file that has this field
        for source_name in sources:
            if source_name in swagger_files:
                source_swagger = swagger_files[source_name]
                if field_name in source_swagger:
                    field_value = source_swagger[field_name]
                    source_file = source_name
                    break

        if field_value is not None:
            # For array fields like schemes, consumes, produces, we might want to merge
            # but for now, following the guide, we just take the first one
            merged_swagger[field_name] = copy.deepcopy(field_value)

    # Also handle any other x-ms-* or x-* extensions that might exist
    # by scanning all files for unknown top-level extensions
    for source_name in sources:
        if source_name in swagger_files:
            source_swagger = swagger_files[source_name]
            for key, value in source_swagger.items():
                if (
                    key.startswith("x-")
                    and key not in top_level_fields
                    and key not in merged_swagger
                ):
                    merged_swagger[key] = copy.deepcopy(value)


def merge_hand_authored_specs(
    swagger_files: Dict[str, Dict[str, Any]],
) -> Dict[str, Any]:
    """
    Merge three hand-authored Swagger files plus common types into a single Swagger dictionary.

    This function implements the merging rules specified in equiv_impl_guide.md:
    - Combine paths from searchservice, searchindex, and knowledgebase
    - Combine definitions from all input files including common_types
    - Surface conflicts as explicit errors
    - Preserve all fields without canonicalization

    Args:
        swagger_files: Dictionary containing loaded Swagger files with keys:
            - 'searchservice': Hand-authored searchservice Swagger
            - 'searchindex': Hand-authored searchindex Swagger
            - 'knowledgebase': Hand-authored knowledgebase Swagger
            - 'common_types': Common types Swagger

    Returns:
        Single merged Swagger dictionary representing the complete hand-authored API surface

    Raises:
        MergeError: If there are conflicting definitions or paths
    """
    # Validate that we have the expected files
    expected_files = ["searchservice", "searchindex", "knowledgebase", "common_types"]
    missing_files = [f for f in expected_files if f not in swagger_files]
    if missing_files:
        raise MergeError(
            f"Missing required files for merging: {', '.join(missing_files)}"
        )

    # Initialize the merged Swagger document
    merged_swagger = {}

    try:
        # Merge top-level fields first (swagger, info, etc.)
        merge_top_level_fields(swagger_files, merged_swagger)

        # Merge paths from the three main API files
        merged_paths = merge_paths(swagger_files)
        if merged_paths:
            merged_swagger["paths"] = merged_paths

        # Merge definitions from all files including common_types
        merged_definitions = merge_definitions(swagger_files)
        if merged_definitions:
            merged_swagger["definitions"] = merged_definitions

        # Merge other sections that might exist (parameters, responses, etc.)
        # These are less common but can exist in Swagger 2.0
        other_sections = ["parameters", "responses"]
        for section_name in other_sections:
            merged_section = {}
            sources = ["searchservice", "searchindex", "knowledgebase", "common_types"]

            for source_name in sources:
                if source_name in swagger_files:
                    source_swagger = swagger_files[source_name]
                    if section_name in source_swagger:
                        source_section = source_swagger[section_name]
                        if isinstance(source_section, dict) and source_section:
                            try:
                                # Use smart merging for parameters section
                                use_smart_merge = section_name == "parameters"
                                merge_objects(
                                    merged_section,
                                    source_section,
                                    f"{section_name} from {source_name}",
                                    smart_merge=use_smart_merge,
                                )
                            except MergeError as e:
                                raise MergeError(f"Conflicts in {section_name}: {e}")

            if merged_section:
                merged_swagger[section_name] = merged_section

        return merged_swagger

    except Exception as e:
        if isinstance(e, MergeError):
            raise
        else:
            raise MergeError(f"Unexpected error during merge: {e}")


def validate_merged_swagger(merged_swagger: Dict[str, Any]) -> None:
    """
    Validate the structure of the merged Swagger document.

    Args:
        merged_swagger: The merged Swagger dictionary to validate

    Raises:
        MergeError: If the merged document has invalid structure
    """
    # Basic validation that required fields are present
    required_fields = ["swagger", "info"]
    missing_fields = [f for f in required_fields if f not in merged_swagger]
    if missing_fields:
        raise MergeError(
            f"Merged Swagger missing required fields: {', '.join(missing_fields)}"
        )

    # Validate that paths exist (API should have some endpoints)
    if "paths" not in merged_swagger or not merged_swagger["paths"]:
        raise MergeError("Merged Swagger has no paths - this suggests a merge error")

    # Validate paths structure
    paths = merged_swagger["paths"]
    if not isinstance(paths, dict):
        raise MergeError(f"Merged paths must be an object, got {type(paths).__name__}")

    # Validate definitions structure if present
    if "definitions" in merged_swagger:
        definitions = merged_swagger["definitions"]
        if not isinstance(definitions, dict):
            raise MergeError(
                f"Merged definitions must be an object, got {type(definitions).__name__}"
            )


def write_diffs_excel_v2(result, output_path: str) -> None:
    """Write differences to Excel file organized by comparison category.

    Creates separate sheets for each category of differences with columns:
    - Diff Type
    - Context (path, method, parameter, etc.)
    - Message

    Args:
        result: EquivalencyResult containing differences
        output_path: Directory to write the Excel file
    """
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    excel_file = Path(output_path) / f"diff_v2_{timestamp}.xlsx"
    excel_file.parent.mkdir(parents=True, exist_ok=True)

    # Categorize differences by type
    categories = {
        "Paths": [],
        "Methods": [],
        "Operations": [],
        "Parameters": [],
        "Responses": [],
        "Definitions": [],
        "Global_Config": [],
        "Other": [],
    }

    # Categorize each difference
    for diff in result.differences:
        diff_type = diff.type.value
        context = diff.context or ""
        message = diff.message

        # Parse structured context into separate components
        if "||" in context:
            # Structured context: operation_id||path_method||suffix
            context_parts = context.split("||")
            operation_id = context_parts[0] if len(context_parts) > 0 else ""
            path_method = context_parts[1] if len(context_parts) > 1 else ""
            context_suffix = context_parts[2] if len(context_parts) > 2 else ""
        else:
            # Legacy context format
            operation_id = ""
            path_method = context
            context_suffix = ""

        possible_match = ""
        if "|| Possible Match: " in message:
            message_parts = message.split("|| Possible Match:")
            message = message_parts[0].strip()
            possible_match = message_parts[1].strip()

        row = {
            "Diff Type": diff_type,
            "Path-Method": path_method,
            "OperationID": operation_id,
            "Context Suffix": context_suffix,
            "Possible Match": possible_match,
            "Message": message,
        }

        # Categorize by difference type
        if "path" in diff_type.lower():
            categories["Paths"].append(row)
        elif "method" in diff_type.lower():
            categories["Methods"].append(row)
        elif "operation" in diff_type.lower():
            categories["Operations"].append(row)
        elif "parameter" in diff_type.lower():
            categories["Parameters"].append(row)
        elif "response" in diff_type.lower():
            categories["Responses"].append(row)
        elif "definition" in diff_type.lower():
            categories["Definitions"].append(row)
        elif any(
            x in diff_type.lower()
            for x in [
                "global",
                "config",
                "swagger_version",
                "info",
                "consumes",
                "produces",
                "schemes",
                "host",
                "base_path",
                "security",
                "tags",
                "external_docs",
            ]
        ):
            categories["Global_Config"].append(row)
        else:
            categories["Other"].append(row)

    # Write to Excel with separate sheets
    with pd.ExcelWriter(excel_file, engine="openpyxl") as writer:
        # Summary sheet
        summary_data = []
        for category, diffs in categories.items():
            if diffs:
                # Count occurrences of each diff type in this category
                diff_type_counts = {}
                for diff in diffs:
                    diff_type = diff["Diff Type"]
                    diff_type_counts[diff_type] = diff_type_counts.get(diff_type, 0) + 1

                # Format diff types with counts: "type1 (3), type2 (1)"
                diff_types_str = ", ".join(
                    [f"{dtype} ({count})" for dtype, count in diff_type_counts.items()]
                )

                summary_data.append(
                    {
                        "Category": category,
                        "Total Diff": len(diffs),
                        "Diff Types (Count)": diff_types_str,
                    }
                )
            else:
                summary_data.append(
                    {
                        "Category": category,
                        "Total Diff": 0,
                        "Diff Types (Count)": "",
                    }
                )

        if summary_data:
            summary_df = pd.DataFrame(summary_data)
            summary_df.to_excel(writer, sheet_name="Summary", index=False)

        # Individual category sheets
        for category, diffs in categories.items():
            if diffs:  # Only create sheet if there are differences
                df = pd.DataFrame(diffs)
                # Limit sheet name length for Excel compatibility
                sheet_name = category[:31] if len(category) > 31 else category
                df.to_excel(writer, sheet_name=sheet_name, index=False)

                # Auto-adjust column widths
                worksheet = writer.sheets[sheet_name]
                for column in worksheet.columns:
                    max_length = 0
                    column_letter = column[0].column_letter
                    for cell in column:
                        try:
                            if len(str(cell.value)) > max_length:
                                max_length = len(str(cell.value))
                        except:
                            pass
                    adjusted_width = min(max_length + 2, 50)
                    worksheet.column_dimensions[column_letter].width = adjusted_width

    print(f"Detailed diff analysis written to: {excel_file}")
