Hello & Welcome to our repo,

If you're a Microsoft Employee, please review and ensure that the following steps have been taken:

- Is this a PR for a new management (RP or New API Version)? (If your answer is Yes then if you haven't done so already contant the ARM team for review).
- If this a new Data-Plane Swagger, have you gone through an review from the API review board? (If you're answer is no then contant the API review board to have it reviwed)
- Is the API that this Swagger rrepresents already Live? (If not then you shouldn't be sending this to the Master branch of the Public repo or add [Do Not Merge until MM-DD-YYY]). the PR will still be reviewed and approved eventually bust merging will happen on your notification that the service is now launched.

**What's happening to your PR now**

The following validation tools are currently running in the following order in the CI and the results will be posted in the travis Job results at the bottom of this page shortly. to run these tools next time on your machine, click on the "Run it locally" link below to see the instructions.

 |
 | - > **Semantic Validator** ([Run it locally](https://github.com/Azure/adx-documentation-pr/wiki/Azure-Swagger-Tools#semantic-validator))
 
 |
 | - > **Azure Linter** ([Run it locally](https://github.com/Azure/adx-documentation-pr/wiki/Azure-Swagger-Tools#azure-linter))
 |
 | - > **Model Validation** ([Run it locally](https://github.com/Azure/adx-documentation-pr/wiki/Azure-Swagger-Tools#model-validator))
 V
