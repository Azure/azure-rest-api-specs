import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ResourceTypeRegistration.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ProviderHub;

@parentResource(ResourceTypeRegistration)
model SkuResource
  is Azure.ResourceManager.ProxyResource<SkuResourceProperties> {
  ...ResourceNameParameter<
    Resource = SkuResource,
    KeyName = "sku",
    SegmentName = "skus",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SkuResourceOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** the provider namespace */
        @path
        @segment("providerRegistrations")
        @key
        providerNamespace: string,

        /** The resource type. */
        @path
        @segment("resourcetypeRegistrations")
        @key
        resourceType: string,
      },
      {},
      {
        /** The SKU. */
        @path
        @segment("skus")
        @key
        sku: string,
      }
    > {}

@armResourceOperations
interface SkuResources {
  /**
   * Gets the sku details for the given resource type and sku name.
   */
  get is SkuResourceOps.Read<SkuResource>;

  /**
   * Creates or updates the resource type skus in the given resource type.
   */
  createOrUpdate is SkuResourceOps.CreateOrUpdateSync<
    SkuResource,
    Response = ArmResourceUpdatedResponse<SkuResource>
  >;

  /**
   * Deletes a resource type sku.
   */
  delete is SkuResourceOps.DeleteSync<SkuResource>;

  /**
   * Gets the list of skus for the given resource type.
   */
  listByResourceTypeRegistrations is SkuResourceOps.List<
    SkuResource,
    Response = ArmResponse<SkuResourceArrayResponseWithContinuation>
  >;
}
@armResourceOperations
interface SkusOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** the provider namespace */
        @path
        @segment("providerRegistrations")
        @key
        providerNamespace: string,

        /** The resource type. */
        @path
        @segment("resourcetypeRegistrations")
        @key
        resourceType: string,

        /** The first child resource type. */
        @path
        @segment("resourcetypeRegistrations")
        @key
        nestedResourceTypeFirst: string,
      },
      {},
      {
        /** The SKU. */
        @path
        @segment("skus")
        @key
        sku: string,
      }
    > {}

@armResourceOperations
interface Skus {
  /**
   * Gets the sku details for the given resource type and sku name.
   */
  getNestedResourceTypeFirst is SkusOps.Read<SkuResource>;

  /**
   * Creates or updates the resource type skus in the given resource type.
   */
  createOrUpdateNestedResourceTypeFirst is SkusOps.CreateOrUpdateSync<
    SkuResource,
    Response = ArmResourceUpdatedResponse<SkuResource>
  >;

  /**
   * Deletes a resource type sku.
   */
  deleteNestedResourceTypeFirst is SkusOps.DeleteSync<SkuResource>;

  /**
   * Gets the list of skus for the given resource type.
   */
  listByResourceTypeRegistrationsNestedResourceTypeFirst is SkusOps.List<
    SkuResource,
    Response = ArmResponse<SkuResourceArrayResponseWithContinuation>
  >;
}
@armResourceOperations
interface SkuResourceOperationGroupOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** the provider namespace */
        @path
        @segment("providerRegistrations")
        @key
        providerNamespace: string,

        /** The resource type. */
        @path
        @segment("resourcetypeRegistrations")
        @key
        resourceType: string,

        /** The first child resource type. */
        @path
        @segment("resourcetypeRegistrations")
        @key
        nestedResourceTypeFirst: string,

        /** The second child resource type. */
        @path
        @segment("resourcetypeRegistrations")
        @key
        nestedResourceTypeSecond: string,
      },
      {},
      {
        /** The SKU. */
        @path
        @segment("skus")
        @key
        sku: string,
      }
    > {}

@armResourceOperations
interface SkuResourceOperationGroup {
  /**
   * Gets the sku details for the given resource type and sku name.
   */
  getNestedResourceTypeSecond is SkuResourceOperationGroupOps.Read<SkuResource>;

  /**
   * Creates or updates the resource type skus in the given resource type.
   */
  createOrUpdateNestedResourceTypeSecond is SkuResourceOperationGroupOps.CreateOrUpdateSync<
    SkuResource,
    Response = ArmResourceUpdatedResponse<SkuResource>
  >;

  /**
   * Deletes a resource type sku.
   */
  deleteNestedResourceTypeSecond is SkuResourceOperationGroupOps.DeleteSync<SkuResource>;

  /**
   * Gets the list of skus for the given resource type.
   */
  listByResourceTypeRegistrationsNestedResourceTypeSecond is SkuResourceOperationGroupOps.List<
    SkuResource,
    Response = ArmResponse<SkuResourceArrayResponseWithContinuation>
  >;
}
@armResourceOperations
interface SkuResourceOperationGroupOpsThird
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** the provider namespace */
        @path
        @segment("providerRegistrations")
        @key
        providerNamespace: string,

        /** The resource type. */
        @path
        @segment("resourcetypeRegistrations")
        @key
        resourceType: string,

        /** The first child resource type. */
        @path
        @segment("resourcetypeRegistrations")
        @key
        nestedResourceTypeFirst: string,

        /** The second child resource type. */
        @path
        @segment("resourcetypeRegistrations")
        @key
        nestedResourceTypeSecond: string,

        /** The third child resource type. */
        @path
        @segment("resourcetypeRegistrations")
        @key
        nestedResourceTypeThird: string,
      },
      {},
      {
        /** The SKU. */
        @path
        @segment("skus")
        @key
        sku: string,
      }
    > {}

@armResourceOperations
interface SkuResourceOperationGroupThird {
  /**
   * Gets the sku details for the given resource type and sku name.
   */
  getNestedResourceTypeThird is SkuResourceOperationGroupOpsThird.Read<SkuResource>;

  /**
   * Creates or updates the resource type skus in the given resource type.
   */
  createOrUpdateNestedResourceTypeThird is SkuResourceOperationGroupOpsThird.CreateOrUpdateSync<
    SkuResource,
    Response = ArmResourceUpdatedResponse<SkuResource>
  >;

  /**
   * Deletes a resource type sku.
   */
  deleteNestedResourceTypeThird is SkuResourceOperationGroupOpsThird.DeleteSync<SkuResource>;

  /**
   * Gets the list of skus for the given resource type.
   */
  listByResourceTypeRegistrationsNestedResourceTypeThird is SkuResourceOperationGroupOpsThird.List<
    SkuResource,
    Response = ArmResponse<SkuResourceArrayResponseWithContinuation>
  >;
}

@@doc(SkuResource.name, "The SKU.");
@@doc(SkuResource.properties, "");
@@doc(SkuResources.createOrUpdate::parameters.resource,
  "The required body parameters supplied to the resource sku operation."
);
@@doc(Skus.createOrUpdateNestedResourceTypeFirst::parameters.resource,
  "The required body parameters supplied to the resource sku operation."
);
@@doc(SkuResourceOperationGroup.createOrUpdateNestedResourceTypeSecond::parameters.resource,
  "The required body parameters supplied to the resource sku operation."
);
@@doc(SkuResourceOperationGroupThird.createOrUpdateNestedResourceTypeThird::parameters.resource,
  "The required body parameters supplied to the resource sku operation."
);
