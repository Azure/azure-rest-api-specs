## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: automation
  namespace: azure.mgmt.automation
  package-name: azure-mgmt-automation
directive: 
  - where: 
      command: automation runbook create
      parameter-name: description 
    set:
      description: Description of the runbook.
  - where: 
      command: automation runbook create
      parameter-name: log-activity-trace
    set:
      description: "activity-level tracing options of the runbook. Allowed values: 0, 1, 2."
  - where: 
      command: automation runbook create
      parameter-name: type
    set:
      description: Type of the runbook
  - where: 
      command: automation runbook create
      parameter-name: name
    set:
      alias: runbook-name, n
az-output-folder: $(azure-cli-extension-folder)/src/automation
python-sdk-output-folder: "$(az-output-folder)/azext_automation/vendored_sdks/automation"