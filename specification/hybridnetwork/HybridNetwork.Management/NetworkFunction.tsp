import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
/**
 * Network function resource response.
 */
model NetworkFunction
  is Azure.ResourceManager.TrackedResource<NetworkFunctionPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = NetworkFunction,
    KeyName = "networkFunctionName",
    SegmentName = "networkFunctions",
    NamePattern = ""
  >;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface NetworkFunctions {
  /**
   * Gets information about the specified network function resource.
   */
  get is ArmResourceRead<NetworkFunction>;

  /**
   * Creates or updates a network function resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    NetworkFunction,
    LroHeaders = ArmAsyncOperationHeader
  >;

  /**
   * Updates the tags for the network function resource.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<NetworkFunction, PatchModel = TagsObject>;

  /**
   * Deletes the specified network function resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkFunction,
    Response = ArmDeletedResponse | ArmAcceptedLroResponse<
      "Accepted. The header contains 'Azure-AsyncOperation' header pointing to an operations resource. The operation URI can be queried to find the current state of the operation.",
      LroHeaders = ArmLroLocationHeader
    > | ArmNoContentResponse<"Request is successful. Resource with the specified name does not exist.">,
    LroHeaders = ArmLroLocationHeader
  >;

  /**
   * Lists all the network function resources in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<NetworkFunction>;

  /**
   * Lists all the network functions in a subscription.
   */
  listBySubscription is ArmListBySubscription<NetworkFunction>;

  /**
   * Execute a request to services on a containerized network function.
   */
  executeRequest is NetworkFunctionsOps.ActionSync<
    Resource = NetworkFunction,
    Request = ExecuteRequestParameters,
    Response = OkResponse | ArmAcceptedLroResponse<
      "Accepted. The header contains 'Azure-AsyncOperation' header which can be used to monitor the progress of the operation.",
      ArmLroLocationHeader
    >
  >;
}

alias NetworkFunctionsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;
  },
  KeysOf<NetworkFunction>,
  ErrorResponse
>;

@@doc(NetworkFunction.name, "Resource name for the network function resource.");
@@doc(NetworkFunction.properties, "Network function properties.");
@@doc(NetworkFunctions.createOrUpdate::parameters.resource,
  "Parameters supplied in the body to the create or update network function operation."
);
@@doc(NetworkFunctions.updateTags::parameters.properties,
  "Parameters supplied to the update network function tags operation."
);
@@doc(NetworkFunctions.executeRequest::parameters.body,
  "Payload for execute request post call."
);
@@doc(NetworkFunction.identity,
  "The managed identity of the network function."
);
@@doc(NetworkFunction.etag,
  "A unique read-only string that changes whenever the resource is updated."
);
