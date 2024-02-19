## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: codesigning
    namespace: azure.mgmt.codesigning
    package-name: azure-mgmt-codesigning
    randomize-names: true
az-output-folder: $(azure-cli-extension-folder)/src/codesigning
python-sdk-output-folder: "$(az-output-folder)/azext_codesigning/vendored_sdks/codesigning"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details

directive:
  - where:
     group: codesigning code-signing-account
    set:
     group: codesigning

cli:
  cli-directive:
    - where:
        group: Operations
      hidden: true
    - where:
        group: CodeSigningAccount
        param: accountName
      name: name
      alias:
        - name
        - n
    - where:
        group: CertificateProfile
        param: profileName
      name: name
      alias:
        - name
        - n
      

```