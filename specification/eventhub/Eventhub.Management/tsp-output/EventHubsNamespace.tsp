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
/**
 * Single Namespace item in List or Get Operation
 */
model EventHubsNamespace is TrackedResource<EHNamespaceProperties> {
  /**
   * The Namespace name
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
interface EventHubsNamespaces {
  /**
   * Gets the description of the specified namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_Get")
  get is ArmResourceRead<EventHubsNamespace>;

  /**
   * Creates or updates a namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EventHubsNamespace>;

  /**
   * Creates or updates a namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Namespaces_Update")
  update is ArmCustomPatchSync<EventHubsNamespace, EventHubsNamespace>;

  /**
   * Deletes an existing namespace. This operation also removes all associated resources under the namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_Delete")
  delete is ArmResourceDeleteAsync<EventHubsNamespace>;

  /**
   * Lists the available Namespaces within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<EventHubsNamespace>;

  /**
   * Lists all the available Namespaces within a subscription, irrespective of the resource groups.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_List")
  list is ArmListBySubscription<EventHubsNamespace>;

  /**
   * Refreshes any information about the association.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkSecurityPerimeterConfigurations_CreateOrUpdate")
  Refreshes is ArmResourceActionAsync<
    EventHubsNamespace,
    void,
    void,
    {
      ...BaseParameters<EventHubsNamespace>;

      /**
       * The ResourceAssociation Name
       */
      @path
      resourceAssociationName: string;
    }
  >;

  /**
   * Check the give Namespace name availability.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DisasterRecoveryConfigs_CheckNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    EventHubsNamespace,
    EventHubsNameAvailabilityContent,
    EventHubsNameAvailabilityResult
  >;

  /**
   * Check the give Namespace name availability.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_CheckNameAvailability")
  checkNameSpaceAvailability is checkGlobalNameAvailability<
    EventHubsNameAvailabilityContent,
    EventHubsNameAvailabilityResult
  >;

  /**
   * Gets lists of resources that supports Privatelinks.
   */
  // FIXME: PrivateLinkResources_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/privateLinkResources")
  @get
  gets is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group within the azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The Namespace name
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

  /**
   * Gets list of current NetworkSecurityPerimeterConfiguration for Namespace
   */
  // FIXME: NetworkSecurityPerimeterConfiguration_List could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkSecurityPerimeterConfiguration_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations")
  @get
  listNamespaces is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group within the azure subscription.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The Namespace name
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
