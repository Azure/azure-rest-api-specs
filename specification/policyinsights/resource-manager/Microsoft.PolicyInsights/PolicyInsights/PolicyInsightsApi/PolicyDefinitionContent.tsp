import "../../../../../resources/resource-manager/Microsoft.Authorization/policy/PolicyDefinitionModels.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace PolicyInsightsCommon;

/** A policy definition supplied for verification or hypothetical evaluation. */
@withVisibility(Lifecycle.Read)
model PolicyDefinitionContent {
  ...OmitProperties<
    ProxyResource<Microsoft.Authorization.PolicyDefinitionProperties>,
    "properties"
  >;

  /** The definition properties. */
  properties: PolicyDefinitionContentProperties;
}

/** Existing policy definition properties with the required verification inputs. */
model PolicyDefinitionContentProperties {
  ...OmitProperties<
    Microsoft.Authorization.PolicyDefinitionProperties,
    "mode" | "policyRule" | "parameters"
  >;

  /** The policy evaluation mode. */
  mode?: string;

  /** The policy rule, including its if condition and then effect. */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Azure Policy rules use the existing Policy JSON expression language."
  policyRule: unknown;

  /** Parameter definitions, indexed by caller-defined parameter names. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Policy parameter names are caller-defined dictionary keys."
  parameters?: Record<PolicyDefinitionParameter>;
}

/** An existing policy parameter definition with its required value type. */
model PolicyDefinitionParameter {
  ...OmitProperties<Microsoft.Authorization.ParameterDefinitionsValue, "type">;

  /** The parameter value type. */
  type: Microsoft.Authorization.ParameterType;
}
