import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Management;

/**
 * The provisioning state of the serviceGroup. For example, Running
 */
union ProvisioningState {
  string,

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * ServiceGroup creation request body parameters.
 */
model ServiceGroupProperties {
  /**
   * The provisioning state of the serviceGroup. For example, Running
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The display name of the serviceGroup. For example, ServiceGroupTest1
   */
  displayName?: string;

  /**
   * The attributes of the serviceGroup.
   */
  @added(Versions.v2026_08_01)
  attributes?: ServiceGroupAttributes;

  /**
   * The details of the parent serviceGroup.
   */
  parent?: ParentServiceGroupProperties;
}

/**
 * The details of the parent serviceGroup.
 */
model ParentServiceGroupProperties {
  /**
   * The fully qualified ID of the parent serviceGroup.  For example, '/providers/Microsoft.Management/serviceGroups/TestServiceGroup'
   */
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Management/serviceGroups";
    }
  ]>;
}

/**
 * The attributes of the serviceGroup.
 */
@added(Versions.v2026_08_01)
model ServiceGroupAttributes {
  /** The criticality designation of the service group. Valid values range from 0 through 4. */
  @minValue(0)
  @maxValue(4)
  criticality?: int32;
}

/**
 * Response holding an array of service groups and a nextLink that supports pagination
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model ServiceGroupCollectionResponse is Azure.Core.Page<ServiceGroup>;

/**
 * Request body for the listAncestors action.
 */
@added(Versions.v2026_09_01_preview)
model ListAncestorsRequest {
  /**
   * An opaque pagination token returned in the previous response's skipToken field.
   * Include this value in the request body to fetch the next page of results.
   */
  skipToken?: string;
}

/**
 * Response for the listAncestors action. Contains a page of ancestor service
 * groups plus an opaque skipToken for fetching subsequent pages.
 */
@added(Versions.v2026_09_01_preview)
model ListAncestorsResponse {
  /**
   * The page of ancestor service groups.
   */
  value: ServiceGroup[];

  /**
   * Opaque pagination token. When present, more results are available; callers
   * must re-POST to the same listAncestors URL with this value in the request
   * body to fetch the next page. When absent, the current page is the last page.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "skipToken is the standard Azure OData paging continuation token, not a secret. The linter flags it due to the 'Token' substring in the name; the property carries opaque pagination state and is not sensitive."
  skipToken?: string;
}

/**
 * Request body for the listDescendants action.
 */
@added(Versions.v2026_09_01_preview)
model ListDescendantsRequest {
  /**
   * An opaque continuation token returned in the previous response. Pass this
   * value unchanged to fetch the next page. Do not decode or modify it.
   */
  skipToken?: string;
}

/**
 * Response for the listDescendants action. Contains a page of service groups
 * plus an opaque skipToken for fetching subsequent pages.
 */
@added(Versions.v2026_09_01_preview)
model ListDescendantsResponse {
  /**
   * The page of descendant service groups.
   */
  value: ServiceGroup[];

  /**
   * Opaque pagination token. When present, more results are available; callers
   * must re-POST to the same listDescendants URL with this value in the request
   * body to fetch the next page. When absent, the current page is the last page.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "skipToken is the standard Azure OData paging continuation token, not a secret. The linter flags it due to the 'Token' substring in the name; the property carries opaque pagination state and is not sensitive."
  skipToken?: string;
}

/**
 * Controls which members are returned by the listMembers action. Currently
 * only "allMembers" is supported. If omitted, the service behaves as if
 * "allMembers" was specified.
 */
@added(Versions.v2026_09_01_preview)
union ListMembersExpand {
  string,

  /**
   * Return all members of the service group.
   */
  AllMembers: "allMembers",
}

/**
 * Request body for the listMembers action.
 */
@added(Versions.v2026_09_01_preview)
model ListMembersRequest {
  /**
   * Controls which members are returned. Only "allMembers" is supported;
   * if omitted, the service defaults to "allMembers".
   */
  expand?: ListMembersExpand;

  /**
   * An opaque pagination token returned in the previous response's skipToken field.
   * Include this value in the request body to fetch the next page of results.
   */
  skipToken?: string;
}

/**
 * Response for the listMembers action. Contains a page of service group members
 * plus an opaque skipToken for fetching subsequent pages.
 */
@added(Versions.v2026_09_01_preview)
model ListMembersResponse {
  /**
   * Resource members found for the requested service group.
   */
  value: ServiceGroupMember[];

  /**
   * An opaque continuation token. When present, more results are available.
   * Pass this value unchanged in the next listMembers request. Do not decode or
   * modify it. This property is omitted when there are no more results.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "skipToken is the standard Azure OData paging continuation token, not a secret. The linter flags it due to the 'Token' substring in the name; the property carries opaque pagination state and is not sensitive."
  skipToken?: string;

  /**
   * Warnings for subscriptions that were skipped while producing partial results.
   */
  @identifiers(#["subscriptionId", "code"])
  warnings?: ListMembersWarning[];
}

/**
 * A resource member returned by the listMembers action.
 */
@added(Versions.v2026_09_01_preview)
model ServiceGroupMember {
  /**
   * The fully qualified Azure Resource Manager ID of the member. For example,
   * /subscriptions/{subId}/resourceGroups/{rgName}/providers/Microsoft.KeyVault/vaults/{vaultName}.
   */
  @visibility(Lifecycle.Read)
  id: Azure.Core.armResourceIdentifier;
}

/**
 * A warning produced when listMembers returns partial results.
 */
@added(Versions.v2026_09_01_preview)
model ListMembersWarning {
  /**
   * The subscription that was skipped.
   */
  subscriptionId: string;

  /**
   * The warning code. SubscriptionInaccessible indicates that the subscription
   * could not be read and was skipped while other accessible members were returned.
   */
  code: ListMembersWarningCode;

  /**
   * A caller-facing description of the warning.
   */
  message: string;
}

/**
 * The code for a listMembers partial-result warning.
 */
@added(Versions.v2026_09_01_preview)
union ListMembersWarningCode {
  string,

  /**
   * The subscription could not be read and was skipped while other accessible
   * members were returned.
   */
  SubscriptionInaccessible: "SubscriptionInaccessible",
}
