import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AuthorizationProviderContract.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Authorization contract.
 */
@parentResource(AuthorizationProviderContract)
model AuthorizationContract
  is Azure.ResourceManager.ProxyResource<AuthorizationContractProperties> {
  ...ResourceNameParameter<
    Resource = AuthorizationContract,
    KeyName = "authorizationId",
    SegmentName = "authorizations",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface AuthorizationContracts {
  /**
   * Gets the details of the authorization specified by its identifier.
   */
  get is ArmResourceRead<
    AuthorizationContract,
    Response = ArmResponse<AuthorizationContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or updates authorization.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    AuthorizationContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<AuthorizationContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<AuthorizationContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Deletes specific Authorization from the Authorization provider.
   */
  delete is ArmResourceDeleteSync<
    AuthorizationContract,
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
   * Lists a collection of authorization providers defined within a authorization provider.
   */
  listByAuthorizationProvider is ArmResourceListByParent<
    AuthorizationContract,
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
    Response = ArmResponse<AuthorizationCollection>
  >;

  /**
   * Confirm valid consent code to suppress Authorizations anti-phishing page.
   */
  confirmConsentCode is ArmResourceActionSync<
    AuthorizationContract,
    AuthorizationConfirmConsentCodeRequestContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets authorization login links.
   */
  @action("getLoginLinks")
  post is ArmResourceActionSync<
    AuthorizationContract,
    AuthorizationLoginRequestContract,
    Response = ArmResponse<AuthorizationLoginResponseContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;
}

@@maxLength(AuthorizationContract.name, 256);
@@minLength(AuthorizationContract.name, 1);
@@doc(AuthorizationContract.name, "Identifier of the authorization.");
@@doc(AuthorizationContract.properties,
  "Properties of the Authorization Contract."
);
@@doc(AuthorizationContracts.createOrUpdate::parameters.resource,
  "Create parameters."
);
@@doc(AuthorizationContracts.confirmConsentCode::parameters.body,
  "Create parameters."
);
@@doc(AuthorizationContracts.post::parameters.body, "Create parameters.");
