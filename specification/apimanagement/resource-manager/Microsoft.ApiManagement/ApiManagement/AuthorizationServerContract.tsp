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
 * External OAuth authorization server settings.
 */
@parentResource(ApiManagementServiceResource)
model AuthorizationServerContract
  is Azure.ResourceManager.ProxyResource<AuthorizationServerContractProperties> {
  ...ResourceNameParameter<
    Resource = AuthorizationServerContract,
    KeyName = "authsid",
    SegmentName = "authorizationServers",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface AuthorizationServerContractsOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(50)
        serviceName: string,
      },
      {
        /** Identifier of the authorization server. */
        @path
        @segment("authorizationServers")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        authsid: string,
      },
      ResourceName = "ApiManagementAuthorizationServer"
    > {}
@armResourceOperations
interface AuthorizationServerContracts {
  /**
   * Gets the details of the authorization server specified by its identifier.
   */
  get is AuthorizationServerContractsOps.Read<
    AuthorizationServerContract,
    Response = ArmResponse<AuthorizationServerContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the authorizationServer specified by its identifier.
   */
  getEntityTag is AuthorizationServerContractsOps.CheckExistence<
    AuthorizationServerContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Creates new authorization server or updates an existing authorization server.
   */
  createOrUpdate is AuthorizationServerContractsOps.CreateOrUpdateSync<
    AuthorizationServerContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response =
      | (ArmResponse<AuthorizationServerContract> & {
          /**
           * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
           */
          @header("ETag")
          eTag: string;
        })
      | (ArmCreatedResponse<AuthorizationServerContract> & {
          /**
           * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
           */
          @header("ETag")
          eTag: string;
        })
  >;

  /**
   * Updates the details of the authorization server specified by its identifier.
   */
  @patch(#{ implicitOptionality: false })
  update is AuthorizationServerContractsOps.CustomPatchSync<
    AuthorizationServerContract,
    PatchModel = AuthorizationServerUpdateContract,
    Parameters = IfMatchHeaderParameter,
    Response = ArmResponse<AuthorizationServerContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Deletes specific authorization server instance.
   */
  delete is AuthorizationServerContractsOps.DeleteSync<
    AuthorizationServerContract,
    Parameters = IfMatchHeaderParameter
  >;

  /**
   * Lists a collection of authorization servers defined within a service instance.
   */
  listByService is AuthorizationServerContractsOps.List<
    AuthorizationServerContract,
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
    Response = ArmResponse<AuthorizationServerCollection>
  >;

  /**
   * Gets the client secret details of the authorization server.
   */
  listSecrets is AuthorizationServerContractsOps.ActionSync<
    AuthorizationServerContract,
    void,
    Response = ArmResponse<AuthorizationServerSecretsContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;
}

@@maxLength(AuthorizationServerContract.name, 80);
@@minLength(AuthorizationServerContract.name, 1);
@@doc(
  AuthorizationServerContract.name,
  "Identifier of the authorization server."
);
@@doc(
  AuthorizationServerContract.properties,
  "Properties of the External OAuth authorization server Contract."
);
@@doc(
  AuthorizationServerContracts.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
@@doc(
  AuthorizationServerContracts.update::parameters.properties,
  "OAuth2 Server settings Update parameters."
);
