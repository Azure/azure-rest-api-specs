import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MoveCollection.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Migrate;
/**
 * Defines the move resource.
 */
@parentResource(MoveCollection)
model MoveResource is ProxyResource<MoveResourceProperties> {
  /**
   * The Move Resource Name.
   */
  @path
  @key("moveResourceName")
  @segment("moveResources")
  name: string;
}

@armResourceOperations
interface MoveResources {
  /**
   * Gets the Move Resource.
   */
  get is ArmResourceRead<
    MoveResource,
    {
      ...BaseParameters<MoveResource>;

      /**
       * The Move Collection Name.
       */
      @path
      moverResourceSetName: string;

      /**
       * The Move Resource Name.
       */
      @path
      moverResourceName: string;
    }
  >;

  /**
   * Creates or updates a Move Resource in the move collection.
   */
  create is ArmResourceCreateOrReplaceAsync<
    MoveResource,
    {
      ...BaseParameters<MoveResource>;

      /**
       * The Move Collection Name.
       */
      @path
      moverResourceSetName: string;

      /**
       * The Move Resource Name.
       */
      @path
      moverResourceName: string;
    },
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes a Move Resource from the move collection.
   */
  delete is ArmResourceDeleteAsync<
    MoveResource,
    {
      ...BaseParameters<MoveResource>;

      /**
       * The Move Collection Name.
       */
      @path
      moverResourceSetName: string;

      /**
       * The Move Resource Name.
       */
      @path
      moverResourceName: string;
    },
    ArmAsyncOperationHeader
  >;

  /**
   * Lists the Move Resources in the move collection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MoveResources_List")
  list is ArmResourceListByParent<
    MoveResource,
    {
      ...BaseParameters<MoveResource>;

      /**
       * The Move Collection Name.
       */
      @path
      moverResourceSetName: string;

      /**
       * The filter to apply on the operation. For example, you can use $filter=Properties/ProvisioningState eq 'Succeeded'.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@projectedName(MoveResources.create::parameters.resource, "json", "body");
@@extension(MoveResources.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(MoveResources.create::parameters.resource, "");
