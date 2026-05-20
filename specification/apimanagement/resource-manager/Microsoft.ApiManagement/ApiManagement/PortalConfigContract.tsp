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

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface PortalConfigContracts {
  /**
   * Get the developer portal configuration.
   */
  get is ArmResourceRead<
    PortalConfigContract,
    Response = ArmResponse<PortalConfigContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the developer portal configuration.
   */
  getEntityTag is ArmResourceCheckExistence<
    PortalConfigContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Create or update the developer portal configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    PortalConfigContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResourceUpdatedResponse<PortalConfigContract>
  >;

  /**
   * Update the developer portal configuration.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    PortalConfigContract,
    PatchModel = PortalConfigContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Lists the developer portal configurations.
   */
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
