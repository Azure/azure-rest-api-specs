import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Peering;
/**
 * Peering is a logical representation of a set of connections to the Microsoft Cloud Edge at a location.
 */
model Peering is Azure.ResourceManager.TrackedResource<PeeringProperties> {
  ...ResourceNameParameter<
    Resource = Peering,
    KeyName = "peeringName",
    SegmentName = "peerings",
    NamePattern = "[A-Za-z0-9_.-]{1,63}"
  >;

  /**
   * The SKU that defines the tier and kind of the peering.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku: PeeringSku;

  /**
   * The kind of the peering.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: Kind;
}

@armResourceOperations
interface Peerings {
  /**
   * Gets an existing peering with the specified name under the given subscription and resource group.
   */
  get is ArmResourceRead<Peering>;

  /**
   * Creates a new peering or updates an existing peering with the specified name under the given subscription and resource group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Peering>;

  /**
   * Updates tags for a peering with the specified name under the given subscription and resource group.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Peering, PatchModel = ResourceTags>;

  /**
   * Deletes an existing peering with the specified name under the given subscription and resource group.
   */
  delete is ArmResourceDeleteSync<Peering>;

  /**
   * Lists all of the peerings under the given subscription and resource group.
   */
  listByResourceGroup is ArmResourceListByParent<Peering>;

  /**
   * Lists all of the peerings under the given subscription.
   */
  listBySubscription is ArmListBySubscription<Peering>;

  /**
   * Lists the prefixes received over the specified peering under the given subscription and resource group.
   */
  @list
  @get
  @action("receivedRoutes")
  listByPeering is ArmResourceActionSync<
    Peering,
    void,
    ArmResponse<PeeringReceivedRouteListResult>,
    Parameters = {
      /**
       * The optional prefix that can be used to filter the routes.
       */
      @query("prefix")
      prefix?: string;

      /**
       * The optional AS path that can be used to filter the routes.
       */
      @query("asPath")
      asPath?: string;

      /**
       * The optional origin AS validation state that can be used to filter the routes.
       */
      @query("originAsValidationState")
      originAsValidationState?: string;

      /**
       * The optional RPKI validation state that can be used to filter the routes.
       */
      @query("rpkiValidationState")
      rpkiValidationState?: string;

      /**
       * The optional page continuation token that is used in the event of paginated result.
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;

  /**
   * Lists all of the RP unbilled prefixes for the specified peering
   */
  @list
  @get
  @action("rpUnbilledPrefixes")
  list is ArmResourceActionSync<
    Peering,
    void,
    ArmResponse<RpUnbilledPrefixListResult>,
    Parameters = {
      /**
       * Flag to enable consolidation prefixes
       */
      @query("consolidate")
      consolidate?: boolean;
    }
  >;
}

@@doc(Peering.name, "The name of the peering.");
@@doc(Peering.properties, "The properties that define a peering.");
@@doc(Peerings.createOrUpdate::parameters.resource,
  "The properties needed to create or update a peering."
);
@@doc(Peerings.update::parameters.properties, "The resource tags.");
