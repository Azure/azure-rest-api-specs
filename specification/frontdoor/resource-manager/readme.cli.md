## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  cli-name: internet-analyzer
  namespace: azure.mgmt.frontdoor
  package-name: azure-mgmt-frontdoor
  debug: false
  # debug-cli: true
  cmd-override:
    "^.*frontdoor.*$": "-"
    "^.*[/]networkexperimentprofiles([/][^/]*)?$": "internet-analyzer profile"
    "^.*[/]networkexperimentprofiles[/].*[/]preconfiguredendpoints[/].*$": "internet-analyzer profile preconfigured-endpoint"
    "^.*[/]networkexperimentprofiles[/].*[/]experiments([/][^/]*)?$": "internet-analyzer test"
    "^.*[/]networkexperimentprofiles[/].*[/]experiments[/].*[/]latencyscorecard$": "internet-analyzer scorecard latency"
    "^.*[/]networkexperimentprofiles[/].*[/]experiments[/].*[/]timeseries$": "internet-analyzer scorecard timeseries"
  flatten-all: true
  option-override:
    "resource_state":
      readonly: true
    "etag":
      readonly: true
    "endpoint_a_name":
      doc: The name of the control endpoint
    "endpoint_b_name":
      doc: The name of the other endpoint
    "^.*$":
      doc-replace:
        "network experiment": "internet analyzer"
  test-setup:
    - name: Creates an NetworkExperiment Profile in a Resource Group
      title: Creates an Internet Analyzer Profile in a Resource Group
    - name: Creates an Experiment
      title: Creates a test
    - name: List NetworkExperiment Profiles in a Resource Group
    # - name: Updates an Experiment
    - name: Gets an NetworkExperiment Profile by Profile Id
      title: Gets an Internet Analyzer Profile by Profile Id
    - name: Gets an Experiment by ExperimentName
      title: Gets a test by name
    - name: Gets a list of Experiments
      title: Gets list of tests
    - name: Gets a list of Preconfigured Endpoints
    - name: Gets a Latency Scorecard for a given Experiment
    - name: Gets a Timeseries for a given Experiment
    - name: Deletes an Experiment
      title: Deletes a test
    - name: Deletes an NetworkExperiment Profile by ProfileName
      title: Deletes an Internet Analyzer Profile in a Resource Group
```
