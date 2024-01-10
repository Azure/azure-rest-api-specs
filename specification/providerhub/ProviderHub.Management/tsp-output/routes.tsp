import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ProviderHub;

interface OperationsOperations {
  @doc("Deletes an operation.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/operations/default")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource provider hosted within ProviderHub.")
      @path
      providerNamespace: string;
    },
    void
  >;
}

interface SkusOperations {
  @doc("Gets the sku details for the given resource type and sku name.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/skus/{sku}")
  @get
  GetNestedResourceTypeFirst is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource provider hosted within ProviderHub.")
      @path
      providerNamespace: string;

      @doc("The resource type.")
      @path
      resourceType: string;

      @doc("The first child resource type.")
      @path
      nestedResourceTypeFirst: string;

      @doc("The SKU.")
      @path
      sku: string;
    },
    SkuResource
  >;

  @doc("Creates or updates the resource type skus in the given resource type.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/skus/{sku}")
  @put
  CreateOrUpdateNestedResourceTypeFirst is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource provider hosted within ProviderHub.")
      @path
      providerNamespace: string;

      @doc("The resource type.")
      @path
      resourceType: string;

      @doc("The first child resource type.")
      @path
      nestedResourceTypeFirst: string;

      @doc("The SKU.")
      @path
      sku: string;

      @doc("The required body parameters supplied to the resource sku operation.")
      @body
      properties: SkuResource;
    },
    SkuResource
  >;

  @doc("Deletes a resource type sku.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/skus/{sku}")
  @delete
  DeleteNestedResourceTypeFirst is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource provider hosted within ProviderHub.")
      @path
      providerNamespace: string;

      @doc("The resource type.")
      @path
      resourceType: string;

      @doc("The first child resource type.")
      @path
      nestedResourceTypeFirst: string;

      @doc("The SKU.")
      @path
      sku: string;
    },
    void
  >;

  @doc("Gets the sku details for the given resource type and sku name.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/resourcetypeRegistrations/{nestedResourceTypeSecond}/skus/{sku}")
  @get
  GetNestedResourceTypeSecond is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource provider hosted within ProviderHub.")
      @path
      providerNamespace: string;

      @doc("The resource type.")
      @path
      resourceType: string;

      @doc("The first child resource type.")
      @path
      nestedResourceTypeFirst: string;

      @doc("The second child resource type.")
      @path
      nestedResourceTypeSecond: string;

      @doc("The SKU.")
      @path
      sku: string;
    },
    SkuResource
  >;

  @doc("Creates or updates the resource type skus in the given resource type.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/resourcetypeRegistrations/{nestedResourceTypeSecond}/skus/{sku}")
  @put
  CreateOrUpdateNestedResourceTypeSecond is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource provider hosted within ProviderHub.")
      @path
      providerNamespace: string;

      @doc("The resource type.")
      @path
      resourceType: string;

      @doc("The first child resource type.")
      @path
      nestedResourceTypeFirst: string;

      @doc("The second child resource type.")
      @path
      nestedResourceTypeSecond: string;

      @doc("The SKU.")
      @path
      sku: string;

      @doc("The required body parameters supplied to the resource sku operation.")
      @body
      properties: SkuResource;
    },
    SkuResource
  >;

  @doc("Deletes a resource type sku.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/resourcetypeRegistrations/{nestedResourceTypeSecond}/skus/{sku}")
  @delete
  DeleteNestedResourceTypeSecond is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource provider hosted within ProviderHub.")
      @path
      providerNamespace: string;

      @doc("The resource type.")
      @path
      resourceType: string;

      @doc("The first child resource type.")
      @path
      nestedResourceTypeFirst: string;

      @doc("The second child resource type.")
      @path
      nestedResourceTypeSecond: string;

      @doc("The SKU.")
      @path
      sku: string;
    },
    void
  >;

  @doc("Gets the sku details for the given resource type and sku name.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/resourcetypeRegistrations/{nestedResourceTypeSecond}/resourcetypeRegistrations/{nestedResourceTypeThird}/skus/{sku}")
  @get
  GetNestedResourceTypeThird is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource provider hosted within ProviderHub.")
      @path
      providerNamespace: string;

      @doc("The resource type.")
      @path
      resourceType: string;

      @doc("The first child resource type.")
      @path
      nestedResourceTypeFirst: string;

      @doc("The second child resource type.")
      @path
      nestedResourceTypeSecond: string;

      @doc("The third child resource type.")
      @path
      nestedResourceTypeThird: string;

      @doc("The SKU.")
      @path
      sku: string;
    },
    SkuResource
  >;

  @doc("Creates or updates the resource type skus in the given resource type.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/resourcetypeRegistrations/{nestedResourceTypeSecond}/resourcetypeRegistrations/{nestedResourceTypeThird}/skus/{sku}")
  @put
  CreateOrUpdateNestedResourceTypeThird is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource provider hosted within ProviderHub.")
      @path
      providerNamespace: string;

      @doc("The resource type.")
      @path
      resourceType: string;

      @doc("The first child resource type.")
      @path
      nestedResourceTypeFirst: string;

      @doc("The second child resource type.")
      @path
      nestedResourceTypeSecond: string;

      @doc("The third child resource type.")
      @path
      nestedResourceTypeThird: string;

      @doc("The SKU.")
      @path
      sku: string;

      @doc("The required body parameters supplied to the resource sku operation.")
      @body
      properties: SkuResource;
    },
    SkuResource
  >;

  @doc("Deletes a resource type sku.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/resourcetypeRegistrations/{nestedResourceTypeSecond}/resourcetypeRegistrations/{nestedResourceTypeThird}/skus/{sku}")
  @delete
  DeleteNestedResourceTypeThird is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource provider hosted within ProviderHub.")
      @path
      providerNamespace: string;

      @doc("The resource type.")
      @path
      resourceType: string;

      @doc("The first child resource type.")
      @path
      nestedResourceTypeFirst: string;

      @doc("The second child resource type.")
      @path
      nestedResourceTypeSecond: string;

      @doc("The third child resource type.")
      @path
      nestedResourceTypeThird: string;

      @doc("The SKU.")
      @path
      sku: string;
    },
    void
  >;

  @doc("Gets the list of skus for the given resource type.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/skus")
  @get
  ListByResourceTypeRegistrationsNestedResourceTypeFirst is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource provider hosted within ProviderHub.")
      @path
      providerNamespace: string;

      @doc("The resource type.")
      @path
      resourceType: string;

      @doc("The first child resource type.")
      @path
      nestedResourceTypeFirst: string;
    },
    ResourceListResult<SkuResource>
  >;

  @doc("Gets the list of skus for the given resource type.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/resourcetypeRegistrations/{nestedResourceTypeSecond}/skus")
  @get
  ListByResourceTypeRegistrationsNestedResourceTypeSecond is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource provider hosted within ProviderHub.")
      @path
      providerNamespace: string;

      @doc("The resource type.")
      @path
      resourceType: string;

      @doc("The first child resource type.")
      @path
      nestedResourceTypeFirst: string;

      @doc("The second child resource type.")
      @path
      nestedResourceTypeSecond: string;
    },
    ResourceListResult<SkuResource>
  >;

  @doc("Gets the list of skus for the given resource type.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/resourcetypeRegistrations/{nestedResourceTypeSecond}/resourcetypeRegistrations/{nestedResourceTypeThird}/skus")
  @get
  ListByResourceTypeRegistrationsNestedResourceTypeThird is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource provider hosted within ProviderHub.")
      @path
      providerNamespace: string;

      @doc("The resource type.")
      @path
      resourceType: string;

      @doc("The first child resource type.")
      @path
      nestedResourceTypeFirst: string;

      @doc("The second child resource type.")
      @path
      nestedResourceTypeSecond: string;

      @doc("The third child resource type.")
      @path
      nestedResourceTypeThird: string;
    },
    ResourceListResult<SkuResource>
  >;
}
