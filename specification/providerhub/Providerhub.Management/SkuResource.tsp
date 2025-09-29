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

        /** the provider namespace */
        @path
        @segment("providers/microsoft.ProviderHub/providerRegistrations")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Skus_Get")
  get is SkuResourceOps.Read<SkuResource>;

  /**
   * Creates or updates the resource type skus in the given resource type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Skus_CreateOrUpdate")
  createOrUpdate is SkuResourceOps.CreateOrUpdateSync<
    SkuResource,
    Response = ArmResourceUpdatedResponse<SkuResource>
  >;

  /**
   * Deletes a resource type sku.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Skus_Delete")
  delete is SkuResourceOps.DeleteSync<SkuResource>;

  /**
   * Gets the list of skus for the given resource type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Skus_ListByResourceTypeRegistrations")
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

        /** the provider namespace */
        @path
        @segment("providers/microsoft.ProviderHub/providerRegistrations")
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

        /** the provider namespace */
        @path
        @segment("providers/microsoft.ProviderHub/providerRegistrations")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Skus_GetNestedResourceTypeSecond")
  getNestedResourceTypeSecond is SkuResourceOperationGroupOps.Read<SkuResource>;

  /**
   * Creates or updates the resource type skus in the given resource type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Skus_CreateOrUpdateNestedResourceTypeSecond")
  createOrUpdateNestedResourceTypeSecond is SkuResourceOperationGroupOps.CreateOrUpdateSync<
    SkuResource,
    Response = ArmResourceUpdatedResponse<SkuResource>
  >;

  /**
   * Deletes a resource type sku.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Skus_DeleteNestedResourceTypeSecond")
  deleteNestedResourceTypeSecond is SkuResourceOperationGroupOps.DeleteSync<SkuResource>;

  /**
   * Gets the list of skus for the given resource type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Skus_ListByResourceTypeRegistrationsNestedResourceTypeSecond")
  listByResourceTypeRegistrationsNestedResourceTypeSecond is SkuResourceOperationGroupOps.List<
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
@@doc(SkuResourceOperationGroup.createOrUpdateNestedResourceTypeSecond::parameters.resource,
  "The required body parameters supplied to the resource sku operation."
);
