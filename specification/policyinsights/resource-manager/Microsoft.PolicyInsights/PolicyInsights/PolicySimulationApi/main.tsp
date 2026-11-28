import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../PolicyInsightsApi/PolicySimulationModels.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Azure Policy hypothetical evaluation operations. */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "The provider Operations endpoint is defined in PolicyInsightsApi and included in the parent readme package."
@armProviderNamespace("Microsoft.PolicyInsights")
@armCommonTypesVersion(CommonTypes.Versions.v3)
@service(#{ title: "PolicyInsightsClient" })
@versioned(Versions)
namespace PolicySimulationApi;

/** Supported API versions for policy simulation. */
enum Versions {
  /** The policy simulation preview API version. */
  @previewVersion
  v2026_09_01_preview: "2026-09-01-preview",
}

@armResourceOperations
interface PolicyMcp {
  /** Evaluates a hypothetical policy definition against a resource within a subscription, without creating an assignment or modifying the resource. */
  @autoRoute
  @action("simulatePolicy")
  simulatePolicyAtSubscriptionScope is ArmProviderActionSync<
    Request = SimulatePolicyContent,
    Response = PolicySimulationResult,
    Scope = SubscriptionActionScope
  >;

  /** Evaluates a hypothetical policy definition against a resource within a resource group, without creating an assignment or modifying the resource. */
  @autoRoute
  @post
  @action("simulatePolicy")
  @armResourceCollectionAction
  simulatePolicyAtResourceGroupScope(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    ...ProviderNamespace<SimulatePolicyContent>,

    /** The hypothetical evaluation request. */
    @body body: SimulatePolicyContent,
  ): PolicySimulationResult | ErrorResponse;

  /** Evaluates a hypothetical policy definition against a resource beneath a management group, without creating an assignment or modifying the resource. */
  @autoRoute
  @post
  @action("simulatePolicy")
  @armResourceCollectionAction
  simulatePolicyAtManagementGroupScope(
    ...ApiVersionParameter,

    /** The management group provider namespace. */
    @path
    @segment("providers")
    @key
    managementProviderNamespace: "Microsoft.Management",

    /** The management group identifier. */
    @path
    @segment("managementGroups")
    @key
    managementGroupId: string,

    ...ProviderNamespace<SimulatePolicyContent>,

    /** The hypothetical evaluation request. */
    @body body: SimulatePolicyContent,
  ): PolicySimulationResult | ErrorResponse;
}
