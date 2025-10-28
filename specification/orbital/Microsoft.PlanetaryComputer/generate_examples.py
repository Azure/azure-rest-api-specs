
import json
import os
import re
import base64
import glob
import copy
from urllib.parse import urlparse, parse_qs

try:
    import jsonref
    HAS_JSONREF = True
except ImportError:
    HAS_JSONREF = False
    print("Warning: jsonref module not available. Install with: pip install jsonref")
    print("$ref resolution will be skipped, which may cause parameter parsing issues.\n")

OPENAPI_JSON = "specification/orbital/data-plane/Microsoft.PlanetaryComputer/preview/2025-04-30-preview/openapi.json"
EXAMPLES_FOLDER = "specification/orbital/Microsoft.PlanetaryComputer/examples/2025-04-30-preview/"
RECORDINGS = "specification/orbital/Microsoft.PlanetaryComputer/recordings/"

def load_openapi_spec():
    """Load the OpenAPI 2.0 spec and make a list of PATH, VERB, operationId"""
    with open(OPENAPI_JSON, 'r') as f:
        if HAS_JSONREF:
            # Load with $ref resolution using jsonref
            base_uri = f'file:///{os.path.abspath(OPENAPI_JSON).replace(os.sep, "/")}'
            spec_dict = json.load(f)
            spec = jsonref.JsonRef.replace_refs(spec_dict, base_uri=base_uri, jsonschema=True)
        else:
            spec = json.load(f)
    
    operations = []
    for path, path_item in spec.get('paths', {}).items():
        for verb, operation in path_item.items():
            if verb.upper() in ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'HEAD', 'OPTIONS']:
                operations.append({
                    'path': path,
                    'verb': verb.upper(),
                    'operationId': operation.get('operationId'),
                    'parameters': operation.get('parameters', []),
                    'responses': operation.get('responses', {})
                })
    
    return operations

def remove_refs_from_object(obj):
    """Recursively remove $ref properties from an object"""
    if isinstance(obj, dict):
        # Remove $ref if it exists
        if '$ref' in obj:
            del obj['$ref']
        # Recursively process all values
        for key, value in obj.items():
            remove_refs_from_object(value)
    elif isinstance(obj, list):
        # Recursively process all items in list
        for item in obj:
            remove_refs_from_object(item)
    # For primitive types (str, int, bool, None), do nothing
    return obj

def parse_path_template(openapi_path, request_uri):
    """Match OpenAPI path template with actual request URI"""
    # Extract path from request URI
    parsed_uri = urlparse(request_uri)
    request_path = parsed_uri.path
    
    # Split both paths into segments
    template_segments = openapi_path.strip('/').split('/')
    request_segments = request_path.strip('/').split('/')
    
    if len(template_segments) != len(request_segments):
        return None
    
    params = {}
    
    for template_seg, request_seg in zip(template_segments, request_segments):
        # Check if this segment contains parameters
        if '{' in template_seg and '}' in template_seg:
            # Handle complex templates like {width}x{height}.{format}
            if template_seg.count('{') > 1:
                # Multiple parameters in one segment
                params.update(parse_complex_segment(template_seg, request_seg))
            else:
                # Single parameter in segment
                param_match = re.search(r'\{([^}]+)\}', template_seg)
                if param_match:
                    param_name = param_match.group(1)
                    params[param_name] = request_seg
        else:
            # Static segment - must match exactly
            if template_seg != request_seg:
                return None
    
    return params

