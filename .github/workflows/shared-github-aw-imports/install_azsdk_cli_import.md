---
# No `on:` here — this is a shared component meant to be imported.
description: Install Azure SDK CLI tool
steps:
  - name: Checkout code
    uses: actions/checkout@v6
    with:
      persist-credentials: false

  - name: Install azsdk mcp server
    shell: pwsh
    run: |
      ./eng/common/mcp/azure-sdk-mcp.ps1 -InstallDirectory /tmp/bin
---

## Workflow Behavior

Set azsdk path to PATH

- Add `$AZSDK_CLI_PATH` to `PATH`
- Verify `azsdk` cli is accessible
