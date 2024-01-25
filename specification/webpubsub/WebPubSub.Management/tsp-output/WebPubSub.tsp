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

namespace Microsoft.SignalRService;
/**
 * A class represent a resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(WebPubSubProperties)
model WebPubSub extends TrackedResourceBase {
  /**
   * The name of the resource.
   */
  @path
  @key("resourceName")
  @segment("webPubSub")
  @visibility("read")
  name: string;

  /**
   * A class that describes the properties of the resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: WebPubSubProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface WebPubSubs {
  /**
   * Get the resource and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebPubSub_Get")
  get is ArmResourceRead<WebPubSub>;

  /**
   * Create or update a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebPubSub_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<WebPubSub>;

  /**
   * Operation to update an exiting resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("WebPubSub_Update")
  update is ArmCustomPatchAsync<WebPubSub, WebPubSub>;

  /**
   * Operation to delete a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebPubSub_Delete")
  delete is ArmResourceDeleteAsync<WebPubSub>;

  /**
   * Handles requests to list all resources in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebPubSub_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<WebPubSub>;

  /**
   * Handles requests to list all resources in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebPubSub_ListBySubscription")
  listBySubscription is ArmListBySubscription<WebPubSub>;

  /**
   * Get the access keys of the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebPubSub_ListKeys")
  listKeys is ArmResourceActionSync<WebPubSub, void, WebPubSubKeys>;

  /**
   * Regenerate the access key for the resource. PrimaryKey and SecondaryKey cannot be regenerated at the same time.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebPubSub_RegenerateKey")
  regenerateKey is ArmResourceActionNoResponseContentAsync<
    WebPubSub,
    RegenerateKeyParameters,
    BaseParameters<WebPubSub>,
    ArmAsyncOperationHeader
  >;

  /**
   * Operation to restart a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebPubSub_Restart")
  restart is ArmResourceActionNoResponseContentAsync<
    WebPubSub,
    void,
    BaseParameters<WebPubSub>,
    ArmAsyncOperationHeader
  >;

  /**
   * Checks that the resource name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebPubSub_CheckNameAvailability")
  checkNameAvailability is checkLocalNameAvailability<
    WebPubSubNameAvailabilityParameters,
    WebPubSubNameAvailability
  >;

  /**
   * List all available skus of the resource.
   */
  // FIXME: WebPubSub_ListSkus could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebPubSub_ListSkus")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/skus")
  @get
  listSkus is Azure.Core.Foundations.Operation<
    {
      /**
       * Gets subscription Id which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the resource.
       */
      @path
      resourceName: string;
    },
    SkuList
  >;

  /**
   * Get the private link resources that need to be created for a resource.
   */
  // FIXME: WebPubSubPrivateLinkResources_List could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebPubSubPrivateLinkResources_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/privateLinkResources")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * Gets subscription Id which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the resource.
       */
      @path
      resourceName: string;
    },
    PrivateLinkResourceList
  >;
}

@@projectedName(WebPubSubs.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(WebPubSubs.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(WebPubSubs.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@projectedName(WebPubSubs.update::parameters.properties, "json", "parameters");
@@extension(WebPubSubs.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(WebPubSubs.update::parameters.properties,
  "Parameters for the update operation"
);
@@projectedName(WebPubSubs.regenerateKey::parameters.body,
  "json",
  "parameters"
);
@@extension(WebPubSubs.regenerateKey::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(WebPubSubs.regenerateKey::parameters.body,
  "Parameter that describes the Regenerate Key Operation."
);