def parse_complex_segment(template_segment, request_segment):
    """Parse segments with multiple parameters like {width}x{height}.{format}, {longitude},{latitude}, {z}/{x}/{y}@{scale}x.{format}"""
    params = {}
    
    # Extract parameter names from template
    param_names = re.findall(r'\{([^}]+)\}', template_segment)
    
    if not param_names:
        return params
    
    # Handle specific known patterns first
    
    # Pattern: {minx},{miny},{maxx},{maxy} (without format)
    if len(param_names) == 4 and template_segment.count(',') == 3 and '.' not in template_segment:
        # Example: -84.393,33.6798,-84.367,33.7058
        bbox_values = request_segment.split(',')
        if len(bbox_values) == 4:
            params[param_names[0]] = bbox_values[0]  # minx
            params[param_names[1]] = bbox_values[1]  # miny
            params[param_names[2]] = bbox_values[2]  # maxx
            params[param_names[3]] = bbox_values[3]  # maxy
            return params
    
    # Pattern: {minx},{miny},{maxx},{maxy}.{format}
    if len(param_names) == 5 and template_segment.count(',') == 3 and '.' in template_segment:
        # Example: -84.393,33.6798,-84.367,33.7058.png
        # Find the last dot to separate format
        last_dot_index = request_segment.rfind('.')
        if last_dot_index > 0:
            format_val = request_segment[last_dot_index + 1:]
            bbox_part = request_segment[:last_dot_index]
            
            # Split on commas to get the 4 bbox values
            bbox_values = bbox_part.split(',')
            if len(bbox_values) == 4:
                params[param_names[0]] = bbox_values[0]  # minx
                params[param_names[1]] = bbox_values[1]  # miny
                params[param_names[2]] = bbox_values[2]  # maxx
                params[param_names[3]] = bbox_values[3]  # maxy
                params[param_names[4]] = format_val      # format
                return params
    
    # Pattern: {longitude},{latitude}
    if len(param_names) == 2 and ',' in template_segment and template_segment.count('{') == 2:
        parts = request_segment.split(',')
        if len(parts) == 2:
            params[param_names[0]] = parts[0].strip()
            params[param_names[1]] = parts[1].strip()
            return params
    
    # Pattern: {scale}x.{format} or {y}@{scale}x.{format}
    if '@' in template_segment and 'x.' in template_segment:
        # Example template: {y}@{scale}x.{format}
        # Example request: 6564.0@1.0x.png
        # Split on @ first
        at_parts = request_segment.split('@')
        if len(at_parts) == 2 and len(param_names) >= 2:
            # First part before @ is for the first parameter (e.g., y)
            if len(param_names) == 3:
                params[param_names[0]] = at_parts[0]
                # Second part has scale and format: "1.0x.png"
                scale_format = at_parts[1]
                # Find "x." to split scale and format
                x_dot_index = scale_format.find('x.')
                if x_dot_index > 0:
                    params[param_names[1]] = scale_format[:x_dot_index]
                    params[param_names[2]] = scale_format[x_dot_index + 2:]
            elif len(param_names) == 2:
                # Template is just {scale}x.{format}
                scale_format = at_parts[1] if at_parts[1] else at_parts[0]
                x_dot_index = scale_format.find('x.')
                if x_dot_index > 0:
                    params[param_names[0]] = scale_format[:x_dot_index]
                    params[param_names[1]] = scale_format[x_dot_index + 2:]
            return params
    
    # Pattern: {width}x{height}.{format}
    if 'x' in template_segment and '.' in template_segment and len(param_names) == 3:
        result = parse_width_height_format(template_segment, request_segment)
        if result:
            return result
    
    # Generic regex-based approach for other patterns
    # Escape special regex characters in the template except for parameter placeholders
    regex_template = re.escape(template_segment)
    
    # Find all parameter placeholders in the escaped template
    param_matches = list(re.finditer(r'\\?\{([^}]+)\\?\}', regex_template))
    
    if not param_matches:
        return params
    
    # Build regex by replacing escaped parameter placeholders with capture groups
    current_regex = regex_template
    param_names_ordered = []
    
    # Replace in reverse order to maintain positions
    for match in reversed(param_matches):
        param_name = match.group(1)
        param_names_ordered.insert(0, param_name)
        
        # Replace the escaped placeholder with a named capture group
        # Use a more permissive pattern that captures most characters except path separators
        start, end = match.span()
        current_regex = current_regex[:start] + f'(?P<{param_name}>[^/]+?)' + current_regex[end:]
    
    # Try to match the request segment against our regex
    try:
        segment_match = re.match(f'^{current_regex}$', request_segment)
        if segment_match:
            params.update(segment_match.groupdict())
    except re.error:
        # If regex fails, return empty params
        pass
    
    return params

