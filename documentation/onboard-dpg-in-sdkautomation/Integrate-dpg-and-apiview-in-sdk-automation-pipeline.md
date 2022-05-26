# Integrate DPG and ApiView in SDK Automation Pipeline
This document is targeting for everyone who wants to know all the implementation details of SDK automation pipeline.
It describes the details of integrating DPG and ApiView in SDK Automation Pipeline.

Before go through this document, please go through [Service Onboard DPG with Swagger CI Pipeline](README.md) to be familiar with the user experience in service team side. Also, you need to be familiar with [SDK Automation Pipeline Framework](../sdkautomation/README.md).

# WorkFlow
![integrate-dpg-and-apiview](integrate-dpg-and-apiview.png)

__Description:__
1. SDK Automation Pipeline is triggered in spec PR CI.
2. SDK Automation Pipeline Framework checks whether there is a comment containing autorest configuration in spec PR. If found, generate sdk by the autorest configuration in comment.
Otherwise, sdk automation pipeline will try to find if there is autorest configuration file in sdk repo. If found, generate sdk with the founded autorest configuration file. If not found, pipeline stops.
   1. When there is a comment containing autorest configuration file, sdk automation pipeline will extract the autorest configuration from the comment, and let automation script use it to generate a new autorest configuration file, and use the new generated autorest configuration file to generate SDK.
   2. When using the autorest configuration file found in sdk repository to generate SDK, SDK automation script need to modify the autorest configuration file in the SDK repo.
      1. If `require` block is used, change the `require` block to include the latest swagger `readme.md` in the PR. The value can be joined by relative path from package folder to sdk root, `specFolder` and `relatedReadmeMdFiles` in `generateInput.json`. For example:
         ```yaml
         require:
           - ../../../../../azure-rest-api-specs/specification/deviceupdate/data-plane/readme.md
         ```
      2. If `input-file` is used, replace the value of `input-file` to include the latest swagger in the PR. The value can be calculated similar as `require` block.
      (We will use `require` block in most times, but we still need to use `input-file` for .Net automation and multi-client for python, java and js sdk.)
3. After generating SDK, SDK automation pipeline generates ApiView and then add comments about results to the Swagger PR.

# Future Work
Currently, we ask service team must add a comment containing autorest configuration in spec PR when new service onboards DPG.
In the future, we are going to integrate it with PowerAPP Workflow. Then service team can provide the necessary information in PowerAPP Workflow, and the information will be added to spec PR automatically. 