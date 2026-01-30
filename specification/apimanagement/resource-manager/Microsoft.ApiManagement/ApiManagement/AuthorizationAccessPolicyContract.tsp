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
  get is ArmResourceRead<
    AuthorizationAccessPolicyContract,
    Response = ArmResponse<AuthorizationAccessPolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or updates Authorization Access Policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    AuthorizationAccessPolicyContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<AuthorizationAccessPolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<AuthorizationAccessPolicyContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Deletes specific access policy from the Authorization.
   */
  delete is ArmResourceDeleteSync<
    AuthorizationAccessPolicyContract,
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
   * Lists a collection of authorization access policy defined within a authorization.
   */
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
      @minValue(0)
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
