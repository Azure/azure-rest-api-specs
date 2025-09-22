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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ClientApplication_Get")
  get is ArmResourceRead<ClientApplicationContract>;

  /**
   * Gets the entity state (Etag) version of the product specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ClientApplication_GetEntityTag")
  getEntityTag is ArmResourceCheckExistence<ClientApplicationContract>;

  /**
   * Creates or Updates a client application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ClientApplication_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ClientApplicationContract>;

  /**
   * Delete client application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ClientApplication_Delete")
  delete is ArmResourceDeleteSync<ClientApplicationContract>;

  /**
   * Lists a collection of client applications in the specified service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ClientApplication_ListByService")
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
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<ClientApplicationCollection>
  >;

  /**
   * Retrived client application secrets.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ClientApplication_ListSecrets")
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
