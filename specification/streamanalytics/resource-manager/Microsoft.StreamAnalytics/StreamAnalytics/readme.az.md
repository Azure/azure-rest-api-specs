## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  extensions: stream-analytics
  package-name: azure-mgmt-streamanalytics
  namespace: azure.mgmt.streamanalytics
az-output-folder: $(azure-cli-extension-folder)/src/stream-analytics
python-sdk-output-folder: "$(az-output-folder)/azext_stream_analytics/vendored_sdks/streamanalytics"
sdk-no-flatten: true
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
directive:
# simplify group name
  - where:
      group: stream-analytics streaming-job
    set:
      group: stream-analytics job
# simplify `create-or-replace` with `create`
  - where:
      command: stream-analytics function create-or-replace
    set:
      command: stream-analytics function create
  - where:
      command: stream-analytics input create-or-replace
    set:
      command: stream-analytics input create
  - where:
      command: stream-analytics output create-or-replace
    set:
      command: stream-analytics output create
  - where:
      command: stream-analytics job create-or-replace
    set:
      command: stream-analytics job create
  - where:
      command: stream-analytics transformation create-or-replace
    set:
      command: stream-analytics transformation create
# simplify retrieval-related commands with `inspect`
  - where:
      command: stream-analytics function retrieve-default-definition
    set:
      command: stream-analytics function inspect
  - where:
      command: stream-analytics subscription list-quota
    set:
      command: stream-analytics subscription inspect

cli:
  cli-directive:
# add alias to `--job-name`
    - where:
        group: StreamingJobs
        op: CreateOrReplace
        parameter: jobName
      alias:
        - job_name
        - name
        - n
    - where:
        group: StreamingJobs
        op: Update
        parameter: jobName
      alias:
        - job_name
        - name
        - n
    - where:
        group: StreamingJobs
        op: Get
        parameter: jobName
      alias:
        - job_name
        - name
        - n
    - where:
        group: StreamingJobs
        op: Delete
        parameter: jobName
      alias:
        - job_name
        - name
        - n
    - where:
        group: StreamingJobs
        op: Start
        parameter: jobName
      alias:
        - job_name
        - name
        - n
    - where:
        group: StreamingJobs
        op: Scale
        parameter: jobName
      alias:
        - job_name
        - name
        - n
    - where:
        group: StreamingJobs
        op: Stop
        parameter: jobName
      alias:
        - job_name
        - name
        - n
# add alias to `--input-name`
    - where:
        group: Inputs
        op: CreateOrReplace
        parameter: inputName
      alias:
        - input_name
        - name
        - n
    - where:
        group: Inputs
        op: Update
        parameter: inputName
      alias:
        - input_name
        - name
        - n
    - where:
        group: Inputs
        op: Delete
        parameter: inputName
      alias:
        - input_name
        - name
        - n
    - where:
        group: Inputs
        op: Get
        parameter: inputName
      alias:
        - input_name
        - name
        - n
    - where:
        group: Inputs
        op: Test
        parameter: inputName
      alias:
        - input_name
        - name
        - n
# add alias to `--output-name`
    - where:
        group: Outputs
        op: CreateOrReplace
        parameter: outputName
      alias:
        - output_name
        - name
        - n
    - where:
        group: Outputs
        op: Update
        parameter: outputName
      alias:
        - output_name
        - name
        - n
    - where:
        group: Outputs
        op: Delete
        parameter: inputName
      alias:
        - output_name
        - name
        - n
    - where:
        group: Outputs
        op: Get
        parameter: outputName
      alias:
        - output_name
        - name
        - n
    - where:
        group: Outputs
        op: Test
        parameter: outputName
      alias:
        - output_name
        - name
        - n
# add alias to `--function-name`
    - where:
        group: Functions
        op: CreateOrReplace
        parameter: functionName
      alias:
        - function_name
        - name
        - n
    - where:
        group: Functions
        op: Test
        parameter: functionName
      alias:
        - function_name
        - name
        - n
    - where:
        group: Functions
        op: Update
        parameter: functionName
      alias:
        - function_name
        - name
        - n
# add alias to `--transformation-name`
    - where:
        group: Transformations
        op: CreateOrReplace
        parameter: transformationName
      alias:
        - transformation_name
        - name
        - n
    - where:
        group: Transformations
        op: Update
        parameter: transformationName
      alias:
        - transformation_name
        - name
        - n
# rename `--query` to `--saql`
    - where:
        group: Transformations
        op: CreateOrReplace
        parameter: query
      name: saql
    - where:
        group: Transformations
        op: Update
        parameter: query
      name: saql
# simplify long parameters
    - where:
        group: StreamingJobs
        op: CreateOrReplace
        parameter: eventsOutOfOrderMaxDelayInSeconds
      name: order_max_delay
    - where:
        group: StreamingJobs
        op: Update
        parameter: eventsOutOfOrderMaxDelayInSeconds
      name: order_max_delay
    - where:
        group: StreamingJobs
        op: CreateOrReplace
        parameter: eventsLateArrivalMaxDelayInSeconds
      name: arrival_max_delay
    - where:
        group: StreamingJobs
        op: Update
        parameter: eventsLateArrivalMaxDelayInSeconds
      name: arrival_max_delay
    - where:
        group: StreamingJobs
        op: CreateOrReplace
        parameter: eventsOutOfOrderPolicy
      name: out_of_order_policy
    - where:
        group: StreamingJobs
        op: Update
        parameter: eventsOutOfOrderPolicy
      name: out_of_order_policy
# simplify long parameters within `inspect`
    - where:
        group: Functions
        op: RetrieveDefaultDefinition
      hidden: True
```
