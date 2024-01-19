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
model SignalRResource is TrackedResource<SignalRProperties> {
  @doc("The name of the resource.")
  @path
  @key("resourceName")
  @segment("signalR")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface SignalRResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the resource and its properties.")
  @operationId("SignalR_Get")
  get is ArmResourceRead<SignalRResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a resource.")
  @operationId("SignalR_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SignalRResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to update an exiting resource.")
  @operationId("SignalR_Update")
  update is ArmCustomPatchAsync<SignalRResource, SignalRResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to delete a resource.")
  @operationId("SignalR_Delete")
  delete is ArmResourceDeleteAsync<SignalRResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Handles requests to list all resources in a resource group.")
  @operationId("SignalR_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<SignalRResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Handles requests to list all resources in a subscription.")
  @operationId("SignalR_ListBySubscription")
  listBySubscription is ArmListBySubscription<SignalRResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the access keys of the resource.")
  @operationId("SignalR_ListKeys")
  listKeys is ArmResourceActionSync<SignalRResource, void, SignalRKeys>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Regenerate the access key for the resource. PrimaryKey and SecondaryKey cannot be regenerated at the same time.")
  @operationId("SignalR_RegenerateKey")
  regenerateKey is ArmResourceActionNoResponseContentAsync<
    SignalRResource,
    RegenerateKeyParameters,
    BaseParameters<SignalRResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to restart a resource.")
  @operationId("SignalR_Restart")
  restart is ArmResourceActionNoResponseContentAsync<
    SignalRResource,
    void,
    BaseParameters<SignalRResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Checks that the resource name is valid and is not already in use.")
  @operationId("SignalR_CheckNameAvailability")
  checkNameAvailability is checkLocalNameAvailability<
    NameAvailabilityParameters,
    NameAvailability
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SignalR_ListSkus")
  @doc("List all available skus of the resource.")
  // FIXME: SignalR_ListSkus could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/skus")
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
  @operationId("SignalRPrivateLinkResources_List")
  @doc("Get the private link resources that need to be created for a resource.")
  // FIXME: SignalRPrivateLinkResources_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SignalRService/signalR/{resourceName}/privateLinkResources")
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
