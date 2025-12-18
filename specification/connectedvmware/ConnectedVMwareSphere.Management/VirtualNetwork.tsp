import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ConnectedVMwarevSphere;
/**
 * Define the virtualNetwork.
 */
model VirtualNetwork
  is Azure.ResourceManager.TrackedResource<VirtualNetworkProperties, false> {
  ...ResourceNameParameter<
    Resource = VirtualNetwork,
    KeyName = "virtualNetworkName",
    SegmentName = "virtualNetworks",
    NamePattern = ""
  >;

  /**
   * Gets or sets the extended location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;

  /**
   * Metadata used by portal/tooling/etc to render different UX experiences for resources of the same type; e.g. ApiApps are a kind of Microsoft.Web/sites type.  If supported, the resource provider must validate and persist this value.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface VirtualNetworksOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = VirtualNetwork,
        KeyName = "virtualNetworkName",
        SegmentName = "virtualNetworks",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface VirtualNetworks {
  /**
   * Implements virtual network GET method.
   */
  get is ArmResourceRead<VirtualNetwork>;

  /**
   * Create Or Update virtual network.
   */
  create is VirtualNetworksOps.CreateOrUpdateAsync<
    VirtualNetwork,
    OptionalRequestBody = true
  >;

  /**
   * API to update certain properties of the virtual network resource.
   */
  @patch(#{ implicitOptionality: false })
  update is VirtualNetworksOps.CustomPatchSync<
    VirtualNetwork,
    PatchModel = ResourcePatch,
    OptionalRequestBody = true
  >;

  /**
   * Implements virtual network DELETE method.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualNetwork,
    Parameters = {
      /**
       * Whether force delete was specified.
       */
      @query("force")
      force?: boolean;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List of virtualNetworks in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    VirtualNetwork,
    Response = ArmResponse<VirtualNetworksList>
  >;

  /**
   * List of virtualNetworks in a subscription.
   */
  list is ArmListBySubscription<
    VirtualNetwork,
    Response = ArmResponse<VirtualNetworksList>
  >;
}

@@doc(VirtualNetwork.name, "Name of the virtual network resource.");
@@doc(VirtualNetwork.properties, "Resource properties.");
@@doc(VirtualNetworks.create::parameters.resource, "Request payload.");
@@doc(VirtualNetworks.update::parameters.properties,
  "Resource properties to update."
);
