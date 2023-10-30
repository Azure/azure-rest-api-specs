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

@@doc(Azure.ResourceManager.ResourceUriParameter.resourceUri,
  "The scope of the operation or resource. Valid scopes are: subscription (format: '/subscriptions/{subscriptionId}'), or resource (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/[{parentResourcePath}/]{resourceType}/{resourceName}'"
);

interface PurviewPolicies {
  @summary("API to list the purview RBAC policies based on a scope")
  @doc("The API lists the Azure purview RBAC policies affecting the scope. The scope can be any valid ARM resource id")
  @tag("PolicyListing")
  list is ArmResourceListByParent<
    Policy,
    {
      ...Foundations.BaseParameters<Policy>;
      ...SkipTokenParameter;

      @extension("x-ms-skip-url-encoding", true)
      @doc("Supported filters : $filter=policyType eq SelfService, $filter=policyType eq SqlDevops. Returns only the policies of the specified type. If not specified, all policies are returned.")
      @query
      $filter?: string;
    }
  >;
}

@doc("The skipToken parameter definition.")
model SkipTokenParameter {
  @extension("x-ms-parameter-location", "method")
  @doc("Paging key to paginate to next page.")
  @query
  skipToken?: string;
}

enum ObjectType {
  User,
  Group,
  ServicePrincipal,
}

enum Decision {
  Permit,
  Deny,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

@doc("A paginated list of purview RBAC policies")
model PolicyList is Azure.Core.Page<Policy>;

@doc("Purview RBAC policy")
@extensionResource
model Policy extends ProxyResource<{}> {
  @doc("The policy name")
  @segment("policies")
  @key("policyname")
  @visibility("read")
  @path
  name: string;

  @doc("The policy kind")
  kind?: string;

  @doc("The policy source")
  source: string;

  @doc("The etag version of a policy")
  etag: string;

  @doc("Array of scopes where the policy is published")
  scopes: string[];

  @doc("Members of the policy")
  members: PolicyMembers;

  @doc("Array of decision rules for the policy")
  decisionRules: PolicyDecisionRule[];

  @doc("The timestamp of the expiry time of the policy (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  @doc("The AAD member who requested the policy")
  requestor?: string;
}

@doc("Policy member")
model PolicyMembers {
  @doc("Array of azure active directory members")
  fabricItemMembers?: FabricItemMember[];

  @doc("Array of azure active directory members")
  aadMembers?: AADMember[];
}

@doc("Microsoft fabric item member")
model FabricItemMember {
  @doc("Source path of the member")
  sourcePath?: string;

  @doc("Array of access items for the member")
  itemAccess?: string[];
}

@doc("Azure active directory member")
model AADMember {
  @doc("The tenantId of the member")
  tenantId?: string;

  @doc("The objectId of the member")
  objectId?: string;

  @doc("The objectType of the member.")
  objectType?: ObjectType;
}

@doc("Purview RBAC policy decision rule")
model PolicyDecisionRule {
  @doc("The effect for rule")
  effect: Decision;

  @doc("Array of attribute predicates")
  permission?: AttributePredicate[];
}

@doc("Attribute predicate for a policy permission")
model AttributePredicate {
  @doc("AttributeName of a policy permission")
  attributeName?: string;

  @doc("values for a policy permission")
  attributeValueIncludedIn?: string[];
}
