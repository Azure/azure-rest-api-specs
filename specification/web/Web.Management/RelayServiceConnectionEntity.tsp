import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Hybrid Connection for an App Service app.
 */
@parentResource(Site)
model RelayServiceConnectionEntity
  is Azure.ResourceManager.ProxyResource<RelayServiceConnectionEntityProperties> {
  ...ResourceNameParameter<
    Resource = RelayServiceConnectionEntity,
    KeyName = "entityName",
    SegmentName = "hybridconnection",
    NamePattern = ""
  >;
}

@armResourceOperations
interface RelayServiceConnectionEntityOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,
      },
      {
        /** Name of the hybrid connection. */
        @path
        @segment("hybridconnection")
        @key
        entityName: string,
      }
    > {}

@armResourceOperations
interface RelayServiceConnectionEntities {
  /**
   * Description for Gets a hybrid connection configuration by its name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetRelayServiceConnection")
  getRelayServiceConnection is RelayServiceConnectionEntityOps.Read<RelayServiceConnectionEntity>;

  /**
   * Description for Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdateRelayServiceConnection")
  createOrUpdateRelayServiceConnection is RelayServiceConnectionEntityOps.CreateOrUpdateSync<
    RelayServiceConnectionEntity,
    Response = ArmResourceUpdatedResponse<RelayServiceConnectionEntity>
  >;

  /**
   * Description for Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_UpdateRelayServiceConnection")
  @patch(#{ implicitOptionality: false })
  updateRelayServiceConnection is RelayServiceConnectionEntityOps.CustomPatchSync<
    RelayServiceConnectionEntity,
    PatchModel = RelayServiceConnectionEntity
  >;

  /**
   * Description for Deletes a relay service connection by its name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteRelayServiceConnection")
  deleteRelayServiceConnection is RelayServiceConnectionEntityOps.DeleteSync<
    RelayServiceConnectionEntity,
    Response = ArmDeletedResponse | ArmNotFoundResponse
  >;
}
@armResourceOperations
interface RelayServiceConnectionEntityOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the deployment slot. If a slot is not specified, the API will get a hybrid connection for the production slot. */
        @path
        @segment("slots")
        @key
        slot: string,
      },
      {
        /** Name of the hybrid connection. */
        @path
        @segment("hybridconnection")
        @key
        entityName: string,
      }
    > {}

@armResourceOperations
interface RelayServiceConnectionEntityOperationGroup {
  /**
   * Description for Gets a hybrid connection configuration by its name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_GetRelayServiceConnectionSlot")
  getRelayServiceConnectionSlot is RelayServiceConnectionEntityOperationGroupOps.Read<RelayServiceConnectionEntity>;

  /**
   * Description for Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdateRelayServiceConnectionSlot")
  createOrUpdateRelayServiceConnectionSlot is RelayServiceConnectionEntityOperationGroupOps.CreateOrUpdateSync<
    RelayServiceConnectionEntity,
    Response = ArmResourceUpdatedResponse<RelayServiceConnectionEntity>
  >;

  /**
   * Description for Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WebApps_UpdateRelayServiceConnectionSlot")
  @patch(#{ implicitOptionality: false })
  updateRelayServiceConnectionSlot is RelayServiceConnectionEntityOperationGroupOps.CustomPatchSync<
    RelayServiceConnectionEntity,
    PatchModel = RelayServiceConnectionEntity
  >;

  /**
   * Description for Deletes a relay service connection by its name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("WebApps_DeleteRelayServiceConnectionSlot")
  deleteRelayServiceConnectionSlot is RelayServiceConnectionEntityOperationGroupOps.DeleteSync<
    RelayServiceConnectionEntity,
    Response = ArmDeletedResponse | ArmNotFoundResponse
  >;
}

@@doc(RelayServiceConnectionEntity.name, "Name of the hybrid connection.");
@@doc(RelayServiceConnectionEntity.properties,
  "RelayServiceConnectionEntity resource specific properties"
);
@@doc(RelayServiceConnectionEntities.createOrUpdateRelayServiceConnection::parameters.resource,
  "Details of the hybrid connection configuration."
);
@@doc(RelayServiceConnectionEntities.updateRelayServiceConnection::parameters.properties,
  "Details of the hybrid connection configuration."
);
@@doc(RelayServiceConnectionEntityOperationGroup.createOrUpdateRelayServiceConnectionSlot::parameters.resource,
  "Details of the hybrid connection configuration."
);
@@doc(RelayServiceConnectionEntityOperationGroup.updateRelayServiceConnectionSlot::parameters.properties,
  "Details of the hybrid connection configuration."
);
