import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-liftr-base";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using LiftrBase;

/* Microsoft.LiftrPilot Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.LiftrPilot management service" })
@versioned(Microsoft.LiftrPilot.Versions)
namespace Microsoft.LiftrPilot;

interface Operations extends Azure.ResourceManager.Operations {}

/** The available API versions. */
enum Versions {
  /** 2024-10-03-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(LiftrBase.Versions.v1_preview)
  v2024_10_03_preview: "2024-10-03-preview",

  /** 2025-04-03-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(LiftrBase.Versions.v1_preview)
  v2025_04_03_preview: "2025-04-03-preview",

  /** 2025-04-18-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(LiftrBase.Versions.v1_preview)
  v2025_04_18_preview: "2025-04-18-preview",

  /** 2025-05-21-preview version (new) */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(LiftrBase.Versions.v1_preview)
  v2025_05_21_preview: "2025-05-21-preview",

  /** 2025-05-23-preview version (new) */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(LiftrBase.Versions.v1_preview)
  v2025_05_23_preview: "2025-05-23-preview",

  /** 2025-10-24-preview version (new) */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @useDependency(LiftrBase.Versions.v1_preview)
  v2025_10_24_preview: "2025-10-24-preview",
}

/** These properties will be sent to your endpoints registered with Liftr during CRUD on resource.
 * BaseResourceProperties contains Marketplace, useDetail related properties*/
@doc("Properties specific to Organization")
model OrganizationProperties is BaseResourceProperties {
  @added(Versions.v2025_10_24_preview)
  @visibility(Lifecycle.Read)
  @doc("Managed-On-Behalf-Of configuration for the resource.")
  managedOnBehalfOfConfiguration?: Azure.ResourceManager.CommonTypes.ManagedOnBehalfOfConfiguration;

  @added(Versions.v2025_10_24_preview)
  @doc("Indicates whether this organization is created as part of a MOBO flow")
  isMoboFlowEnabled?: boolean;
}

model OrganizationResource
  is Azure.ResourceManager.TrackedResource<OrganizationProperties> {
  @key("organizationName")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_\\-.: ]*$")
  @segment("organizations")
  @minLength(1)
  @maxLength(50)
  @doc("Name of the Organization resource")
  @path
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

/**
 * The type used for update operations of the Organization Resource.
 */
model OrganizationResourceUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** Updatable managed service identity */
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface Organizations {
  get is ArmResourceRead<OrganizationResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<OrganizationResource>;
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchSync<
    OrganizationResource,
    OrganizationResourceUpdate
  >;
  delete is ArmResourceDeleteWithoutOkAsync<OrganizationResource>;
  listByResourceGroup is ArmResourceListByParent<OrganizationResource>;
  listBySubscription is ArmListBySubscription<OrganizationResource>;
}

@added(Versions.v2025_04_03_preview)
@doc("Liftr-Pilot proxy resource")
@parentResource(OrganizationResource)
model PilotProxyResource is ProxyResource<PilotProxyResourceProperties> {
  @key("pilotProxyResourceName")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_\\-.: ]*$")
  @segment("pilotProxyResources")
  @minLength(1)
  @maxLength(50)
  @doc("Name of the PilotProxyResource")
  @path
  name: string;
}

@added(Versions.v2025_04_03_preview)
@doc("The properties of PilotProxyResource")
model PilotProxyResourceProperties {
  @doc("Description of the proxy resource")
  description: string;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@added(Versions.v2025_04_03_preview)
@armResourceOperations
interface PilotProxyResources {
  get is ArmResourceRead<PilotProxyResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PilotProxyResource>;
  delete is ArmResourceDeleteWithoutOkAsync<PilotProxyResource>;
  listByOrganization is ArmResourceListByParent<PilotProxyResource>;
}

@added(Versions.v2025_04_18_preview)
@doc("Liftr-Pilot pure proxy resource")
@parentResource(OrganizationResource)
model PilotPureProxyResource
  is ProxyResource<PilotPureProxyResourceProperties> {
  @key("pilotPureProxyResourceName")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_\\-.: ]*$")
  @segment("pilotPureProxyResources")
  @minLength(1)
  @maxLength(50)
  @doc("Name of the PilotPureProxyResource")
  @path
  name: string;
}

