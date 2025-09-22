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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Authorization_Get")
  get is ArmResourceRead<AuthorizationContract>;

  /**
   * Creates or updates authorization.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Authorization_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    AuthorizationContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Deletes specific Authorization from the Authorization provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Authorization_Delete")
  delete is ArmResourceDeleteSync<
    AuthorizationContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Lists a collection of authorization providers defined within a authorization provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Authorization_ListByAuthorizationProvider")
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
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<AuthorizationCollection>
  >;

  /**
   * Confirm valid consent code to suppress Authorizations anti-phishing page.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Authorization_ConfirmConsentCode")
  confirmConsentCode is ArmResourceActionSync<
    AuthorizationContract,
    AuthorizationConfirmConsentCodeRequestContract,
    OkResponse
  >;

  /**
   * Gets authorization login links.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AuthorizationLoginLinks_Post")
  @action("getLoginLinks")
  post is ArmResourceActionSync<
    AuthorizationContract,
    AuthorizationLoginRequestContract,
    ArmResponse<AuthorizationLoginResponseContract>
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
