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
   * The criticality designation of the service group.
   */
  @added(Versions.v2026_03_01_preview)
  criticality?: float64;

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
 * Response holding an array of service groups and a nextLink that supports pagination
 */
model ServiceGroupCollectionResponse is Azure.Core.Page<ServiceGroup>;

/**
 * Request body for the listDescendants action.
 */
@added(Versions.v2026_03_01_preview)
model ListDescendantsRequest {
  /**
   * An opaque pagination token returned in the previous response's skipToken field.
   * Include this value in the request body to fetch the next page of results.
   */
  skipToken?: string;
}

/**
 * Response for the listDescendants action. Contains a page of service groups
 * plus an opaque skipToken for fetching subsequent pages.
 */
@added(Versions.v2026_03_01_preview)
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
