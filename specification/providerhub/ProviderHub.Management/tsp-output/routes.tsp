import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ProviderHub;

interface OperationsOperations {
  /**
   * Deletes an operation.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/operations/default")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource provider hosted within ProviderHub.
       */
      @path
      providerNamespace: string;
    },
    void
  >;
}

interface SkusOperations {
  /**
   * Gets the sku details for the given resource type and sku name.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/skus/{sku}")
  @get
  getNestedResourceTypeFirst is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource provider hosted within ProviderHub.
       */
      @path
      providerNamespace: string;

      /**
       * The resource type.
       */
      @path
      resourceType: string;

      /**
       * The first child resource type.
       */
      @path
      nestedResourceTypeFirst: string;

      /**
       * The SKU.
       */
      @path
      sku: string;
    },
    SkuResource
  >;

  /**
   * Creates or updates the resource type skus in the given resource type.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/skus/{sku}")
  @put
  createOrUpdateNestedResourceTypeFirst is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource provider hosted within ProviderHub.
       */
      @path
      providerNamespace: string;

      /**
       * The resource type.
       */
      @path
      resourceType: string;

      /**
       * The first child resource type.
       */
      @path
      nestedResourceTypeFirst: string;

      /**
       * The SKU.
       */
      @path
      sku: string;

      /**
       * The required body parameters supplied to the resource sku operation.
       */
      @body
      properties: SkuResource;
    },
    SkuResource
  >;

  /**
   * Deletes a resource type sku.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/skus/{sku}")
  @delete
  deleteNestedResourceTypeFirst is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource provider hosted within ProviderHub.
       */
      @path
      providerNamespace: string;

      /**
       * The resource type.
       */
      @path
      resourceType: string;

      /**
       * The first child resource type.
       */
      @path
      nestedResourceTypeFirst: string;

      /**
       * The SKU.
       */
      @path
      sku: string;
    },
    void
  >;

  /**
   * Gets the sku details for the given resource type and sku name.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/resourcetypeRegistrations/{nestedResourceTypeSecond}/skus/{sku}")
  @get
  getNestedResourceTypeSecond is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource provider hosted within ProviderHub.
       */
      @path
      providerNamespace: string;

      /**
       * The resource type.
       */
      @path
      resourceType: string;

      /**
       * The first child resource type.
       */
      @path
      nestedResourceTypeFirst: string;

      /**
       * The second child resource type.
       */
      @path
      nestedResourceTypeSecond: string;

      /**
       * The SKU.
       */
      @path
      sku: string;
    },
    SkuResource
  >;

  /**
   * Creates or updates the resource type skus in the given resource type.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/resourcetypeRegistrations/{nestedResourceTypeSecond}/skus/{sku}")
  @put
  createOrUpdateNestedResourceTypeSecond is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource provider hosted within ProviderHub.
       */
      @path
      providerNamespace: string;

      /**
       * The resource type.
       */
      @path
      resourceType: string;

      /**
       * The first child resource type.
       */
      @path
      nestedResourceTypeFirst: string;

      /**
       * The second child resource type.
       */
      @path
      nestedResourceTypeSecond: string;

      /**
       * The SKU.
       */
      @path
      sku: string;

      /**
       * The required body parameters supplied to the resource sku operation.
       */
      @body
      properties: SkuResource;
    },
    SkuResource
  >;

  /**
   * Deletes a resource type sku.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/resourcetypeRegistrations/{nestedResourceTypeSecond}/skus/{sku}")
  @delete
  deleteNestedResourceTypeSecond is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource provider hosted within ProviderHub.
       */
      @path
      providerNamespace: string;

      /**
       * The resource type.
       */
      @path
      resourceType: string;

      /**
       * The first child resource type.
       */
      @path
      nestedResourceTypeFirst: string;

      /**
       * The second child resource type.
       */
      @path
      nestedResourceTypeSecond: string;

      /**
       * The SKU.
       */
      @path
      sku: string;
    },
    void
  >;

  /**
   * Gets the sku details for the given resource type and sku name.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/resourcetypeRegistrations/{nestedResourceTypeSecond}/resourcetypeRegistrations/{nestedResourceTypeThird}/skus/{sku}")
  @get
  getNestedResourceTypeThird is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource provider hosted within ProviderHub.
       */
      @path
      providerNamespace: string;

      /**
       * The resource type.
       */
      @path
      resourceType: string;

      /**
       * The first child resource type.
       */
      @path
      nestedResourceTypeFirst: string;

      /**
       * The second child resource type.
       */
      @path
      nestedResourceTypeSecond: string;

      /**
       * The third child resource type.
       */
      @path
      nestedResourceTypeThird: string;

      /**
       * The SKU.
       */
      @path
      sku: string;
    },
    SkuResource
  >;

  /**
   * Creates or updates the resource type skus in the given resource type.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/resourcetypeRegistrations/{nestedResourceTypeSecond}/resourcetypeRegistrations/{nestedResourceTypeThird}/skus/{sku}")
  @put
  createOrUpdateNestedResourceTypeThird is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource provider hosted within ProviderHub.
       */
      @path
      providerNamespace: string;

      /**
       * The resource type.
       */
      @path
      resourceType: string;

      /**
       * The first child resource type.
       */
      @path
      nestedResourceTypeFirst: string;

      /**
       * The second child resource type.
       */
      @path
      nestedResourceTypeSecond: string;

      /**
       * The third child resource type.
       */
      @path
      nestedResourceTypeThird: string;

      /**
       * The SKU.
       */
      @path
      sku: string;

      /**
       * The required body parameters supplied to the resource sku operation.
       */
      @body
      properties: SkuResource;
    },
    SkuResource
  >;

  /**
   * Deletes a resource type sku.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/resourcetypeRegistrations/{nestedResourceTypeSecond}/resourcetypeRegistrations/{nestedResourceTypeThird}/skus/{sku}")
  @delete
  deleteNestedResourceTypeThird is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource provider hosted within ProviderHub.
       */
      @path
      providerNamespace: string;

      /**
       * The resource type.
       */
      @path
      resourceType: string;

      /**
       * The first child resource type.
       */
      @path
      nestedResourceTypeFirst: string;

      /**
       * The second child resource type.
       */
      @path
      nestedResourceTypeSecond: string;

      /**
       * The third child resource type.
       */
      @path
      nestedResourceTypeThird: string;

      /**
       * The SKU.
       */
      @path
      sku: string;
    },
    void
  >;

  /**
   * Gets the list of skus for the given resource type.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/skus")
  @get
  listByResourceTypeRegistrationsNestedResourceTypeFirst is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource provider hosted within ProviderHub.
       */
      @path
      providerNamespace: string;

      /**
       * The resource type.
       */
      @path
      resourceType: string;

      /**
       * The first child resource type.
       */
      @path
      nestedResourceTypeFirst: string;
    },
    ResourceListResult<SkuResource>
  >;

  /**
   * Gets the list of skus for the given resource type.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/resourcetypeRegistrations/{nestedResourceTypeSecond}/skus")
  @get
  listByResourceTypeRegistrationsNestedResourceTypeSecond is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource provider hosted within ProviderHub.
       */
      @path
      providerNamespace: string;

      /**
       * The resource type.
       */
      @path
      resourceType: string;

      /**
       * The first child resource type.
       */
      @path
      nestedResourceTypeFirst: string;

      /**
       * The second child resource type.
       */
      @path
      nestedResourceTypeSecond: string;
    },
    ResourceListResult<SkuResource>
  >;

  /**
   * Gets the list of skus for the given resource type.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ProviderHub/providerRegistrations/{providerNamespace}/resourcetypeRegistrations/{resourceType}/resourcetypeRegistrations/{nestedResourceTypeFirst}/resourcetypeRegistrations/{nestedResourceTypeSecond}/resourcetypeRegistrations/{nestedResourceTypeThird}/skus")
  @get
  listByResourceTypeRegistrationsNestedResourceTypeThird is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource provider hosted within ProviderHub.
       */
      @path
      providerNamespace: string;

      /**
       * The resource type.
       */
      @path
      resourceType: string;

      /**
       * The first child resource type.
       */
      @path
      nestedResourceTypeFirst: string;

      /**
       * The second child resource type.
       */
      @path
      nestedResourceTypeSecond: string;

      /**
       * The third child resource type.
       */
      @path
      nestedResourceTypeThird: string;
    },
    ResourceListResult<SkuResource>
  >;
}
