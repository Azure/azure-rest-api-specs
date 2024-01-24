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

namespace Microsoft.NetworkCloud;
/**
 * Upon creation, the additional services that are provided by the platform will be allocated and
 * represented in the status of this resource. All resources associated with this cloud services network will be part
 * of the same layer 2 (L2) isolation domain. At least one service network must be created but may be reused across many
 * virtual machines and/or Hybrid AKS clusters.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(
  CloudServicesNetworkProperties
)
@includeInapplicableMetadataInPayload(false)
model CloudServicesNetwork extends TrackedResourceBase {
  /**
   * The name of the cloud services network.
   */
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @path
  @key("cloudServicesNetworkName")
  @segment("cloudServicesNetworks")
  name: string;

  /**
   * The extended location of the cluster associated with the resource.
   */
  extendedLocation: ExtendedLocation;

  /**
   * The list of the resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: CloudServicesNetworkProperties;
}

@armResourceOperations
interface CloudServicesNetworks {
  /**
   * Get properties of the provided cloud services network.
   */
  get is ArmResourceRead<CloudServicesNetwork>;

  /**
   * Create a new cloud services network or update the properties of the existing cloud services network.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CloudServicesNetwork,
    BaseParameters<CloudServicesNetwork>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update properties of the provided cloud services network, or update the tags associated with it. Properties and tag updates can be done independently.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    CloudServicesNetwork,
    CloudServicesNetworkPatchParameters,
    BaseParameters<CloudServicesNetwork>,
    ArmAsyncOperationHeader
  >;

  /**
   * Delete the provided cloud services network.
   */
  delete is ArmResourceDeleteAsync<
    CloudServicesNetwork,
    BaseParameters<CloudServicesNetwork>,
    ArmLroLocationHeader
  >;

  /**
   * Get a list of cloud services networks in the provided resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("CloudServicesNetworks_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<CloudServicesNetwork>;

  /**
   * Get a list of cloud services networks in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<CloudServicesNetwork>;
}

@@projectedName(CloudServicesNetworks.createOrUpdate::parameters.resource,
  "json",
  "cloudServicesNetworkParameters"
);
@@extension(CloudServicesNetworks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "cloudServicesNetworkParameters"
);
@@doc(CloudServicesNetworks.createOrUpdate::parameters.resource,
  "The request body."
);
@@projectedName(CloudServicesNetworks.update::parameters.properties,
  "json",
  "cloudServicesNetworkUpdateParameters"
);
@@extension(CloudServicesNetworks.update::parameters.properties,
  "x-ms-client-name",
  "cloudServicesNetworkUpdateParameters"
);
@@doc(CloudServicesNetworks.update::parameters.properties, "The request body.");
