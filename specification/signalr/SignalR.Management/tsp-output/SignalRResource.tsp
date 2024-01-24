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
@Azure.ResourceManager.Private.armResourceInternal(SignalRProperties)
@includeInapplicableMetadataInPayload(false)
model SignalRResource extends TrackedResourceBase {
  /**
   * The name of the resource.
   */
  @path
  @key("resourceName")
  @segment("signalR")
  name: string;

  /**
   * The kind of the service, it can be SignalR or RawWebSockets
   */
  @visibility("read", "create")
  kind?: ServiceKind;

  /**
   * A class that describes the properties of the resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: SignalRProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface SignalRResources {
  /**
   * Get the resource and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalR_Get")
  get is ArmResourceRead<SignalRResource>;

  /**
   * Create or update a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalR_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SignalRResource>;

  /**
   * Operation to update an exiting resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("SignalR_Update")
  update is ArmCustomPatchAsync<SignalRResource, SignalRResource>;

  /**
   * Operation to delete a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalR_Delete")
  delete is ArmResourceDeleteAsync<SignalRResource>;

  /**
   * Handles requests to list all resources in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalR_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<SignalRResource>;

  /**
   * Handles requests to list all resources in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalR_ListBySubscription")
  listBySubscription is ArmListBySubscription<SignalRResource>;

  /**
   * Get the access keys of the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalR_ListKeys")
  listKeys is ArmResourceActionSync<SignalRResource, void, SignalRKeys>;

  /**
   * Regenerate the access key for the resource. PrimaryKey and SecondaryKey cannot be regenerated at the same time.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalR_RegenerateKey")
  regenerateKey is ArmResourceActionNoResponseContentAsync<
    SignalRResource,
    RegenerateKeyParameters,
    BaseParameters<SignalRResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Operation to restart a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalR_Restart")
  restart is ArmResourceActionNoResponseContentAsync<
    SignalRResource,
    void,
    BaseParameters<SignalRResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Checks that the resource name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalR_CheckNameAvailability")
  checkNameAvailability is checkLocalNameAvailability<
    NameAvailabilityParameters,
    NameAvailability
  >;

  /**
   * List all available skus of the resource.
   */
  // FIXME: SignalR_ListSkus could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalR_ListSkus")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/skus")
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
  // FIXME: SignalRPrivateLinkResources_List could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalRPrivateLinkResources_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/privateLinkResources")
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

@@projectedName(SignalRResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(SignalRResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SignalRResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@projectedName(SignalRResources.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(SignalRResources.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(SignalRResources.update::parameters.properties,
  "Parameters for the update operation"
);
@@projectedName(SignalRResources.regenerateKey::parameters.body,
  "json",
  "parameters"
);
@@extension(SignalRResources.regenerateKey::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(SignalRResources.regenerateKey::parameters.body,
  "Parameter that describes the Regenerate Key Operation."
);
