import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

/** Error response for Azure range errors. */
alias AzureRangeErrorResponse<ErrorResponseParameter = Azure.Core.Foundations.ErrorResponse> = ErrorResponseParameter;

@@clientName(OpenAI._MisalignmentSteer, "MisalignmentSteer");
@@clientName(OpenAI._MisalignmentErrorType, "MisalignmentErrorType");
