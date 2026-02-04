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
  get is ArmResourceRead<
    PolicyRestrictionContract,
    Response = ArmResponse<PolicyRestrictionContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the policy restriction in the Api Management service.
   */
  getEntityTag is ArmResourceCheckExistence<
    PolicyRestrictionContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or updates the policy restriction configuration of the Api Management service.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    PolicyRestrictionContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<PolicyRestrictionContract> & {
      /**
       * Current entity state version
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<PolicyRestrictionContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Updates the policy restriction configuration of the Api Management service.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    PolicyRestrictionContract,
    PatchModel = PolicyRestrictionUpdateContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<PolicyRestrictionContract> & {
      /**
       * Current entity state version
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Deletes the policy restriction configuration of the Api Management Service.
   */
  delete is ArmResourceDeleteSync<
    PolicyRestrictionContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    }
  >;

  /**
   * Gets all policy restrictions of API Management services.
   */
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
