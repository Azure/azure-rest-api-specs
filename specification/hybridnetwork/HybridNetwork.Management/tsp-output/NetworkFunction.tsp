import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
/**
 * Network function resource response.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(
  NetworkFunctionPropertiesFormat
)
@includeInapplicableMetadataInPayload(false)
model NetworkFunction extends TrackedResourceBase {
  /**
   * The name of the network function resource.
   */
  @path
  @key("networkFunctionName")
  @segment("networkFunctions")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  etag?: string;

  /**
   * Network function properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: NetworkFunctionPropertiesFormat;

  ...Azure.ResourceManager.ManagedServiceIdentity;
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
    BaseParameters<NetworkFunction>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates the tags for the network function resource.
   */
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<NetworkFunction, TagsObject>;

  /**
   * Deletes the specified network function resource.
   */
  delete is ArmResourceDeleteAsync<
    NetworkFunction,
    BaseParameters<NetworkFunction>,
    ArmLroLocationHeader
  >;

  /**
   * Lists all the network function resources in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkFunctions_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<NetworkFunction>;

  /**
   * Lists all the network functions in a subscription.
   */
  listBySubscription is ArmListBySubscription<NetworkFunction>;

  /**
   * Execute a request to services on a containerized network function.
   */
  executeRequest is ArmResourceActionAsync<
    NetworkFunction,
    ExecuteRequestParameters,
    void,
    BaseParameters<NetworkFunction>,
    ArmLroLocationHeader
  >;
}

@@projectedName(NetworkFunctions.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(NetworkFunctions.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(NetworkFunctions.createOrUpdate::parameters.resource,
  "Parameters supplied in the body to the create or update network function operation."
);
@@projectedName(NetworkFunctions.updateTags::parameters.properties,
  "json",
  "parameters"
);
@@extension(NetworkFunctions.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(NetworkFunctions.updateTags::parameters.properties,
  "Parameters supplied to the update network function tags operation."
);
@@projectedName(NetworkFunctions.executeRequest::parameters.body,
  "json",
  "parameters"
);
@@extension(NetworkFunctions.executeRequest::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(NetworkFunctions.executeRequest::parameters.body,
  "Payload for execute request post call."
);
