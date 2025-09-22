import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApiManagementServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * The developer portal configuration contract.
 */
@parentResource(ApiManagementServiceResource)
model PortalConfigContract
  is Azure.ResourceManager.ProxyResource<PortalConfigProperties> {
  ...ResourceNameParameter<
    Resource = PortalConfigContract,
    KeyName = "portalConfigId",
    SegmentName = "portalconfigs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PortalConfigContracts {
  /**
   * Get the developer portal configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PortalConfig_Get")
  get is ArmResourceRead<PortalConfigContract>;

  /**
   * Gets the entity state (Etag) version of the developer portal configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PortalConfig_GetEntityTag")
  getEntityTag is ArmResourceCheckExistence<PortalConfigContract>;

  /**
   * Create or update the developer portal configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("PortalConfig_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    PortalConfigContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    },
    Response = ArmResourceUpdatedResponse<PortalConfigContract>
  >;

  /**
   * Update the developer portal configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PortalConfig_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    PortalConfigContract,
    PatchModel = PortalConfigContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Lists the developer portal configurations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PortalConfig_ListByService")
  listByService is ArmResourceListByParent<
    PortalConfigContract,
    Response = ArmResponse<PortalConfigCollection>
  >;
}

@@maxLength(PortalConfigContract.name, 80);
@@minLength(PortalConfigContract.name, 1);
@@doc(PortalConfigContract.name, "Portal configuration identifier.");
@@doc(PortalConfigContract.properties,
  "The developer portal configuration contract properties."
);
@@doc(PortalConfigContracts.createOrUpdate::parameters.resource,
  "Update the developer portal configuration."
);
@@doc(PortalConfigContracts.update::parameters.properties,
  "Update the developer portal configuration."
);
