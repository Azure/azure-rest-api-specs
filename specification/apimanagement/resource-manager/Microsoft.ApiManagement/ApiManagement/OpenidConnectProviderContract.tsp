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
 * OpenId Connect Provider details.
 */
@parentResource(ApiManagementServiceResource)
model OpenidConnectProviderContract
  is Azure.ResourceManager.ProxyResource<OpenidConnectProviderContractProperties> {
  ...ResourceNameParameter<
    Resource = OpenidConnectProviderContract,
    KeyName = "opid",
    SegmentName = "openidConnectProviders",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface OpenidConnectProviderContractsOps
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
        /** Identifier of the OpenID Connect Provider. */
        @path
        @segment("openidConnectProviders")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @maxLength(256)
        opid: string,
      },
      ResourceName = "ApiManagementOpenIdConnectProvider"
    > {}
@armResourceOperations
interface OpenidConnectProviderContracts {
  /**
   * Gets specific OpenID Connect Provider without secrets.
   */
  get is OpenidConnectProviderContractsOps.Read<
    OpenidConnectProviderContract,
    Response = ArmResponse<OpenidConnectProviderContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the openIdConnectProvider specified by its identifier.
   */
  getEntityTag is OpenidConnectProviderContractsOps.CheckExistence<
    OpenidConnectProviderContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Creates or updates the OpenID Connect Provider.
   */
  createOrUpdate is OpenidConnectProviderContractsOps.CreateOrUpdateSync<
    OpenidConnectProviderContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response =
      | (ArmResponse<OpenidConnectProviderContract> & {
          /**
           * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
           */
          @header("ETag")
          eTag: string;
        })
      | (ArmResourceCreatedSyncResponse<OpenidConnectProviderContract> & {
          /**
           * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
           */
          @header("ETag")
          eTag: string;
        })
  >;

  /**
   * Updates the specific OpenID Connect Provider.
   */
  @patch(#{ implicitOptionality: false })
  update is OpenidConnectProviderContractsOps.CustomPatchSync<
    OpenidConnectProviderContract,
    PatchModel = OpenidConnectProviderUpdateContract,
    Parameters = IfMatchHeaderParameter,
    Response = ArmResponse<OpenidConnectProviderContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Deletes specific OpenID Connect Provider of the API Management service instance.
   */
  delete is OpenidConnectProviderContractsOps.DeleteSync<
    OpenidConnectProviderContract,
    Parameters = IfMatchHeaderParameter
  >;

  /**
   * Lists of all the OpenId Connect Providers.
   */
  listByService is OpenidConnectProviderContractsOps.List<
    OpenidConnectProviderContract,
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
    Response = ArmResponse<OpenIdConnectProviderCollection>
  >;

  /**
   * Gets the client secret details of the OpenID Connect Provider.
   */
  listSecrets is OpenidConnectProviderContractsOps.ActionSync<
    OpenidConnectProviderContract,
    void,
    ArmResponse<ClientSecretContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;
}

@@maxLength(OpenidConnectProviderContract.name, 256);
@@doc(
  OpenidConnectProviderContract.name,
  "Identifier of the OpenID Connect Provider."
);
@@doc(
  OpenidConnectProviderContract.properties,
  "OpenId Connect Provider contract properties."
);
@@doc(
  OpenidConnectProviderContracts.createOrUpdate::parameters.resource,
  "Create parameters."
);
@@doc(
  OpenidConnectProviderContracts.update::parameters.properties,
  "Update parameters."
);
