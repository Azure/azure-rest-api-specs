import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Solutions;

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,

  /**
   * user
   */
  user: "user",

  /**
   * system
   */
  system: "system",

  /**
   * user,system
   */
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,

  /**
   * Internal
   */
  Internal: "Internal",
}

/**
 * Provisioning status of the managed application.
 */
union ProvisioningState {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Deleted
   */
  Deleted: "Deleted",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Updating
   */
  Updating: "Updating",
}

/**
 * The Jit approval mode.
 */
union JitApprovalMode {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * AutoApprove
   */
  AutoApprove: "AutoApprove",

  /**
   * ManualApprove
   */
  ManualApprove: "ManualApprove",
}

/**
 * The approver type.
 */
union JitApproverType {
  string,

  /**
   * user
   */
  user: "user",

  /**
   * group
   */
  group: "group",
}

/**
 * The management mode.
 */
union ApplicationManagementMode {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * Unmanaged
   */
  Unmanaged: "Unmanaged",

  /**
   * Managed
   */
  Managed: "Managed",
}

/**
 * The managed application artifact name.
 */
union ApplicationArtifactName {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * ViewDefinition
   */
  ViewDefinition: "ViewDefinition",

  /**
   * Authorizations
   */
  Authorizations: "Authorizations",

  /**
   * CustomRoleDefinition
   */
  CustomRoleDefinition: "CustomRoleDefinition",
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
 * The managed application artifact name.
 */
union ApplicationDefinitionArtifactName {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * ApplicationResourceTemplate
   */
  ApplicationResourceTemplate: "ApplicationResourceTemplate",

  /**
   * CreateUiDefinition
   */
  CreateUiDefinition: "CreateUiDefinition",

  /**
   * MainTemplateParameters
   */
  MainTemplateParameters: "MainTemplateParameters",
}

/**
 * The deployment mode.
 */
union DeploymentMode {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * Incremental
   */
  Incremental: "Incremental",

  /**
   * Complete
   */
  Complete: "Complete",
}

/**
 * The JIT request scheduling type.
 */
union JitSchedulingType {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * Once
   */
  Once: "Once",

  /**
   * Recurring
   */
  Recurring: "Recurring",
}

/**
 * The JIT request state.
 */
union JitRequestState {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Approved
   */
  Approved: "Approved",

  /**
   * Denied
   */
  Denied: "Denied",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Expired
   */
  Expired: "Expired",

  /**
   * Timeout
   */
  Timeout: "Timeout",
}

/**
 * The JIT status.
 */
union Status {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * Elevate
   */
  Elevate: "Elevate",

  /**
   * Remove
   */
  Remove: "Remove",
}

/**
 * The sub status.
 */
union Substatus {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * Approved
   */
  Approved: "Approved",

  /**
   * Denied
   */
  Denied: "Denied",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Expired
   */
  Expired: "Expired",

  /**
   * Timeout
   */
  Timeout: "Timeout",
}

/**
 * The managed application artifact type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ApplicationArtifactType {
  /**
   * NotSpecified
   */
  NotSpecified,

  /**
   * Template
   */
  Template,

  /**
   * Custom
   */
  Custom,
}

/**
 * The identity type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ResourceIdentityType {
  /**
   * SystemAssigned
   */
  SystemAssigned,

  /**
   * UserAssigned
   */
  UserAssigned,

  /**
   * SystemAssigned, UserAssigned
   */
  `SystemAssigned, UserAssigned`,

  /**
   * None
   */
  None,
}

/**
 * The managed application lock level.
 */
union ApplicationLockLevel {
  string,

  /**
   * CanNotDelete
   */
  CanNotDelete: "CanNotDelete",

  /**
   * ReadOnly
   */
  ReadOnly: "ReadOnly",

  /**
   * None
   */
  None: "None",
}

/**
 * Localized display information for this particular operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * The managed application properties.
 */