def parse_width_height_format(template_segment, request_segment):
    """Specific parser for {width}x{height}.{format} pattern"""
    params = {}
    
    # Extract parameter names from template
    param_names = re.findall(r'\{([^}]+)\}', template_segment)
    
    # For {width}x{height}.{format} pattern
    if len(param_names) == 3 and 'x' in template_segment and '.' in template_segment:
        # Match pattern like "256.0x256.0.png"
        # Find the last dot (for format extension) and work backwards
        last_dot_index = request_segment.rfind('.')
        if last_dot_index > 0 and 'x' in request_segment[:last_dot_index]:
            format_val = request_segment[last_dot_index + 1:]
            width_height_part = request_segment[:last_dot_index]
            
            # Split on 'x' to get width and height
            if 'x' in width_height_part:
                width, height = width_height_part.split('x', 1)
                params[param_names[0]] = width  # width
                params[param_names[1]] = height  # height
                params[param_names[2]] = format_val  # format
    
    return params

def parse_multipart_form_data(request_body, content_type):
    """Parse multipart/form-data from request body"""
    form_data = {}
    
    if not request_body or not content_type or 'multipart/form-data' not in content_type:
        return form_data
    
    # Extract boundary from content type
    boundary_match = re.search(r'boundary=([^;]+)', content_type)
    if not boundary_match:
        return form_data
    
    boundary = boundary_match.group(1)
    
    # Join request body if it's an array
    if isinstance(request_body, list):
        body_content = ''.join(request_body)
    else:
        body_content = request_body
    
    # Split by boundary
    parts = body_content.split(f'--{boundary}')
    
    for part in parts:
        if not part.strip() or part.strip() == '--':
            continue
            
        # Look for Content-Disposition header
        disposition_match = re.search(r'Content-Disposition: form-data; name="([^"]+)"', part)
        if disposition_match:
            field_name = disposition_match.group(1)
            
            # Extract the value (after the headers)
            content_start = part.find('\r\n\r\n')
            if content_start != -1:
                value = part[content_start + 4:].strip()
                
                # Handle base64 encoded values
                if value.startswith('b64:'):
                    try:
                        decoded_value = base64.b64decode(value[4:]).decode('utf-8')
                        form_data[field_name] = decoded_value
                    except Exception:
                        form_data[field_name] = value
                else:
                    form_data[field_name] = value
    
    return form_data

def convert_parameter_type(value, param_spec):
    """Convert parameter value to the correct type based on OpenAPI spec"""
    if not param_spec:
        return value
    
    param_type = param_spec.get('type')
    param_format = param_spec.get('format')
    
    # Handle array types
    if param_type == 'array':
        items_type = param_spec.get('items', {}).get('type')
        if isinstance(value, str):
            # Parse CSV format
            values = [v.strip() for v in value.split(',')]
        elif isinstance(value, list):
            values = value
        else:
            return value
        
        # Convert each item to the correct type
        if items_type == 'integer':
            try:
                return [int(v) for v in values]
            except (ValueError, TypeError):
                return values
        elif items_type == 'number' or items_type == 'float':
            try:
                return [float(v) for v in values]
            except (ValueError, TypeError):
                return values
        else:
            return values
    
    # Handle integer types
    elif param_type == 'integer':
        try:
            return int(value)
        except (ValueError, TypeError):
            return value
    
    # Handle number/float types
    elif param_type == 'number' or param_format == 'float' or param_format == 'double':
        try:
            return float(value)
        except (ValueError, TypeError):
            return value
    
    # Handle boolean types
    elif param_type == 'boolean':
        if isinstance(value, bool):
            return value
        if isinstance(value, str):
            return value.lower() in ('true', '1', 'yes')
        return bool(value)
    
    # Default: return as-is (string or other)
    return value

