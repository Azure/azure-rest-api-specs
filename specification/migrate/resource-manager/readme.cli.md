## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml 
cli:
  cli-name: migrate
  namespace: azure.mgmt.migrate
  package-name: azure-mgmt-migrate
  test-scenario:
    - name: LocationCheckNameAvailability_Available
    - name: LocationCheckNameAvailability_AlreadyExists
    - name: AssessmentOptions_Get
    - name: Projects_List
    - name: Projects_Get
    - name: Projects_Create
    - name: Projects_Update
    - name: Projects_Delete
    - name: Projects_GetKeys
    - name: Machines_ListByProject
    - name: Machines_Get
    - name: Groups_ListByProject
    - name: Groups_Get
    - name: Groups_Create
    - name: Groups_Delete
    - name: Assessments_ListByGroup
    - name: Assessments_ListByProject
    - name: Assessments_Get
    - name: Assessments_Create
    - name: Assessments_Delete
    - name: Assessments_GetReportDownloadUrl
    - name: AssessedMachines_ListByAssessment
    - name: AssessedMachines_Get
    - name: Operations_List
```
