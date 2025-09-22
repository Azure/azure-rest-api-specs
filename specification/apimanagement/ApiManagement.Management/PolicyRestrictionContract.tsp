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
 * Policy restriction contract details.
 */
@parentResource(ApiManagementServiceResource)
model PolicyRestrictionContract
  is Azure.ResourceManager.ProxyResource<PolicyRestrictionContractProperties> {
  ...ResourceNameParameter<
    Resource = PolicyRestrictionContract,
    KeyName = "policyRestrictionId",
    SegmentName = "policyRestrictions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PolicyRestrictionContracts {
  /**
   * Get the policy restriction of the Api Management service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyRestriction_Get")
  get is ArmResourceRead<PolicyRestrictionContract>;

  /**
   * Gets the entity state (Etag) version of the policy restriction in the Api Management service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyRestriction_GetEntityTag")
  getEntityTag is ArmResourceCheckExistence<PolicyRestrictionContract>;

  /**
   * Creates or updates the policy restriction configuration of the Api Management service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyRestriction_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    PolicyRestrictionContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Updates the policy restriction configuration of the Api Management service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyRestriction_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    PolicyRestrictionContract,
    PatchModel = PolicyRestrictionUpdateContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Deletes the policy restriction configuration of the Api Management Service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyRestriction_Delete")
  delete is ArmResourceDeleteSync<
    PolicyRestrictionContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Gets all policy restrictions of API Management services.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyRestriction_ListByService")
  listByService is ArmResourceListByParent<
    PolicyRestrictionContract,
    Response = ArmResponse<PolicyRestrictionCollection>
  >;
}

@@maxLength(PolicyRestrictionContract.name, 80);
@@minLength(PolicyRestrictionContract.name, 1);
@@doc(PolicyRestrictionContract.name,
  "Policy restrictions after an entity level"
);
@@doc(PolicyRestrictionContract.properties,
  "Properties of the Policy Restriction."
);
@@doc(PolicyRestrictionContracts.createOrUpdate::parameters.resource,
  "The policy restriction to apply."
);
@@doc(PolicyRestrictionContracts.update::parameters.properties,
  "The policy restriction to apply."
);