model ApplicationProperties {
  /**
   * The managed resource group Id.
   */
  managedResourceGroupId?: string;

  /**
   * The fully qualified path of managed application definition Id.
   */
  applicationDefinitionId?: string;

  /**
   * Name and value pairs that define the managed application parameters. It can be a JObject or a well formed JSON string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: unknown;

  /**
   * Name and value pairs that define the managed application outputs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  outputs?: unknown;

  /**
   * The managed application provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The managed application billing details.
   */
  @visibility(Lifecycle.Read)
  billingDetails?: ApplicationBillingDetailsDefinition;

  /**
   * The managed application Jit access policy.
   */
  jitAccessPolicy?: ApplicationJitAccessPolicy;

  /**
   * The publisher tenant Id.
   */
  @visibility(Lifecycle.Read)
  publisherTenantId?: string;

  /**
   * The  read-only authorizations property that is retrieved from the application package.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["principalId", "roleDefinitionId"])
  authorizations?: ApplicationAuthorization[];

  /**
   * The managed application management mode.
   */
  @visibility(Lifecycle.Read)
  managementMode?: ApplicationManagementMode;

  /**
   * The read-only customer support property that is retrieved from the application package.
   */
  @visibility(Lifecycle.Read)
  customerSupport?: ApplicationPackageContact;

  /**
   * The read-only support URLs property that is retrieved from the application package.
   */
  @visibility(Lifecycle.Read)
  supportUrls?: ApplicationPackageSupportUrls;

  /**
   * The collection of managed application artifacts.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name", "uri"])
  artifacts?: ApplicationArtifact[];

  /**
   * The client entity that created the JIT request.
   */
  @visibility(Lifecycle.Read)
  createdBy?: ApplicationClientDetails;

  /**
   * The client entity that last updated the JIT request.
   */
  @visibility(Lifecycle.Read)
  updatedBy?: ApplicationClientDetails;
}

/**
 * Managed application billing details definition.
 */
model ApplicationBillingDetailsDefinition {
  /**
   * The managed application resource usage Id.
   */
  resourceUsageId?: string;
}

/**
 * Managed application Jit access policy.
 */
model ApplicationJitAccessPolicy {
  /**
   * Whether the JIT access is enabled.
   */
  jitAccessEnabled: boolean;

  /**
   * JIT approval mode.
   */
  jitApprovalMode?: JitApprovalMode;

  /**
   * The JIT approvers
   */
  jitApprovers?: JitApproverDefinition[];

  /**
   * The maximum duration JIT access is granted. This is an ISO8601 time period value.
   */
  maximumJitAccessDuration?: string;
}

/**
 * JIT approver definition.
 */
model JitApproverDefinition {
  /**
   * The approver service principal Id.
   */
  id: string;

  /**
   * The approver type.
   */
  type?: JitApproverType;

  /**
   * The approver display name.
   */
  displayName?: string;
}

/**
 * The managed application provider authorization.
 */
model ApplicationAuthorization {
  /**
   * The provider's principal identifier. This is the identity that the provider will use to call ARM to manage the managed application resources.
   */
  principalId: string;

  /**
   * The provider's role definition identifier. This role will define all the permissions that the provider must have on the managed application's container resource group. This role definition cannot have permission to delete the resource group.
   */
  roleDefinitionId: string;
}

/**
 * The application package contact information.
 */
model ApplicationPackageContact {
  /**
   * The contact name.
   */
  contactName?: string;

  /**
   * The contact email.
   */
  email: string;

  /**
   * The contact phone number.
   */
  phone: string;
}

/**
 * The appliance package support URLs.
 */
model ApplicationPackageSupportUrls {
  /**
   * The public azure support URL.
   */
  publicAzure?: string;

  /**
   * The government cloud support URL.
   */
  governmentCloud?: string;
}

/**
 * Managed application artifact.
 */
model ApplicationArtifact {
  /**
   * The managed application artifact name.
   */
  name: ApplicationArtifactName;

  /**
   * The managed application artifact blob uri.
   */
  uri: string;

  /**
   * The managed application artifact type.
   */
  type: ApplicationArtifactType;
}

