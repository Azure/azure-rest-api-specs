import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Management;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ManagementGroupExpandType {
  string,

  /**
   * children
   */
  children: "children",

  /**
   * path
   */
  path: "path",

  /**
   * ancestors
   */
  ancestors: "ancestors",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union EntitySearchType {
  string,

  /**
   * AllowedParents
   */
  AllowedParents: "AllowedParents",

  /**
   * AllowedChildren
   */
  AllowedChildren: "AllowedChildren",

  /**
   * ParentAndFirstLevelChildren
   */
  ParentAndFirstLevelChildren: "ParentAndFirstLevelChildren",

  /**
   * ParentOnly
   */
  ParentOnly: "ParentOnly",

  /**
   * ChildrenOnly
   */
  ChildrenOnly: "ChildrenOnly",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union EntityViewParameterType {
  string,

  /**
   * FullHierarchy
   */
  FullHierarchy: "FullHierarchy",

  /**
   * GroupsOnly
   */
  GroupsOnly: "GroupsOnly",

  /**
   * SubscriptionsOnly
   */
  SubscriptionsOnly: "SubscriptionsOnly",

  /**
   * Audit
   */
  Audit: "Audit",
}

/**
 * The type of child resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ManagementGroupChildType {
  /**
   * Microsoft.Management/managementGroups
   */
  `Microsoft.Management/managementGroups`,

  /**
   * /subscriptions
   */
  `/subscriptions`,
}

/**
 * Required if nameAvailable == false. Invalid indicates the name provided does not match the resource provider's naming requirements (incorrect length, unsupported characters, etc.) AlreadyExists indicates that the name is already in use and is therefore unavailable.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum Reason {
  /**
   * Invalid
   */
  Invalid,

  /**
   * AlreadyExists
   */
  AlreadyExists,
}

/**
 * The users specific permissions to this item.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum Permissions {
  /**
   * noaccess
   */
  noaccess,

  /**
   * view
   */
  view,

  /**
   * edit
   */
  edit,

  /**
   * delete
   */
  delete,
}

/**
 * The status of the Tenant Backfill
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum Status {
  /**
   * NotStarted
   */
  NotStarted,

  /**
   * NotStartedButGroupsExist
   */
  NotStartedButGroupsExist,

  /**
   * Started
   */
  Started,

  /**
   * Failed
   */
  Failed,

  /**
   * Cancelled
   */
  Cancelled,

  /**
   * Completed
   */
  Completed,
}

/**
 * Describes the result of the request to list management groups.
 */
