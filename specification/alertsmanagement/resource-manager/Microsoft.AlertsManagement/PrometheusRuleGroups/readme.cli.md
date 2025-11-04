## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  namespace: azure.mgmt.prometheusrulegroups
  test-scenario:
    - name: /PrometheusRuleGroups/put/Create or update a Prometheus rule group
    - name: /PrometheusRuleGroups/get/Get a Prometheus rule group
    - name: /PrometheusRuleGroups/get/List Prometheus rule groups by resource group
    - name: /PrometheusRuleGroups/get/List Prometheus rule groups by subscription
    - name: /PrometheusRuleGroups/patch/Update a Prometheus rule group
    - name: /PrometheusRuleGroups/delete/Delete a Prometheus rule group
```
