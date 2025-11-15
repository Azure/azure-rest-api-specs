"""
Swagger Equivalency Validator

This module contains the SwaggerValidator class that handles the comparison
between TypeSpec-compiled swagger and hand-authored swagger files.
"""

import json
import os
import csv
from datetime import datetime
from typing import Dict, Any, List
import yaml
from colorama import Fore, Style
from deepdiff import DeepDiff


class SwaggerValidator:
    """Main validator class that handles the entire validation process."""

    def __init__(self, config_path: str = "config.yaml"):
        self.config = self._load_config(config_path)
        self.base_path = os.path.dirname(os.path.abspath(config_path))

    def _load_config(self, config_path: str) -> dict:
        """Load configuration from YAML file."""
        if not os.path.exists(config_path):
            raise FileNotFoundError(f"Configuration file not found: {config_path}")

        with open(config_path, 'r', encoding='utf-8') as f:
            return yaml.safe_load(f)

    def _resolve_file_path(self, relative_path: str) -> str:
        """Resolve relative file path to absolute path."""
        if os.path.isabs(relative_path):
            return relative_path
        return os.path.abspath(os.path.join(self.base_path, relative_path))

    def _load_swagger_file(self, file_path: str) -> Dict[str, Any]:
        """Load and normalize a swagger JSON file."""
        resolved_path = self._resolve_file_path(file_path)
        if not os.path.exists(resolved_path):
            raise FileNotFoundError(f"Swagger file not found: {resolved_path}")

        with open(resolved_path, 'r', encoding='utf-8') as f:
            swagger_data = json.load(f)

        # Remove descriptions and examples for comparison
        return self._normalize_swagger(swagger_data)

    def _normalize_swagger(self, data: Any) -> Any:
        """Normalize swagger data by removing ignored fields."""
        if isinstance(data, dict):
            # Remove description fields and examples
            normalized = {k: self._normalize_swagger(v) for k, v in data.items()
                         if k not in ['description', 'summary', 'title', 'example', 'examples', 'x-ms-examples']}
            # Sort for consistent ordering
            return {k: normalized[k] for k in sorted(normalized.keys())}
        elif isinstance(data, list):
            return [self._normalize_swagger(item) for item in data]
        else:
            return data

    def _merge_swagger_files(self, swagger_files: List[Dict[str, Any]]) -> Dict[str, Any]:
        """Merge multiple swagger files into one consolidated structure."""
        if not swagger_files:
            return {}

        merged = swagger_files[0].copy()

        for swagger_data in swagger_files[1:]:
            # Merge paths
            if 'paths' in swagger_data:
                if 'paths' not in merged:
                    merged['paths'] = {}
                merged['paths'].update(swagger_data['paths'])

            # Merge definitions
            if 'definitions' in swagger_data:
                if 'definitions' not in merged:
                    merged['definitions'] = {}
                merged['definitions'].update(swagger_data['definitions'])

            # Merge parameters
            if 'parameters' in swagger_data:
                if 'parameters' not in merged:
                    merged['parameters'] = {}
                merged['parameters'].update(swagger_data['parameters'])

            # Merge security definitions
            if 'securityDefinitions' in swagger_data:
                if 'securityDefinitions' not in merged:
                    merged['securityDefinitions'] = {}
                merged['securityDefinitions'].update(swagger_data['securityDefinitions'])

        return merged

    def _validate_equivalency(self, typespec_swagger: Dict[str, Any], merged_swagger: Dict[str, Any]) -> Dict[str, Any]:
        """Validate equivalency between swagger files."""
        results = {
            'paths_comparison': {},
            'definitions_comparison': {},
            'parameters_comparison': {},
            'security_comparison': {},
            'overall_equivalency': False,
            'errors': []
        }

        # Compare paths
        paths_equivalent = self._compare_paths(
            typespec_swagger.get('paths', {}),
            merged_swagger.get('paths', {}),
            results
        )

        # Compare definitions
        definitions_equivalent = self._compare_definitions(
            typespec_swagger.get('definitions', {}),
            merged_swagger.get('definitions', {}),
            results
        )

        # Compare parameters
        parameters_equivalent = self._compare_components(
            typespec_swagger.get('parameters', {}),
            merged_swagger.get('parameters', {}),
            'parameters_comparison',
            results
        )

        # Compare security definitions
        security_equivalent = self._compare_components(
            typespec_swagger.get('securityDefinitions', {}),
            merged_swagger.get('securityDefinitions', {}),
            'security_comparison',
            results
        )

        results['overall_equivalency'] = (
            paths_equivalent and definitions_equivalent and
            parameters_equivalent and security_equivalent
        )

        return results

    def _compare_paths(self, typespec_paths: Dict[str, Any], hand_authored_paths: Dict[str, Any], results: Dict[str, Any]) -> bool:
        """Compare API paths and operations."""
        paths_equivalent = True

        # Find missing paths
        missing_in_typespec = set(hand_authored_paths.keys()) - set(typespec_paths.keys())
        missing_in_hand_authored = set(typespec_paths.keys()) - set(hand_authored_paths.keys())

        if missing_in_typespec:
            results['errors'].append({
                'type': 'missing_paths_in_typespec',
                'paths': list(missing_in_typespec)
            })
            paths_equivalent = False

        if missing_in_hand_authored:
            results['errors'].append({
                'type': 'missing_paths_in_hand_authored',
                'paths': list(missing_in_hand_authored)
            })
            paths_equivalent = False

        # Compare common paths
        common_paths = set(typespec_paths.keys()) & set(hand_authored_paths.keys())
        for path in common_paths:
            path_comparison = self._compare_path_operations(
                typespec_paths[path], hand_authored_paths[path]
            )
            results['paths_comparison'][path] = path_comparison
            if not path_comparison['equivalent']:
                paths_equivalent = False

        return paths_equivalent

    def _compare_path_operations(self, typespec_ops: Dict[str, Any], hand_authored_ops: Dict[str, Any]) -> Dict[str, Any]:
        """Compare operations for a specific path."""
        comparison = {
            'equivalent': True,
            'operations': {},
            'missing_in_typespec': [],
            'missing_in_hand_authored': []
        }

        http_methods = {'get', 'post', 'put', 'delete', 'patch', 'head', 'options'}
        typespec_methods = set(typespec_ops.keys()) & http_methods
        hand_authored_methods = set(hand_authored_ops.keys()) & http_methods

        missing_in_typespec = hand_authored_methods - typespec_methods
        missing_in_hand_authored = typespec_methods - hand_authored_methods

        if missing_in_typespec:
            comparison['missing_in_typespec'] = list(missing_in_typespec)
            comparison['equivalent'] = False

        if missing_in_hand_authored:
            comparison['missing_in_hand_authored'] = list(missing_in_hand_authored)
            comparison['equivalent'] = False

        # Compare common operations
        common_methods = typespec_methods & hand_authored_methods
        for method in common_methods:
            operation_comparison = self._compare_operation(
                typespec_ops[method], hand_authored_ops[method]
            )
            comparison['operations'][method] = operation_comparison
            if not operation_comparison['equivalent']:
                comparison['equivalent'] = False

        return comparison

    def _compare_operation(self, typespec_op: Dict[str, Any], hand_authored_op: Dict[str, Any]) -> Dict[str, Any]:
        """Compare individual operations."""
        comparison = {'equivalent': True, 'differences': []}

        # Compare parameters
        typespec_params = self._normalize_parameters(typespec_op.get('parameters', []))
        hand_authored_params = self._normalize_parameters(hand_authored_op.get('parameters', []))

        param_diff = DeepDiff(typespec_params, hand_authored_params, ignore_order=True)
        if param_diff:
            comparison['differences'].append({
                'type': 'parameters',
                'diff': str(param_diff)
            })
            comparison['equivalent'] = False

        # Compare responses
        typespec_responses = self._normalize_responses(typespec_op.get('responses', {}))
        hand_authored_responses = self._normalize_responses(hand_authored_op.get('responses', {}))

        response_diff = DeepDiff(typespec_responses, hand_authored_responses, ignore_order=True)
        if response_diff:
            comparison['differences'].append({
                'type': 'responses',
                'diff': str(response_diff)
            })
            comparison['equivalent'] = False

        return comparison

    def _normalize_parameters(self, parameters: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
        """Normalize parameter list for comparison."""
        normalized = []
        for param in parameters:
            normalized_param = {
                'name': param.get('name'),
                'in': param.get('in'),
                'required': param.get('required', False),
                'type': param.get('type'),
                'schema': param.get('schema')
            }
            normalized_param = {k: v for k, v in normalized_param.items() if v is not None}
            normalized.append(normalized_param)

        return sorted(normalized, key=lambda p: (p.get('in', ''), p.get('name', '')))

    def _normalize_responses(self, responses: Dict[str, Any]) -> Dict[str, Any]:
        """Normalize response schemas for comparison."""
        normalized = {}
        for status_code, response_data in responses.items():
            normalized_response = {}
            if 'schema' in response_data:
                normalized_response['schema'] = response_data['schema']
            if 'headers' in response_data:
                normalized_response['headers'] = response_data['headers']
            normalized[status_code] = normalized_response
        return normalized

    def _compare_definitions(self, typespec_defs: Dict[str, Any], hand_authored_defs: Dict[str, Any], results: Dict[str, Any]) -> bool:
        """Compare model definitions."""
        definitions_equivalent = True

        missing_in_typespec = set(hand_authored_defs.keys()) - set(typespec_defs.keys())
        missing_in_hand_authored = set(typespec_defs.keys()) - set(hand_authored_defs.keys())

        if missing_in_typespec:
            results['errors'].append({
                'type': 'missing_definitions_in_typespec',
                'definitions': list(missing_in_typespec)
            })
            definitions_equivalent = False

        if missing_in_hand_authored:
            results['errors'].append({
                'type': 'missing_definitions_in_hand_authored',
                'definitions': list(missing_in_hand_authored)
            })
            definitions_equivalent = False

        # Compare common definitions
        common_definitions = set(typespec_defs.keys()) & set(hand_authored_defs.keys())
        for def_name in common_definitions:
            diff = DeepDiff(typespec_defs[def_name], hand_authored_defs[def_name], ignore_order=True)
            if diff:
                results['definitions_comparison'][def_name] = {
                    'equivalent': False,
                    'differences': str(diff)
                }
                definitions_equivalent = False
            else:
                results['definitions_comparison'][def_name] = {
                    'equivalent': True,
                    'differences': {}
                }

        return definitions_equivalent

    def _compare_components(self, typespec_comp: Dict[str, Any], hand_authored_comp: Dict[str, Any], key: str, results: Dict[str, Any]) -> bool:
        """Compare components like parameters or security definitions."""
        diff = DeepDiff(typespec_comp, hand_authored_comp, ignore_order=True)
        if diff:
            results[key] = {'equivalent': False, 'differences': str(diff)}
            return False
        else:
            results[key] = {'equivalent': True, 'differences': {}}
            return True

    def _generate_csv_report(self, validation_results: Dict[str, Any], summary: Dict[str, Any]) -> str:
        """Generate a CSV report."""
        os.makedirs(self.config['output']['path'], exist_ok=True)

        filename = f"equivalency_report_{datetime.now().strftime('%Y%m%d_%H%M%S')}.csv"
        filepath = os.path.join(self.config['output']['path'], filename)

        fieldnames = [
            'Path', 'Method', 'Operation_ID', 'Status', 'Issue_Type',
            'Issue_Description', 'TypeSpec_File', 'Hand_Authored_Files', 'Severity', 'Details'
        ]

        rows = []

        # Extract issues from validation results
        if validation_results.get('paths_comparison'):
            for path, comparison in validation_results['paths_comparison'].items():
                if not comparison.get('equivalent', True):
                    # Missing operations
                    for method in comparison.get('missing_in_typespec', []):
                        rows.append({
                            'Path': path,
                            'Method': method.upper(),
                            'Operation_ID': 'N/A',
                            'Status': 'Missing_in_TypeSpec',
                            'Issue_Type': 'Missing_Operation',
                            'Issue_Description': f'{method.upper()} operation missing in TypeSpec',
                            'TypeSpec_File': 'search.json',
                            'Hand_Authored_Files': 'searchservice.json, searchindex.json, knowledgebase.json',
                            'Severity': 'Error',
                            'Details': 'Operation not found in TypeSpec-compiled swagger'
                        })

                    for method in comparison.get('missing_in_hand_authored', []):
                        rows.append({
                            'Path': path,
                            'Method': method.upper(),
                            'Operation_ID': 'N/A',
                            'Status': 'Missing_in_Hand_Authored',
                            'Issue_Type': 'Missing_Operation',
                            'Issue_Description': f'{method.upper()} operation missing in hand-authored files',
                            'TypeSpec_File': 'search.json',
                            'Hand_Authored_Files': 'searchservice.json, searchindex.json, knowledgebase.json',
                            'Severity': 'Error',
                            'Details': 'Operation not found in hand-authored swagger files'
                        })

                    # Operation differences
                    for method, op_comparison in comparison.get('operations', {}).items():
                        if not op_comparison.get('equivalent', True):
                            for diff in op_comparison.get('differences', []):
                                rows.append({
                                    'Path': path,
                                    'Method': method.upper(),
                                    'Operation_ID': 'N/A',
                                    'Status': 'Not_Equivalent',
                                    'Issue_Type': diff.get('type', 'Unknown').replace('_', ' ').title(),
                                    'Issue_Description': f'{diff.get("type", "Unknown").replace("_", " ").title()} differences found',
                                    'TypeSpec_File': 'search.json',
                                    'Hand_Authored_Files': 'searchservice.json, searchindex.json, knowledgebase.json',
                                    'Severity': 'Error',
                                    'Details': str(diff.get('diff', ''))[:200]
                                })

        # Add definition differences
        if validation_results.get('definitions_comparison'):
            for def_name, comparison in validation_results['definitions_comparison'].items():
                if not comparison.get('equivalent', True):
                    rows.append({
                        'Path': 'N/A',
                        'Method': 'N/A',
                        'Operation_ID': 'N/A',
                        'Status': 'Not_Equivalent',
                        'Issue_Type': 'Definition_Difference',
                        'Issue_Description': f'Model definition "{def_name}" differs',
                        'TypeSpec_File': 'search.json',
                        'Hand_Authored_Files': 'searchservice.json, searchindex.json, knowledgebase.json',
                        'Severity': 'Error',
                        'Details': str(comparison.get('differences', ''))[:200]
                    })

        # Add errors
        for error in validation_results.get('errors', []):
            error_type = error.get('type', 'Unknown')
            if 'missing_paths' in error_type:
                for path in error.get('paths', []):
                    rows.append({
                        'Path': path,
                        'Method': 'N/A',
                        'Operation_ID': 'N/A',
                        'Status': 'Missing_in_TypeSpec' if 'typespec' in error_type else 'Missing_in_Hand_Authored',
                        'Issue_Type': 'Missing_Path',
                        'Issue_Description': f'Path missing in {"TypeSpec" if "typespec" in error_type else "hand-authored files"}',
                        'TypeSpec_File': 'search.json',
                        'Hand_Authored_Files': 'searchservice.json, searchindex.json, knowledgebase.json',
                        'Severity': 'Error',
                        'Details': error_type
                    })
            elif 'missing_definitions' in error_type:
                for definition in error.get('definitions', []):
                    rows.append({
                        'Path': 'N/A',
                        'Method': 'N/A',
                        'Operation_ID': 'N/A',
                        'Status': 'Missing_in_TypeSpec' if 'typespec' in error_type else 'Missing_in_Hand_Authored',
                        'Issue_Type': 'Missing_Definition',
                        'Issue_Description': f'Definition "{definition}" missing',
                        'TypeSpec_File': 'search.json',
                        'Hand_Authored_Files': 'searchservice.json, searchindex.json, knowledgebase.json',
                        'Severity': 'Error',
                        'Details': error_type
                    })

        # If no issues, add summary
        if not rows:
            rows.append({
                'Path': 'SUMMARY',
                'Method': 'N/A',
                'Operation_ID': 'N/A',
                'Status': 'Equivalent',
                'Issue_Type': 'None',
                'Issue_Description': 'All swagger files are equivalent',
                'TypeSpec_File': 'search.json',
                'Hand_Authored_Files': 'searchservice.json, searchindex.json, knowledgebase.json',
                'Severity': 'Info',
                'Details': 'Complete equivalency validation passed'
            })

        # Write CSV
        with open(filepath, 'w', newline='', encoding='utf-8') as csvfile:
            writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
            writer.writeheader()
            writer.writerows(rows)

        return filepath

    def _get_summary(self, validation_results: Dict[str, Any]) -> Dict[str, Any]:
        """Generate summary statistics."""
        total_errors = len(validation_results.get('errors', []))
        path_issues = sum(1 for comparison in validation_results.get('paths_comparison', {}).values()
                         if not comparison.get('equivalent', True))
        definition_issues = sum(1 for comparison in validation_results.get('definitions_comparison', {}).values()
                              if not comparison.get('equivalent', True))

        return {
            'overall_equivalent': validation_results.get('overall_equivalency', False),
            'total_errors': total_errors,
            'total_warnings': 0,
            'path_issues': path_issues,
            'definition_issues': definition_issues,
            'parameters_equivalent': validation_results.get('parameters_comparison', {}).get('equivalent', True),
            'security_equivalent': validation_results.get('security_comparison', {}).get('equivalent', True)
        }

    def _print_summary(self, summary: Dict[str, Any]) -> None:
        """Print validation summary to console."""
        print("\n" + "="*60)
        print("SWAGGER EQUIVALENCY VALIDATION SUMMARY")
        print("="*60)

        status = "✓ EQUIVALENT" if summary['overall_equivalent'] else "✗ NOT EQUIVALENT"
        print(f"Overall Status: {status}")
        print(f"Total Errors: {summary['total_errors']}")
        print(f"Path Issues: {summary['path_issues']}")
        print(f"Definition Issues: {summary['definition_issues']}")

        params_status = "✓" if summary['parameters_equivalent'] else "✗"
        security_status = "✓" if summary['security_equivalent'] else "✗"
        print(f"Parameters: {params_status}")
        print(f"Security: {security_status}")

        print("="*60)

        if summary['overall_equivalent']:
            print("🎉 TypeSpec-compiled swagger is equivalent to hand-authored swaggers!")
        else:
            print("⚠️  Differences found between TypeSpec-compiled and hand-authored swaggers.")
            print("   Check the CSV report for details.")

        print("\n")

    def validate(self) -> int:
        """Run the complete validation process."""
        try:
            print(f"{Fore.CYAN}Azure AI Search - Swagger Equivalency Validator{Style.RESET_ALL}")
            print("="*60)
            print(f"{Fore.YELLOW}Loading swagger files...{Style.RESET_ALL}")

            # Load TypeSpec-compiled swagger
            typespec_swagger = self._load_swagger_file(self.config['typespec_compiled']['path'])

            # Load hand-authored swagger files
            hand_authored_files = []
            for file_config in self.config['hand_authored'].values():
                hand_authored_files.append(self._load_swagger_file(file_config['path']))

            print(f"  • TypeSpec-compiled: {len(typespec_swagger.get('paths', {}))} paths")
            total_paths = sum(len(f.get('paths', {})) for f in hand_authored_files)
            print(f"  • Hand-authored files: {total_paths} total paths")

            # Merge hand-authored files
            merged_swagger = self._merge_swagger_files(hand_authored_files)

            print(f"{Fore.YELLOW}Validating equivalency...{Style.RESET_ALL}")

            # Validate equivalency
            validation_results = self._validate_equivalency(typespec_swagger, merged_swagger)
            summary = self._get_summary(validation_results)

            # Generate CSV report
            csv_report_path = self._generate_csv_report(validation_results, summary)

            print(f"{Fore.GREEN}✓ CSV report generated: {csv_report_path}{Style.RESET_ALL}")

            # Print summary
            self._print_summary(summary)

            print("Generated Report:")
            print(f"  • CSV: {csv_report_path}")

            # Return exit code
            return 0 if summary['overall_equivalent'] else 1

        except Exception as e:
            print(f"{Fore.RED}Error: {e}{Style.RESET_ALL}")
            import traceback
            traceback.print_exc()
            return 1