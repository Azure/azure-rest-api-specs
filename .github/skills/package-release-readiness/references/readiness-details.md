# Package Release Readiness Details

## Readiness Check Results

The `azsdk_release_sdk` tool with `checkReady: true` checks:
- API review status
- Changelog status
- Package name approval (if new preview package)
- Release date in release tracker

## Issue Resolution

- **Missing changelog:** Run `azsdk_package_update_changelog_content`
- **Missing metadata:** Run `azsdk_package_update_metadata`
- **Version issues:** Run `azsdk_package_update_version`
- **Validation failures:** Run `azsdk_package_run_check` to identify specific issues

## Release Process

1. Confirm with user before releasing
2. Run `azsdk_release_sdk` to trigger the release pipeline
3. Instruct user to approve the release stage in the pipeline
4. Warn that package will be published to public registries once approved