/**
 * The application client details to track the entity creating/updating the managed app resource.
 */
model ApplicationClientDetails {
  /**
   * The client Oid.
   */
  oid?: string;

  /**
   * The client Puid
   */
  puid?: string;

  /**
   * The client application Id.
   */
  applicationId?: string;
}

/**
 * Plan for the managed application.
 */
model Plan {
  /**
   * The plan name.
   */
  name: string;

  /**
   * The publisher ID.
   */
  publisher: string;

  /**
   * The product code.
   */
  product: string;

  /**
   * The promotion code.
   */
  promotionCode?: string;

  /**
   * The plan's version.
   */
  version: string;
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The identity type.
   */
  type?: ResourceIdentityType;

  /**
   * The list of user identities associated with the resource. The user identity dictionary key references will be resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<userAssignedResourceIdentity>;
}

/**
 * Represents the user assigned identity that is contained within the UserAssignedIdentities dictionary on ResourceIdentity
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model userAssignedResourceIdentity {
  /**
   * The principal id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;
}

/**
 * Resource information.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GenericResource extends Resource {
  /**
   * ID of the resource that manages this resource.
   */
  managedBy?: string;

  /**
   * The SKU of the resource.
   */
  sku?: Sku;
}

/**
 * SKU for the resource.
 */
model Sku {
  /**
   * The SKU name.
   */
  name: string;

  /**
   * The SKU tier.
   */
  tier?: string;

  /**
   * The SKU size.
   */
  size?: string;

  /**
   * The SKU family.
   */
  family?: string;

  /**
   * The SKU model.
   */
  `model`?: string;

  /**
   * The SKU capacity.
   */
  capacity?: int32;
}

/**
 * Resource information.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model Resource {
  /**
   * Resource ID
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource location
   */
  location?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Information about managed application.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ApplicationPatchable extends GenericResource {
  /**
   * The managed application properties.
   */
  properties?: ApplicationProperties;

  /**
   * The plan information.
   */
  plan?: PlanPatchable;

  /**
   * The kind of the managed application. Allowed values are MarketPlace and ServiceCatalog.
   */
  @pattern("^[-\\w\\._,\\(\\)]+$")
  kind?: string;

  /**
   * The identity of the resource.
   */
  identity?: Identity;
}

/**
 * Plan for the managed application.
 */
model PlanPatchable {
  /**
   * The plan name.
   */
  name?: string;

  /**
   * The publisher ID.
   */
  publisher?: string;

  /**
   * The product code.
   */
  product?: string;

  /**
   * The promotion code.
   */
  promotionCode?: string;

  /**
   * The plan's version.
   */
  version?: string;
}

