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

// @versioned(MdsSolution.CopilotService.Versions)
// namespace MdsSolution.CopilotService.OperationStatus {
//   alias DefaultServiceTraits = NoRepeatableRequests &
//     NoConditionalRequests &
//     NoClientRequestId;
//   alias AzureCoreOperations = Azure.Core.ResourceOperations<DefaultServiceTraits>;

//   namespace OperationStatus {
//     /**
//      * Get the status of an operation.
//      * @param operationId The ID of the operation to get the status for.
//      */
//     #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" ""
//     #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
//     @get
//     @route("/dmm/copilot/v3/operations/{operationId}")
//     @added(MdsSolution.CopilotService.Versions.V3)
//     op getOperationStatus(
//       @path operationId: string,
//     ): AzureCoreOperations.ResourceRead<OperationResponseModel> | NotFoundResponse;
//   }
// }
