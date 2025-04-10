import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Fabric.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Protection container details.
 */
@parentResource(Fabric)
model ProtectionContainer
  is Azure.ResourceManager.ProxyResource<ProtectionContainerProperties> {
  ...ResourceNameParameter<
    Resource = ProtectionContainer,
    KeyName = "protectionContainerName",
    SegmentName = "replicationProtectionContainers",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ProtectionContainers {
  /**
   * Gets the details of a protection container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationProtectionContainers_Get")
  get is ArmResourceRead<ProtectionContainer>;

  /**
   * Operation to create a protection container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ReplicationProtectionContainers_Create")
  create is ArmResourceCreateOrReplaceAsync<
    ProtectionContainer,
    Response = ArmResourceUpdatedResponse<ProtectionContainer> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists the protection containers in the specified fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationProtectionContainers_ListByReplicationFabrics")
  listByReplicationFabrics is ArmResourceListByParent<
    ProtectionContainer,
    Response = ArmResponse<ProtectionContainerCollection>
  >;

  /**
   * The operation to a add a protectable item to a protection container(Add physical server).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationProtectionContainers_DiscoverProtectableItem")
  discoverProtectableItem is ArmResourceActionAsync<
    ProtectionContainer,
    DiscoverProtectableItemRequest,
    ArmResponse<ProtectionContainer>
  >;

  /**
   * Operation to remove a protection container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("remove")
  @operationId("ReplicationProtectionContainers_Delete")
  delete is ArmResourceActionAsync<
    ProtectionContainer,
    void,
    NoContentResponse
  >;

  /**
   * Operation to switch protection from one container to another.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationProtectionContainers_SwitchClusterProtection")
  switchClusterProtection is ArmResourceActionAsync<
    ProtectionContainer,
    SwitchClusterProtectionInput,
    ArmResponse<ProtectionContainer>
  >;

  /**
   * Operation to switch protection from one container to another or one replication provider to another.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("switchprotection")
  @operationId("ReplicationProtectionContainers_SwitchProtection")
  switchProtection is ArmResourceActionAsync<
    ProtectionContainer,
    SwitchProtectionInput,
    ArmResponse<ProtectionContainer>
  >;
}

@@doc(ProtectionContainer.name, "Protection container name.");
@@doc(ProtectionContainer.properties, "The custom data.");
@@doc(ProtectionContainers.create::parameters.resource, "Creation input.");
@@doc(ProtectionContainers.discoverProtectableItem::parameters.body,
  "The request object to add a protectable item."
);
@@doc(ProtectionContainers.switchClusterProtection::parameters.body,
  "Switch protection input."
);
@@doc(ProtectionContainers.switchProtection::parameters.body,
  "Switch protection input."
);
