"""
Swagger Equivalency Validator

This module contains the SwaggerValidator class that handles the comparison
between TypeSpec-compiled swagger and hand-authored swagger files using openapi-diff.
"""

import json
import os
import subprocess
from datetime import datetime
from typing import Dict, Any, List
import yaml
from colorama import Fore, Style


class SwaggerValidator:
    """Simplified validator class using openapi-diff for professional API comparison."""

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
        """Load a swagger JSON file."""
        resolved_path = self._resolve_file_path(file_path)
        if not os.path.exists(resolved_path):
            raise FileNotFoundError(f"Swagger file not found: {resolved_path}")

        with open(resolved_path, 'r', encoding='utf-8') as f:
            return json.load(f)

    def _normalize_swagger(self, data: Any, path: str = "") -> Any:
        """
        Normalize swagger data by replacing variable content with standardized values.
        This maintains OpenAPI spec compliance while enabling meaningful comparison.
        """
        if isinstance(data, dict):
            normalized = {}
            for k, v in data.items():
                current_path = f"{path}/{k}" if path else k

                # Handle description fields more carefully based on context
                if k in ['description', 'summary', 'title'] and isinstance(v, str):
                    # Only replace string values with standardized placeholders
                    normalized[k] = f"[NORMALIZED_{k.upper()}]"
                elif k in ['example', 'examples', 'x-ms-examples']:
                    # Skip examples entirely to avoid external file reference issues
                    continue
                elif k == 'discriminator' and isinstance(v, dict):
                    # Preserve discriminator structure but normalize content
                    normalized[k] = self._normalize_swagger(v, current_path)
                elif k == '$ref':
                    # Handle cross-file references by converting them to internal references
                    if isinstance(v, str):
                        if v.startswith('knowledgebase.json#/'):
                            # Convert cross-file reference to internal reference
                            normalized[k] = v.replace('knowledgebase.json#/', '#/')
                        elif v.startswith('searchservice.json#/'):
                            # Convert cross-file reference to internal reference
                            normalized[k] = v.replace('searchservice.json#/', '#/')
                        elif v.startswith('searchindex.json#/'):
                            # Convert cross-file reference to internal reference
                            normalized[k] = v.replace('searchindex.json#/', '#/')
                        elif '../../../../../common-types/data-plane/v1/types.json#/' in v:
                            # Convert common-types reference to internal reference
                            normalized[k] = v.replace('../../../../../common-types/data-plane/v1/types.json#/', '#/')
                        else:
                            # Preserve other references as-is
                            normalized[k] = v
                    else:
                        normalized[k] = v
                else:
                    # Recursively normalize other fields
                    normalized[k] = self._normalize_swagger(v, current_path)

            # Sort for consistent ordering
            return {k: normalized[k] for k in sorted(normalized.keys())}
        elif isinstance(data, list):
            return [self._normalize_swagger(item, f"{path}[{i}]") for i, item in enumerate(data)]
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

    def _run_openapi_diff(self, old_spec_path: str, new_spec_path: str) -> str:
        """Run openapi-diff and return the raw output."""
        try:
            # Run openapi-diff with default output format
            result = subprocess.run([
                'openapi-diff',
                old_spec_path,
                new_spec_path
            ], capture_output=True, text=True, check=False, shell=True)

            # Return the output regardless of exit code
            # openapi-diff returns non-zero when differences are found, which is normal
            output = result.stdout or result.stderr or "No output from openapi-diff"
            return output.strip()

        except FileNotFoundError:
            raise RuntimeError("openapi-diff not found. Please install it with: npm install -g openapi-diff")

    def _save_intermediate_file(self, data: Dict[str, Any], filename: str) -> str:
        """Save normalized swagger data to intermediate file."""
        os.makedirs(self.config['output']['path'], exist_ok=True)
        filepath = os.path.join(self.config['output']['path'], filename)

        with open(filepath, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=2, sort_keys=True)

        return filepath

    def _load_intermediate_file(self, filename: str) -> Dict[str, Any]:
        """Load previously saved intermediate file."""
        filepath = os.path.join(self.config['output']['path'], filename)

        if not os.path.exists(filepath):
            raise FileNotFoundError(f"Intermediate file not found: {filepath}")

        with open(filepath, 'r', encoding='utf-8') as f:
            return json.load(f)

    def _generate_text_report(self, diff_output: str) -> str:
        """Save openapi-diff output to a text file."""
        os.makedirs(self.config['output']['path'], exist_ok=True)

        filename = f"openapi_diff_report_{datetime.now().strftime('%Y%m%d_%H%M%S')}.txt"
        filepath = os.path.join(self.config['output']['path'], filename)

        with open(filepath, 'w', encoding='utf-8') as f:
            f.write("OpenAPI-Diff Comparison Report\n")
            f.write("="*50 + "\n\n")
            f.write("Comparing:\n")
            f.write("  Old: norm-hand-search.json (merged hand-authored files)\n")
            f.write("  New: norm-tsp-search.json (TypeSpec-compiled)\n\n")
            f.write("Results:\n")
            f.write("-"*20 + "\n")
            f.write(diff_output)

        return filepath

    def _print_summary(self, diff_output: str) -> None:
        """Print validation summary to console."""
        print("\n" + "="*60)
        print("SWAGGER EQUIVALENCY VALIDATION SUMMARY (OpenAPI-Diff)")
        print("="*60)

        # Simple heuristic to determine if files are equivalent
        if not diff_output.strip() or "No differences found" in diff_output:
            print(f"Overall Status: {Fore.GREEN}✓ EQUIVALENT{Style.RESET_ALL}")
            print("✓ TypeSpec-compiled swagger is equivalent to hand-authored swaggers!")
        else:
            print(f"Overall Status: {Fore.RED}✗ NOT EQUIVALENT{Style.RESET_ALL}")
            print("! Differences found between TypeSpec-compiled and hand-authored swaggers.")
            print("  Check the text report for details.")

        print("="*60)
        print("\n")

    def validate(self, skip_normalization: bool = False) -> int:
        """Run the complete validation process."""
        try:
            print(f"{Fore.CYAN}Azure AI Search - Swagger Equivalency Validator (OpenAPI-Diff){Style.RESET_ALL}")
            print("="*60)

            if not skip_normalization:
                print(f"{Fore.YELLOW}Step 1: Generating normalized files...{Style.RESET_ALL}")
                print(f"{Fore.YELLOW}Loading swagger files...{Style.RESET_ALL}")

                # Load TypeSpec-compiled swagger
                typespec_swagger = self._load_swagger_file(self.config['typespec_compiled']['path'])
                typespec_normalized = self._normalize_swagger(typespec_swagger)

                # Load hand-authored swagger files
                hand_authored_files = []
                for file_config in self.config['hand_authored'].values():
                    swagger_data = self._load_swagger_file(file_config['path'])
                    hand_authored_files.append(self._normalize_swagger(swagger_data))

                # Merge hand-authored files
                merged_swagger = self._merge_swagger_files(hand_authored_files)

                # Save intermediate files
                typespec_file = self._save_intermediate_file(typespec_normalized, 'norm-tsp-search.json')
                hand_authored_file = self._save_intermediate_file(merged_swagger, 'norm-hand-search.json')

                print(f"{Fore.GREEN}✓ Normalized TypeSpec swagger saved: {typespec_file}{Style.RESET_ALL}")
                print(f"{Fore.GREEN}✓ Normalized hand-authored swagger saved: {hand_authored_file}{Style.RESET_ALL}")

            else:
                print(f"{Fore.YELLOW}Step 1: Skipped normalization (using existing files)...{Style.RESET_ALL}")

            print(f"{Fore.YELLOW}Step 2: Loading intermediate normalized files...{Style.RESET_ALL}")

            try:
                # Check if intermediate files exist
                typespec_file = os.path.join(self.config['output']['path'], 'norm-tsp-search.json')
                hand_authored_file = os.path.join(self.config['output']['path'], 'norm-hand-search.json')

                if not os.path.exists(typespec_file) or not os.path.exists(hand_authored_file):
                    raise FileNotFoundError("Intermediate files not found")

                # Load file info for display
                typespec_swagger = self._load_intermediate_file('norm-tsp-search.json')
                merged_swagger = self._load_intermediate_file('norm-hand-search.json')

                print(f"  • TypeSpec-compiled: {len(typespec_swagger.get('paths', {}))} paths (from norm-tsp-search.json)")
                print(f"  • Hand-authored merged: {len(merged_swagger.get('paths', {}))} paths (from norm-hand-search.json)")

            except FileNotFoundError:
                print(f"{Fore.RED}Intermediate files not found!{Style.RESET_ALL}")
                if skip_normalization:
                    print(f"{Fore.YELLOW}Please run 'python main.py' first to generate normalized files.{Style.RESET_ALL}")
                else:
                    print(f"{Fore.YELLOW}Failed to generate intermediate files.{Style.RESET_ALL}")
                return 1

            print(f"{Fore.YELLOW}Step 3: Running openapi-diff comparison...{Style.RESET_ALL}")

            # Run openapi-diff on the intermediate files
            diff_output = self._run_openapi_diff(hand_authored_file, typespec_file)

            # Generate text report
            report_path = self._generate_text_report(diff_output)

            print(f"{Fore.GREEN}✓ Comparison report generated: {report_path}{Style.RESET_ALL}")

            # Print openapi-diff output to console
            print(f"\n{Fore.CYAN}OpenAPI-Diff Results:{Style.RESET_ALL}")
            print("-" * 40)
            if diff_output.strip():
                print(diff_output)
            else:
                print("No differences found!")

            # Print summary
            self._print_summary(diff_output)

            print("Generated Files:")
            print("  • TypeSpec normalized: norm-tsp-search.json")
            print("  • Hand-authored normalized: norm-hand-search.json")
            print(f"  • Comparison report: {report_path}")

            # Return exit code based on whether differences were found
            return 1 if diff_output.strip() else 0

        except Exception as e:
            print(f"{Fore.RED}Error: {e}{Style.RESET_ALL}")
            import traceback
            traceback.print_exc()
            return 1