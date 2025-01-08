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

namespace Microsoft.ProgrammableConnectivity;
/**
 * A Programmable Connectivity Operator API Plans resource. This is a readonly resource that indicates which Operator Network APIs are available in the user's subscription.
 */
@subscriptionResource
model OperatorApiPlan
  is Azure.ResourceManager.ProxyResource<OperatorApiPlanProperties> {
  /**
   * APC Gateway Plan Name.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("operatorApiPlanName")
  @segment("operatorApiPlans")
  @visibility("read")
  name: string;
}

/**
 * Azure marketplace properties for a plan.
 */
model MarketplaceProperties {
  /**
   * Azure marketplace Offer ID for this plan.
   */
  offerId?: string;

  /**
   * Azure marketplace Legacy Offer ID for this plan. This is used to fetch the details of the plan from the Azure marketplace.
   */
  legacyOfferId?: string;

  /**
   * Azure marketplace Publisher ID for this plan.
   */
  publisherId?: string;

  /**
   * Azure marketplace Plan ID for this plan.
   */
  planId?: string;

  /**
   * Azure marketplace Term ID for this plan.
   */
  termId?: string;
}

/**
 * Operator API Plan properties.
 */
model OperatorApiPlanProperties {
  /**
   * Name of the Operator this plan belongs to.
   */
  operatorName?: string;

  /**
   * Standardized Network API name defined by CAMARA specifications.
   */
  camaraApiName?: string;

  /**
   * List of Azure regions where this offer is supported.
   */
  supportedLocations?: string[];

  /**
   * List of country/region names where this plan is being supported by the Operator.
   */
  operatorRegions?: string[];

  /**
   * List of country/region names where this plan is being supported by Azure Marketplace.
   */
  markets?: string[];

  /**
   * The limits, if any, will be imposed by the operator.
   */
  limits?: string;

  /**
   * Azure marketplace properties for this plan.
   */
  marketplaceProperties?: MarketplaceProperties;

  /**
   * The status of the last operation on the Gateway resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface OperatorApiPlans {
  /**
   * Get an OperatorApiPlan resource by name.
   */
  get is ArmResourceRead<OperatorApiPlan>;

  /**
   * List OperatorApiPlan resources by subscription ID.
   */
  listBySubscription is ArmResourceListByParent<
    OperatorApiPlan,
    {
      ...BaseParameters<OperatorApiPlan>;

      /**
       * An optional OData based filter expression to apply on the operation.
       */
      @query("$filter")
      filter?: string;

      /**
       * An optional query parameter which specifies the maximum number of records to be returned.
       */
      @maxValue(20)
      @minValue(1)
      @query("$top")
      top?: int32;

      /**
       * An optional query parameter which specifies the number of records to be skipped.
       */
      @query("$skip")
      skip?: int32;
    }
  >;
}
