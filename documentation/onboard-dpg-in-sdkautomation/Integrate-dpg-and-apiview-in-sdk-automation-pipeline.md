# Integrate DPG and ApiView in SDK Automation Pipeline
This document is targeting for everyone who wants to know all the implementation details of SDK automation pipeline.
It describes the details of integrating DPG and ApiView in SDK Automation Pipeline.

Before go through this document, please go through [Service Onboard DPG with Swagger CI Pipeline](README.md) to be familiar with the user experience in service team side. Also, you need to be familiar with [SDK Automation Pipeline Framework](../sdkautomation/README.md).

# WorkFlow
![integrate-dpg-and-apiview](integrate-dpg-and-apiview.png)

__Description:__
1. There is swagger PR triggering the SDK Automation Pipeline.
2. SDK Automation Pipeline Framework checks whether there is a branch named `dpg/<prNumber>` in sdk repository. If yes, the branch `dpg/<prNumber>` will be used as base branch to generate SDK. Otherwise, `main` branch will be used as base branch.
   1. `<prNumber>` is the swagger PR number.
   2. If there is branch `dpg/<prNumber>`, `main` branch is usually used and sometimes not. It depends on the [specificationRepositoryConfiguration](../../specificationRepositoryConfiguration.json).
3. SDK automation script finds the corresponding `autorest.md` or `README.md` in sdk repository. If there is no `autorest.md` or `README.md` founded, please output `{"packages": []}` in `generateOutput.json`, then the pipeline finishes and skipp the following steps.
   1. A relative readme.md and changedFiles of the swagger PR can be get in `generateInput.json`, and automation script can use it to find the corresponding `autorest.md` and `README.md`.
   2. We will only use `require` to include swagger readme.md in `autorest.md` or `README.md`, and `input-file` should not be used in `autorest.md` or `README.md` in most times, but there are some exceptions:
      1. .Net SDK may continue to use `input-file` because existing HLC dataplane sdk may already use `input-file`.
      2. Multi-Client for Java, Python and JS cannot use `readme.md` in swagger directly because they use `batch` task, so using `input-file` is better.
4. SDK automation script modifies the founded `autorest.md` or `README.md`.
   1. Change the `require` block to include the latest swagger `readme.md` in the PR. The value can be joined by `specFolder` and `relatedReadmeMdFiles` in `generateInput.json`. For example:
      ```yaml
      require:
        - ../../../../../azure-rest-api-specs/specification/deviceupdate/data-plane/readme.md
      ```
5. SDK automation script generates SDK with the modified `autorest.md` or `README.md`.
6. SDK Automation Pipeline Framework creates ApiView based on the generated SDK.
7. Add comments about the sdk generation result and created ApiView to swagger PR.