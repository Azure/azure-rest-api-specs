# Service Onboard DPG with Swagger CI Pipeline

Service Onboarding DPG with Swagger CI pipeline can help you get generated SDK and ApiView during the procedure of creating swagger PR.

This Document describes the process of how to onboard DPG with SDK automation pipeline. __This document is targeting for service team.__ 

*If you want to go through details of pipeline implementation, please go to [Integrate DPG and ApiView in SDK Automation Pipeline](Integrate-dpg-and-apiview-in-sdk-automation-pipeline.md).*

## WorkFlow

![workflow-for-service-team](workflow-service-team.png)

__Description:__
1. Creates a swagger PR.
2. If the service has onboarded DPG before, please go to step 4. Otherwise, please go to step 3.
3. Create branch with name `dpg/<prNumber>` in sdk repository, and add `autorest.md` or `README.md`. Then add a comment `/azp run` in swagger PR.
   1. `<prNumber>` is the PR number of swagger PR.
   2. About how to add `autorest.md` or `README.md`, please refer to [Add autorest configuration in sdk repository](./add-autorest-configuration-in-sdk-repository.md).
4. Swagger PR CI generates SDK and ApiView automatically, and you can find them in swagger PR comments.
5. Ask Arch Board to review the generated ApiView.
6. If Arch Board approves the ApiView, go to step 10. Otherwise, go to step 7.
7. Update Swagger if needed.
8. Update `autorest.md` or `README.md` if needed. Here, if there is a branch named `dpg/<prNumber>` in sdk repository, please update it in the branch. Otherwise update it in main branch.
9. Add a comment `/azp run` in swagger PR, and go to step 4.
10. Get the generated SDK and do some manual changes, such as adding samples/tests to it.
    1. Swagger PR CI creates a PR for generated SDK, and you can find it in comment `[Swagger Generation Artifacts]->[sdk-repository-name]->[Preview SDK changes]`. For example: `[Swagger Generation Artifacts]->[azure-sdk-for-js]->[Preview SDK changes]`.
    2. About what manual changes you need to do, please refer to [Next Steps After Generating Codes](./next-steps-after-generating-codes.md).
11. Create a PR to sdk repository and ask SDK owner to review it.

## FAQ
1. I don't have permission to create branch in sdk repository. Who can I ask for help?
    
    __Answer__: Please ask sdk owners for help. SDK owner list:
   1. .Net: chunyu3, pshao25, fengzhou-msft.
   2. Java: weidongxu-microsoft, haolingdong-msft
   3. Python: msyyc, changlong-liu
   4. JS: qiaozha, MaryGao
   
2. What should I do when I encounter error in generating SDK in swagger PR CI pipeline?
   
    __Answer__: Please check the comment [Swagger Generation Artifacts] and the error message of failed pipeline. If you find the error messages ask you to fix `autorest.md`/`README.md`/swagger, please fix it. If you cannot understand error message, please ask sdk owners for help.