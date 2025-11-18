"""
Configuration module for the Swagger equivalency checker.

Handles reading and validating config.yaml according to the format specified
in equiv_impl_guide.md.
"""

import os
import yaml
from typing import Dict, Any
from dataclasses import dataclass
from pathlib import Path


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

    def resolve_paths(self, base_dir: Path) -> 'Config':
        """Resolve relative paths against the base directory."""
        return Config(
            typespec_compiled_path=str(base_dir / self.typespec_compiled_path),
            hand_authored=HandAuthoredConfig(
                searchservice_path=str(base_dir / self.hand_authored.searchservice_path),
                searchindex_path=str(base_dir / self.hand_authored.searchindex_path),
                knowledgebase_path=str(base_dir / self.hand_authored.knowledgebase_path),
                common_types_path=str(base_dir / self.hand_authored.common_types_path),
            ),
            output_path=str(base_dir / self.output_path)
        )


class ConfigError(Exception):
    """Exception raised for configuration-related errors."""
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
        with open(config_path, 'r', encoding='utf-8') as f:
            raw_config = yaml.safe_load(f)
    except yaml.YAMLError as e:
        raise ConfigError(f"Invalid YAML in configuration file: {e}")
    except Exception as e:
        raise ConfigError(f"Error reading configuration file: {e}")

    # Validate structure
    if not isinstance(raw_config, dict):
        raise ConfigError("Configuration must be a YAML object")

    # Extract and validate typespec_compiled
    typespec_compiled = raw_config.get('typespec_compiled', {})
    if not isinstance(typespec_compiled, dict) or 'path' not in typespec_compiled:
        raise ConfigError("Missing or invalid 'typespec_compiled.path' in configuration")

    # Extract and validate hand_authored
    hand_authored = raw_config.get('hand_authored', {})
    if not isinstance(hand_authored, dict):
        raise ConfigError("Missing or invalid 'hand_authored' section in configuration")

    required_hand_authored_keys = ['searchservice', 'searchindex', 'knowledgebase', 'common_types']
    for key in required_hand_authored_keys:
        if key not in hand_authored or not isinstance(hand_authored[key], dict):
            raise ConfigError(f"Missing or invalid 'hand_authored.{key}' in configuration")
        if 'path' not in hand_authored[key]:
            raise ConfigError(f"Missing 'hand_authored.{key}.path' in configuration")

    # Extract and validate output
    output = raw_config.get('output', {})
    if not isinstance(output, dict) or 'path' not in output:
        raise ConfigError("Missing or invalid 'output.path' in configuration")

    # Build config object
    try:
        config = Config(
            typespec_compiled_path=typespec_compiled['path'],
            hand_authored=HandAuthoredConfig(
                searchservice_path=hand_authored['searchservice']['path'],
                searchindex_path=hand_authored['searchindex']['path'],
                knowledgebase_path=hand_authored['knowledgebase']['path'],
                common_types_path=hand_authored['common_types']['path'],
            ),
            output_path=output['path']
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
        ('TypeSpec compiled file', config.typespec_compiled_path),
        ('Hand-authored searchservice file', config.hand_authored.searchservice_path),
        ('Hand-authored searchindex file', config.hand_authored.searchindex_path),
        ('Hand-authored knowledgebase file', config.hand_authored.knowledgebase_path),
        ('Common types file', config.hand_authored.common_types_path),
    ]

    missing_files = []
    for name, path in paths_to_check:
        if not os.path.exists(path):
            missing_files.append(f"{name}: {path}")
        elif not os.path.isfile(path):
            missing_files.append(f"{name} is not a file: {path}")

    if missing_files:
        raise ConfigError("Missing or invalid files:\n" + "\n".join(f"  - {f}" for f in missing_files))

    # Ensure output directory exists or can be created
    output_dir = Path(config.output_path)
    try:
        output_dir.mkdir(parents=True, exist_ok=True)
    except Exception as e:
        raise ConfigError(f"Cannot create output directory {config.output_path}: {e}")