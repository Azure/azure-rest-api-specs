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
    - name: Creates an NetworkExperiment Profile in a Resource Group
    - name: Creates an Experiment
    - name: List NetworkExperiment Profiles in a Resource Group
    # - name: Updates an Experiment
    - name: Gets an NetworkExperiment Profile by Profile Id
    - name: Gets an Experiment by ExperimentName
    - name: Gets a list of Experiments
    - name: Gets a list of Preconfigured Endpoints
    - name: Gets a Latency Scorecard for a given Experiment
    - name: Gets a Timeseries for a given Experiment
    - name: Deletes an Experiment
    - name: Deletes an NetworkExperiment Profile by ProfileName

```
