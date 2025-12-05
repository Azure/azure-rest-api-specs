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

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
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
  @summary("Gets a hybrid connection configuration by its name.")
  getRelayServiceConnection is RelayServiceConnectionEntityOps.Read<
    RelayServiceConnectionEntity,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).")
  createOrUpdateRelayServiceConnection is RelayServiceConnectionEntityOps.CreateOrUpdateSync<
    RelayServiceConnectionEntity,
    Response = ArmResourceUpdatedResponse<RelayServiceConnectionEntity>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).
   */
  @summary("Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).")
  @patch(#{ implicitOptionality: false })
  updateRelayServiceConnection is RelayServiceConnectionEntityOps.CustomPatchSync<
    RelayServiceConnectionEntity,
    PatchModel = RelayServiceConnectionEntity,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a relay service connection by its name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Deletes a relay service connection by its name.")
  deleteRelayServiceConnection is RelayServiceConnectionEntityOps.DeleteSync<
    RelayServiceConnectionEntity,
    Response = ArmDeletedResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
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
  @summary("Gets a hybrid connection configuration by its name.")
  getRelayServiceConnectionSlot is RelayServiceConnectionEntityOperationGroupOps.Read<
    RelayServiceConnectionEntity,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).")
  createOrUpdateRelayServiceConnectionSlot is RelayServiceConnectionEntityOperationGroupOps.CreateOrUpdateSync<
    RelayServiceConnectionEntity,
    Response = ArmResourceUpdatedResponse<RelayServiceConnectionEntity>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).
   */
  @summary("Creates a new hybrid connection configuration (PUT), or updates an existing one (PATCH).")
  @patch(#{ implicitOptionality: false })
  updateRelayServiceConnectionSlot is RelayServiceConnectionEntityOperationGroupOps.CustomPatchSync<
    RelayServiceConnectionEntity,
    PatchModel = RelayServiceConnectionEntity,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Deletes a relay service connection by its name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Deletes a relay service connection by its name.")
  deleteRelayServiceConnectionSlot is RelayServiceConnectionEntityOperationGroupOps.DeleteSync<
    RelayServiceConnectionEntity,
    Response = ArmDeletedResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
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
