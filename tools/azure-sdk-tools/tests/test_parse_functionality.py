"""Test functionality for parsing pyproject.toml files and extracting namespace information."""

import os
import logging
import tempfile
import unittest
from unittest.mock import patch, mock_open


INIT_PY_FILE = "__init__.py"
INIT_EXTENSION_SUBSTRING = ".extend_path(__path__, __name__)"


class PackageParser:
    """Parser for extracting package information from SDK packages."""
    
    def __init__(self):
        self.namespace = None
    
    def _find_modules(self, pkg_root_path):
        """Find modules within the package to import and parse
        :param str: pkg_root_path
            Package root path
        :rtype: list
        """
        modules = []
        for root, subdirs, files in os.walk(pkg_root_path):
            # Ignore any modules with name starts with "_"
            # For e.g. _generated, _shared etc
            # Ignore build, which is created when installing a package from source.
            # Ignore tests, which may have an __init__.py but is not part of the package.
            dirs_to_skip = [x for x in subdirs if x.startswith(("_", ".", "test", "build"))]
            for d in dirs_to_skip:
                logging.debug("Dirs to skip: {}".format(dirs_to_skip))
                subdirs.remove(d)
            if INIT_PY_FILE in files:
                module_name = os.path.relpath(root, pkg_root_path).replace(
                    os.path.sep, "."
                )
                # If namespace has not been set yet, try to find the first __init__.py that's not purely for extension.
                if not self.namespace:
                    self._set_root_namespace(
                        os.path.join(root, INIT_PY_FILE), module_name
                    )

                modules.append(module_name)
                # Add any public py file names as modules
                sub_modules = [
                    os.path.splitext(os.path.basename(f))[0]
                    for f in files
                    if f.endswith(".py") and not os.path.basename(f).startswith("_")
                ]
                modules.extend(["{0}.{1}".format(module_name, x) for x in sub_modules])

        logging.debug("Modules in package: {}".format(modules))
        return sorted(modules)

    def _set_root_namespace(self, init_file_path, module_name):
        """Set the root namespace by examining the __init__.py file."""
        with open(init_file_path, "r") as f:
            in_docstring = False
            content = []
            for line in f:
                stripped_line = line.strip()
                # If in multi-line docstring, skip following lines until end of docstring.
                # If single-line docstring, skip the docstring line.
                if stripped_line.startswith(('"""', "'''")) and not stripped_line.endswith(('"""', "'''")):
                    in_docstring = not in_docstring
                # If comment, skip line. Otherwise, add to content.
                if not in_docstring and not stripped_line.startswith("#"):
                    content.append(line)
            if len(content) > 1 or (
                len(content) == 1 and not INIT_EXTENSION_SUBSTRING in content[0]
            ):
                self.namespace = module_name


def parse_pyproject(package_name, package_root_path):
    """Parse pyproject.toml and extract package information including proper namespace.
    
    :param str package_name: The package name (e.g., azure-eventhub-checkpointstoreblob)
    :param str package_root_path: The root path of the package
    :return: Dictionary containing package information including namespace
    :rtype: dict
    """
    parser = PackageParser()
    
    # First, try to discover the namespace by examining the package structure
    if os.path.exists(package_root_path):
        parser._find_modules(package_root_path)
    
    # If namespace discovery failed, fall back to the simple replacement method
    # This should ideally not happen with proper package structure
    if not parser.namespace:
        name_space = package_name.replace('-', '.')
    else:
        name_space = parser.namespace
    
    return {
        "package_name": package_name,
        "namespace": name_space,
        "package_root": package_root_path
    }


