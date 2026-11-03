import "@azure-tools/typespec-foundry-core";

// REST entrypoints use ranged errors; SDK entrypoints substitute error.default.tsp.
/** Error response for Azure range errors. */
alias AzureRangeErrorResponse<ErrorResponseParameter = Azure.Core.Foundations.ErrorResponse> = Microsoft.Foundry.Core.AzureRangeErrorResponse<ErrorResponseParameter>;
