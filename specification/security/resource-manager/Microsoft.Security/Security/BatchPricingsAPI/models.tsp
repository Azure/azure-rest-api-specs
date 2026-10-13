import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;
using Autorest;

namespace BatchPricingsAPI;

/**
 * Reference to the pricing properties defined in pricings.json.
 */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "The batch resource intentionally reuses the public pricing model from the sibling generated Swagger."
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "The schema is supplied by the external pricing model reference."
@useRef("./pricings.json#/definitions/PricingProperties")
model PricingPropertiesReference {}

/**
 * Properties for a pricing batch resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "The synchronous pricing batch resource reports per-plan results and does not have a provisioning lifecycle."
model PricingBatchProperties {
  /**
   * Pricing plan configurations represented by this resource.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @minItems(1)
  @maxItems(30)
  @identifiers(#["planName"])
  plansConfigurations: PricingBatchPlanItem[];
}

/**
 * An individual pricing plan configuration.
 */
model PricingBatchPlanItem {
  /**
   * Name of the pricing plan.
   */
  planName: string;

  /**
   * Pricing configuration properties for the plan.
   */
  properties: PricingPropertiesReference;

  /**
   * Status of this plan's update operation. This property is returned only after a PUT operation.
   */
  @visibility(Lifecycle.Read)
  operationStatus?: PricingPlanOperationStatus;
}

/**
 * Status of a pricing plan update operation.
 */
model PricingPlanOperationStatus {
  /**
   * The operation status code.
   */
  code?: PricingPlanOperationStatusCode;

  /**
   * Additional information about the operation result.
   */
  message?: string;
}

/**
 * Status code for a pricing plan update operation.
 */
union PricingPlanOperationStatusCode {
  string,

  /**
   * The pricing plan was updated successfully.
   */
  Succeeded: "Succeeded",

  /**
   * The pricing plan was not updated successfully.
   */
  Failed: "Failed",
}
