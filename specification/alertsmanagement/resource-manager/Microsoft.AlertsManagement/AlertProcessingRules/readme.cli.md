## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  namespace: azure.mgmt.alertprocessingrules
  test-scenario:
    - name: /ActionRules/put/PutActionRule
    - name: /ActionRules/get/GetActionRuleById
    - name: /ActionRules/get/GetActionRulesResourceGroupWide
    - name: /ActionRules/get/GetActionRulesSubscriptionWide
    - name: /ActionRules/patch/PatchActionRule
    - name: /ActionRules/delete/DeleteActionRule
```
