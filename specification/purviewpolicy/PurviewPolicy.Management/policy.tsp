import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Rest;
using Http;
using OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.Purview;

@armResourceOperations
interface PurviewPolicies {
  /** The API lists the Azure purview RBAC policies affecting the scope. The scope can be any valid ARM resource id */
  @summary("API to list the purview RBAC policies based on a scope")
  @tag("PolicyListing")
  list is ArmResourceListByParent<
    Policy,
    {
      ...Foundations.BaseParameters<Policy>;
      ...SkipTokenParameter;

      /** Supported filters : $filter=policyType eq SelfService, $filter=policyType eq SqlDevops. Returns only the policies of the specified type. If not specified, all policies are returned. */
      #suppress "@azure-tools/typespec-azure-core/no-openapi" "LEGACY - THIS shouldn't even be needed"
      @extension("x-ms-skip-url-encoding", true)
      @query("$filter")
      filter?: string;
    }
  >;
}

/** The skipToken parameter definition. */
model SkipTokenParameter {
  /** Paging key to paginate to next page. */
  @query
  skipToken?: string;
}

/** The objectType of the member. */
union ObjectType {
  string,

  /** AAD User object type. */
  "User",

  /** AAD Group object type. */
  "Group",

  /** Service Principal object type. */
  "ServicePrincipal",
}

/** The effect for rule */
union Decision {
  string,

  /** Access permitted */
  "Permit",

  /** Access denied */
  "Deny",
}

/** A paginated list of purview RBAC policies */
model PolicyList is Azure.Core.Page<Policy>;

/** Purview RBAC policy */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Special ARM resource with no property bag"
@extensionResource
@segment("policies")
model Policy extends Azure.ResourceManager.Foundations.ProxyResource {
  /** The policy kind */
  kind?: string;

  /** The policy source */
  source: string;

  /** The etag version of a policy */
  etag: string;

  /** Array of scopes where the policy is published */
  scopes: string[];

  /** Members of the policy */
  members: PolicyMembers;

  /** Array of decision rules for the policy */
  @identifiers(#[])
  decisionRules: PolicyDecisionRule[];

  /** The timestamp of the expiry time of the policy (UTC). */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  /** The AAD member who requested the policy */
  requestor?: string;
}

/** Policy member */
model PolicyMembers {
  /** Array of azure active directory members */
  @identifiers(#[])
  fabricItemMembers?: FabricItemMember[];

  /** Array of azure active directory members */
  @identifiers(#[])
  aadMembers?: AadMember[];
}

/** Microsoft fabric item member */
model FabricItemMember {
  /** Source path of the member */
  sourcePath?: string;

  /** Array of access items for the member */
  itemAccess?: string[];
}

/** Azure active directory member */
model AadMember {
  /** The tenantId of the member */
  tenantId?: string;

  /** The objectId of the member */
  objectId?: string;

  /** The objectType of the member. */
  objectType?: ObjectType;
}

/** Purview RBAC policy decision rule */
model PolicyDecisionRule {
  /** The effect for rule */
  effect: Decision;

  /** Array of attribute predicates */
  @identifiers(#[])
  permission?: AttributePredicate[];
}

/** Attribute predicate for a policy permission */
model AttributePredicate {
  /** AttributeName of a policy permission */
  attributeName?: string;

  /** values for a policy permission */
  attributeValueIncludedIn?: string[];
}
