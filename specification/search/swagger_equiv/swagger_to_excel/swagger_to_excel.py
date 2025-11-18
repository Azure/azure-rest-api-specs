#!/usr/bin/env python3
"""
Swagger to Excel Converter for Azure Search APIs
Converts Swagger/OpenAPI JSON files to human-readable Excel format
"""

import json
import sys
import yaml
import pandas as pd
from pathlib import Path
from typing import Dict, Any
import argparse
from datetime import datetime


class SwaggerAnalyzer:
    """Main class for analyzing Swagger JSON files and converting to Excel"""

    def __init__(self, output_dir: str = "./excel_output", config_path: str = "config.yaml"):
        self.base_dir = Path(__file__).parent
        self.output_dir = self.base_dir / output_dir
        self.output_dir.mkdir(exist_ok=True)

        # Load config for sheet configuration if available
        self.config = self._load_config(config_path) if Path(config_path).exists() else self._default_config()

    def _load_config(self, config_path: str) -> Dict[str, Any]:
        """Load configuration from YAML file"""
        try:
            with open(config_path, 'r', encoding='utf-8') as f:
                return yaml.safe_load(f)
        except Exception as e:
            print(f"Warning: Could not load config: {e}")
            return self._default_config()

    def _default_config(self) -> Dict[str, Any]:
        """Default configuration when config file is not available"""
        return {
            'output': {'file_prefix': 'swagger_analysis'},
            'sheets': {
                'api_overview': {'enabled': True, 'name': 'API Overview'},
                'endpoints': {'enabled': True, 'name': 'Endpoints Detail'},
                'parameters': {'enabled': True, 'name': 'Parameters'},
                'responses': {'enabled': True, 'name': 'Responses'},
                'data_models': {'enabled': True, 'name': 'Data Models'},
                'tag_groups': {'enabled': True, 'name': 'Tag Groups'}
            }
        }

    def process_single_file(self, file_path: str, output_name: str = None) -> str:
        """Process a single Swagger JSON file and return the output file path"""
        file_path_obj = Path(file_path)

        if not file_path_obj.exists():
            raise FileNotFoundError(f"File not found: {file_path}")

        # Use provided name or derive from file
        if output_name is None:
            output_name = file_path_obj.stem

        print(f"Processing: {file_path_obj.name}")

        try:
            # Load Swagger JSON
            with open(file_path_obj, 'r', encoding='utf-8') as f:
                swagger_data = json.load(f)

            # Generate Excel
            output_file = self._create_excel_file(swagger_data, output_name)
            print(f"Created: {output_file}")
            return str(output_file)

        except Exception as e:
            raise Exception(f"Error processing {file_path_obj.name}: {e}")

    def process_all_files(self):
        """Process all files specified in configuration"""
        print("Starting Swagger to Excel conversion...")
        print(f"Output directory: {self.output_dir}")

        # Process TSP-compiled files
        if 'tsp_compiled' in self.config['input_files']:
            for file_config in self.config['input_files']['tsp_compiled']:
                self._process_single_file(file_config, "tsp_compiled")

        # Process hand-authored files
        if 'hand_authored' in self.config['input_files']:
            for file_config in self.config['input_files']['hand_authored']:
                self._process_single_file(file_config, "hand_authored")

        print("Conversion completed!")

    def _process_single_file(self, file_config: Dict[str, str], file_type: str):
        """Process a single Swagger JSON file"""
        file_path = self.base_dir / file_config['path']
        file_name = file_config['name']

        print(f"Processing {file_type}: {file_name}")

        if not file_path.exists():
            print(f"Warning: File not found: {file_path}")
            return

        try:
            # Load Swagger JSON
            with open(file_path, 'r', encoding='utf-8') as f:
                swagger_data = json.load(f)

            # Generate Excel
            self._create_excel_file(swagger_data, file_name, file_type)

        except Exception as e:
            print(f"Error processing {file_name}: {e}")

    def _create_excel_file(self, swagger_data: Dict[str, Any], file_name: str, file_type: str = None) -> Path:
        """Create Excel file with multiple sheets"""
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        file_prefix = self.config.get('output', {}).get('file_prefix', 'swagger_analysis')
        output_file = self.output_dir / f"{file_prefix}_{file_name}_{timestamp}.xlsx"

        with pd.ExcelWriter(output_file, engine='openpyxl') as writer:

            # Sheet 1: API Overview
            if self.config['sheets']['api_overview']['enabled']:
                overview_df = self._create_api_overview(swagger_data)
                overview_df.to_excel(
                    writer,
                    sheet_name=self.config['sheets']['api_overview']['name'],
                    index=False
                )

            # Sheet 2: Endpoints Detail
            if self.config['sheets']['endpoints']['enabled']:
                endpoints_df = self._create_endpoints_detail(swagger_data)
                endpoints_df.to_excel(
                    writer,
                    sheet_name=self.config['sheets']['endpoints']['name'],
                    index=False
                )

            # Sheet 3: Parameters
            if self.config['sheets']['parameters']['enabled']:
                params_df = self._create_parameters_detail(swagger_data)
                params_df.to_excel(
                    writer,
                    sheet_name=self.config['sheets']['parameters']['name'],
                    index=False
                )

            # Sheet 4: Responses
            if self.config['sheets']['responses']['enabled']:
                responses_df = self._create_responses_detail(swagger_data)
                responses_df.to_excel(
                    writer,
                    sheet_name=self.config['sheets']['responses']['name'],
                    index=False
                )

            # Sheet 5: Data Models
            if self.config['sheets']['data_models']['enabled']:
                models_df = self._create_data_models(swagger_data)
                models_df.to_excel(
                    writer,
                    sheet_name=self.config['sheets']['data_models']['name'],
                    index=False
                )

            # Sheet 6: Tag Groups
            if self.config['sheets']['tag_groups']['enabled']:
                tags_df = self._create_tag_groups_summary(swagger_data)
                tags_df.to_excel(
                    writer,
                    sheet_name=self.config['sheets']['tag_groups']['name'],
                    index=False
                )

        print(f"Created Excel file: {output_file}")
        return output_file

    def _create_api_overview(self, swagger_data: Dict[str, Any]) -> pd.DataFrame:
        """Create API overview summary"""
        info = swagger_data.get('info', {})
        paths = swagger_data.get('paths', {})

        # Count operations by method
        method_counts = {}
        tag_counts = {}
        total_operations = 0

        for path, methods in paths.items():
            for method, operation in methods.items():
                if method.lower() in ['get', 'post', 'put', 'delete', 'patch', 'head', 'options']:
                    total_operations += 1
                    method_counts[method.upper()] = method_counts.get(method.upper(), 0) + 1

                    # Count tags
                    for tag in operation.get('tags', []):
                        tag_counts[tag] = tag_counts.get(tag, 0) + 1

        overview_data = [
            ['API Title', info.get('title', 'N/A')],
            ['API Version', info.get('version', 'N/A')],
            ['API Description', info.get('description', 'N/A')],
            ['Swagger Version', swagger_data.get('swagger', 'N/A')],
            ['Total Paths', len(paths)],
            ['Total Operations', total_operations],
            ['Total Tags', len(tag_counts)],
            ['', ''],  # Separator
            ['Operations by Method', ''],
        ]

        for method, count in sorted(method_counts.items()):
            overview_data.append([f'  {method}', count])

        overview_data.append(['', ''])  # Separator
        overview_data.append(['Top Tags by Operation Count', ''])

        for tag, count in sorted(tag_counts.items(), key=lambda x: x[1], reverse=True)[:10]:
            overview_data.append([f'  {tag}', count])

        return pd.DataFrame(overview_data, columns=['Property', 'Value'])

    def _create_endpoints_detail(self, swagger_data: Dict[str, Any]) -> pd.DataFrame:
        """Create detailed endpoints information"""
        endpoints = []

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

                    endpoint = {
                        'Path': path,
                        'Method': method.upper(),
                        'Operation ID': operation.get('operationId', ''),
                        'Tags': ', '.join(operation.get('tags', [])),
                        'Summary': operation.get('summary', ''),
                        'Description': self._truncate_text(operation.get('description', ''), 200),
                        'Deprecated': operation.get('deprecated', False),
                        'Consumes': ', '.join(operation.get('consumes', [])),
                        'Produces': ', '.join(operation.get('produces', [])),
                        'Total Parameters': len(params),
                        'Path Parameters': path_params,
                        'Query Parameters': query_params,
                        'Header Parameters': header_params,
                        'Body Parameters': body_params,
                        'Form Parameters': form_params,
                        'Success Responses': ', '.join(success_codes),
                        'Error Responses': ', '.join(error_codes),
                        'Total Responses': len(responses)
                    }

                    # Add security information if available
                    if 'security' in operation:
                        security_schemes = []
                        for security_req in operation['security']:
                            security_schemes.extend(security_req.keys())
                        endpoint['Security'] = ', '.join(security_schemes)
                    else:
                        endpoint['Security'] = 'Not specified'

                    endpoints.append(endpoint)

        return pd.DataFrame(endpoints)

    def _create_parameters_detail(self, swagger_data: Dict[str, Any]) -> pd.DataFrame:
        """Create detailed parameters information"""
        parameters = []

        # Global parameters
        global_params = swagger_data.get('parameters', {})
        for param_name, param_def in global_params.items():
            param_info = {
                'Source': 'Global Parameter',
                'Path': 'N/A',
                'Method': 'N/A',
                'Operation ID': 'N/A',
                'Parameter Name': param_name,
                'In': param_def.get('in', ''),
                'Type': param_def.get('type', param_def.get('schema', {}).get('type', '')),
                'Required': param_def.get('required', False),
                'Description': self._truncate_text(param_def.get('description', ''), 150),
                'Default': param_def.get('default', ''),
                'Enum Values': ', '.join(map(str, param_def.get('enum', []))),
                'Format': param_def.get('format', ''),
                'Pattern': param_def.get('pattern', ''),
                'Min Length': param_def.get('minLength', ''),
                'Max Length': param_def.get('maxLength', ''),
                'Minimum': param_def.get('minimum', ''),
                'Maximum': param_def.get('maximum', '')
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
                            'Source': 'Operation Parameter',
                            'Path': path,
                            'Method': method.upper(),
                            'Operation ID': operation_id,
                            'Parameter Name': param.get('name', ''),
                            'In': param.get('in', ''),
                            'Type': param.get('type', param.get('schema', {}).get('type', '')),
                            'Required': param.get('required', False),
                            'Description': self._truncate_text(param.get('description', ''), 150),
                            'Default': param.get('default', ''),
                            'Enum Values': ', '.join(map(str, param.get('enum', []))),
                            'Format': param.get('format', ''),
                            'Pattern': param.get('pattern', ''),
                            'Min Length': param.get('minLength', ''),
                            'Max Length': param.get('maxLength', ''),
                            'Minimum': param.get('minimum', ''),
                            'Maximum': param.get('maximum', '')
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

    def _create_responses_detail(self, swagger_data: Dict[str, Any]) -> pd.DataFrame:
        """Create detailed responses information"""
        responses = []

        for path, methods in swagger_data.get('paths', {}).items():
            for method, operation in methods.items():
                if method.lower() in ['get', 'post', 'put', 'delete', 'patch', 'head', 'options']:
                    operation_id = operation.get('operationId', '')

                    for status_code, response in operation.get('responses', {}).items():
                        response_info = {
                            'Path': path,
                            'Method': method.upper(),
                            'Operation ID': operation_id,
                            'Status Code': status_code,
                            'Description': self._truncate_text(response.get('description', ''), 200),
                            'Has Schema': 'schema' in response,
                            'Schema Type': '',
                            'Schema Reference': '',
                            'Headers': ''
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

    def _create_data_models(self, swagger_data: Dict[str, Any]) -> pd.DataFrame:
        """Create data models information from definitions"""
        models = []

        definitions = swagger_data.get('definitions', {})

        for model_name, model_def in definitions.items():
            # Basic model information
            model_info = {
                'Model Name': model_name,
                'Type': model_def.get('type', 'object'),
                'Description': self._truncate_text(model_def.get('description', ''), 200),
                'Required Properties': ', '.join(model_def.get('required', [])),
                'Total Properties': len(model_def.get('properties', {})),
                'Has Additional Properties': model_def.get('additionalProperties', False),
                'Discriminator': model_def.get('discriminator', ''),
                'AllOf': len(model_def.get('allOf', [])),
                'Properties Detail': ''
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

    def _create_tag_groups_summary(self, swagger_data: Dict[str, Any]) -> pd.DataFrame:
        """Create tag groups summary"""
        tag_stats = {}

        for path, methods in swagger_data.get('paths', {}).items():
            for method, operation in methods.items():
                if method.lower() in ['get', 'post', 'put', 'delete', 'patch', 'head', 'options']:
                    tags = operation.get('tags', ['Untagged'])

                    for tag in tags:
                        if tag not in tag_stats:
                            tag_stats[tag] = {
                                'Tag Name': tag,
                                'Total Operations': 0,
                                'GET': 0,
                                'POST': 0,
                                'PUT': 0,
                                'DELETE': 0,
                                'PATCH': 0,
                                'HEAD': 0,
                                'OPTIONS': 0,
                                'Unique Paths': set(),
                                'Operations List': []
                            }

                        tag_stats[tag]['Total Operations'] += 1
                        tag_stats[tag][method.upper()] += 1
                        tag_stats[tag]['Unique Paths'].add(path)
                        tag_stats[tag]['Operations List'].append(operation.get('operationId', f"{method.upper()} {path}"))

        # Convert to DataFrame format
        tag_summary = []
        for tag, stats in tag_stats.items():
            summary = {
                'Tag Name': tag,
                'Total Operations': stats['Total Operations'],
                'Unique Paths': len(stats['Unique Paths']),
                'GET': stats['GET'],
                'POST': stats['POST'],
                'PUT': stats['PUT'],
                'DELETE': stats['DELETE'],
                'PATCH': stats['PATCH'],
                'HEAD': stats['HEAD'],
                'OPTIONS': stats['OPTIONS'],
                'Operations': ', '.join(stats['Operations List'][:5])  # Show first 5 operations
            }

            if len(stats['Operations List']) > 5:
                summary['Operations'] += f" ... ({len(stats['Operations List']) - 5} more)"

            tag_summary.append(summary)

        # Sort by total operations descending
        tag_summary.sort(key=lambda x: x['Total Operations'], reverse=True)

        return pd.DataFrame(tag_summary)

    def _truncate_text(self, text: str, max_length: int = 100) -> str:
        """Truncate text to specified length"""
        if not text:
            return ''
        if len(text) <= max_length:
            return text
        return text[:max_length - 3] + '...'


def main():
    """Main entry point"""
    parser = argparse.ArgumentParser(description='Convert Swagger JSON files to Excel format')
    parser.add_argument(
        'file',
        nargs='?',
        help='Swagger JSON file to convert (optional if using --config)'
    )
    parser.add_argument(
        '--output',
        help='Output directory (default: ./excel_output)'
    )
    parser.add_argument(
        '--name',
        help='Output file name (default: derived from input file)'
    )
    parser.add_argument(
        '--config',
        action='store_true',
        help='Use config.yaml to process multiple files'
    )

    args = parser.parse_args()

    try:
        output_dir = args.output if args.output else "./excel_output"
        analyzer = SwaggerAnalyzer(output_dir=output_dir)

        if args.config or (not args.file and Path("config.yaml").exists()):
            # Config-driven mode: process all files from config.yaml
            if not Path("config.yaml").exists():
                print("Error: config.yaml not found")
                sys.exit(1)
            analyzer.process_all_files()
        elif args.file:
            # Single file mode
            output_file = analyzer.process_single_file(args.file, args.name)
            print(f"Excel file created successfully: {output_file}")
        else:
            print("Error: Please provide a file to convert or use --config flag")
            parser.print_help()
            sys.exit(1)

    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()