"""
Command-line interface for the Swagger equivalency checker.

This module implements the CLI entry point that wires together all components:
- Read config.yaml to discover file paths
- Load all Swagger specifications
- Merge hand-authored specs
- Canonicalize both specs
- Build models and compare for equivalency
- Exit with appropriate code and output

According to equiv_impl_guide.md, the CLI should:
- Exit with code 0 if equivalent, non-zero if not equivalent or error
- Print summary to stdout
- Write detailed artifacts to output directory
"""

import sys
import json
import argparse
from pathlib import Path
from typing import Optional

# Add current directory to path to allow direct execution
sys.path.insert(0, str(Path(__file__).parent))

from utils import load_config, validate_paths, ConfigError
from utils import load_and_validate_all_files, LoaderError
from utils import merge_hand_authored_specs, validate_merged_swagger, MergeError
from utils import write_merge_log, write_diffs_excel
from canonicalize import canonicalize_both_specs, CanonicalizationError
from compare import compare_swagger_specs, EquivalencyResult


def save_artifacts(
    config,
    result: EquivalencyResult,
    hand_authored_canonical: dict = None,
    typespec_canonical: dict = None,
    original_swagger_files: dict = None
) -> None:
    """
    Save comparison artifacts to the output directory.

    Args:
        config: Configuration object
        result: Comparison result
        hand_authored_canonical: Canonicalized hand-authored spec (optional)
        typespec_canonical: Canonicalized TypeSpec spec (optional)
        original_swagger_files: Original swagger files before merging (optional)
    """
    output_dir = Path(config.output_path)
    output_dir.mkdir(parents=True, exist_ok=True)

    # Write merge log
    write_merge_log(config.output_path)

    # Convert differences to structured format for Excel output
    structured_diffs = []
    if not result.equivalent:
        for i, diff in enumerate(result.differences, 1):
            # Extract details from the difference description
            description = str(diff)

            # Parse path, method, parameter info from description
            path = ""
            method = ""
            operation_id = ""
            parameter = ""
            response = ""
            source = ""

            # Extract path information
            if "[/" in description:
                path_part = description.split("[/")[1].split("]")[0] if "]" in description else ""
                path = "/" + path_part if path_part else ""

            # Extract method from path
            if " " in path and path.count(" ") > 0:
                parts = path.split(" ")
                if len(parts) >= 2:
                    path = parts[0]
                    method = parts[1] if parts[1].upper() in ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'HEAD', 'OPTIONS'] else ""

            # Extract parameter info
            if "param:" in description:
                parameter = description.split("param:")[1].split("]")[0] if "]" in description.split("param:")[1] else ""
            elif "Parameter" in description:
                parameter_parts = description.split("Parameter")
                if len(parameter_parts) > 1:
                    parameter = parameter_parts[1].split(":")[0].strip()

            # Extract response info
            if "Response" in description or "response" in description:
                response_parts = [part for part in description.split() if "response" in part.lower()]
                if response_parts:
                    response = response_parts[0]

            # Extract operation ID
            if "Operation ID" in description:
                op_parts = description.split("Operation ID")[1].split(":") if ":" in description.split("Operation ID")[1] else []
                if len(op_parts) > 1:
                    operation_id = op_parts[1].split("vs")[0].strip().strip("'\"")

            # Determine source
            if "definition:" in description:
                source = "Definition"
            elif "Path missing" in description or "Extra path" in description:
                source = "Path"
            elif "Parameter" in description:
                source = "Parameter"
            elif "Response" in description:
                source = "Response"
            elif "Operation" in description:
                source = "Operation"
            else:
                source = "Other"

            structured_diffs.append({
                'id': i,
                'path': path,
                'method': method,
                'operation_id': operation_id,
                'parameter': parameter,
                'response': response,
                'source': source,
                'description': description,
                'details': str(diff.details) if hasattr(diff, 'details') else ""
            })

    # Write Excel file with canonical specs for side-by-side comparison
    write_diffs_excel(structured_diffs, config.output_path,
                           hand_authored_canonical=hand_authored_canonical,
                           typespec_canonical=typespec_canonical,
                           original_swagger_files=original_swagger_files)

    # Save canonicalized specs if provided
    if hand_authored_canonical:
        canonical_hand_file = output_dir / "hand_authored_canonical.json"
        with open(canonical_hand_file, 'w', encoding='utf-8') as f:
            json.dump(hand_authored_canonical, f, indent=2)

    if typespec_canonical:
        canonical_typespec_file = output_dir / "typespec_canonical.json"
        with open(canonical_typespec_file, 'w', encoding='utf-8') as f:
            json.dump(typespec_canonical, f, indent=2)


