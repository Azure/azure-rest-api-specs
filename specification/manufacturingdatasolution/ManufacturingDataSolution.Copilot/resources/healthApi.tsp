// import "@typespec/rest";
// import "@typespec/http";
// import "@typespec/openapi3";
// import "@typespec/versioning";
// import "@azure-tools/typespec-azure-core";

// using TypeSpec.Rest;
// using TypeSpec.Http;
// using Azure.Core;
// using Azure.Core.Traits;
// using TypeSpec.Versioning;

// #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" ""
// #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
// @versioned(MdsSolution.CopilotService.Versions)
// namespace MdsSolution.CopilotService.Health {
//   alias DefaultServiceTraits = NoRepeatableRequests &
//     NoConditionalRequests &
//     NoClientRequestId;
//   alias AzureCoreOperations = Azure.Core.ResourceOperations<DefaultServiceTraits>;
//   @route("/dmm/copilot")
//   namespace Health {
//     @get
//     @route("/health")
//     @doc("Get the health status of the service.")
//     op getHealthStatus(): {
//       @statusCode statusCode: 200;
//       @body data: QueryResponseResult;
//     };
//   }
// }
