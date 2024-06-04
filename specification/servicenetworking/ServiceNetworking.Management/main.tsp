import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

/** Traffic Controller Provider management API. */
@armProviderNamespace
@armCommonTypesVersion("v3")
@service({
  title: "TrafficController",
})
@versioned(Versions)
namespace Microsoft.ServiceNetworking;

/** Api versions */
enum Versions {
  /** 2023-11-01 stable version */
  v2023_11_01: "2023-11-01",

  /** 2024-05-01 preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2024_05_01_preview: "2024-05-01-preview",
}

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

//----------------------- Frontends -----------------------
/** Frontend Sub Resource of Traffic Controller. */
@parentResource(TrafficController)
model Frontend is TrackedResource<FrontendProperties> {
  /** Frontends */
  @key("frontendName")
  @visibility("read")
  @path
  @segment("frontends")
  @pattern("^[A-Za-z0-9]([A-Za-z0-9-_.]{0,62}[A-Za-z0-9])?$")
  name: string;
}

/** Frontend Properties. */
model FrontendProperties {
  /** The Fully Qualified Domain Name of the DNS record associated to a Traffic Controller frontend. */
  @visibility("read")
  fqdn?: string;

  /** Provisioning State of Traffic Controller Frontend Resource */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

//----------------------- Associations -----------------------
/** Association Subresource of Traffic Controller */
@parentResource(TrafficController)
model Association is TrackedResource<AssociationProperties> {
  /** Name of Association */
  @key("associationName")
  @visibility("read")
  @path
  @segment("associations")
  @pattern("^[A-Za-z0-9]([A-Za-z0-9-_.]{0,62}[A-Za-z0-9])?$")
  name: string;
}

/** Association Properties. */
model AssociationProperties {
  /** Association Type */
  associationType: AssociationType;

  /** Association Subnet */
  subnet?: AssociationSubnet;

  /** Provisioning State of Traffic Controller Association Resource */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/** Association Type Enum */
union AssociationType {
  string,

  /** Association of Type Subnet */
  "subnets",
}

/** Association Subnet. */
model AssociationSubnet {
  /** Association ID. */
  id: string;
}
//----------------------- SecurityPolicy -----------------------
/** SecurityPolicy Subresource of Traffic Controller. */
@parentResource(TrafficController)
model SecurityPolicy is TrackedResource<SecurityPolicyProperties> {
  /** SecurityPolicy */
  @key("securityPolicyName")
  @visibility("read")
  @path
  @segment("securityPolicy")
  @pattern("^[A-Za-z0-9]([A-Za-z0-9-_.]{0,62}[A-Za-z0-9])?$")
  name: string;
}

/** SecurityPolicy Properties. */
model SecurityPolicyProperties {
  /** Type of the Traffic Controller Security Policy */
  @visibility("read")
  policyType: PolicyType;

  /** Web Application Firewall Policy of the Traffic Controller Security Policy */
  wafPolicy?: WafPolicy;

  /** Provisioning State of Traffic Controller SecurityPolicy Resource */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/** Policy Type of the Security Policy */
union PolicyType {
  string,

  /** Policy of Type WAF */
  WAF: "waf",
}

/** Web Application Firewall Policy */
model WafPolicy {
  /** Resource ID of the WAF */
  id: string;
}

/** SecurityPolicyConfigurations Subresource of Traffic Controller. */
@parentResource(TrafficController)
model SecurityPolicyConfigurations {
  /** Contains reference to a WAF-type security policy that is applied at the Traffic Controller level. */
  wafSecurityPolicy?: WafSecurityPolicy;
}

/** Web Application Firewall Security Policy */
model WafSecurityPolicy {
  /** Resource ID of the Waf Security Policy */
  id: string;
}

//----------------------- Traffic Controller -----------------------
@resource("trafficControllers")
model TrafficController is TrackedResource<TrafficControllerProperties> {
  /** traffic controller name for path */
  @key("trafficControllerName")
  @path
  @segment("trafficControllers")
  @pattern("^[A-Za-z0-9]([A-Za-z0-9-_.]{0,62}[A-Za-z0-9])?$")
  name: string;
}

/** Traffic Controller Properties. */
model TrafficControllerProperties {
  /** Configuration Endpoints. */
  @visibility("read")
  configurationEndpoints?: string[];

  /** Frontends References List */
  @visibility("read")
  frontends?: ResourceId[];

  /** Associations References List */
  @visibility("read")
  associations?: ResourceId[];

  /** Security Policies References List */
  @visibility("read")
  @added(Versions.v2024_05_01_preview)
  securityPolicies?: ResourceId[];

  /** Security Policy Configuration */
  @added(Versions.v2024_05_01_preview)
  @OpenAPI.extension("x-ms-identifiers", [])
  securityPolicyConfigurations?: SecurityPolicyConfigurations;

  /** The status of the last operation. */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/** Resource Provisioning State Enum */
@lroStatus
union ProvisioningState {
  string,

  /** Resource in Provisioning State */
  Provisioning: "Provisioning",

  /** Resource in Updating State */
  Updating: "Updating",

  /** Resource in Deleting State */
  Deleting: "Deleting",

  /** Resource in Accepted State */
  Accepted: "Accepted",

  /** Resource in Succeeded State */
  Succeeded: "Succeeded",

  /** Resource in Failed State */
  Failed: "Failed",

  /** Resource in Canceled State */
  Canceled: "Canceled",
}

/** Resource ID definition used by parent to reference child resources. */
model ResourceId {
  /** Resource ID of child resource. */
  id: string;
}

//----------------------- Paths -----------------------
@armResourceOperations
interface AssociationsInterface {
  get is ArmResourceRead<Association>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Association>;
  update is ArmResourcePatchSync<Association, AssociationProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Association>;
  listByResourceGroup is ArmResourceListByParent<Association>;
}

@armResourceOperations
interface FrontendsInterface {
  get is ArmResourceRead<Frontend>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Frontend>;
  update is ArmResourcePatchSync<Frontend, FrontendProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Frontend>;
  listByResourceGroup is ArmResourceListByParent<Frontend>;
}

@added(Versions.v2024_05_01_preview)
@armResourceOperations
interface SecurityPoliciesInterface {
  get is ArmResourceRead<SecurityPolicy>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SecurityPolicy>;
  update is ArmResourcePatchSync<SecurityPolicy, SecurityPolicyProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<SecurityPolicy>;
  listByResourceGroup is ArmResourceListByParent<SecurityPolicy>;
}

@armResourceOperations
interface TrafficControllerInterface {
  get is ArmResourceRead<TrafficController>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<TrafficController>;
  update is ArmResourcePatchSync<
    TrafficController,
    TrafficControllerProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<TrafficController>;
  listByResourceGroup is ArmResourceListByParent<TrafficController>;
  listBySubscription is ArmListBySubscription<TrafficController>;
}

interface Operations extends Azure.ResourceManager.Operations {}