def extract_parameters(operation, request_uri, path_params, request_body=None, content_type=None):
    """Extract all query, path, and form parameters with correct types"""
    parsed_uri = urlparse(request_uri)
    query_params = parse_qs(parsed_uri.query)
    
    # Flatten query params (remove list wrapping for single values)
    query_params = {k: v[0] if len(v) == 1 else v for k, v in query_params.items()}
    
    # Build a lookup map of parameter specs by name
    param_specs = {}
    for param in operation.get('parameters', []):
        param_name = param.get('name')
        if param_name:
            param_specs[param_name] = param
    
    parameters = {}
    
    # Add path parameters with type conversion
    for param_name, param_value in path_params.items():
        param_spec = param_specs.get(param_name)
        parameters[param_name] = convert_parameter_type(param_value, param_spec)
    
    # Add query parameters with type conversion
    for param_name, param_value in query_params.items():
        param_spec = param_specs.get(param_name)
        parameters[param_name] = convert_parameter_type(param_value, param_spec)
    
    # Add form data parameters if present
    if request_body and content_type and 'multipart/form-data' in content_type:
        # Add contentType parameter for multipart requests
        parameters['contentType'] = 'multipart/form-data'
        
        form_data = parse_multipart_form_data(request_body, content_type)
        parameters.update(form_data)
    
    return parameters

def process_response_body(response_body):
    """Process response body - handle both string and array formats"""
    # If it's None, return None
    if response_body is None:
        return None
    
    # If it's already a dict, return as-is (already parsed JSON)
    if isinstance(response_body, dict):
        return response_body
    
    # If it's a list, concatenate elements (recordings split long strings into arrays)
    if isinstance(response_body, list):
        # Join array elements into single string
        body_content = ''.join(response_body)
    else:
        body_content = response_body
    
    # Try to parse as JSON, if it fails return as string
    try:
        return json.loads(body_content)
    except json.JSONDecodeError:
        # Not JSON - return as string
        # For multiline strings in JSON, they will be escaped with \n
        return body_content

def load_existing_example(example_path):
    """Load existing example file if it exists"""
    if os.path.exists(example_path):
        try:
            with open(example_path, 'r') as f:
                return json.load(f)
        except Exception:
            return None
    return None

def should_add_response(existing_example, status_code):
    """Check if we should add this response status code"""
    # Skip 404 status codes - don't add them to examples
    if status_code == "404":
        return False
    
    if not existing_example:
        return True
    
    # Check if this status code already exists in responses
    existing_responses = existing_example.get('responses', {})
    return status_code not in existing_responses