@added(Versions.v2025_04_18_preview)
@doc("The properties of PurePilotProxyResource")
model PilotPureProxyResourceProperties {
  @doc("Description of the pure proxy resource")
  description: string;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@added(Versions.v2025_04_18_preview)
@armResourceOperations
interface PilotPureProxyResources {
  get is ArmResourceRead<PilotPureProxyResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PilotPureProxyResource>;
  delete is ArmResourceDeleteWithoutOkAsync<PilotPureProxyResource>;
  listByOrganization is ArmResourceListByParent<PilotPureProxyResource>;
}

@added(Versions.v2025_05_21_preview)
@doc("Partner-specific Properties")
model PartnerProperties {
  @doc("The region of the instance")
  region: string;

  @doc("The subdomain of the instance")
  @pattern("^[a-zA-Z0-9]+$")
  @minLength(1)
  @maxLength(30)
  subdomain: string;
}

@added(Versions.v2025_05_21_preview)
@doc("Properties specific to TestTrackedResource")
model TestTrackedResourceProperties is BaseResourceProperties {
  @doc("Partner properties")
  partnerProperties: PartnerProperties;

  @doc("Single sign-on properties")
  singleSignOnProperties?: SingleSignOnPropertiesV2;
}

@added(Versions.v2025_05_21_preview)
@doc("Test tracked resource")
model TestTrackedResourceUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** Updatable managed service identity */
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@added(Versions.v2025_05_21_preview)
model TestTrackedResource
  is Azure.ResourceManager.TrackedResource<TestTrackedResourceProperties> {
  @key("testTrackedResourceName")
  @pattern("^[a-zA-Z0-9]+$")
  @segment("testTrackedResources")
  @minLength(1)
  @maxLength(50)
  @doc("Name of the TestTrackedResource resource")
  @path
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@added(Versions.v2025_05_21_preview)
@doc("The properties of StopBackupTestTrackedResourceRequest")
model StopBackupTestTrackedResourceRequest {
  @doc("The reason for stopping the backup")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  reason: string;
}

@added(Versions.v2025_05_21_preview)
@doc("The properties of RestoreTestTrackedResourceRequest")
model RestoreTestTrackedResourceRequest {
  @doc("Check whether inplace or out of place restore.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  inPlaceRestore: boolean;
}

@added(Versions.v2025_05_21_preview)
@doc("Restore resource response for a Test tracked resource.")
model RestoreTestTrackedResourceResponse {
  @doc("The partner response for taskId")
  @visibility(Lifecycle.Read)
  taskId: int32;
}

@added(Versions.v2025_05_21_preview)
@armResourceOperations
interface TestTrackedResources {
  get is ArmResourceRead<TestTrackedResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<TestTrackedResource>;
  delete is ArmResourceDeleteWithoutOkAsync<TestTrackedResource>;
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<TestTrackedResource, TestTrackedResourceUpdate>;
  listByResourceGroup is ArmResourceListByParent<TestTrackedResource>;
  listBySubscription is ArmListBySubscription<TestTrackedResource>;
  @doc("Restore resource for a test tracked resource.")
  @armResourceAction(TestTrackedResource)
  @action("restore")
  @post
  restore(
    ...ResourceInstanceParameters<TestTrackedResource>,

    @bodyRoot
    @doc("The body type of the operation request.")
    request: RestoreTestTrackedResourceRequest,
  ): ArmResponse<RestoreTestTrackedResourceResponse> | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/no-openapi"
  @doc("Stop Backup for a Test Tracked Resource")
  @armResourceAction(TestTrackedResource)
  @post
  @OpenAPI.extension("x-ms-long-running-operation", true)
  stopBackup(
    ...ResourceInstanceParameters<TestTrackedResource>,

    @bodyRoot
    @doc("The body type of the operation request.")
    request: StopBackupTestTrackedResourceRequest,
  ): ArmAcceptedLroResponse | ErrorResponse;
}

@added(Versions.v2025_05_21_preview)
@doc("Test proxy resource")
@parentResource(TestTrackedResource)
model TestProxyResource is ProxyResource<TestProxyResourceProperties> {
  @key("testProxyResourceName")
  @pattern("^[a-zA-Z0-9]+$")
  @segment("testProxyResources")
  @minLength(1)
  @maxLength(50)
  @doc("Name of the TestProxyResource")
  @path
  name: string;
}

@added(Versions.v2025_05_21_preview)
@doc("The properties of TestProxyResource")
model TestProxyResourceProperties {
  @doc("partner properties")
  partnerProperties: PartnerProperties;

  @doc("Single sign-on properties")
  singleSignOnProperties?: SingleSignOnPropertiesV2;

  @doc("Description of the proxy resource")
  description: string;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@added(Versions.v2025_05_21_preview)
@doc("The properties of ExportTestProxyResourceRequest")
model ExportTestProxyResourceRequest {
  @doc("Exporting the resource to a different region")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  region: string;
}

@added(Versions.v2025_05_21_preview)
@doc("The properties of RestartTestProxyResourceRequest")
model RestartTestProxyResourceRequest {
  @doc("Check whether inStaleState or not.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  inStaleState: boolean;
}

@added(Versions.v2025_05_21_preview)
@doc("Restart resource response for a Test proxy resource.")
model RestartTestProxyResourceResponse {
  @doc("The partner response for taskId")
  @visibility(Lifecycle.Read)
  taskId: int32;
}

@added(Versions.v2025_05_21_preview)
@armResourceOperations
interface TestProxyResources {
  get is ArmResourceRead<TestProxyResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<TestProxyResource>;
  delete is ArmResourceDeleteWithoutOkAsync<TestProxyResource>;
  listByTestTracked is ArmResourceListByParent<TestProxyResource>;
  @doc("Restart resource for a test proxy resource.")
  @armResourceAction(TestProxyResource)
  @action("restart")
  @post
  restart(
    ...ResourceInstanceParameters<TestProxyResource>,

    @bodyRoot
    @doc("The body type of the operation request.")
    request: RestartTestProxyResourceRequest,
  ): ArmResponse<RestartTestProxyResourceResponse> | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/no-openapi"
  @doc("Export for a Test Proxy Resource")
  @armResourceAction(TestProxyResource)
  @post
  @OpenAPI.extension("x-ms-long-running-operation", true)
  export(
    ...ResourceInstanceParameters<TestProxyResource>,

    @bodyRoot
    @doc("The body type of the operation request.")
    request: ExportTestProxyResourceRequest,
  ): ArmAcceptedLroResponse | ErrorResponse;
}

@added(Versions.v2025_05_21_preview)
@doc("Test child pure proxy resource")
@parentResource(TestProxyResource)
model TestChildPureProxyResource
  is ProxyResource<TestChildPureProxyResourceProperties> {
  @key("testChildPureProxyResourceName")
  @pattern("^[a-zA-Z0-9]+$")
  @segment("testChildPureProxyResources")
  @minLength(1)
  @maxLength(50)
  @doc("Name of the TestChildPureProxyResource")
  @path
  name: string;
}

@added(Versions.v2025_05_21_preview)
@doc("The properties of TestChildPureProxyResource")
model TestChildPureProxyResourceProperties {
  @doc("partner properties")
  partnerProperties: PartnerProperties;

  @doc("Single sign-on properties")
  singleSignOnProperties?: SingleSignOnPropertiesV2;

  @doc("Description of the test child pure proxy resource")
  description: string;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@added(Versions.v2025_05_21_preview)
@doc("The properties of UnregisterTestChildPureProxyResourceRequest")
model UnregisterTestChildPureProxyResourceRequest {
  @doc("Unregister the resource")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  region: string;
}

@added(Versions.v2025_05_21_preview)
@doc("The properties of RegisterTestChildPureProxyResourceRequest")
model RegisterTestChildPureProxyResourceRequest {
  @doc("Check whether inRegisterState or not.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  inRegisterState: boolean;
}

@added(Versions.v2025_05_21_preview)
@doc("Restart resource response for a Test child pure proxy resource.")
model RegisterTestChildPureProxyResourceResponse {
  @doc("The partner response for taskId")
  @visibility(Lifecycle.Read)
  taskId: int32;
}

@added(Versions.v2025_05_21_preview)
@armResourceOperations
interface TestChildPureProxyResources {
  get is ArmResourceRead<TestChildPureProxyResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<TestChildPureProxyResource>;
  delete is ArmResourceDeleteWithoutOkAsync<TestChildPureProxyResource>;
  listByTestTracked is ArmResourceListByParent<TestChildPureProxyResource>;
  @doc("Register resource for a test child pure proxy child resource.")
  @armResourceAction(TestChildPureProxyResource)
  @action("register")
  @post
  register(
    ...ResourceInstanceParameters<TestChildPureProxyResource>,

    @bodyRoot
    @doc("The body type of the operation request.")
    request: RegisterTestChildPureProxyResourceRequest,
  ): ArmResponse<RegisterTestChildPureProxyResourceResponse> | ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/no-openapi"
  @doc("Unregister for a Test Child Pure Proxy Resource")
  @armResourceAction(TestChildPureProxyResource)
  @post
  @OpenAPI.extension("x-ms-long-running-operation", true)
  unregister(
    ...ResourceInstanceParameters<TestChildPureProxyResource>,

    @bodyRoot
    @doc("The body type of the operation request.")
    request: UnregisterTestChildPureProxyResourceRequest,
  ): ArmAcceptedLroResponse | ErrorResponse;
}

@added(Versions.v2025_05_21_preview)
@doc("Properties specific to TestTrackedResource")
model TestTrackedSyncResourceProperties is BaseResourceProperties {
  @doc("partner properties")
  partnerProperties: PartnerProperties;

  @doc("Single sign-on properties")
  singleSignOnProperties?: SingleSignOnPropertiesV2;
}
@added(Versions.v2025_05_21_preview)
@doc("Test tracked resource")
model TestTrackedSyncResourceUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** Updatable managed service identity */
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@added(Versions.v2025_05_21_preview)
model TestTrackedSyncResource
  is Azure.ResourceManager.TrackedResource<TestTrackedSyncResourceProperties> {
  @key("testTrackedSyncResourceName")
  @pattern("^[a-zA-Z0-9]+$")
  @segment("testTrackedSyncResources")
  @minLength(1)
  @maxLength(50)
  @doc("Name of the TestTrackedSyncResource resource")
  @path
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@added(Versions.v2025_05_21_preview)
@armResourceOperations
interface TestTrackedSyncResources {
  get is ArmResourceRead<TestTrackedSyncResource>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<TestTrackedSyncResource>;
  delete is ArmResourceDeleteSync<TestTrackedSyncResource>;
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchSync<
    TestTrackedSyncResource,
    TestTrackedSyncResourceUpdate
  >;
  listByResourceGroup is ArmResourceListByParent<TestTrackedSyncResource>;
  listBySubscription is ArmListBySubscription<TestTrackedSyncResource>;
}

@added(Versions.v2025_05_23_preview)
@doc("Properties specific to SaaS")
model SaasProperties is BaseResourceProperties;

@added(Versions.v2025_05_23_preview)
model SaaS is Azure.ResourceManager.TrackedResource<SaasProperties> {
  @key("saaSResourceName")
  @pattern("^[a-zA-Z0-9]+$")
  @segment("saaSResources")
  @minLength(1)
  @maxLength(50)
  @doc("Name of the SaaS resource")
  @path
  name: string;
}

@added(Versions.v2025_05_23_preview)
@doc("SaaS guid & PublishedId for Activate and Validate SaaS Resource")
model ActivateSaasParameterRequest {
  @doc("SaaS guid for Activate and Validate SaaS Resource")
  saasGuid: string;
}

@added(Versions.v2025_05_23_preview)
@doc("Restore resource response for a Test tracked resource.")
model ActivateSaasResponse {
  @doc("The partner response for saasId")
  @visibility(Lifecycle.Read)
  saasId: string;
}

@added(Versions.v2025_10_24_preview)
@doc("Input for ProviderLevelTestAction")
model ProviderLevelTestActionRequest {
  @doc("ID of the action performed")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  actionId: string;
}

@added(Versions.v2025_10_24_preview)
@doc("Output for ProviderLevelTestAction")
model ProviderLevelTestActionResponse {
  @doc("Result of the action performed")
  @visibility(Lifecycle.Read)
  result: string;
}

@added(Versions.v2025_10_24_preview)
@armResourceOperations
interface ProviderLevelTestActions {
  #suppress "@azure-tools/typespec-azure-core/no-openapi"
  @doc("Test Provider Level Action.")
  @route("/providers/Microsoft.LiftrPilot/providerLevelTestAction")
  @post
  @OpenAPI.extension("x-ms-long-running-operation", true)
  invoke(
    ...ApiVersionParameter,

    @bodyRoot
    @doc("The details for ProviderLevelTestAction request.")
    request: ProviderLevelTestActionRequest,
  ): ArmResponse<ProviderLevelTestActionResponse> | ArmAcceptedLroResponse | ErrorResponse;
}

@added(Versions.v2025_05_23_preview)
@armResourceOperations
interface SaasOperations {
  @doc("Activate SaaS resource.")
  @armResourceAction(SaaS)
  @action("activateSaaS")
  @post
  activateSaaS(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ProviderNamespace<SaaS>,

    @bodyRoot
    @doc("The details for ActivateSaaSParameter request.")
    request: ActivateSaasParameterRequest,
  ): ArmResponse<ActivateSaasResponse> | ErrorResponse;
}