/**
 * The managed application definition properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ApplicationDefinitionProperties {
  /**
   * The managed application lock level.
   */
  lockLevel: ApplicationLockLevel;

  /**
   * The managed application definition display name.
   */
  displayName?: string;

  /**
   * A value indicating whether the package is enabled or not.
   */
  isEnabled?: boolean;

  /**
   * The managed application provider authorizations.
   */
  @identifiers(#["principalId", "roleDefinitionId"])
  authorizations?: ApplicationAuthorization[];

  /**
   * The collection of managed application artifacts. The portal will use the files specified as artifacts to construct the user experience of creating a managed application from a managed application definition.
   */
  @identifiers(#["name", "uri"])
  artifacts?: ApplicationDefinitionArtifact[];

  /**
   * The managed application definition description.
   */
  description?: string;

  /**
   * The managed application definition package file Uri. Use this element
   */
  packageFileUri?: string;

  /**
   * The storage account id for bring your own storage scenario.
   */
  storageAccountId?: string;

  /**
   * The inline main template json which has resources to be provisioned. It can be a JObject or well-formed JSON string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  mainTemplate?: unknown;

  /**
   * The createUiDefinition json for the backing template with Microsoft.Solutions/applications resource. It can be a JObject or well-formed JSON string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createUiDefinition?: unknown;

  /**
   * The managed application notification policy.
   */
  notificationPolicy?: ApplicationNotificationPolicy;

  /**
   * The managed application locking policy.
   */
  lockingPolicy?: ApplicationPackageLockingPolicyDefinition;

  /**
   * The managed application deployment policy.
   */
  deploymentPolicy?: ApplicationDeploymentPolicy;

  /**
   * The managed application management policy that determines publisher's access to the managed resource group.
   */
  managementPolicy?: ApplicationManagementPolicy;

  /**
   * The managed application provider policies.
   */
  @identifiers(#["name", "policyDefinitionId"])
  policies?: ApplicationPolicy[];
}

/**
 * Application definition artifact.
 */
model ApplicationDefinitionArtifact {
  /**
   * The managed application definition artifact name.
   */
  name: ApplicationDefinitionArtifactName;

  /**
   * The managed application definition artifact blob uri.
   */
  uri: string;

  /**
   * The managed application definition artifact type.
   */
  type: ApplicationArtifactType;
}

/**
 * Managed application notification policy.
 */
model ApplicationNotificationPolicy {
  /**
   * The managed application notification endpoint.
   */
  @identifiers(#["uri"])
  notificationEndpoints: ApplicationNotificationEndpoint[];
}

/**
 * Managed application notification endpoint.
 */
model ApplicationNotificationEndpoint {
  /**
   * The managed application notification endpoint uri.
   */
  uri: string;
}

/**
 * Managed application locking policy.
 */
model ApplicationPackageLockingPolicyDefinition {
  /**
   * The deny assignment excluded actions.
   */
  allowedActions?: string[];

  /**
   * The deny assignment excluded data actions.
   */
  allowedDataActions?: string[];
}

/**
 * Managed application deployment policy.
 */
model ApplicationDeploymentPolicy {
  /**
   * The managed application deployment mode.
   */
  deploymentMode: DeploymentMode;
}

/**
 * Managed application management policy.
 */
model ApplicationManagementPolicy {
  /**
   * The managed application management mode.
   */
  mode?: ApplicationManagementMode;
}

/**
 * Managed application policy.
 */
model ApplicationPolicy {
  /**
   * The policy name
   */
  name?: string;

  /**
   * The policy definition Id.
   */
  policyDefinitionId?: string;

  /**
   * The policy parameters.
   */
  parameters?: string;
}

/**
 * Information about an application definition request.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ApplicationDefinitionPatchable {
  /**
   * Application definition tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Information about JIT request properties
 */
model JitRequestProperties {
  /**
   * The parent application id.
   */
  applicationResourceId: string;

  /**
   * The publisher tenant id.
   */
  @visibility(Lifecycle.Read)
  publisherTenantId?: string;

  /**
   * The JIT authorization policies.
   */
  @identifiers(#["principalId", "roleDefinitionId"])
  jitAuthorizationPolicies: JitAuthorizationPolicies[];

  /**
   * The JIT request properties.
   */
  jitSchedulingPolicy: JitSchedulingPolicy;

  /**
   * The JIT request provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The JIT request state.
   */
  @visibility(Lifecycle.Read)
  jitRequestState?: JitRequestState;

  /**
   * The client entity that created the JIT request.
   */
  @visibility(Lifecycle.Read)
  createdBy?: ApplicationClientDetails;

  /**
   * The client entity that last updated the JIT request.
   */
  @visibility(Lifecycle.Read)
  updatedBy?: ApplicationClientDetails;
}

/**
 * The JIT authorization policies.
 */
model JitAuthorizationPolicies {
  /**
   * The the principal id that will be granted JIT access.
   */
  principalId: string;

  /**
   * The role definition id that will be granted to the Principal.
   */
  roleDefinitionId: string;
}

/**
 * The JIT scheduling policies.
 */
model JitSchedulingPolicy {
  /**
   * The type of JIT schedule.
   */
  type: JitSchedulingType;

  /**
   * The required duration of the JIT request.
   */
  @summary("The required duration of the JIT request.")
  duration: duration;

  /**
   * The start time of the request.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime: utcDateTime;
}

/**
 * Information about JIT request.
 */
model JitRequestPatchable {
  /**
   * Jit request tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * The array of plan.
 */
model AllowedUpgradePlansResult {
  /**
   * The array of plans.
   */
  @pageItems
  value?: Plan[];
}

/**
 * Update access request definition.
 */
model UpdateAccessDefinition {
  /**
   * The approver name.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Approver?: string;

  /**
   * The JIT request metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Metadata: JitRequestMetadata;

  /**
   * The JIT status.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Status: Status;

  /**
   * The JIT status.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SubStatus: Substatus;
}

/**
 * The JIT request metadata.
 */
model JitRequestMetadata {
  /**
   * The origin request id.
   */
  originRequestId?: string;

  /**
   * The requestor id.
   */
  requestorId?: string;

  /**
   * The publisher's tenant name.
   */
  tenantDisplayName?: string;

  /**
   * The subject display name.
   */
  subjectDisplayName?: string;
}

/**
 * List token request body.
 */
model ListTokenRequest {
  /**
   * The authorization audience.
   */
  authorizationAudience?: string;

  /**
   * The user assigned identities.
   */
  userAssignedIdentities?: string[];
}

/**
 * The array of managed identity tokens.
 */
model ManagedIdentityTokenResult {
  /**
   * The array of managed identity tokens.
   */
  @pageItems
  @identifiers(#[])
  value?: ManagedIdentityToken[];
}

/**
 * The managed identity token for the managed app resource.
 */
model ManagedIdentityToken {
  /**
   * The requested access token.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  accessToken?: string;

  /**
   * The number of seconds the access token will be valid.
   */
  expiresIn?: string;

  /**
   * The timespan when the access token expires. This is represented as the number of seconds from epoch.
   */
  expiresOn?: string;

  /**
   * The timespan when the access token takes effect. This is represented as the number of seconds from epoch.
   */
  notBefore?: string;

  /**
   * The aud (audience) the access token was request for. This is the same as what was provided in the listTokens request.
   */
  authorizationAudience?: string;

  /**
   * The Azure resource ID for the issued token. This is either the managed application ID or the user-assigned identity ID.
   */
  resourceId?: string;

  /**
   * The type of the token.
   */
  tokenType?: string;
}

/**
 * Plan for the managed application.
 */
model RegistryPackagePlan {
  /**
   * The publisher ID.
   */
  publisher: string;

  /**
   * The offer Id.
   */
  offer: string;

  /**
   * The plan Id.
   */
  plan: string;

  /**
   * The plan's version.
   */
  version?: string;
}

/**
 * Information about an application definition request.
 */
model RegistryPackage {
  /**
   * The publisher
   */
  publisher: string;

  /**
   * The offer Id
   */
  offer: string;

  /**
   * The plan Id
   */
  plan: string;

  /**
   * The version of the plan
   */
  version: string;

  /**
   * The registry package links.
   */
  packageLinks: RegistryPackageLinks;
}

/**
 * Resource information.
 */
model RegistryPackageLinks {
  /**
   * The create ui definition link.
   */
  createUiDefinitionLink?: string;

  /**
   * The deployment template link.
   */
  deploymentTemplateLink?: string;
}

/**
 * The managed application properties.
 */
model ApplicationPropertiesPatchable {
  /**
   * The managed resource group Id.
   */
  managedResourceGroupId?: string;

  /**
   * The fully qualified path of managed application definition Id.
   */
  applicationDefinitionId?: string;

  /**
   * Name and value pairs that define the managed application parameters. It can be a JObject or a well formed JSON string.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  parameters?: unknown;

  /**
   * Name and value pairs that define the managed application outputs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  outputs?: unknown;

  /**
   * The managed application provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
