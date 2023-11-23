import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.EventHub;
@doc("Single Namespace item in List or Get Operation")
model EHNamespace is TrackedResource<EHNamespaceProperties> {
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
interface EHNamespaces {
  @doc("Gets the description of the specified namespace.")
  get is ArmResourceRead<EHNamespace>;
  @doc("Creates or updates a namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EHNamespace>;
  @doc("Creates or updates a namespace. Once created, this namespace's resource manifest is immutable. This operation is idempotent.")
  update is ArmResourcePatchSync<EHNamespace, EHNamespaceProperties>;
  @doc("Deletes an existing namespace. This operation also removes all associated resources under the namespace.")
  delete is ArmResourceDeleteAsync<EHNamespace>;
  @doc("Lists the available Namespaces within a resource group.")
  listByResourceGroup is ArmResourceListByParent<EHNamespace>;
  @doc("Lists all the available Namespaces within a subscription, irrespective of the resource groups.")
  list is ArmListBySubscription<EHNamespace>;
  @doc("Refreshes any information about the association.")
  createOrUpdate is ArmResourceActionAsync<
    EHNamespace,
    {},
    {},
    {
      ...BaseParameters<EHNamespace>;

      @doc("The ResourceAssociation Name")
      @path
      resourceAssociationName: string;
    }
  >;
  @doc("Check the give Namespace name availability.")
  checkNameAvailability is ArmResourceActionSync<
    EHNamespace,
    CheckNameAvailabilityParameter,
    CheckNameAvailabilityResult
  >;
  @doc("Gets lists of resources that supports Privatelinks.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/privateLinkResources")
  @get
  Get is Azure.Core.Foundations.Operation<
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

  @doc("Gets list of current NetworkSecurityPerimeterConfiguration for Namespace")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventHub/namespaces/{namespaceName}/networkSecurityPerimeterConfigurations")
  @get
  List is Azure.Core.Foundations.Operation<
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
