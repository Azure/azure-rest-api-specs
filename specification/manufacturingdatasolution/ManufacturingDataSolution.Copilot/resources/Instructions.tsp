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
// @versioned(MdsSolution.CopilotService.Versions)
// namespace MdsSolution.CopilotService.Instructions {
//   alias ServiceTraits = SupportsRepeatableRequests &
//     SupportsConditionalRequests &
//     SupportsClientRequestId;

//   alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

//   @route("/dmm/copilot")
//   namespace Instructions {
//     /**
//      * Get the instructions.
//      * @param showOnlyActive filter to show only active instructions. Default is false.
//      */
//     @route("/v3/instructions")
//     @get
//     @added(MdsSolution.CopilotService.Versions.V3)
//     op getInstructions(
//       @query("showOnlyActive") showOnlyActive: boolean = false,
//     ): Azure.Core.ResourceRead<InstructionInfoResponse> | NoContentResponse;

//     /**
//      * Get the instruction resource.
//      * @param instructionId The ID of the instruction to get the status for.
//      * @param version The version of the instruction to get the status for.
//      */
//     @route("/v3/instructions/{instructionId}")
//     @get
//     op getInstructionResource(
//       @path instructionId: string,
//       @query("version") version: string = "",
//     ): Azure.Core.ResourceRead<InstructionResponseModel> | NotFoundResponse;

//     /**
//      * Upsert instructions.
//      * @param instructionRequestList The list of instructions to create or update.
//      */
//     @route("/v3/instructions")
//     @put
//     op replaceOrInsertInstructions(
//       @body instructionRequestList: InstructionRequestModelList,
//     ): RpcOperation<
//       {},
//       {
//         statusCode: 202;
//       },
//       ServiceTraits
//     > | BadRequestResponse;

//     /**
//      * Patch instructions.
//      * @param instructionId The ID of the instruction to patch.
//      * @param instructionVersion The version of the instruction to patch.
//      * @param instructionPatchRequest The patch request.
//      */
//     @route("/v3/instructions/{instructionId}/versions/{instructionVersion}")
//     @patch
//     op patchInstruction(
//       @path instructionId: string,
//       @path instructionVersion: string,
//       @body instructionPatchRequest: InstructionPatchRequest,
//     ): RpcOperation<
//       {},
//       {
//         statusCode: 202;
//       },
//       ServiceTraits
//     > | NotFoundResponse;

//     /**
//      * Delete instructions.
//      * @param instructionId The ID of the instruction to delete.
//      * @param instructionVersion The version of the instruction to delete.
//      */
//     @delete
//     @route("/v3/instructions/{instructionId}/versions/{instructionVersion}")
//     op deleteInstructionByVersion(
//       @path instructionId: string,
//       @path instructionVersion: string,
//     ): RpcOperation<
//       {},
//       {
//         statusCode: 202;
//       },
//       ServiceTraits
//     > | NotFoundResponse;

//     /**
//      * Bulk Delete instructions.
//      * @param instructionId The ID of the instruction to delete.
//      * @param forceDelete Force delete the instruction.
//      * @param deleteAll Delete all versions of the instruction.
//      */
//     @delete
//     @route("/v3/instructions/{instructionId}")
//     op deleteInstructionCustomVersionInBulk(
//       @path instructionId: string,
//       @query("forceDelete") forceDelete: boolean = false,
//       @query("deleteAll") deleteAll: boolean = false,
//     ): RpcOperation<
//       {},
//       {
//         statusCode: 202;
//       },
//       ServiceTraits
//     > | NotFoundResponse;
//   }
// }
