## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  namespace: azure.mgmt.alertsmanagement
  test-scenario:
    - name: /ActionRules/put/PutActionRule
    - name: /SmartDetectorAlertRules/put/Create or update a Smart Detector alert rule
    - name: /SmartDetectorAlertRules/get/Get a Smart Detector alert rule
    - name: /ActionRules/get/GetActionRuleById
    - name: /SmartDetectorAlertRules/get/List alert rules
    - name: /ActionRules/get/GetActionRulesResourceGroupWide
    - name: /SmartGroups/get/Resolve
    - name: /SmartGroups/get/Get
    - name: /SmartDetectorAlertRules/get/List Smart Detector alert rules
    - name: /Alerts/get/GetById
    - name: /Alerts/get/Summary
    - name: /SmartGroups/get/List
    - name: /ActionRules/get/GetActionRulesSubscriptionWide
    - name: /Alerts/get/ListAlerts
    - name: /Alerts/get/MonService
    - name: /SmartDetectorAlertRules/patch/Patch alert rules
    - name: /ActionRules/patch/PatchActionRule
    - name: /SmartGroups/post/changestate
    - name: /Alerts/post/Resolve
    - name: /SmartDetectorAlertRules/delete/Delete a Smart Detector alert rule
    - name: /ActionRules/delete/DeleteActionRule
```
