## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  namespace: azure.mgmt.alertprocessingrules
  test-scenario:
    - name: /AlertProcessingRules/put/Create or update an alert processing rule that adds an action group to all Sev0 and Sev1 alerts in a subscription
    - name: /AlertProcessingRules/put/Create or update an alert processing rule that adds an action group to all alerts in a subscription
    - name: /AlertProcessingRules/put/Create or update an alert processing rule that adds an action group to all alerts in a resource group
    - name: /AlertProcessingRules/put/Create or update an alert processing rule that adds an action group to all VM alerts in a subscription
    - name: /AlertProcessingRules/put/Create or update an alert processing rule that removes all action groups from alerts on a specific VM for a recurring maintenance window (1800-0600)
    - name: /AlertProcessingRules/put/Create or update an alert processing rule that removes all action groups from all alerts in a subscription coming from a specific alert rule
    - name: /AlertProcessingRules/put/Create or update an alert processing rule that removes all action groups outside business hours (Mon-Fri 09:00-17:00, UTC+05:30)
    - name: /AlertProcessingRules/get/GetAlertProcessingRuleById
    - name: /AlertProcessingRules/get/GetAlertProcessingRulesResourceGroupWide
    - name: /AlertProcessingRules/get/GetAlertProcessingRulesSubscriptionWide
    - name: /AlertProcessingRules/patch/PatchAlertProcessingRule
    - name: /AlertProcessingRules/delete/DeleteAlertProcessingRule
    - name: /ActionRules/put/PutActionRule
    - name: /ActionRules/get/GetActionRuleById
    - name: /ActionRules/get/GetActionRulesResourceGroupWide
    - name: /ActionRules/get/GetActionRulesSubscriptionWide
    - name: /ActionRules/patch/PatchActionRule
    - name: /ActionRules/delete/DeleteActionRule
