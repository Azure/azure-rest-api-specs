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

namespace Microsoft.ServiceBus;
/**
 * Description of a namespace resource.
 */
model ServiceBusNamespace is TrackedResource<SBNamespaceProperties> {
  /**
   * The namespace name
   */
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
interface ServiceBusNamespaces {
  /**
   * Gets a description for the specified namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_Get")
  get is ArmResourceRead<ServiceBusNamespace>;

  /**
   * Creates or updates a service namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ServiceBusNamespace>;

  /**
   * Updates a service namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Namespaces_Update")
  update is ArmCustomPatchSync<
    ServiceBusNamespace,
    ServiceBusNamespaceUpdateParameters
  >;

  /**
   * Deletes an existing namespace. This operation also removes all associated resources under the namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_Delete")
  delete is ArmResourceDeleteAsync<ServiceBusNamespace>;

  /**
   * Gets the available namespaces within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ServiceBusNamespace>;

  /**
   * Gets all the available namespaces within the subscription, irrespective of the resource groups.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_List")
  list is ArmListBySubscription<ServiceBusNamespace>;

  /**
   * Check the give namespace name availability.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DisasterRecoveryConfigs_CheckNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    ServiceBusNamespace,
    ServiceBusNameAvailabilityContent,
    ServiceBusNameAvailabilityResult
  >;

  /**
   * Gets lists of resources that supports Privatelinks.
   */
  // FIXME: PrivateLinkResources_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/privateLinkResources")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The namespace name
       */
      @maxLength(50)
      @minLength(6)
      @path
      namespaceName: string;

      /**
       * Subscription credentials that uniquely identify a Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    PrivateLinkResourcesListResult
  >;
}

@@projectedName(ServiceBusNamespaces.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServiceBusNamespaces.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServiceBusNamespaces.createOrUpdate::parameters.resource,
  "Parameters supplied to create a namespace resource."
);
@@projectedName(ServiceBusNamespaces.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ServiceBusNamespaces.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServiceBusNamespaces.update::parameters.properties,
  "Parameters supplied to update a namespace resource."
);
@@projectedName(ServiceBusNamespaces.checkNameAvailability::parameters.body,
  "json",
  "parameters"
);
@@extension(ServiceBusNamespaces.checkNameAvailability::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServiceBusNamespaces.checkNameAvailability::parameters.body,
  "Parameters to check availability of the given namespace name"
);
