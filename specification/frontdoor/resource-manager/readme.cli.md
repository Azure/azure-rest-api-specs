## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: internet-analyzer
  namespace: azure.mgmt.frontdoor
  package-name: azure-mgmt-frontdoor
  debug: false
  cmd-override:
    "^.*frontdoor.*$": "-"
    "^.*[/]networkexperimentprofiles([/][^/]*)?$": "internet-analyzer profile"
    "^.*[/]networkexperimentprofiles[/].*[/]preconfiguredendpoints[/].*$": "internet-analyzer profile preconfigured-endpoint"
    "^.*[/]networkexperimentprofiles[/].*[/]experiments([/][^/]*)?$": "internet-analyzer test"
    "^.*[/]networkexperimentprofiles[/].*[/]experiments[/].*[/]latencyscorecard$": "internet-analyzer scorecard latency"
    "^.*[/]networkexperimentprofiles[/].*[/]experiments[/].*[/]timeseries$": "internet-analyzer scorecard timeseries"
  adjustments:
    "/sku": "Sku*/"
    "/properties/endpointa": "endpointA_*/"
    "/properties/endpointb": "endpointB_*/"
  test-setup:
    - name: Create or Update a service with all parameters
```
