#!/usr/bin/env python3
"""
Convert errors.log to CSV format for Excel pivot table analysis.
Parses JavaScript object error entries and extracts key fields into CSV columns.
"""

import csv
import re
import sys
from pathlib import Path

def clean_ansi_codes(text):
    """Remove ANSI color codes from text"""
    if not text:
        return text
    # Remove ANSI escape sequences
    ansi_escape = re.compile(r'\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])')
    return ansi_escape.sub('', text)

def extract_field_value(text, field_name):
    """Extract a field value from JavaScript object text"""
    # Pattern to match field: 'value' or field: value
    pattern = f"{field_name}:\\s*'([^']*)'|{field_name}:\\s*([^,}}]+)"
    match = re.search(pattern, text)
    if match:
        return match.group(1) if match.group(1) is not None else match.group(2).strip()
    return ''

def extract_nested_field(text, parent_field, child_field):
    """Extract nested field like schemaPosition.line"""
    # Look for parent_field: { ... child_field: value ... }
    parent_pattern = f"{parent_field}:\\s*{{([^}}]*)}}"
    parent_match = re.search(parent_pattern, text)
    if parent_match:
        nested_content = parent_match.group(1)
        child_pattern = f"{child_field}:\\s*([^,}}\\s]+)"
        child_match = re.search(child_pattern, nested_content)
        if child_match:
            return child_match.group(1).strip()
    return ''

def is_error_object(text):
    """Check if this object represents an error"""
    # Look for error-related indicators
    return ('code:' in text and 'message:' in text and 
            ('error' in text or 'INVALID_' in text or '_ERROR' in text or 
             'OBJECT_' in text or 'REQUIRED_' in text or 'RESPONSE_' in text))

def parse_error_object(obj_text):
    """Parse a complete error object and extract fields"""
    if not is_error_object(obj_text):
        return None
        
    # Clean ANSI codes
    clean_text = clean_ansi_codes(obj_text)
    
    return {
        'code': extract_field_value(clean_text, 'code'),
        'message': extract_field_value(clean_text, 'message'),
        'schemaUrl': extract_field_value(clean_text, 'schemaUrl'),
        'exampleUrl': extract_field_value(clean_text, 'exampleUrl'),
        'severity': extract_field_value(clean_text, 'severity'),
        'source': extract_field_value(clean_text, 'source'),
        'operationId': extract_field_value(clean_text, 'operationId'),
        'schemaPosition_line': extract_nested_field(clean_text, 'schemaPosition', 'line'),
        'schemaPosition_column': extract_nested_field(clean_text, 'schemaPosition', 'column'),
        'schemaJsonPath': extract_field_value(clean_text, 'schemaJsonPath'),
        'examplePosition_line': extract_nested_field(clean_text, 'examplePosition', 'line'),
        'examplePosition_column': extract_nested_field(clean_text, 'examplePosition', 'column'),
        'exampleJsonPath': extract_field_value(clean_text, 'exampleJsonPath'),
        'level': clean_ansi_codes(extract_field_value(clean_text, 'level'))
    }

def convert_errors_to_csv(input_file, output_file):
    """Convert errors.log to CSV format"""
    
    fieldnames = [
        'code', 'message', 'schemaUrl', 'exampleUrl', 'severity', 'source', 
        'operationId', 'schemaPosition_line', 'schemaPosition_column', 
        'schemaJsonPath', 'examplePosition_line', 'examplePosition_column', 
        'exampleJsonPath', 'level'
    ]
    
    error_count = 0
    
    try:
        with open(input_file, 'r', encoding='utf-8') as infile:
            content = infile.read()
            
        # Split content into objects by looking for '}' followed by optional whitespace and '{'
        # or end of string
        objects = re.split(r'}\s*(?={|$)', content)
        
        with open(output_file, 'w', newline='', encoding='utf-8') as outfile:
            writer = csv.DictWriter(outfile, fieldnames=fieldnames)
            writer.writeheader()
            
            for obj_text in objects:
                obj_text = obj_text.strip()
                if obj_text and not obj_text.endswith('}'):
                    obj_text += '}'
                    
                if obj_text:
                    error_data = parse_error_object(obj_text)
                    if error_data and error_data['code']:  # Only include entries with error codes
                        writer.writerow(error_data)
                        error_count += 1
                    
        print(f"✅ Successfully converted {error_count} error entries from {input_file} to {output_file}")
        return True
        
    except FileNotFoundError:
        print(f"❌ Error: File '{input_file}' not found")
        return False
    except Exception as e:
        print(f"❌ Error processing file: {e}")
        return False

def main():
    """Main function"""
    input_file = "errors.log"
    output_file = "errors_analysis.csv"
    
    # Check if input file exists
    if not Path(input_file).exists():
        print(f"❌ Error: {input_file} not found in current directory")
        sys.exit(1)
    
    print(f"🔄 Converting {input_file} to {output_file}...")
    
    success = convert_errors_to_csv(input_file, output_file)
    
    if success:
        print(f"\n📊 CSV file created: {output_file}")
        print(f"📈 You can now open {output_file} in Excel and create pivot tables")
        print("\n💡 Suggested pivot table configurations:")
        print("   - Rows: code, operationId")
        print("   - Columns: source, severity")
        print("   - Values: Count of code")
        print("   - Filters: schemaUrl, exampleUrl")
    else:
        sys.exit(1)

if __name__ == "__main__":
    main()