class TestParseFunctionality(unittest.TestCase):
    """Test cases for parse functionality."""

    def test_parse_pyproject_simple_replacement(self):
        """Test that simple replacement still works for packages without complex structure."""
        with tempfile.TemporaryDirectory() as temp_dir:
            package_name = "azure-simple-package"
            result = parse_pyproject(package_name, temp_dir)
            
            self.assertEqual(result["package_name"], package_name)
            self.assertEqual(result["namespace"], "azure.simple.package")

    def test_parse_pyproject_eventhub_checkpointstoreblob(self):
        """Test namespace discovery for azure-eventhub-checkpointstoreblob package."""
        with tempfile.TemporaryDirectory() as temp_dir:
            # Create the directory structure for azure-eventhub-checkpointstoreblob
            package_name = "azure-eventhub-checkpointstoreblob"
            
            # Create the expected directory structure
            azure_dir = os.path.join(temp_dir, "azure")
            eventhub_dir = os.path.join(azure_dir, "eventhub")
            extensions_dir = os.path.join(eventhub_dir, "extensions")
            checkpointstoreblob_dir = os.path.join(extensions_dir, "checkpointstoreblob")
            
            os.makedirs(checkpointstoreblob_dir)
            
            # Create __init__.py files
            # azure/__init__.py (extension only)
            with open(os.path.join(azure_dir, "__init__.py"), "w") as f:
                f.write('__path__ = __import__("pkgutil").extend_path(__path__, __name__)\n')
            
            # azure/eventhub/__init__.py (extension only)
            with open(os.path.join(eventhub_dir, "__init__.py"), "w") as f:
                f.write('__path__ = __import__("pkgutil").extend_path(__path__, __name__)\n')
            
            # azure/eventhub/extensions/__init__.py (extension only)
            with open(os.path.join(extensions_dir, "__init__.py"), "w") as f:
                f.write('__path__ = __import__("pkgutil").extend_path(__path__, __name__)\n')
            
            # azure/eventhub/extensions/checkpointstoreblob/__init__.py (actual package content)
            with open(os.path.join(checkpointstoreblob_dir, "__init__.py"), "w") as f:
                f.write('"""Azure Event Hub Checkpoint Store Blob package."""\n')
                f.write('from .version import VERSION\n')
                f.write('\n')
                f.write('__version__ = VERSION\n')
            
            result = parse_pyproject(package_name, temp_dir)
            
            self.assertEqual(result["package_name"], package_name)
            self.assertEqual(result["namespace"], "azure.eventhub.extensions.checkpointstoreblob")

    def test_parse_pyproject_extension_only_namespace(self):
        """Test that packages with only extension __init__.py files fall back correctly."""
        with tempfile.TemporaryDirectory() as temp_dir:
            package_name = "azure-test-extension"
            
            # Create directory with only extension __init__.py
            azure_dir = os.path.join(temp_dir, "azure")
            test_dir = os.path.join(azure_dir, "test")
            
            os.makedirs(test_dir)
            
            # Create extension-only __init__.py files
            with open(os.path.join(azure_dir, "__init__.py"), "w") as f:
                f.write('__path__ = __import__("pkgutil").extend_path(__path__, __name__)\n')
            
            with open(os.path.join(test_dir, "__init__.py"), "w") as f:
                f.write('__path__ = __import__("pkgutil").extend_path(__path__, __name__)\n')
            
            result = parse_pyproject(package_name, temp_dir)
            
            self.assertEqual(result["package_name"], package_name)
            # Should fall back to simple replacement since no substantial __init__.py found
            self.assertEqual(result["namespace"], "azure.test.extension")

    def test_parse_pyproject_real_eventhub_checkpointstoreblob(self):
        """Test namespace discovery using the actual SDK directory structure."""
        # Get the current script directory and navigate to the SDK structure
        current_dir = os.path.dirname(os.path.abspath(__file__))
        repo_root = os.path.dirname(os.path.dirname(os.path.dirname(current_dir)))
        sdk_path = os.path.join(repo_root, "sdk", "eventhub", "azure-eventhub-checkpointstoreblob")
        
        if os.path.exists(sdk_path):
            package_name = "azure-eventhub-checkpointstoreblob"
            result = parse_pyproject(package_name, sdk_path)
            
            self.assertEqual(result["package_name"], package_name)
            self.assertEqual(result["namespace"], "azure.eventhub.extensions.checkpointstoreblob")
        else:
            # Skip if the SDK structure doesn't exist
            self.skipTest(f"SDK structure not found at {sdk_path}")


if __name__ == "__main__":
    unittest.main()