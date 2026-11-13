import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../PolicyInsightsApi/PolicyAuthoringModels.tsp";
import "./client.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using PolicyInsightsCommon;

/** Azure Policy definition verification and authoring reference operations. */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "The provider Operations endpoint is defined in PolicyInsightsApi and included in the parent readme package."
@armProviderNamespace("Microsoft.PolicyInsights")
@armCommonTypesVersion(CommonTypes.Versions.v3)
@service(#{ title: "PolicyInsightsClient" })
@versioned(Versions)
namespace PolicyAuthoringApi;

/** Supported API versions for policy authoring operations. */
enum Versions {
  /** The policy authoring preview API version. */
  @previewVersion
  v2025_05_01_preview: "2025-05-01-preview",
}

@armResourceOperations
interface PolicyMcp {
  /** Returns authoring syntax, relevant aliases, and policy rule and effect examples for the supplied intent. */
  @autoRoute
  @action("generatePolicyAuthoringGuide")
  generatePolicyAuthoringGuide is ArmProviderActionSync<
    Request = GeneratePolicyAuthoringGuideContent,
    Response = PolicyAuthoringGuideResult,
    Scope = TenantActionScope
  >;

  /** Validates a policy definition and, if validation succeeds, lints it using the selected rule sets. Validation and lint failures are returned in a successful HTTP response. */
  @autoRoute
  @action("verifyPolicy")
  verifyPolicy is ArmProviderActionSync<
    Request = VerifyPolicyContent,
    Response = PolicyVerificationResult,
    Scope = TenantActionScope
  >;
}
