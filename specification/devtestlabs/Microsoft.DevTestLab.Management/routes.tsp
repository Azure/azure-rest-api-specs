// // FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

// import "@azure-tools/typespec-azure-core";
// import "@typespec/rest";
// import "./models.tsp";
// import "@azure-tools/typespec-azure-resource-manager";
// import "@typespec/openapi";

// using TypeSpec.Rest;
// using TypeSpec.Http;
// using Azure.ResourceManager;
// using TypeSpec.OpenAPI;

// namespace Microsoft.DevTestLab;

// #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
// interface OperationsOperationGroup {
//   /**
//    * Get operation.
//    */
//   #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
//   @operationId("Operations_Get")
//   @armResourceOperation(false)
//   @route("/subscriptions/{subscriptionId}/providers/Microsoft.DevTestLab/locations/{locationName}/operations/{name}")
//   @get
//   get(
//     ...ApiVersionParameter,
//     ...SubscriptionIdParameter,

//     /**
//      * The name of the location.
//      */
//     @path
//     locationName: string,

//     /**
//      * The name of the operation.
//      */
//     @minLength(1)
//     @path
//     name: string,
//   ): ArmResponse<OperationResult> | ErrorResponse;
// }
