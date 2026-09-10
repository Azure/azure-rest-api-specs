import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "../Common/main.tsp";

using Azure.ResourceManager;
using Common;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;

namespace BatchPricingsAPI;

/**
 * Pricing batch resource for updating multiple pricing configurations.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "The legacy scopeId route is required for compatibility with pricing APIs."
@singleton("global")
@extensionResource
model PricingBatch
  is Azure.ResourceManager.ExtensionResource<PricingBatchProperties> {
  ...ResourceNameParameter<
    Resource = PricingBatch,
    KeyName = "pricingBatchName",
    SegmentName = "batchPricings",
    NamePattern = "^global$"
  >;
}

alias BatchPricingsOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** The subscription scope for the batch pricing resource. */
    @path(#{ allowReserved: true })
    @key
    scopeId: string;

    /** The provider namespace. */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security";
  },
  {},
  {
    /** Name of the pricing batch resource. */
    @path
    @segment("batchPricings")
    @key
    @pattern("^global$")
    pricingBatchName: string;
  }
>;

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "A pricing batch represents current configuration and has no delete semantics."
@armResourceOperations
interface BatchPricings {
  /**
   * Gets the current pricing batch configuration for the specified scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Preserves the reviewed operation ID and generated SDK surface."
  @tag("PricingBatch")
  @operationId("PricingBatch_Get")
  get is BatchPricingsOps.Read<PricingBatch, ErrorType = CloudError>;

  /**
   * Updates multiple pricing plan configurations in a single operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Preserves the reviewed operation ID and generated SDK surface."
  @tag("PricingBatch")
  @operationId("PricingBatch_CreateOrUpdate")
  createOrUpdate is BatchPricingsOps.CreateOrUpdateSync<
    PricingBatch,
    ErrorType = CloudError
  >;
}

@@doc(PricingBatch.name,
  "Name of the pricing batch configuration. Only 'global' is supported."
);
@@doc(PricingBatch.properties, "Pricing batch properties.");
