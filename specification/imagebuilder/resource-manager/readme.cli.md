## CLI

These settings apply only when `--cli` is specified on the command line.

``` yaml $(cli)
cli:
  namespace: azure.mgmt.imagebuilder
  flatten-all: true
  test-scenario:
    - name: Create an Image Template.
    - name: Create an Image Template with a user assigned identity configured
    - name: Retrieve single runOutput
    - name: Retrieve a list of all outputs created by the last run of an Image Template
    - name: Retrieve an Image Template.
    - name: List images by resource group
    - name: List images by subscription.
    - name: Create image(s) from existing imageTemplate.
    - name: Remove identities for an Image Template.
    - name: Update the tags for an Image Template.
    - name: Delete an Image Template.
```
