import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./L2Network_models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.NetworkCloud;
/**
 * The name of the L2 network.
 */
model L2NetworkNameParameter
  is ResourceNameParameter<
    Resource = L2Network,
    KeyName = "l2NetworkName",
    SegmentName = "l2Networks",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$"
  >;

/**
 * L2Network represents a network that utilizes a single isolation domain set up for layer-2 resources.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "legacy resource using legacy features"
model L2Network
  is Azure.ResourceManager.TrackedResource<L2NetworkProperties, false> {
  ...L2NetworkNameParameter;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...RequiredExtendedLocationProperty;
}

@armResourceOperations
interface L2Networks {
  /**
   * Get properties of the provided layer 2 (L2) network.
   */
  get is ArmResourceRead<L2Network>;

  /**
   * Create a new layer 2 (L2) network or update the properties of the existing network.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    L2Network,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = L2Network>
  >;

  /**
   * Update tags associated with the provided layer 2 (L2) network.
   */
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchSync<
    L2Network,
    PatchModel = L2NetworkPatchParameters,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided layer 2 (L2) network.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    L2Network,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of layer 2 (L2) networks in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    L2Network,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<L2NetworkList>
  >;

  /**
   * Get a list of layer 2 (L2) networks in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    L2Network,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<L2NetworkList>
  >;
}

@@doc(L2Network.name, "The name of the L2 network.");
@@doc(L2Network.properties, "The list of the resource properties.");
@@doc(L2Networks.createOrUpdate::parameters.resource, "The request body.");
@@doc(L2Networks.update::parameters.properties, "The request body.");
