// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface DeletedAccountsOperationGroup {
  /**
   * Returns all the resources of a particular type belonging to a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeletedAccounts_List")
  @autoRoute
  @get
  @action("deletedAccounts")
  @list
  list is ArmProviderActionSync<
    Response = AccountListResult,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ResourceSkusOperationGroup {
  /**
   * Gets the list of Microsoft.CognitiveServices SKUs available for your Subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceSkus_List")
  @autoRoute
  @get
  @list
  @action("skus")
  list is ArmProviderActionSync<
    Response = ResourceSkuListResult,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface UsagesOperationGroup {
  /**
   * Get usages for the requested subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Usages_List")
  @autoRoute
  @get
  @action("usages")
  @list
  list is ArmProviderActionSync<
    Response = UsageListResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      ...LocationParameter;

      /**
       * An OData filter expression that describes a subset of usages to return. The supported parameter is name.value (name of the metric, can have an or of multiple names).
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

/**
 * Check available SKUs.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@autoRoute
op checkSkuAvailability is ArmProviderActionSync<
  Request = CheckSkuAvailabilityParameter,
  Response = SkuAvailabilityListResult,
  Scope = SubscriptionActionScope,
  Parameters = LocationParameter
>;
/**
 * Check whether a domain is available.
 */
@autoRoute
op checkDomainAvailability is ArmProviderActionSync<
  Request = CheckDomainAvailabilityParameter,
  Response = DomainAvailability,
  Scope = SubscriptionActionScope,
  Parameters = {}
>;
/**
 * Model capacity calculator.
 */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
@operationId("calculateModelCapacity")
@autoRoute
op calculateModelCapacity is ArmProviderActionSync<
  Request = CalculateModelCapacityParameter,
  Response = CalculateModelCapacityResult,
  Scope = SubscriptionActionScope,
  Parameters = {}
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface CommitmentTiersOperationGroup {
  /**
   * List Commitment Tiers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CommitmentTiers_List")
  @autoRoute
  @get
  @list
  @action("commitmentTiers")
  list is ArmProviderActionSync<
    Response = CommitmentTierListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ModelsOperationGroup {
  /**
   * List Models.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Models_List")
  @autoRoute
  @get
  @list
  @action("models")
  list is ArmProviderActionSync<
    Response = ModelListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface LocationBasedModelCapacitiesOperationGroup {
  /**
   * List Location Based ModelCapacities.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LocationBasedModelCapacities_List")
  @autoRoute
  @get
  @action("modelCapacities")
  @list
  list is ArmProviderActionSync<
    Response = ModelCapacityListResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      ...LocationParameter;

      /**
       * The format of the Model
       */
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @query("modelFormat")
      modelFormat: string;

      /**
       * The name of the Model
       */
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @query("modelName")
      modelName: string;

      /**
       * The version of the Model
       */
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @query("modelVersion")
      modelVersion: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ModelCapacitiesOperationGroup {
  /**
   * List ModelCapacities.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ModelCapacities_List")
  @autoRoute
  @get
  @list
  @action("modelCapacities")
  list is ArmProviderActionSync<
    Response = ModelCapacityListResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The format of the Model
       */
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @query("modelFormat")
      modelFormat: string;

      /**
       * The name of the Model
       */
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @query("modelName")
      modelName: string;

      /**
       * The version of the Model
       */
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @query("modelVersion")
      modelVersion: string;
    }
  >;
}
