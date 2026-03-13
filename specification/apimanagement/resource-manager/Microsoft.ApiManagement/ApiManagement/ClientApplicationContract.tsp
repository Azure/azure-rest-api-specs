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
 * Client application details.
 */
@parentResource(ApiManagementServiceResource)
model ClientApplicationContract
  is Azure.ResourceManager.ProxyResource<ClientApplicationContractProperties> {
  ...ResourceNameParameter<
    Resource = ClientApplicationContract,
    KeyName = "clientApplicationId",
    SegmentName = "clientApplications",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ClientApplicationContracts {
  /**
   * Gets the details of the client application specified by its identifier.
   */
  get is ArmResourceRead<
    ClientApplicationContract,
    Response = ArmResponse<ClientApplicationContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the product specified by its identifier.
   */
  getEntityTag is ArmResourceCheckExistence<
    ClientApplicationContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates or Updates a client application.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ClientApplicationContract,
    Response = (ArmResponse<ClientApplicationContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<ClientApplicationContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Delete client application.
   */
  delete is ArmResourceDeleteSync<ClientApplicationContract>;

  /**
   * Lists a collection of client applications in the specified service instance.
   */
  listByService is ArmResourceListByParent<
    ClientApplicationContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| description | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br> state | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>|
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
    Response = ArmResponse<ClientApplicationCollection>
  >;

  /**
   * Retrived client application secrets.
   */
  listSecrets is ArmResourceActionSync<
    ClientApplicationContract,
    void,
    ArmResponse<ClientApplicationSecretsContract>
  >;
}

@@maxLength(ClientApplicationContract.name, 256);
@@minLength(ClientApplicationContract.name, 1);
@@doc(ClientApplicationContract.name,
  "Client Application identifier. Must be unique in the current API Management service instance."
);
@@doc(ClientApplicationContract.properties,
  "Client application entity contract properties."
);
@@doc(ClientApplicationContracts.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
