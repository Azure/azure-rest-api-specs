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
@doc("A class represent a resource.")
model WebPubSub is TrackedResource<WebPubSubProperties> {
  @doc("The name of the resource.")
  @path
  @key("resourceName")
  @segment("webPubSub")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface WebPubSubs {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the resource and its properties.")
  @operationId("WebPubSub_Get")
  get is ArmResourceRead<WebPubSub>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a resource.")
  @operationId("WebPubSub_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<WebPubSub>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to update an exiting resource.")
  @operationId("WebPubSub_Update")
  update is ArmCustomPatchAsync<WebPubSub, WebPubSub>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to delete a resource.")
  @operationId("WebPubSub_Delete")
  delete is ArmResourceDeleteAsync<WebPubSub>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Handles requests to list all resources in a resource group.")
  @operationId("WebPubSub_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<WebPubSub>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Handles requests to list all resources in a subscription.")
  @operationId("WebPubSub_ListBySubscription")
  listBySubscription is ArmListBySubscription<WebPubSub>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the access keys of the resource.")
  @operationId("WebPubSub_ListKeys")
  listKeys is ArmResourceActionSync<WebPubSub, void, WebPubSubKeys>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Regenerate the access key for the resource. PrimaryKey and SecondaryKey cannot be regenerated at the same time.")
  @operationId("WebPubSub_RegenerateKey")
  regenerateKey is ArmResourceActionNoResponseContentAsync<
    WebPubSub,
    RegenerateKeyParameters,
    BaseParameters<WebPubSub>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to restart a resource.")
  @operationId("WebPubSub_Restart")
  restart is ArmResourceActionNoResponseContentAsync<
    WebPubSub,
    void,
    BaseParameters<WebPubSub>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Checks that the resource name is valid and is not already in use.")
  @operationId("WebPubSub_CheckNameAvailability")
  checkNameAvailability is checkLocalNameAvailability<
    WebPubSubNameAvailabilityParameters,
    WebPubSubNameAvailability
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebPubSub_ListSkus")
  @doc("List all available skus of the resource.")
  // FIXME: WebPubSub_ListSkus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/skus")
  @get
  listSkus is Azure.Core.Foundations.Operation<
    {
      @doc("Gets subscription Id which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;
    },
    SkuList
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebPubSubPrivateLinkResources_List")
  @doc("Get the private link resources that need to be created for a resource.")
  // FIXME: WebPubSubPrivateLinkResources_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/webPubSub/{resourceName}/privateLinkResources")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Gets subscription Id which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
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
