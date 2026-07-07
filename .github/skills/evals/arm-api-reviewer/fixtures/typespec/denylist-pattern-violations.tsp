// TypeSpec fixture: Denylist pattern violations (OAPI-PATTERN-ALLOWLIST)
// Seeded violations:
//   - @pattern decorator using a denylist (negated character class [^...]) on the resource
//     key property (new — blocking)
//   - @pattern decorator using a denylist on a body property (new — blocking)
// Positive controls (should NOT be flagged):
//   - @pattern decorator using a proper allowlist (acceptable)
//   - @pattern decorator using a negative lookahead alongside a positive class (acceptable)

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Policy Service",
})
@versioned(Versions)
namespace Microsoft.PolicyService;

/** API versions */
enum Versions {
  /** 2025-01-01 version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2025_01_01: "2025-01-01",
}

/** Properties of a policy resource. */
model PolicyProperties {
  // Violation: denylist pattern on a body property (new — blocking)
  /** The display name of the policy. */
  @pattern("^[^<>*%&:\\?.+/]*[^<>*%&:\\?.+/ ]+$")
  @maxLength(128)
  displayName?: string;

  // Positive control: allowlist pattern — should NOT be flagged
  /** The category of the policy. */
  @pattern("^[A-Za-z][A-Za-z0-9 _-]{0,62}$")
  @maxLength(63)
  category?: string;

  // Positive control: negative lookahead + allowlist — should NOT be flagged
  /** The slug identifier for the policy. */
  @pattern("^(?![.-])[A-Za-z0-9_.-]{1,64}$")
  @maxLength(64)
  slug?: string;

  /** The provisioning state. */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

// Violation: denylist @pattern on the resource key property (new — blocking)
@segment("policies")
model Policy is TrackedResource<PolicyProperties> {
  @key("policyName")
  @pattern("^[^<>%&:\\?/]*[^<>%&:\\?/ ]+$")
  @maxLength(260)
  name: string;
}

interface Policies extends TrackedResourceOperations<Policy, PolicyProperties> {}
