import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevCenter;
/**
 * Represents a devcenter resource.
 */
model DevCenter is TrackedResource<DevCenterProperties> {
  /**
   * The name of the devcenter.
   */
  @path
  @key("devCenterName")
  @segment("devcenters")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface DevCenters {
  /**
   * Gets a devcenter.
   */
  get is ArmResourceRead<DevCenter>;

  /**
   * Creates or updates a devcenter resource
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DevCenter,
    BaseParameters<DevCenter>,
    ArmAsyncOperationHeader
  >;

  /**
   * Partially updates a devcenter.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    DevCenter,
    DevCenterUpdate,
    BaseParameters<DevCenter>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes a devcenter
   */
  delete is ArmResourceDeleteAsync<
    DevCenter,
    BaseParameters<DevCenter>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists all devcenters in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DevCenters_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    DevCenter,
    {
      ...BaseParameters<DevCenter>;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Lists all devcenters in a subscription.
   */
  listBySubscription is ArmListBySubscription<DevCenter>;

  /**
   * Lists images for a devcenter.
   */
  // FIXME: Images_ListByDevCenter could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Images_ListByDevCenter")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevCenter/devcenters/{devCenterName}/images")
  @get
  listByDevCenter is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the devcenter.
       */
      @path
      devCenterName: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;
    },
    ResourceListResult<Image>
  >;
}

@@projectedName(DevCenters.createOrUpdate::parameters.resource, "json", "body");
@@extension(DevCenters.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(DevCenters.createOrUpdate::parameters.resource,
  "Represents a devcenter."
);
@@projectedName(DevCenters.update::parameters.properties, "json", "body");
@@extension(DevCenters.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(DevCenters.update::parameters.properties,
  "Updatable devcenter properties."
);