def print_result_summary(
    result: EquivalencyResult,
    verbose: bool = False
) -> None:
    """Print comparison result summary to stdout."""
    if result.equivalent:
        print("\033[92mSUCCESS\033[0m: Specifications are semantically equivalent")
    else:
        print("\033[91mx Specifications are NOT semantically equivalent\033[0m")
        print(f"Found {result.difference_count} differences")

        if verbose:
            for i, diff in enumerate(result.differences, 1):
                print(f"{i}. {diff}")
        else:
            # Print just the first few differences
            max_shown = 5
            for i, diff in enumerate(result.differences[:max_shown], 1):
                print(f"{i}. {diff}")

            if len(result.differences) > max_shown:
                remaining = len(result.differences) - max_shown
                print(f"... and {remaining} more differences (use --verbose to see all)")
                print("Full details written to output directory")


def main_cli(argv: Optional[list] = None) -> int:
    """
    Main CLI entry point.

    Args:
        argv: Command line arguments (defaults to sys.argv)

    Returns:
        Exit code: 0 if equivalent, non-zero if not equivalent or error
    """
    parser = argparse.ArgumentParser(
        description="Swagger Equivalency Checker - Compare hand-authored and TypeSpec-compiled Swagger specifications",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Exit codes:
  0  - Specifications are semantically equivalent
  1  - Specifications are NOT equivalent
  2  - Configuration or file loading error
  3  - Processing error
"""
    )

    parser.add_argument(
        '--config', '-c',
        default='config.yaml',
        help='Path to configuration file (default: config.yaml)'
    )

    parser.add_argument(
        '--verbose', '-v',
        action='store_true',
        help='Print detailed differences (default: summary only)'
    )

    parser.add_argument(
        '--save-canonical',
        action='store_true',
        help='Save canonicalized specs to output directory for debugging'
    )

    parser.add_argument(
        '--ignore-operation-id',
        action='store_true',
        help='Ignore operationId mismatches during comparison'
    )

    args = parser.parse_args(argv)

    try:
        # Load and validate configuration
        config = load_config(args.config)
        validate_paths(config)

        # Load all Swagger files
        loaded_files = load_and_validate_all_files(config)

        # Merge hand-authored specifications
        merged_hand_authored = merge_hand_authored_specs(loaded_files)
        validate_merged_swagger(merged_hand_authored)

        # Canonicalize both specifications
        canonical_hand_authored, canonical_typespec = canonicalize_both_specs(
            merged_hand_authored,
            loaded_files['typespec_compiled']
        )

        # Compare for equivalency
        result = compare_swagger_specs(
            canonical_hand_authored,
            canonical_typespec,
            ignore_operation_id=args.ignore_operation_id
        )

        # Save artifacts - always pass canonical specs for comparison
        artifacts_to_save = {
            'hand_authored_canonical': canonical_hand_authored,
            'typespec_canonical': canonical_typespec,
            'original_swagger_files': loaded_files
        }

        # Only save canonical spec files if requested
        if not args.save_canonical:
            # Remove canonical specs from artifacts_to_save for file saving, but keep for Excel comparison
            save_artifacts(config, result,
                          hand_authored_canonical=canonical_hand_authored,
                          typespec_canonical=canonical_typespec,
                          original_swagger_files=loaded_files)
        else:
            save_artifacts(config, result, **artifacts_to_save)

        # Print results and exit with appropriate code
        print_result_summary(result, verbose=args.verbose)

        return 0 if result.equivalent else 1

    except ConfigError as e:
        print(f"\033[91mERROR\033[0m: Configuration error: {e}", file=sys.stderr)
        return 2

    except LoaderError as e:
        print(f"\033[91mERROR\033[0m: File loading error: {e}", file=sys.stderr)
        return 2

    except MergeError as e:
        print(f"\033[91mERROR\033[0m: Merge error: {e}", file=sys.stderr)
        return 3

    except CanonicalizationError as e:
        print(f"\033[91mERROR\033[0m: Canonicalization error: {e}", file=sys.stderr)
        return 3

    except Exception as e:
        print(f"\033[91mERROR\033[0m: Unexpected error: {e}", file=sys.stderr)
        import traceback
        traceback.print_exc()
        return 3


def main() -> None:
    """Entry point for setuptools console script."""
    sys.exit(main_cli())


if __name__ == '__main__':
    main()