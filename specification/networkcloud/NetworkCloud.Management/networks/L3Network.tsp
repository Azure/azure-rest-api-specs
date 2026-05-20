import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./L3Network_models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.NetworkCloud;
/**
 * The name of the L3 network.
 */
model L3NetworkNameParameter
  is ResourceNameParameter<
    Resource = L3Network,
    KeyName = "l3NetworkName",
    SegmentName = "l3Networks",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$"
  >;

/**
 * L3Network represents a network that utilizes a single isolation domain set up for layer-3 resources.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "legacy resource using legacy features"
model L3Network
  is Azure.ResourceManager.TrackedResource<L3NetworkProperties, false> {
  ...L3NetworkNameParameter;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...RequiredExtendedLocationProperty;
}

@armResourceOperations
interface L3Networks {
  /**
   * Get properties of the provided layer 3 (L3) network.
   */
  get is ArmResourceRead<L3Network>;

  /**
   * Create a new layer 3 (L3) network or update the properties of the existing network.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    L3Network,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = L3Network>
  >;

  /**
   * Update tags associated with the provided layer 3 (L3) network.
   */
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchSync<
    L3Network,
    PatchModel = L3NetworkPatchParameters,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided layer 3 (L3) network.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    L3Network,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of layer 3 (L3) networks in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    L3Network,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<L3NetworkList>
  >;

  /**
   * Get a list of layer 3 (L3) networks in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    L3Network,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<L3NetworkList>
  >;
}

@@doc(L3Network.name, "The name of the L3 network.");
@@doc(L3Network.properties, "The list of the resource properties.");
@@doc(L3Networks.createOrUpdate::parameters.resource, "The request body.");
@@doc(L3Networks.update::parameters.properties, "The request body.");
