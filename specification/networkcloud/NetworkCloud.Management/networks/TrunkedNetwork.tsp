import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./TrunkedNetwork_models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.NetworkCloud;
/**
 * The name of the trunked network.
 */
model TrunkedNetworkNameParameter
  is ResourceNameParameter<
    Resource = TrunkedNetwork,
    KeyName = "trunkedNetworkName",
    SegmentName = "trunkedNetworks",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$"
  >;

/**
 * TrunkedNetwork represents a network that utilizes multiple isolation domains and specified VLANs to create a trunked network.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "legacy resource using legacy features"
model TrunkedNetwork
  is Azure.ResourceManager.TrackedResource<TrunkedNetworkProperties, false> {
  ...TrunkedNetworkNameParameter;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...RequiredExtendedLocationProperty;
}

@armResourceOperations
interface TrunkedNetworks {
  /**
   * Get properties of the provided trunked network.
   */
  get is ArmResourceRead<TrunkedNetwork>;

  /**
   * Create a new trunked network or update the properties of the existing trunked network.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    TrunkedNetwork,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = TrunkedNetwork>
  >;

  /**
   * Update tags associated with the provided trunked network.
   */
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchSync<
    TrunkedNetwork,
    PatchModel = TrunkedNetworkPatchParameters,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided trunked network.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    TrunkedNetwork,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of trunked networks in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    TrunkedNetwork,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<TrunkedNetworkList>
  >;

  /**
   * Get a list of trunked networks in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    TrunkedNetwork,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<TrunkedNetworkList>
  >;
}

@@doc(TrunkedNetwork.name, "The name of the trunked network.");
@@doc(TrunkedNetwork.properties, "The list of the resource properties.");
@@doc(TrunkedNetworks.createOrUpdate::parameters.resource, "The request body.");
@@doc(TrunkedNetworks.update::parameters.properties, "The request body.");
