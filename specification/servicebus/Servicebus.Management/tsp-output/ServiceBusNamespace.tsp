import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ServiceBus;
@doc("Description of a namespace resource.")
model ServiceBusNamespace is TrackedResource<SBNamespaceProperties> {
  @doc("The namespace name")
  @maxLength(50)
  @minLength(6)
  @key("namespaceName")
  @segment("namespaces")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface Namespaces {
  // @doc("Gets a description for the specified namespace.")
  // get is ArmResourceRead<ServiceBusNamespace>;
  // @doc("Creates or updates a service namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.")
  // createOrUpdate is ArmResourceCreateOrUpdateAsync<ServiceBusNamespace>;
  @doc("Updates a service namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.")
  update is ArmCustomPatchSync<
    ServiceBusNamespace,
    ServiceBusNamespaceUpdateParameters
  >;
  // @doc("Deletes an existing namespace. This operation also removes all associated resources under the namespace.")
  // delete is ArmResourceDeleteAsync<ServiceBusNamespace>;
  @doc("Gets the available namespaces within a resource group.")
  listByResourceGroup is ArmResourceListByParent<ServiceBusNamespace>;
  @doc("Gets all the available namespaces within the subscription, irrespective of the resource groups.")
  list is ArmListBySubscription<ServiceBusNamespace>;
}

// @armResourceOperations
// interface DisasterRecoveryConfigs {
//   @doc("Check the give namespace name availability.")
//   checkNameAvailability is ArmResourceActionSync<
//     ServiceBusNamespace,
//     ServiceBusNameAvailabilityContent,
//     ServiceBusNameAvailabilityResult
//   >;
// }

@armResourceOperations
interface PrivateLinkResources {
  @doc("Gets lists of resources that supports Privatelinks.")
  // FIXME: PrivateLinkResources_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ServiceBus/namespaces/{namespaceName}/privateLinkResources")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the Resource group within the Azure subscription.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The namespace name")
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
}