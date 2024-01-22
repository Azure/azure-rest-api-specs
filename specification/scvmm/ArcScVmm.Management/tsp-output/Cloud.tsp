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

namespace Microsoft.ScVmm;
/**
 * The Clouds resource definition.
 */
model Cloud is TrackedResource<CloudProperties> {
  /**
   * Name of the Cloud.
   */
  @path
  @key("cloudName")
  @segment("clouds")
  name: string;

  /**
   * The extended location.
   */
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface Clouds {
  /**
   * Implements Cloud GET method.
   */
  get is ArmResourceRead<Cloud>;

  /**
   * Onboards the ScVmm fabric cloud as an Azure cloud resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Cloud,
    BaseParameters<Cloud>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates the Clouds resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    Cloud,
    ResourcePatch,
    BaseParameters<Cloud>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deregisters the ScVmm fabric cloud from Azure.
   */
  delete is ArmResourceDeleteAsync<
    Cloud,
    {
      ...BaseParameters<Cloud>;

      /**
       * Forces the resource to be deleted from azure. The corresponding CR would be attempted to be deleted too.
       */
      @query("force")
      force?: boolean;
    },
    ArmAsyncOperationHeader
  >;

  /**
   * List of Clouds in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Clouds_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Cloud>;

  /**
   * List of Clouds in a subscription.
   */
  listBySubscription is ArmListBySubscription<Cloud>;
}

@@projectedName(Clouds.createOrUpdate::parameters.resource, "json", "body");
@@extension(Clouds.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(Clouds.createOrUpdate::parameters.resource, "Request payload.");
@@projectedName(Clouds.update::parameters.properties, "json", "body");
@@extension(Clouds.update::parameters.properties, "x-ms-client-name", "body");
@@doc(Clouds.update::parameters.properties, "Clouds patch payload.");
