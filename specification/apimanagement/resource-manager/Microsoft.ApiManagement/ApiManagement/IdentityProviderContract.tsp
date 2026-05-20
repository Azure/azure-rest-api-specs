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
 * Identity Provider details.
 */
@parentResource(ApiManagementServiceResource)
model IdentityProviderContract
  is Azure.ResourceManager.ProxyResource<IdentityProviderContractProperties> {
  ...ResourceNameParameter<
    Resource = IdentityProviderContract,
    KeyName = "identityProviderName",
    SegmentName = "identityProviders",
    NamePattern = "",
    Type = IdentityProviderType
  >;
}

@armResourceOperations
interface IdentityProviderContracts {
  /**
   * Gets the configuration details of the identity Provider configured in specified service instance.
   */
  get is ArmResourceRead<
    IdentityProviderContract,
    Response = ArmResponse<IdentityProviderContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag?: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the identityProvider specified by its identifier.
   */
  getEntityTag is ArmResourceCheckExistence<
    IdentityProviderContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag?: string;
    }
  >;

  /**
   * Creates or Updates the IdentityProvider configuration.
   */
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    IdentityProviderContract,
    Request = IdentityProviderCreateContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<IdentityProviderContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag?: string;
    }) | (ArmResourceCreatedSyncResponse<IdentityProviderContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag?: string;
    })
  >;

  /**
   * Updates an existing IdentityProvider configuration.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    IdentityProviderContract,
    PatchModel = IdentityProviderUpdateParameters,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<IdentityProviderContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag?: string;
    }
  >;

  /**
   * Deletes the specified identity provider configuration.
   */
  delete is ArmResourceDeleteSync<
    IdentityProviderContract,
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
   * Lists a collection of Identity Provider configured in the specified service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-aad#how-to-authorize-developer-accounts-using-azure-active-directory")
  listByService is ArmResourceListByParent<
    IdentityProviderContract,
    Response = ArmResponse<IdentityProviderList>
  >;

  /**
   * Gets the client secret details of the Identity Provider.
   */
  listSecrets is ArmResourceActionSync<
    IdentityProviderContract,
    void,
    Response = ArmResponse<ClientSecretContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag?: string;
    }
  >;
}

@@doc(IdentityProviderContract.name, "Identity Provider Type identifier.");
@@doc(IdentityProviderContract.properties,
  "Identity Provider contract properties."
);
@@doc(IdentityProviderContracts.createOrUpdate::parameters.resource,
  "Create parameters."
);
@@doc(IdentityProviderContracts.update::parameters.properties,
  "Update parameters."
);
