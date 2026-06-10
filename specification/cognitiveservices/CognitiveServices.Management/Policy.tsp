import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Account.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.CognitiveServices;

/**
 * Policy resource for controlling sandbox traffic.
 * Supports both account-level (shared across projects) and project-level (private) scoping,
 * mirroring the connection resource model.
 */
@added(Versions.v2026_07_01_preview)
@parentResource(Account)
model PolicyResource
  is Azure.ResourceManager.ProxyResource<PolicyProperties, false> {
  ...ResourceNameParameter<
    Resource = PolicyResource,
    KeyName = "policyName",
    SegmentName = "policies",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$"
  >;
}

// --- Account-level operations ---

@added(Versions.v2026_07_01_preview)
@armResourceOperations
interface AccountPolicyOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of Cognitive Services account. */
        @path
        @segment("accounts")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        @minLength(2)
        @maxLength(64)
        accountName: string,
      },
      {
        /** The name of the policy. */
        @path
        @segment("policies")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
        policyName: string,
      },
      ResourceName = "CognitiveServicesAccountPolicy"
    > {}

@added(Versions.v2026_07_01_preview)
@armResourceOperations(#{ omitTags: true })
interface AccountPolicies {
  /**
   * Gets the specified policy associated with the Cognitive Services account.
   */
  @tag("AccountPolicyResource")
  get is AccountPolicyOps.Read<PolicyResource>;

  /**
   * Creates or updates a policy under the specified Cognitive Services account.
   */
  @tag("AccountPolicyResource")
  createOrUpdate is AccountPolicyOps.CreateOrUpdateSync<PolicyResource>;

  /**
   * Deletes the specified policy from the Cognitive Services account.
   */
  @tag("AccountPolicyResource")
  delete is AccountPolicyOps.DeleteSync<PolicyResource>;

  /**
   * Lists all policies under the specified Cognitive Services account.
   */
  @tag("AccountPolicyResource")
  list is AccountPolicyOps.List<PolicyResource, Response = PolicyListResult>;
}

// --- Project-level operations ---

@added(Versions.v2026_07_01_preview)
@armResourceOperations
interface ProjectPolicyOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of Cognitive Services account. */
        @path
        @segment("accounts")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        @minLength(2)
        @maxLength(64)
        accountName: string,

        /** The name of Cognitive Services account's project. */
        @path
        @segment("projects")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        @minLength(2)
        @maxLength(64)
        projectName: string,
      },
      {
        /** The name of the policy. */
        @path
        @segment("policies")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,32}$")
        policyName: string,
      },
      ResourceName = "CognitiveServicesProjectPolicy"
    > {}

@added(Versions.v2026_07_01_preview)
@armResourceOperations(#{ omitTags: true })
interface ProjectPolicies {
  /**
   * Gets the specified policy associated with the Cognitive Services project.
   */
  @tag("ProjectPolicyResource")
  get is ProjectPolicyOps.Read<PolicyResource>;

  /**
   * Creates or updates a policy under the specified Cognitive Services project.
   */
  @tag("ProjectPolicyResource")
  createOrUpdate is ProjectPolicyOps.CreateOrUpdateSync<PolicyResource>;

  /**
   * Deletes the specified policy from the Cognitive Services project.
   */
  @tag("ProjectPolicyResource")
  delete is ProjectPolicyOps.DeleteSync<PolicyResource>;

  /**
   * Lists all policies under the specified Cognitive Services project.
   */
  @tag("ProjectPolicyResource")
  list is ProjectPolicyOps.List<PolicyResource, Response = PolicyListResult>;
}

// --- Documentation annotations ---

@@doc(PolicyResource.name, "The name of the policy.");
@@doc(
  PolicyResource.properties,
  "Properties of the policy resource."
);
@@doc(
  AccountPolicies.createOrUpdate::parameters.resource,
  "The policy resource to create or update."
);
@@doc(
  ProjectPolicies.createOrUpdate::parameters.resource,
  "The policy resource to create or update."
);
@@summary(
  AccountPolicies.list,
  "Lists all policies under the specified Cognitive Services account."
);
@@summary(
  AccountPolicies.get,
  "Gets the specified policy associated with the Cognitive Services account."
);
@@summary(
  AccountPolicies.createOrUpdate,
  "Creates or updates a policy under the specified Cognitive Services account."
);
@@summary(
  AccountPolicies.delete,
  "Deletes the specified policy from the Cognitive Services account."
);
@@summary(
  ProjectPolicies.list,
  "Lists all policies under the specified Cognitive Services project."
);
@@summary(
  ProjectPolicies.get,
  "Gets the specified policy associated with the Cognitive Services project."
);
@@summary(
  ProjectPolicies.createOrUpdate,
  "Creates or updates a policy under the specified Cognitive Services project."
);
@@summary(
  ProjectPolicies.delete,
  "Deletes the specified policy from the Cognitive Services project."
);
