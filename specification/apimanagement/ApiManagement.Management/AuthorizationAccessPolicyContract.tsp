import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AuthorizationContract.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Authorization access policy contract.
 */
@parentResource(AuthorizationContract)
model AuthorizationAccessPolicyContract
  is Azure.ResourceManager.ProxyResource<AuthorizationAccessPolicyContractProperties> {
  ...ResourceNameParameter<
    Resource = AuthorizationAccessPolicyContract,
    KeyName = "authorizationAccessPolicyId",
    SegmentName = "accessPolicies",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface AuthorizationAccessPolicyContracts {
  /**
   * Gets the details of the authorization access policy specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AuthorizationAccessPolicy_Get")
  get is ArmResourceRead<AuthorizationAccessPolicyContract>;

  /**
   * Creates or updates Authorization Access Policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AuthorizationAccessPolicy_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    AuthorizationAccessPolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Deletes specific access policy from the Authorization.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AuthorizationAccessPolicy_Delete")
  delete is ArmResourceDeleteSync<
    AuthorizationAccessPolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Lists a collection of authorization access policy defined within a authorization.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AuthorizationAccessPolicy_ListByAuthorization")
  listByAuthorization is ArmResourceListByParent<
    AuthorizationAccessPolicyContract,
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
    Response = ArmResponse<AuthorizationAccessPolicyCollection>
  >;
}

@@maxLength(AuthorizationAccessPolicyContract.name, 256);
@@minLength(AuthorizationAccessPolicyContract.name, 1);
@@doc(AuthorizationAccessPolicyContract.name,
  "Identifier of the authorization access policy."
);
@@doc(AuthorizationAccessPolicyContract.properties,
  "Properties of the Authorization Contract."
);
@@doc(AuthorizationAccessPolicyContracts.createOrUpdate::parameters.resource,
  "Create parameters."
);
