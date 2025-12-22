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
 * Authorization Provider contract.
 */
@parentResource(ApiManagementServiceResource)
model AuthorizationProviderContract
  is Azure.ResourceManager.ProxyResource<AuthorizationProviderContractProperties> {
  ...ResourceNameParameter<
    Resource = AuthorizationProviderContract,
    KeyName = "authorizationProviderId",
    SegmentName = "authorizationProviders",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface AuthorizationProviderContracts {
  /**
   * Gets the details of the authorization provider specified by its identifier.
   */
  get is ArmResourceRead<
    AuthorizationProviderContract,
    Response = ArmResponse<AuthorizationProviderContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or updates authorization provider.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    AuthorizationProviderContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<AuthorizationProviderContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmCreatedResponse<AuthorizationProviderContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Deletes specific authorization provider from the API Management service instance.
   */
  delete is ArmResourceDeleteSync<
    AuthorizationProviderContract,
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
   * Lists a collection of authorization providers defined within a service instance.
   */
  listByService is ArmResourceListByParent<
    AuthorizationProviderContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<AuthorizationProviderCollection>
  >;

  /**
   * Refreshes the Key Vault reference secret for the specified authorization provider.
   */
  refreshSecret is ArmResourceActionSync<
    AuthorizationProviderContract,
    void,
    Response = ArmResponse<AuthorizationProviderContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;
}

@@maxLength(AuthorizationProviderContract.name, 256);
@@minLength(AuthorizationProviderContract.name, 1);
@@doc(AuthorizationProviderContract.name,
  "Identifier of the authorization provider."
);
@@doc(AuthorizationProviderContract.properties,
  "Properties of the Authorization Provider Contract."
);
@@doc(AuthorizationProviderContracts.createOrUpdate::parameters.resource,
  "Create parameters."
);
