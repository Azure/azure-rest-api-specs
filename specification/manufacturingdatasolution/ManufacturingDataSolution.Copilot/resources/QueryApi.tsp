// import "@typespec/rest";
// import "@typespec/http";
// import "@typespec/openapi3";
// import "@typespec/versioning";
// import "@azure-tools/typespec-azure-core";
// import "./../models/copilotmodels.tsp";
// import "./../models/common.tsp";

// using TypeSpec.Rest;
// using TypeSpec.Http;
// using CopilotModels;
// using CopilotCommon;
// using Azure.Core;
// using Azure.Core.Traits;
// using TypeSpec.Versioning;

// #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" ""
// #suppress "@azure-tools/typespec-azure-core/documentation-required" ""
// #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
// @versioned(MdsSolution.CopilotService.Versions)
// namespace MdsSolution.CopilotService.QueryApis {
//   alias ServiceTraits = SupportsRepeatableRequests &
//     SupportsConditionalRequests &
//     SupportsClientRequestId;

//   alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

//   @route("/dmm/copilot/v3/")
//   namespace QueryApis {
//     @route("/query")
//     @post
//     op getQueryResult(
//       ...QueryApiParams,
//       @body request: QueryRequest,
//     ): Operations.ResourceRead<
//       QueryResponseResult,
//       ResponseHeadersTrait<CommonHeaders>
//     > | BadRequestResponse | TooManyRequestsResponse;

//     @post
//     @route("/feedback")
//     op feedback(
//       @body request: CopilotFeedbackRequest,
//     ): Operations.GetResourceOperationStatus<
//       OkResponse,
//       ResponseHeadersTrait<{
//         @header("Operation-Id")
//         operationId?: string;

//         @header("Conversation-Id")
//         conversationId?: string;

//         @header("AcceptLanguage")
//         acceptLanguage?: string;
//       }>
//     >;

//     @route("/validate")
//     @post
//     op validate(
//       @body request: ValidateRequest,
//     ): Operations.LongRunningResourceCreateOrUpdate<ValidateResponse> | BadRequestResponse;

//     @route("/validate/test/{validateTestId}")
//     @get
//     op getValidateTestDetails(
//       @path validateTestId: string,
//     ): Operations.ResourceRead<CommonOkResponse<ValidateTestDetailsResponse>> | NotFoundResponse;

//     @route("/validate/test")
//     @get
//     op listValidateTestRequests(
//       ...ValidateApiParams,
//     ): Operations.ResourceList<ValidateTestSummary> | NoContentResponse;
//   }
// }
