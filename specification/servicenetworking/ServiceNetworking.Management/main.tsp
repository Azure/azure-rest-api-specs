import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

@armProviderNamespace
@armCommonTypesVersion("v3")
@service({
  title: "TrafficController",
})
@doc("Traffic Controller Provider management API.")
@versioned(Versions)
namespace Microsoft.ServiceNetworking;

/** Api versions */
enum Versions {
  /** 2024-05-01 preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-05-01-preview`,
}

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

//----------------------- Frontends -----------------------
@doc("Frontend Subresource of Traffic Controller.")
@parentResource(TrafficController)
model Frontend is TrackedResource<FrontendProperties> {
  @key("frontendName")
  @doc("Frontends")
  @visibility("read")
  @path
  @segment("frontends")
  @pattern("^[A-Za-z0-9]([A-Za-z0-9-_.]{0,62}[A-Za-z0-9])?$")
  name: string;
}

@doc("Frontend Properties.")
model FrontendProperties {
  @visibility("read")
  @doc("The Fully Qualified Domain Name of the DNS record associated to a Traffic Controller frontend.")
  fqdn?: string;

  @visibility("read")
  @doc("Provisioning State of Traffic Controller Frontend Resource")
  provisioningState?: ProvisioningState;
}

//----------------------- Associations -----------------------
@doc("Association Subresource of Traffic Controller")
@parentResource(TrafficController)
model Association is TrackedResource<AssociationProperties> {
  @key("associationName")
  @visibility("read")
  @doc("Name of Association")
  @path
  @segment("associations")
  @pattern("^[A-Za-z0-9]([A-Za-z0-9-_.]{0,62}[A-Za-z0-9])?$")
  name: string;
}

@doc("Association Properties.")
model AssociationProperties {
  @doc("Association Type")
  associationType: AssociationType;

  @doc("Association Subnet")
  subnet?: AssociationSubnet;

  @visibility("read")
  @doc("Provisioning State of Traffic Controller Association Resource")
  provisioningState?: ProvisioningState;
}

@doc("Association Type Enum")
union AssociationType {
  string,
  "subnets",
}

@doc("Association Subnet.")
model AssociationSubnet {
  @doc("Association ID.")
  id: string;
}

//----------------------- SecurityPolicy -----------------------
@doc("SecurityPolicy Subresource of Traffic Controller.")
@parentResource(TrafficController)
model SecurityPolicy is TrackedResource<SecurityPolicyProperties> {
  @key("securityPolicyName")
  @doc("SecurityPolicy")
  @visibility("read")
  @path
  @segment("securityPolicy")
  @pattern("^[A-Za-z0-9]([A-Za-z0-9-_.]{0,62}[A-Za-z0-9])?$")
  name: string;
}

@doc("SecurityPolicy Properties.")
model SecurityPolicyProperties {
  @visibility("read")
  @doc("Type of the Traffic Controller Security Policy")
  policyType: PolicyType;

  @doc("Web Application Firewall Policy of the Traffic Controller Security Policy")
  wafPolicy?: WafPolicy;

  @visibility("read")
  @doc("Provisioning State of Traffic Controller SecurityPolicy Resource")
  provisioningState?: ProvisioningState;
}

union PolicyType {
  string,
  WAF: "waf",
}

@doc("Web Application Firewall Policy")
model WafPolicy {
  @doc("Resource ID of the WAF")
  id: string; 
}

@doc("SecurityPolicyConfigurations Subresource of Traffic Controller.")
@parentResource(TrafficController)
model SecurityPolicyConfigurations {
@doc("Contains reference to a WAF-type security policy that is applied at the Traffic Controller level.")
wafSecurityPolicy?: WafSecurityPolicy
} 

@doc("Web Application Firewall Security Policy")
model WafSecurityPolicy {
  @doc("Resource ID of the Waf Security Policy")
  id : string;
}

//----------------------- Traffic Controller -----------------------
@resource("trafficControllers")
model TrafficController is TrackedResource<TrafficControllerProperties> {
  @key("trafficControllerName")
  @path
  @segment("trafficControllers")
  @doc("traffic controller name for path")
  @pattern("^[A-Za-z0-9]([A-Za-z0-9-_.]{0,62}[A-Za-z0-9])?$")
  name: string;
}

@doc("Traffic Controller Properties.")
model TrafficControllerProperties {
  @doc("Configuration Endpoints.")
  @visibility("read")
  configurationEndpoints?: string[];

  @visibility("read")
  @doc("Frontends References List")
  frontends?: ResourceId[];

  @visibility("read")
  @doc("Associations References List")
  associations?: ResourceId[];

  @visibility("read")
  @doc("Security Policies References List ")
  securityPolicies?: ResourceId[];

  @doc("Security Policy Configuration")
  @OpenAPI.extension("x-ms-identifiers",[])
  securityPolicyConfigurations?: SecurityPolicyConfigurations[];

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Resource Provisioning State Enum")
@lroStatus
union ProvisioningState {
  string,
  Provisioning: "Provisioning",
  Updating: "Updating",
  Deleting: "Deleting",
  Accepted: "Accepted",
  Succeeded: "Succeeded",
  Failed: "Failed",
  Canceled: "Canceled",
}

@doc("Resource ID definition used by parent to reference child resources.")
model ResourceId {
  @doc("Resource ID of child resource.")
  id: string;
}

//----------------------- Paths -----------------------
@armResourceOperations
interface AssociationsInterface
  extends ResourceInstanceOperations<Association, AssociationProperties>,
    ResourceListByParent<Association> {}

@armResourceOperations
interface FrontendsInterface
  extends ResourceInstanceOperations<Frontend, FrontendProperties>,
    ResourceListByParent<Frontend> {}

@armResourceOperations
interface SecurityPoliciesInterface
  extends ResourceInstanceOperations<SecurityPolicy, SecurityPolicyProperties>,
    ResourceListByParent<SecurityPolicy> {}

@armResourceOperations
interface TrafficControllerInterface
  extends TrackedResourceOperations<
      TrafficController,
      TrafficControllerProperties
    > {}

interface Operations extends Azure.ResourceManager.Operations {}