def post_process_examples():
    """Create derived examples by copying existing ones and removing tileMatrixSetId parameter"""
    
    # Define the mapping of source to target examples
    example_mappings = [
        {
            'source': 'TilerWmtsTileMatrixSets_GetCapabilitiesXml.json',
            'target': 'TilerWmts_GetCapabilitiesXml.json',
            'remove_param': 'tileMatrixSetId'
        },
        {
            'source': 'MosaicsAssetsForTileMatrixSets_GetZxyAssets.json',
            'target': 'MosaicsAssetsForTiles_GetZxyAssets.json',
            'remove_param': 'tileMatrixSetId'
        },
        {
            'source': 'MosaicsWmtsMosaicsTileMatrixSets_GetCapabilitiesXml.json',
            'target': 'MosaicsWmtsMosaics_GetCapabilitiesXml.json',
            'remove_param': 'tileMatrixSetId'
        },
        {
            'source': 'TilerTileMatrixSets_GetZxyScaleByFormat.json',
            'target': 'TilerTiles_GetZxyScaleByFormat.json',
            'remove_param': 'tileMatrixSetId'
        },
        {
            'source': 'TilerTileJsonTileMatrixSets_Get.json',
            'target': 'TilerTileJsonOperations_Get.json',
            'remove_param': 'tileMatrixSetId'
        },
        {
            'source': 'MosaicsTileMatrixSets_GetZxyScaleByFormat.json',
            'target': 'MosaicsTiles_GetZxyScaleByFormat.json',
            'remove_param': 'tileMatrixSetId'
        },
        {
            'source': 'MosaicsTileMatrixSetsTileJson_Get.json',
            'target': 'MosaicsTileJsonOperations_Get.json',
            'remove_param': 'tileMatrixSetId'
        },
        {
            'source': 'StacSearch_Create.json',
            'target': 'StacSearch_Get.json',
            'type': 'search_variant'  # Special handling for search operations
        }
    ]
    
    print(f"\n{'='*80}")
    print("POST-PROCESSING: Creating derived examples")
    print(f"{'='*80}")
    
    for mapping in example_mappings:
        source_path = os.path.join(EXAMPLES_FOLDER, mapping['source'])
        target_path = os.path.join(EXAMPLES_FOLDER, mapping['target'])
        
        if not os.path.exists(source_path):
            print(f"Source file not found: {mapping['source']}")
            continue
            
        try:
            # Load source example
            with open(source_path, 'r') as f:
                source_example = json.load(f)
            
            # Create copy for target
            target_example = copy.deepcopy(source_example)
            
            # Update operation ID and title
            new_operation_id = os.path.splitext(mapping['target'])[0]
            target_example['operationId'] = new_operation_id
            target_example['title'] = new_operation_id
            
            # Handle different transformation types
            if mapping.get('type') == 'search_variant':
                # For StacSearch_Get: keep only api-version parameter and change response to 200
                if 'parameters' in target_example:
                    # Keep only api-version parameter (GET operations don't have request bodies)
                    api_version = target_example['parameters'].get('api-version')
                    target_example['parameters'] = {}
                    if api_version:
                        target_example['parameters']['api-version'] = api_version
                
                # Change response from 201 to 200 if it exists
                if 'responses' in target_example:
                    if '201' in target_example['responses']:
                        target_example['responses']['200'] = target_example['responses']['201']
                        del target_example['responses']['201']
                
                print(f"Created search variant: {mapping['target']}")
                
            else:
                # Standard parameter removal
                if 'parameters' in target_example and mapping['remove_param'] in target_example['parameters']:
                    del target_example['parameters'][mapping['remove_param']]
                    print(f"Removed parameter '{mapping['remove_param']}' from {mapping['target']}")
                
                print(f"Created derived example: {mapping['target']}")
            
            # Write target example
            # Remove $ref properties before writing
            remove_refs_from_object(target_example)
            
            with open(target_path, 'w') as f:
                json.dump(target_example, f, indent=2, ensure_ascii=False)
            
        except Exception as e:
            print(f"Error processing {mapping['source']} -> {mapping['target']}: {e}")

