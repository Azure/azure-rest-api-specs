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

namespace Microsoft.Peering;
@doc("Peering is a logical representation of a set of connections to the Microsoft Cloud Edge at a location.")
model Peering is TrackedResource<PeeringProperties> {
  @doc("The name of the peering.")
  @path
  @key("peeringName")
  @segment("peerings")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface Peerings {
  @doc("Gets an existing peering with the specified name under the given subscription and resource group.")
  get is ArmResourceRead<Peering>;

  @doc("Creates a new peering or updates an existing peering with the specified name under the given subscription and resource group.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Peering>;

  @doc("Updates tags for a peering with the specified name under the given subscription and resource group.")
  update is ArmCustomPatchSync<
    Peering,
    Paths1Sywd6ZSubscriptionsSubscriptionidResourcegroupsResourcegroupnameProvidersMicrosoftPeeringPeeringsPeeringnamePatchRequestbodyContentApplicationJsonSchema
  >;

  @doc("Deletes an existing peering with the specified name under the given subscription and resource group.")
  delete is ArmResourceDeleteSync<Peering>;

  @doc("Lists all of the peerings under the given subscription and resource group.")
  listByResourceGroup is ArmResourceListByParent<Peering>;

  @doc("Lists all of the peerings under the given subscription.")
  listBySubscription is ArmListBySubscription<Peering>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ReceivedRoutes_ListByPeering")
  @doc("Lists the prefixes received over the specified peering under the given subscription and resource group.")
  // FIXME: ReceivedRoutes_ListByPeering could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peerings/{peeringName}/receivedRoutes")
  @get
  listByPeering is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The name of the peering.")
      @path
      peeringName: string;

      @doc("The optional prefix that can be used to filter the routes.")
      @query("prefix")
      prefix?: string;

      @doc("The optional AS path that can be used to filter the routes.")
      @query("asPath")
      asPath?: string;

      @doc("The optional origin AS validation state that can be used to filter the routes.")
      @query("originAsValidationState")
      originAsValidationState?: string;

      @doc("The optional RPKI validation state that can be used to filter the routes.")
      @query("rpkiValidationState")
      rpkiValidationState?: string;

      @doc("The optional page continuation token that is used in the event of paginated result.")
      @query("$skipToken")
      $skipToken?: string;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PeeringReceivedRouteListResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RpUnbilledPrefixes_List")
  @doc("Lists all of the RP unbilled prefixes for the specified peering")
  // FIXME: RpUnbilledPrefixes_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Peering/peerings/{peeringName}/rpUnbilledPrefixes")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure resource group name.")
      @path
      resourceGroupName: string;

      @doc("The peering name.")
      @path
      peeringName: string;

      @doc("Flag to enable consolidation prefixes")
      @query("consolidate")
      consolidate?: boolean;

      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    RpUnbilledPrefixListResult
  >;
}

@@projectedName(Peerings.createOrUpdate::parameters.resource,
  "json",
  "peering"
);
@@extension(Peerings.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "peering"
);
@@doc(Peerings.createOrUpdate::parameters.resource,
  "The properties needed to create or update a peering."
);
@@projectedName(Peerings.update::parameters.properties, "json", "tags");
@@extension(Peerings.update::parameters.properties, "x-ms-client-name", "tags");
@@doc(Peerings.update::parameters.properties, "The resource tags.");
