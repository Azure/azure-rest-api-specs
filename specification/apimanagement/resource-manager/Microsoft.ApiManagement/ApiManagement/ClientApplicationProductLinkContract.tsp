import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ClientApplicationContract.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Specifies Client Application - Product link assignment
 */
@parentResource(ClientApplicationContract)
model ClientApplicationProductLinkContract
  is Azure.ResourceManager.ProxyResource<ClientApplicationProductLinkContractProperties> {
  ...ResourceNameParameter<
    Resource = ClientApplicationProductLinkContract,
    KeyName = "clientApplicationProductLinkId",
    SegmentName = "productLinks",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ClientApplicationProductLinkContracts {
  /**
   * Gets the product link for the client application.
   */
  get is ArmResourceRead<
    ClientApplicationProductLinkContract,
    Response = ArmResponse<ClientApplicationProductLinkContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Adds an Product to the specified Client Application via link.
   */
  create is ArmResourceCreateOrReplaceSync<ClientApplicationProductLinkContract>;

  /**
   * Deletes the specified Product from the specified client application.
   */
  delete is ArmResourceDeleteSync<ClientApplicationProductLinkContract>;

  /**
   * Lists a collection of product links associated with the specified client application.
   */
  listByClientApplications is ArmResourceListByParent<
    ClientApplicationProductLinkContract,
    Parameters = {
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
    Response = ArmResponse<ClientApplicationProductLinkCollection>
  >;
}

@@maxLength(ClientApplicationProductLinkContract.name, 256);
@@minLength(ClientApplicationProductLinkContract.name, 1);
@@doc(ClientApplicationProductLinkContract.name,
  "Client Application Product Link identifier. Must be unique in the current API Management service instance."
);
@@doc(ClientApplicationProductLinkContract.properties,
  "Client application - product link entity contract properties."
);
@@doc(ClientApplicationProductLinkContracts.create::parameters.resource,
  "Create parameters."
);
