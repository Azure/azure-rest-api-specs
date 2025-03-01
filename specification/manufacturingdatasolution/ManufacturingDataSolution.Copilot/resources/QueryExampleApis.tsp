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
// #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
// #suppress "@azure-tools/typespec-azure-core/use-standard-names" ""
// @versioned(MdsSolution.CopilotService.Versions)
// namespace MdsSolution.CopilotService.ExampleQueryService {
//   alias ServiceTraits = SupportsRepeatableRequests &
//     SupportsConditionalRequests &
//     SupportsClientRequestId;

//   alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

//   @route("/dmm/copilot")
//   namespace ExampleQueryService {
//     /**
//      * Create an example query.
//      * @param exampleQuery The example query to create.
//      */
//     @put
//     @route("/v3/exampleQuery")
//     op createExampleQuery(
//       @body exampleQuery: ExampleQuery,
//     ): Operations.ResourceRead<ExampleQueryList> | BadRequestResponse;

//     /**
//      * Update an example query.
//      * @param exampleId The ID of the example query to update.
//      * @param exampleQueryPatchRequest The patch request for the example query.
//      */
//     @patch
//     @route("/v3/exampleQuery/{exampleId}")
//     op updateExampleQuery(
//       @path exampleId: string,
//       @body exampleQueryPatchRequest: ExampleQueryPatchRequest,
//     ): Operations.ResourceRead<ExampleQuery> | BadRequestResponse | NotFoundResponse;

//     /**
//      * Get an example query.
//      * @param exampleId The ID of the example query to get.
//      */
//     @get
//     @route("/v3/exampleQuery/{exampleId}")
//     op getExampleQuery(
//       @path exampleId: string,
//     ): Operations.ResourceRead<ExampleQuery> | NotFoundResponse;

//     /**
//      * Get all example queries.
//      */
//     @get
//     @route("/v3/exampleQuery")
//     op getAllExampleQueries(): Operations.ResourceRead<ExampleQueryList>;

//     /**
//      * Delete an example query.
//      * @param exampleId The ID of the example query to delete.
//      */
//     @delete
//     @route("/v3/exampleQuery/{exampleId}")
//     op deleteExampleQuery(
//       @path exampleId: string,
//     ): Operations.ResourceDelete<{}> | NotFoundResponse;
//   }
// }
