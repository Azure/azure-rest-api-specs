import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProtectionContainer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Replication protected item.
 */
@parentResource(ProtectionContainer)
model ProtectableItem
  is Azure.ResourceManager.ProxyResource<ProtectableItemProperties> {
  ...ResourceNameParameter<
    Resource = ProtectableItem,
    KeyName = "protectableItemName",
    SegmentName = "replicationProtectableItems",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ProtectableItems {
  /**
   * The operation to get the details of a protectable item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationProtectableItems_Get")
  get is ArmResourceRead<ProtectableItem>;

  /**
   * Lists the protectable items in a protection container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationProtectableItems_ListByReplicationProtectionContainers")
  listByReplicationProtectionContainers is ArmResourceListByParent<
    ProtectableItem,
    Parameters = {
      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;

      /**
       * take OData query parameter.
       */
      @query("$take")
      $take?: string;

      /**
       * skipToken OData query parameter.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<ProtectableItemCollection>
  >;
}

@@doc(ProtectableItem.name, "Protectable item name.");
@@doc(ProtectableItem.properties, "The custom data.");
