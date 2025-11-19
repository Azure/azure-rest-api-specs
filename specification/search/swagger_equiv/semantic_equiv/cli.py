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
from canonicalize import canonicalize_both_specs, CanonicalizationError
from compare import compare_swagger_specs, EquivalencyResult


def save_artifacts(config, result: EquivalencyResult,
                  hand_authored_canonical: dict = None,
                  typespec_canonical: dict = None) -> None:
    """
    Save comparison artifacts to the output directory.

    Args:
        config: Configuration object
        result: Comparison result
        hand_authored_canonical: Canonicalized hand-authored spec (optional)
        typespec_canonical: Canonicalized TypeSpec spec (optional)
    """
    output_dir = Path(config.output_path)
    output_dir.mkdir(parents=True, exist_ok=True)

    # Save comparison result
    result_file = output_dir / "comparison_result.json"
    result_data = {
        "equivalent": result.equivalent,
        "difference_count": result.difference_count,
        "differences": [
            {
                "type": diff.type.value,
                "message": diff.message,
                "context": diff.context
            }
            for diff in result.differences
        ]
    }

    with open(result_file, 'w', encoding='utf-8') as f:
        json.dump(result_data, f, indent=2)

    # Save canonicalized specs if provided
    if hand_authored_canonical:
        canonical_hand_file = output_dir / "hand_authored_canonical.json"
        with open(canonical_hand_file, 'w', encoding='utf-8') as f:
            json.dump(hand_authored_canonical, f, indent=2)

    if typespec_canonical:
        canonical_typespec_file = output_dir / "typespec_canonical.json"
        with open(canonical_typespec_file, 'w', encoding='utf-8') as f:
            json.dump(typespec_canonical, f, indent=2)

    # Save detailed diff report if not equivalent
    if not result.equivalent:
        diff_file = output_dir / "differences_report.txt"
        with open(diff_file, 'w', encoding='utf-8') as f:
            f.write("Swagger Equivalency Check - Differences Report\\n")
            f.write("=" * 50 + "\\n\\n")
            f.write(f"Total differences found: {result.difference_count}\\n\\n")

            # Group differences by type
            by_type = {}
            for diff in result.differences:
                diff_type = diff.type.value
                if diff_type not in by_type:
                    by_type[diff_type] = []
                by_type[diff_type].append(diff)

            for diff_type, diffs in sorted(by_type.items()):
                f.write(f"{diff_type.upper()} ({len(diffs)} occurrences):\\n")
                f.write("-" * 40 + "\\n")
                for diff in diffs:
                    f.write(f"  {diff}\\n")
                f.write("\\n")


def print_result_summary(result: EquivalencyResult, verbose: bool = False) -> None:
    """Print comparison result summary to stdout."""
    if result.equivalent:
        print("✅ SUCCESS: Specifications are semantically equivalent")
    else:
        print("❌ FAILURE: Specifications are NOT semantically equivalent")
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
                print(f"Full details written to output directory")


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

        # Save artifacts
        artifacts_to_save = {}
        if args.save_canonical:
            artifacts_to_save['hand_authored_canonical'] = canonical_hand_authored
            artifacts_to_save['typespec_canonical'] = canonical_typespec

        save_artifacts(config, result, **artifacts_to_save)

        # Print results and exit with appropriate code
        print_result_summary(result, verbose=args.verbose)

        return 0 if result.equivalent else 1

    except ConfigError as e:
        print(f"❌ Configuration error: {e}", file=sys.stderr)
        return 2

    except LoaderError as e:
        print(f"❌ File loading error: {e}", file=sys.stderr)
        return 2

    except MergeError as e:
        print(f"❌ Merge error: {e}", file=sys.stderr)
        return 3

    except CanonicalizationError as e:
        print(f"❌ Canonicalization error: {e}", file=sys.stderr)
        return 3

    except Exception as e:
        print(f"❌ Unexpected error: {e}", file=sys.stderr)
        import traceback
        traceback.print_exc()
        return 3


def main() -> None:
    """Entry point for setuptools console script."""
    sys.exit(main_cli())


if __name__ == '__main__':
    main()