model ManagementGroupListResult {
  /**
   * The list of management groups.
   */
  @pageItems
  value?: ManagementGroupInfo[];

  /**
   * The URL to use for getting the next set of results.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  `@nextLink`?: string;
}

/**
 * The management group resource.
 */
model ManagementGroupInfo {
  /**
   * The fully qualified ID for the management group.  For example, /providers/Microsoft.Management/managementGroups/0000000-0000-0000-0000-000000000000
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The type of the resource. For example, Microsoft.Management/managementGroups
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The name of the management group. For example, 00000000-0000-0000-0000-000000000000
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The generic properties of a management group.
   */
  properties?: ManagementGroupInfoProperties;
}

/**
 * The generic properties of a management group.
 */
model ManagementGroupInfoProperties {
  /**
   * The AAD Tenant ID associated with the management group. For example, 00000000-0000-0000-0000-000000000000
   */
  tenantId?: string;

  /**
   * The friendly name of the management group.
   */
  displayName?: string;
}

/**
 * The error object.
 */
@error
model ErrorResponse {
  /**
   * The details of the error.
   */
  error?: ErrorDetails;
}

/**
 * The details of the error.
 */
model ErrorDetails {
  /**
   * One of a server-defined set of error codes.
   */
  code?: string;

  /**
   * A human-readable representation of the error.
   */
  message?: string;

  /**
   * A human-readable representation of the error's details.
   */
  details?: string;
}

/**
 * The generic properties of a management group.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ManagementGroupProperties {
  /**
   * The AAD Tenant ID associated with the management group. For example, 00000000-0000-0000-0000-000000000000
   */
  tenantId?: string;

  /**
   * The friendly name of the management group.
   */
  displayName?: string;

  /**
   * The details of a management group.
   */
  details?: ManagementGroupDetails;

  /**
   * The list of children.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  children?: ManagementGroupChildInfo[] | null;
}

/**
 * The details of a management group.
 */
model ManagementGroupDetails {
  /**
   * The version number of the object.
   */
  version?: int32;

  /**
   * The date and time when this object was last updated.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedTime?: utcDateTime;

  /**
   * The identity of the principal or process that updated the object.
   */
  updatedBy?: string;

  /**
   * (Optional) The ID of the parent management group.
   */
  parent?: ParentGroupInfo;

  /**
   * The path from the root to the current group.
   */
  @identifiers(#["name"])
  path?: ManagementGroupPathElement[];

  /**
   * The ancestors of the management group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  managementGroupAncestors?: string[] | null;

  /**
   * The ancestors of the management group displayed in reversed order, from immediate parent to the root.
   */
  @identifiers(#["name"])
  managementGroupAncestorsChain?: ManagementGroupPathElement[];
}

/**
 * (Optional) The ID of the parent management group.
 */
model ParentGroupInfo {
  /**
   * The fully qualified ID for the parent management group.  For example, /providers/Microsoft.Management/managementGroups/0000000-0000-0000-0000-000000000000
   */
  id?: string;

  /**
   * The name of the parent management group
   */
  name?: string;

  /**
   * The friendly name of the parent management group.
   */
  displayName?: string;
}

/**
 * A path element of a management group ancestors.
 */
model ManagementGroupPathElement {
  /**
   * The name of the group.
   */
  name?: string;

  /**
   * The friendly name of the group.
   */
  displayName?: string;
}

/**
 * The child information of a management group.
 */
model ManagementGroupChildInfo {
  /**
   * The fully qualified resource type which includes provider namespace (e.g. Microsoft.Management/managementGroups)
   */
  type?: ManagementGroupChildType;

  /**
   * The fully qualified ID for the child resource (management group or subscription).  For example, /providers/Microsoft.Management/managementGroups/0000000-0000-0000-0000-000000000000
   */
  id?: string;

  /**
   * The name of the child entity.
   */
  name?: string;

  /**
   * The friendly name of the child resource.
   */
  displayName?: string;

  /**
   * The list of children.
   */
  children?: ManagementGroupChildInfo[];
}

/**
 * Management group creation parameters.
 */
model CreateManagementGroupRequest {
  /**
   * The fully qualified ID for the management group.  For example, /providers/Microsoft.Management/managementGroups/0000000-0000-0000-0000-000000000000
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The type of the resource.  For example, Microsoft.Management/managementGroups
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The name of the management group. For example, 00000000-0000-0000-0000-000000000000
   */
  name?: string;

  /**
   * The generic properties of a management group used during creation.
   */
  properties?: CreateManagementGroupProperties;
}

/**
 * The generic properties of a management group used during creation.
 */
model CreateManagementGroupProperties {
  /**
   * The AAD Tenant ID associated with the management group. For example, 00000000-0000-0000-0000-000000000000
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The friendly name of the management group. If no value is passed then this  field will be set to the groupId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  displayName?: string | null;

  /**
   * The details of a management group used during creation.
   */
  details?: CreateManagementGroupDetails;

  /**
   * The list of children.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  @visibility(Lifecycle.Read)
  children?: CreateManagementGroupChildInfo[] | null;
}

/**
 * The details of a management group used during creation.
 */
model CreateManagementGroupDetails {
  /**
   * The version number of the object.
   */
  @visibility(Lifecycle.Read)
  version?: int32;

  /**
   * The date and time when this object was last updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedTime?: utcDateTime;

  /**
   * The identity of the principal or process that updated the object.
   */
  @visibility(Lifecycle.Read)
  updatedBy?: string;

  /**
   * (Optional) The ID of the parent management group used during creation.
   */
  parent?: CreateParentGroupInfo;
}

/**
 * (Optional) The ID of the parent management group used during creation.
 */
model CreateParentGroupInfo {
  /**
   * The fully qualified ID for the parent management group.  For example, /providers/Microsoft.Management/managementGroups/0000000-0000-0000-0000-000000000000
   */
  id?: string;

  /**
   * The name of the parent management group
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The friendly name of the parent management group.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;
}

/**
 * The child information of a management group used during creation.
 */
model CreateManagementGroupChildInfo {
  /**
   * The fully qualified resource type which includes provider namespace (e.g. Microsoft.Management/managementGroups)
   */
  @visibility(Lifecycle.Read)
  type?: ManagementGroupChildType;

  /**
   * The fully qualified ID for the child resource (management group or subscription).  For example, /providers/Microsoft.Management/managementGroups/0000000-0000-0000-0000-000000000000
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the child entity.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The friendly name of the child resource.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The list of children.
   */
  @visibility(Lifecycle.Read)
  children?: CreateManagementGroupChildInfo[];
}

/**
 * The results of Azure-AsyncOperation.
 */
model AzureAsyncOperationResults {
  /**
   * The fully qualified ID for the management group.  For example, /providers/Microsoft.Management/managementGroups/0000000-0000-0000-0000-000000000000
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The type of the resource.  For example, Microsoft.Management/managementGroups
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The name of the management group. For example, 00000000-0000-0000-0000-000000000000
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The current status of the asynchronous operation performed . For example, Running, Succeeded, Failed
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The generic properties of a management group.
   */
  properties?: ManagementGroupInfoProperties;
}

/**
 * Management group patch parameters.
 */
model PatchManagementGroupRequest {
  /**
   * The friendly name of the management group.
   */
  displayName?: string;

  /**
   * (Optional) The fully qualified ID for the parent management group.  For example, /providers/Microsoft.Management/managementGroups/0000000-0000-0000-0000-000000000000
   */
  parentGroupId?: string;
}

/**
 * The descendant.
 */
model DescendantInfo {
  /**
   * The fully qualified ID for the descendant.  For example, /providers/Microsoft.Management/managementGroups/0000000-0000-0000-0000-000000000000 or /subscriptions/0000000-0000-0000-0000-000000000000
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  @visibility(Lifecycle.Read)
  id?: string | null;

  /**
   * The type of the resource. For example, Microsoft.Management/managementGroups or /subscriptions
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  @visibility(Lifecycle.Read)
  type?: string | null;

  /**
   * The name of the descendant. For example, 00000000-0000-0000-0000-000000000000
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The generic properties of an descendant.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  properties?: DescendantInfoProperties | null;
}

/**
 * The generic properties of an descendant.
 */
model DescendantInfoProperties {
  /**
   * The friendly name of the management group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  displayName?: string | null;

  /**
   * The ID of the parent management group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  parent?: DescendantParentGroupInfo | null;
}

/**
 * The ID of the parent management group.
 */
model DescendantParentGroupInfo {
  /**
   * The fully qualified ID for the parent management group.  For example, /providers/Microsoft.Management/managementGroups/0000000-0000-0000-0000-000000000000
   */
  id?: string;
}

/**
 * The generic properties of subscription under a management group.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SubscriptionUnderManagementGroupProperties {
  /**
   * The AAD Tenant ID associated with the subscription. For example, 00000000-0000-0000-0000-000000000000
   */
  tenant?: string;

  /**
   * The friendly name of the subscription.
   */
  displayName?: string;

  /**
   * The ID of the parent management group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  parent?: DescendantParentGroupInfo | null;

  /**
   * The state of the subscription.
   */
  state?: string;
}

/**
 * The details of all subscriptions under management group.
 */
model ListSubscriptionUnderManagementGroup
  is Azure.Core.Page<SubscriptionUnderManagementGroup>;

/**
 * Lists all hierarchy settings.
 */
model HierarchySettingsList {
  /**
   * The list of hierarchy settings.
   */
  value?: HierarchySettingsInfo[];

  /**
   * The URL to use for getting the next set of results.
   */
  @visibility(Lifecycle.Read)
  `@nextLink`?: string;
}

/**
 * The hierarchy settings resource.
 */
model HierarchySettingsInfo {
  /**
   * The fully qualified ID for the settings object.  For example, /providers/Microsoft.Management/managementGroups/0000000-0000-0000-0000-000000000000/settings/default.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The type of the resource.  For example, Microsoft.Management/managementGroups/settings.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The name of the object. In this case, default.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The generic properties of hierarchy settings.
   */
  properties?: HierarchySettingsProperties;
}

/**
 * The generic properties of hierarchy settings.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model HierarchySettingsProperties {
  /**
   * The AAD Tenant ID associated with the hierarchy settings. For example, 00000000-0000-0000-0000-000000000000
   */
  tenantId?: string;

  /**
   * Indicates whether RBAC access is required upon group creation under the root Management Group. If set to true, user will require Microsoft.Management/managementGroups/write action on the root Management Group scope in order to create new Groups directly under the root. This will prevent new users from creating new Management Groups, unless they are given access.
   */
  requireAuthorizationForGroupCreation?: boolean;

  /**
   * Settings that sets the default Management Group under which new subscriptions get added in this tenant. For example, /providers/Microsoft.Management/managementGroups/defaultGroup
   */
  defaultManagementGroup?: string;
}

/**
 * Parameters for creating or updating Management Group settings
 */
model CreateOrUpdateSettingsRequest {
  /**
   * The properties of the request to create or update Management Group settings
   */
  properties?: CreateOrUpdateSettingsProperties;
}

/**
 * The properties of the request to create or update Management Group settings
 */
model CreateOrUpdateSettingsProperties {
  /**
   * Indicates whether RBAC access is required upon group creation under the root Management Group. If set to true, user will require Microsoft.Management/managementGroups/write action on the root Management Group scope in order to create new Groups directly under the root. This will prevent new users from creating new Management Groups, unless they are given access.
   */
  requireAuthorizationForGroupCreation?: boolean;

  /**
   * Settings that sets the default Management Group under which new subscriptions get added in this tenant. For example, /providers/Microsoft.Management/managementGroups/defaultGroup
   */
  defaultManagementGroup?: string;
}

/**
 * Operation supported by the Microsoft.Management resource provider.
 */
model Operation {
  /**
   * Operation name: {provider}/{resource}/{operation}.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The object that represents the operation.
   */
  display?: OperationDisplayProperties;
}

/**
 * The object that represents the operation.
 */
model OperationDisplayProperties {
  /**
   * The name of the provider.
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The resource on which the operation is performed.
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The operation that can be performed.
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * Operation description.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * Management group name availability check parameters.
 */
model CheckNameAvailabilityRequest {
  /**
   * the name to check for availability
   */
  name?: string;

  /**
   * fully qualified resource type which includes provider namespace
   */
  type?: "Microsoft.Management/managementGroups";
}

/**
 * Describes the result of the request to check management group name availability.
 */
model CheckNameAvailabilityResult {
  /**
   * Required. True indicates name is valid and available. False indicates the name is invalid, unavailable, or both.
   */
  @visibility(Lifecycle.Read)
  nameAvailable?: boolean;

  /**
   * Required if nameAvailable == false. Invalid indicates the name provided does not match the resource provider's naming requirements (incorrect length, unsupported characters, etc.) AlreadyExists indicates that the name is already in use and is therefore unavailable.
   */
  @visibility(Lifecycle.Read)
  reason?: Reason;

  /**
   * Required if nameAvailable == false. Localized. If reason == invalid, provide the user with the reason why the given name is invalid, and provide the resource naming requirements so that the user can select a valid name. If reason == AlreadyExists, explain that is already in use, and direct them to select a different name.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * The entity.
 */
model EntityInfo {
  /**
   * The fully qualified ID for the entity.  For example, /providers/Microsoft.Management/managementGroups/0000000-0000-0000-0000-000000000000
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  @visibility(Lifecycle.Read)
  id?: string | null;

  /**
   * The type of the resource. For example, Microsoft.Management/managementGroups
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  @visibility(Lifecycle.Read)
  type?: string | null;

  /**
   * The name of the entity. For example, 00000000-0000-0000-0000-000000000000
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The generic properties of an entity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  properties?: EntityInfoProperties | null;
}

/**
 * The generic properties of an entity.
 */
model EntityInfoProperties {
  /**
   * The AAD Tenant ID associated with the entity. For example, 00000000-0000-0000-0000-000000000000
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  tenantId?: string | null;

  /**
   * The friendly name of the management group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  displayName?: string | null;

  /**
   * (Optional) The ID of the parent management group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  parent?: EntityParentGroupInfo | null;

  /**
   * The users specific permissions to this item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "For backward compatibility"
  permissions?: Permissions | null;

  /**
   * The users specific permissions to this item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "For backward compatibility"
  inheritedPermissions?: Permissions | null;

  /**
   * Number of Descendants
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  numberOfDescendants?: int32 | null;

  /**
   * Number of children is the number of Groups and Subscriptions that are exactly one level underneath the current Group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  numberOfChildren?: int32 | null;

  /**
   * Number of children is the number of Groups that are exactly one level underneath the current Group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  numberOfChildGroups?: int32 | null;

  /**
   * The parent display name chain from the root group to the immediate parent
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  parentDisplayNameChain?: string[] | null;

  /**
   * The parent name chain from the root group to the immediate parent
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  parentNameChain?: string[] | null;
}

/**
 * (Optional) The ID of the parent management group.
 */
model EntityParentGroupInfo {
  /**
   * The fully qualified ID for the parent management group.  For example, /providers/Microsoft.Management/managementGroups/0000000-0000-0000-0000-000000000000
   */
  id?: string;
}

/**
 * The tenant backfill status
 */
model TenantBackfillStatusResult {
  /**
   * The AAD Tenant ID associated with the management group. For example, 00000000-0000-0000-0000-000000000000
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The status of the Tenant Backfill
   */
  @visibility(Lifecycle.Read)
  status?: Status;
}

/**
 * The results of an asynchronous operation.
 */
model OperationResults {
  /**
   * The fully qualified ID for the management group.  For example, /providers/Microsoft.Management/managementGroups/0000000-0000-0000-0000-000000000000
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The type of the resource.  For example, Microsoft.Management/managementGroups
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The name of the management group. For example, 00000000-0000-0000-0000-000000000000
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The generic properties of a management group.
   */
  properties?: ManagementGroupInfoProperties;
}

/**
 * The management group details for the hierarchy view.
 */
model EntityHierarchyItem {
  /**
   * The fully qualified ID for the management group.  For example, /providers/Microsoft.Management/managementGroups/0000000-0000-0000-0000-000000000000
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The type of the resource.  For example, Microsoft.Management/managementGroups
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The name of the management group. For example, 00000000-0000-0000-0000-000000000000
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The generic properties of a management group.
   */
  properties?: EntityHierarchyItemProperties;
}

/**
 * The generic properties of a management group.
 */
model EntityHierarchyItemProperties {
  /**
   * The friendly name of the management group.
   */
  displayName?: string;

  /**
   * The users specific permissions to this item.
   */
  permissions?: Permissions;

  /**
   * The list of children.
   */
  children?: EntityHierarchyItem[];
}

/**
 * Describes the result of the request to view entities.
 */
model EntityListResult {
  ...Azure.Core.Page<EntityInfo>;

  /**
   * Total count of records that match the filter.
   */
  count?: int32;
}

model DescendantListResult is Azure.Core.Page<DescendantInfo>;
