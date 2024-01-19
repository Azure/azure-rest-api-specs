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

namespace Microsoft.EventHub;
@doc("Single Namespace item in List or Get Operation")
model EventHubsNamespace is TrackedResource<EHNamespaceProperties> {
  @doc("The Namespace name")
  @maxLength(50)
  @minLength(6)
  @path
  @key("namespaceName")
  @segment("namespaces")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface EventHubsNamespaces {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the description of the specified namespace.")
  @operationId("Namespaces_Get")
  get is ArmResourceRead<EventHubsNamespace>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.")
  @operationId("Namespaces_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EventHubsNamespace>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.")
  @operationId("Namespaces_Update")
  update is ArmCustomPatchSync<EventHubsNamespace, EventHubsNamespace>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes an existing namespace. This operation also removes all associated resources under the namespace.")
  @operationId("Namespaces_Delete")
  delete is ArmResourceDeleteAsync<EventHubsNamespace>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the available Namespaces within a resource group.")
  @operationId("Namespaces_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<EventHubsNamespace>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all the available Namespaces within a subscription, irrespective of the resource groups.")
  @operationId("Namespaces_List")
  list is ArmListBySubscription<EventHubsNamespace>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Refreshes any information about the association.")
  @operationId("NetworkSecurityPerimeterConfigurations_CreateOrUpdate")
  createOrUpdate is ArmResourceActionAsync<
    EventHubsNamespace,
    void,
    void,
    {
      ...BaseParameters<EventHubsNamespace>;

      @doc("The ResourceAssociation Name")
      @path
      resourceAssociationName: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Check the give Namespace name availability.")
  @operationId("DisasterRecoveryConfigs_CheckNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    EventHubsNamespace,
    EventHubsNameAvailabilityContent,
    EventHubsNameAvailabilityResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Check the give Namespace name availability.")
  @operationId("Namespaces_CheckNameAvailability")
  checkNameAvailability is checkGlobalNameAvailability<
    EventHubsNameAvailabilityContent,
    EventHubsNameAvailabilityResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_Get")
  @doc("Gets lists of resources that supports Privatelinks.")
  // FIXME: PrivateLinkResources_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/privateLinkResources")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    PrivateLinkResourcesListResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkSecurityPerimeterConfiguration_List")
  @doc("Gets list of current NetworkSecurityPerimeterConfiguration for Namespace")
  // FIXME: NetworkSecurityPerimeterConfiguration_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group within the azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The Namespace name")
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      @doc("Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    NetworkSecurityPerimeterConfigurationList
  >;
}

@@projectedName(EventHubsNamespaces.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(EventHubsNamespaces.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(EventHubsNamespaces.createOrUpdate::parameters.resource,
  "Parameters for creating a namespace resource."
);
@@projectedName(EventHubsNamespaces.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(EventHubsNamespaces.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(EventHubsNamespaces.update::parameters.properties,
  "Parameters for updating a namespace resource."
);
@@projectedName(EventHubsNamespaces.checkNameAvailability::parameters.body,
  "json",
  "parameters"
);
@@extension(EventHubsNamespaces.checkNameAvailability::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(EventHubsNamespaces.checkNameAvailability::parameters.body,
  "Parameters to check availability of the given Alias name"
);