def generate_examples():
    """Main function to generate examples"""
    print("Loading OpenAPI specification...")
    operations = load_openapi_spec()
    print(f"Found {len(operations)} operations")
    
    # Get all recording files
    recording_pattern = os.path.join(RECORDINGS, "*.json")
    recording_files = glob.glob(recording_pattern)
    print(f"Found {len(recording_files)} recording files")
    
    total_entries = 0
    processed_entries = 0
    
    for recording_file in recording_files:
        print(f"\n{'='*80}")
        print(f"Processing recording file: {os.path.basename(recording_file)}")
        print(f"{'='*80}")
        
        try:
            with open(recording_file, 'r') as f:
                recording = json.load(f)
        except Exception as e:
            print(f"Error reading {recording_file}: {e}")
            continue
        
        entries = recording.get('Entries', [])
        total_entries += len(entries)
        print(f"Found {len(entries)} entries in this recording")
        
        # Process all entries in the recording
        for i, entry in enumerate(entries):
            print(f"\nProcessing entry {i+1}/{len(entries)}: {entry['RequestMethod']} {entry['RequestUri']}")
            
            request_uri = entry['RequestUri']
            request_method = entry['RequestMethod'].upper()
            
            # Find matching operation - prioritize more specific paths (without parameters)
            matching_operation = None
            path_params = {}
            
            # Sort operations by specificity: paths without parameters first
            sorted_operations = sorted(operations, 
                                     key=lambda op: (op['verb'] != request_method, op['path'].count('{')))
            
            for operation in sorted_operations:
                if operation['verb'] == request_method:
                    path_params = parse_path_template(operation['path'], request_uri)
                    if path_params is not None:
                        matching_operation = operation
                        break
            
            if matching_operation:
                print(f"Found matching operation: {matching_operation['operationId']}")
                processed_entries += 1
                
                # Get content type from request headers
                content_type = entry.get('RequestHeaders', {}).get('Content-Type', '')
                
                # Extract parameters including form data
                parameters = extract_parameters(matching_operation, request_uri, path_params, 
                                              entry.get('RequestBody'), content_type)
                print(f"Extracted parameters: {parameters}")
                
                # Process response
                status_code = str(entry['StatusCode'])
                response_body = process_response_body(entry['ResponseBody'])
                
                # Write example file
                example_filename = f"{matching_operation['operationId']}.json"
                example_path = os.path.join(EXAMPLES_FOLDER, example_filename)
                
                # Check if example already exists and if this status code is already documented
                existing_example = load_existing_example(example_path)
                
                if not should_add_response(existing_example, status_code):
                    print(f"Status code {status_code} already exists for {matching_operation['operationId']}, skipping...")
                    continue
                
                # Prepare request body for non-form-data requests  
                request_body = None
                if (entry.get('RequestBody') is not None and 
                    content_type and 'multipart/form-data' not in content_type):
                    raw_body = entry.get('RequestBody')
                    # Try to parse as JSON first
                    try:
                        if isinstance(raw_body, str):
                            request_body = json.loads(raw_body)
                        elif isinstance(raw_body, list):
                            # Join array elements and try to parse
                            body_content = ''.join(raw_body)
                            request_body = json.loads(body_content)
                        else:
                            request_body = raw_body
                    except json.JSONDecodeError:
                        # If JSON parsing fails, use the raw body
                        request_body = raw_body
                
                # Create or update example structure
                if existing_example:
                    # Update existing example with new response
                    example = existing_example
                    if response_body is None:
                        example['responses'][status_code] = {}
                    else:
                        example['responses'][status_code] = {
                            "body": response_body
                        }
                    # Add request body as a parameter if it doesn't exist and we have one
                    if request_body is not None and 'body' not in example.get('parameters', {}):
                        if 'parameters' not in example:
                            example['parameters'] = {}
                        example['parameters']['body'] = request_body
                    print(f"Added status code {status_code} to existing example: {example_path}")
                else:
                    # Create new example
                    example = {
                        "title": matching_operation['operationId'],
                        "operationId": matching_operation['operationId'],
                        "parameters": parameters,
                        "responses": {
                            status_code: {} if response_body is None else {
                                "body": response_body
                            }
                        }
                    }
                    # Add request body as a parameter if we have one
                    if request_body is not None:
                        example['parameters']['body'] = request_body
                    print(f"Created new example: {example_path}")
                
                # Ensure examples folder exists
                os.makedirs(EXAMPLES_FOLDER, exist_ok=True)
                
                # Remove $ref properties before writing
                remove_refs_from_object(example)
                
                with open(example_path, 'w') as f:
                    json.dump(example, f, indent=2, ensure_ascii=False)
                
                print("Example updated successfully")
                
            else:
                print(f"No matching operation found for {request_method} {request_uri}")
    
    print(f"\n{'='*80}")
    print("SUMMARY")
    print(f"{'='*80}")
    print(f"Total recording files processed: {len(recording_files)}")
    print(f"Total entries found: {total_entries}")
    print(f"Total entries with matching operations: {processed_entries}")
    
    # List generated example files
    example_files = glob.glob(os.path.join(EXAMPLES_FOLDER, "*.json"))
    print(f"Total example files generated: {len(example_files)}")
    print("\nGenerated example files:")
    for example_file in sorted(example_files):
        print(f"  - {os.path.basename(example_file)}")
    
    if total_entries == 0:
        print("No entries found in any recording files")
    
    # Run post-processing to create derived examples
    post_process_examples()
    
    # Update final count after post-processing
    final_example_files = glob.glob(os.path.join(EXAMPLES_FOLDER, "*.json"))
    print(f"\nFinal total example files after post-processing: {len(final_example_files)}")

if __name__ == "__main__":
    generate_examples()
