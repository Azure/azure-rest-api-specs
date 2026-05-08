import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./CloudServicesNetwork_models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.NetworkCloud;
/**
 * The name of the cloud services network.
 */
model CloudServicesNetworkNameParameter
  is ResourceNameParameter<
    Resource = CloudServicesNetwork,
    KeyName = "cloudServicesNetworkName",
    SegmentName = "cloudServicesNetworks",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$"
  >;

/**
 * Upon creation, the additional services that are provided by the platform will be allocated and represented in the status of this resource. All resources associated with this cloud services network will be part of the same layer 2 (L2) isolation domain. At least one service network must be created but may be reused across many virtual machines and/or Hybrid AKS clusters.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "legacy resource using legacy features"
model CloudServicesNetwork
  is Azure.ResourceManager.TrackedResource<CloudServicesNetworkProperties> {
  ...CloudServicesNetworkNameParameter;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...RequiredExtendedLocationProperty;
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
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = CloudServicesNetwork>
  >;

  /**
   * Update properties of the provided cloud services network, or update the tags associated with it. Properties and tag updates can be done independently.
   */
  @patch(#{ implicitOptionality: false })
  /* Note: It is preferred to use Azure.ResourceManager.ArmCustomPatchAsync, for existing resources the patch body is (nonsensically) "optional", and this is the only way to achieve it. */
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    CloudServicesNetwork,
    PatchModel = CloudServicesNetworkPatchParameters,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = CloudServicesNetwork> &
      ArmLroLocationHeader<FinalResult = CloudServicesNetwork>,
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided cloud services network.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    CloudServicesNetwork,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of cloud services networks in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    CloudServicesNetwork,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<CloudServicesNetworkList>
  >;

  /**
   * Get a list of cloud services networks in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    CloudServicesNetwork,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<CloudServicesNetworkList>
  >;
}

@@doc(CloudServicesNetwork.name, "The name of the cloud services network.");
@@doc(CloudServicesNetwork.properties, "The list of the resource properties.");
@@doc(CloudServicesNetworks.createOrUpdate::parameters.resource,
  "The request body."
);
@@doc(CloudServicesNetworks.update::parameters.properties, "The request body.");
