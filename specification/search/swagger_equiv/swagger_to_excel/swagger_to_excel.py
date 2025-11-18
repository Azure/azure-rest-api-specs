#!/usr/bin/env python3
"""
Swagger to Excel Converter for Azure Search APIs
Converts multiple Swagger/OpenAPI JSON files to combined Excel format with categories
"""

import json
import sys
import yaml
import pandas as pd
from pathlib import Path
from typing import Dict, Any, List, Tuple
import argparse
from datetime import datetime


class SwaggerAnalyzer:
    """Main class for analyzing multiple Swagger JSON files and converting to combined Excel"""

    def __init__(self, output_dir: str = "./output", config_path: str = "config.yaml"):
        self.base_dir = Path(__file__).parent
        self.output_dir = self.base_dir / output_dir
        self.output_dir.mkdir(exist_ok=True)

        # Load config for sheet configuration
        self.config = self._load_config(config_path)

        # Storage for all loaded swagger data
        self.all_swagger_data = []

    def _load_config(self, config_path: str) -> Dict[str, Any]:
        """Load configuration from YAML file"""
        if not Path(config_path).exists():
            raise FileNotFoundError(f"Configuration file not found: {config_path}")

        try:
            with open(config_path, 'r', encoding='utf-8') as f:
                config = yaml.safe_load(f)
                if config is None:
                    raise ValueError(f"Configuration file is empty: {config_path}")
                return config
        except Exception as e:
            raise Exception(f"Error loading configuration file {config_path}: {e}")

    def process_all_files(self):
        """Process all files specified in configuration and create combined Excel"""
        print("Starting combined Swagger to Excel conversion...")
        print(f"Output directory: {self.output_dir}")

        # Load all swagger files
        self._load_all_swagger_files()

        # Create combined Excel file
        self._create_combined_excel_file()

        print("Combined conversion completed!")

    def _load_all_swagger_files(self):
        """Load all swagger files from configuration"""
        self.all_swagger_data = []

        # Process TSP-compiled files
        if 'tsp_compiled' in self.config['input_files']:
            for file_config in self.config['input_files']['tsp_compiled']:
                self._load_single_swagger_file(file_config)

        # Process hand-authored files
        if 'hand_authored' in self.config['input_files']:
            for file_config in self.config['input_files']['hand_authored']:
                self._load_single_swagger_file(file_config)

    def _load_single_swagger_file(self, file_config: Dict[str, str]):
        """Load a single Swagger JSON file"""
        file_path = self.base_dir / file_config['path']
        category = file_config['category']

        print(f"Loading {category}: {file_path.name}")

        if not file_path.exists():
            print(f"Warning: File not found: {file_path}")
            return

        try:
            # Load Swagger JSON
            with open(file_path, 'r', encoding='utf-8') as f:
                swagger_data = json.load(f)

            self.all_swagger_data.append({
                'category': category,
                'data': swagger_data,
                'file_path': file_path
            })

        except Exception as e:
            print(f"Error loading {category}: {e}")

    def _create_combined_excel_file(self):
        """Create combined Excel file with all data"""
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        file_prefix = self.config.get('output', {}).get('file_prefix', 'swagger_analysis')
        output_file = self.output_dir / f"{file_prefix}_{timestamp}.xlsx"

        print(f"Creating combined Excel file: {output_file}")

        with pd.ExcelWriter(output_file, engine='openpyxl') as writer:

            # Sheet 1: API Overview
            overview_df = self._create_combined_api_overview()
            overview_df.to_excel(
                writer,
                sheet_name=self.config['sheets']['api_overview']['name'],
                index=False
            )

            # Sheet 2: Operation Overview
            operation_overview_df = self._create_operation_overview()
            operation_overview_df.to_excel(
                writer,
                sheet_name=self.config['sheets']['operation_overview']['name'],
                index=False
            )

            # Sheet 3: Endpoints Detail
            endpoints_df = self._create_combined_endpoints_detail()
            endpoints_df.to_excel(
                writer,
                sheet_name=self.config['sheets']['endpoints']['name'],
                index=False
            )

            # Sheet 4: Parameters
            params_df = self._create_combined_parameters_detail()
            params_df.to_excel(
                writer,
                sheet_name=self.config['sheets']['parameters']['name'],
                index=False
            )

            # Sheet 5: Responses
            responses_df = self._create_combined_responses_detail()
            responses_df.to_excel(
                writer,
                sheet_name=self.config['sheets']['responses']['name'],
                index=False
            )

            # Sheet 6: Data Models
            models_df = self._create_combined_data_models()
            models_df.to_excel(
                writer,
                sheet_name=self.config['sheets']['data_models']['name'],
                index=False
            )

        print(f"Created combined Excel file: {output_file}")
        return output_file

    def _create_combined_api_overview(self) -> pd.DataFrame:
        """Create combined API overview with category breakdown"""
        overview_rows = []

        for swagger_info in self.all_swagger_data:
            category = swagger_info['category']
            swagger_data = swagger_info['data']

            paths = swagger_data.get('paths', {})

            # Count operations by method
            method_counts = {'GET': 0, 'POST': 0, 'PUT': 0, 'DELETE': 0, 'PATCH': 0, 'HEAD': 0, 'OPTIONS': 0}
            tag_counts = {}
            total_operations = 0

            for path, methods in paths.items():
                for method, operation in methods.items():
                    if method.upper() in method_counts:
                        total_operations += 1
                        method_counts[method.upper()] += 1

                        # Count tags
                        for tag in operation.get('tags', []):
                            tag_counts[tag] = tag_counts.get(tag, 0) + 1

            # Create tags summary (top 5 tags)
            top_tags = sorted(tag_counts.items(), key=lambda x: x[1], reverse=True)[:5]
            tags_summary = ', '.join([f"{tag}({count})" for tag, count in top_tags])

            overview_rows.append({
                'Category': category,
                'Total Paths': len(paths),
                'Total Operations': total_operations,
                'Total DELETE': method_counts['DELETE'],
                'Total GET': method_counts['GET'],
                'Total POST': method_counts['POST'],
                'Total PUT': method_counts['PUT'],
                'Total PATCH': method_counts['PATCH'],
                'Total HEAD': method_counts['HEAD'],
                'Total OPTIONS': method_counts['OPTIONS'],
                'Total Tags': len(tag_counts),
                'Tags': tags_summary
            })

        return pd.DataFrame(overview_rows)

    def _create_operation_overview(self) -> pd.DataFrame:
        """Create simple operation overview"""
        operations = []

        for swagger_info in self.all_swagger_data:
            category = swagger_info['category']
            swagger_data = swagger_info['data']

            for path, methods in swagger_data.get('paths', {}).items():
                for method, operation in methods.items():
                    if method.lower() in ['get', 'post', 'put', 'delete', 'patch', 'head', 'options']:
                        # Count parameters
                        params = operation.get('parameters', [])
                        param_count = len(params)

                        # Count responses
                        responses = operation.get('responses', {})
                        response_count = len(responses)

                        operations.append({
                            'Category': category,
                            'Path': path,
                            'Method': method.upper(),
                            'Operation ID': operation.get('operationId', ''),
                            'Total Parameters': param_count,
                            'Total Responses': response_count
                        })

        return pd.DataFrame(operations)

    def _create_combined_endpoints_detail(self) -> pd.DataFrame:
        """Create detailed endpoints information with category"""
        endpoints = []

        for swagger_info in self.all_swagger_data:
            category = swagger_info['category']
            swagger_data = swagger_info['data']

            for path, methods in swagger_data.get('paths', {}).items():
                for method, operation in methods.items():
                    if method.lower() in ['get', 'post', 'put', 'delete', 'patch', 'head', 'options']:

                        # Count parameters by type
                        params = operation.get('parameters', [])
                        path_params = len([p for p in params if p.get('in') == 'path'])
                        query_params = len([p for p in params if p.get('in') == 'query'])
                        header_params = len([p for p in params if p.get('in') == 'header'])
                        body_params = len([p for p in params if p.get('in') == 'body'])
                        form_params = len([p for p in params if p.get('in') == 'formData'])

                        # Get response codes
                        responses = operation.get('responses', {})
                        success_codes = [r for r in responses.keys() if str(r).startswith('2')]
                        error_codes = [r for r in responses.keys() if not str(r).startswith('2') and r != 'default']

                        # Add security information if available
                        security = 'Not specified'
                        if 'security' in operation:
                            security_schemes = []
                            for security_req in operation['security']:
                                security_schemes.extend(security_req.keys())
                            security = ', '.join(security_schemes)

                        endpoint = {
                            'Category': category,
                            'Path': path,
                            'Method': method.upper(),
                            'Operation ID': operation.get('operationId', ''),
                            'Total Parameters': len(params),
                            'Path Parameters': path_params,
                            'Query Parameters': query_params,
                            'Header Parameters': header_params,
                            'Body Parameters': body_params,
                            'Form Parameters': form_params,
                            'Total Responses': len(responses),
                            'Success Responses': ', '.join(success_codes),
                            'Error Responses': ', '.join(error_codes),
                            'Consumes': ', '.join(operation.get('consumes', [])),
                            'Produces': ', '.join(operation.get('produces', [])),
                            'Security': security,
                            'Deprecated': operation.get('deprecated', False),
                            'Tags': ', '.join(operation.get('tags', [])),
                            'Summary': operation.get('summary', ''),
                            'Description': self._truncate_text(operation.get('description', ''), 300)
                        }

                        endpoints.append(endpoint)

        return pd.DataFrame(endpoints)

    def _create_combined_parameters_detail(self) -> pd.DataFrame:
        """Create detailed parameters information with category"""
        parameters = []

        for swagger_info in self.all_swagger_data:
            category = swagger_info['category']
            swagger_data = swagger_info['data']

            # Global parameters
            global_params = swagger_data.get('parameters', {})
            for param_name, param_def in global_params.items():
                param_info = {
                    'Category': category,
                    'Source': 'Global Parameter',
                    'Path': 'N/A',
                    'Method': 'N/A',
                    'Operation ID': 'N/A',
                    'Parameter Name': param_name,
                    'In': param_def.get('in', ''),
                    'Type': param_def.get('type', param_def.get('schema', {}).get('type', '')),
                    'Required': param_def.get('required', False),
                    'Default': param_def.get('default', ''),
                    'Enum Values': ', '.join(map(str, param_def.get('enum', []))),
                    'Format': param_def.get('format', ''),
                    'Pattern': param_def.get('pattern', ''),
                    'Min Length': param_def.get('minLength', ''),
                    'Max Length': param_def.get('maxLength', ''),
                    'Minimum': param_def.get('minimum', ''),
                    'Maximum': param_def.get('maximum', ''),
                    'Description': self._truncate_text(param_def.get('description', ''), 150)
                }
                parameters.append(param_info)

            # Operation parameters
            for path, methods in swagger_data.get('paths', {}).items():
                for method, operation in methods.items():
                    if method.lower() in ['get', 'post', 'put', 'delete', 'patch', 'head', 'options']:
                        operation_id = operation.get('operationId', '')

                        for param in operation.get('parameters', []):
                            # Handle parameter references
                            if '$ref' in param:
                                ref_path = param['$ref']
                                if ref_path.startswith('#/parameters/'):
                                    param_name = ref_path.split('/')[-1]
                                    if param_name in global_params:
                                        param = global_params[param_name].copy()
                                        param['name'] = param_name

                            param_info = {
                                'Category': category,
                                'Source': 'Operation Parameter',
                                'Path': path,
                                'Method': method.upper(),
                                'Operation ID': operation_id,
                                'Parameter Name': param.get('name', ''),
                                'In': param.get('in', ''),
                                'Type': param.get('type', param.get('schema', {}).get('type', '')),
                                'Required': param.get('required', False),
                                'Default': param.get('default', ''),
                                'Enum Values': ', '.join(map(str, param.get('enum', []))),
                                'Format': param.get('format', ''),
                                'Pattern': param.get('pattern', ''),
                                'Min Length': param.get('minLength', ''),
                                'Max Length': param.get('maxLength', ''),
                                'Minimum': param.get('minimum', ''),
                                'Maximum': param.get('maximum', ''),
                                'Description': self._truncate_text(param.get('description', ''), 150)
                            }

                            # Handle schema-based parameters (body parameters)
                            if 'schema' in param and param['in'] == 'body':
                                schema = param['schema']
                                if '$ref' in schema:
                                    param_info['Type'] = f"Reference: {schema['$ref']}"
                                elif 'type' in schema:
                                    param_info['Type'] = schema['type']

                            parameters.append(param_info)

        return pd.DataFrame(parameters)

    def _create_combined_responses_detail(self) -> pd.DataFrame:
        """Create detailed responses information with category"""
        responses = []

        for swagger_info in self.all_swagger_data:
            category = swagger_info['category']
            swagger_data = swagger_info['data']

            for path, methods in swagger_data.get('paths', {}).items():
                for method, operation in methods.items():
                    if method.lower() in ['get', 'post', 'put', 'delete', 'patch', 'head', 'options']:
                        operation_id = operation.get('operationId', '')

                        for status_code, response in operation.get('responses', {}).items():
                            response_info = {
                                'Category': category,
                                'Path': path,
                                'Method': method.upper(),
                                'Operation ID': operation_id,
                                'Status Code': status_code,
                                'Has Schema': 'schema' in response,
                                'Schema Type': '',
                                'Schema Reference': '',
                                'Headers': '',
                                'Description': self._truncate_text(response.get('description', ''), 200)
                            }

                            # Extract schema information
                            if 'schema' in response:
                                schema = response['schema']
                                if '$ref' in schema:
                                    response_info['Schema Reference'] = schema['$ref']
                                    response_info['Schema Type'] = 'Reference'
                                else:
                                    response_info['Schema Type'] = schema.get('type', 'Unknown')

                            # Extract headers information
                            if 'headers' in response:
                                header_names = list(response['headers'].keys())
                                response_info['Headers'] = ', '.join(header_names)

                            responses.append(response_info)

        return pd.DataFrame(responses)

    def _create_combined_data_models(self) -> pd.DataFrame:
        """Create data models information from definitions with category"""
        models = []

        for swagger_info in self.all_swagger_data:
            category = swagger_info['category']
            swagger_data = swagger_info['data']

            definitions = swagger_data.get('definitions', {})

            for model_name, model_def in definitions.items():
                # Basic model information
                model_info = {
                    'Category': category,
                    'Model Name': model_name,
                    'Type': model_def.get('type', 'object'),
                    'Required Properties': ', '.join(model_def.get('required', [])),
                    'Total Properties': len(model_def.get('properties', {})),
                    'Has Additional Properties': model_def.get('additionalProperties', False),
                    'Discriminator': model_def.get('discriminator', ''),
                    'AllOf': len(model_def.get('allOf', [])),
                    'Properties Detail': '',
                    'Description': self._truncate_text(model_def.get('description', ''), 200)
                }

                # Extract properties information
                properties = model_def.get('properties', {})
                if properties:
                    prop_details = []
                    for prop_name, prop_def in properties.items():
                        prop_type = prop_def.get('type', 'unknown')
                        if '$ref' in prop_def:
                            prop_type = f"ref:{prop_def['$ref']}"
                        elif 'items' in prop_def and '$ref' in prop_def['items']:
                            prop_type = f"array<{prop_def['items']['$ref']}>"
                        elif prop_type == 'array' and 'items' in prop_def:
                            item_type = prop_def['items'].get('type', 'unknown')
                            prop_type = f"array<{item_type}>"

                        is_required = prop_name in model_def.get('required', [])
                        prop_details.append(f"{prop_name}({prop_type}){'*' if is_required else ''}")

                    model_info['Properties Detail'] = '; '.join(prop_details[:10])  # Limit to first 10 properties
                    if len(prop_details) > 10:
                        model_info['Properties Detail'] += f"; ... ({len(prop_details) - 10} more)"

                models.append(model_info)

        return pd.DataFrame(models)

    def _truncate_text(self, text: str, max_length: int = 100) -> str:
        """Truncate text to specified length"""
        if not text:
            return ''
        if len(text) <= max_length:
            return text
        return text[:max_length - 3] + '...'


def main():
    """Main entry point"""
    parser = argparse.ArgumentParser(description='Convert multiple Swagger JSON files to combined Excel format')
    parser.add_argument(
        '--output',
        default='./output',
        help='Output directory (default: ./output)'
    )
    parser.add_argument(
        '--config',
        default='config.yaml',
        help='Configuration file path (default: config.yaml)'
    )

    args = parser.parse_args()

    try:
        analyzer = SwaggerAnalyzer(output_dir=args.output, config_path=args.config)
        analyzer.process_all_files()

    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()