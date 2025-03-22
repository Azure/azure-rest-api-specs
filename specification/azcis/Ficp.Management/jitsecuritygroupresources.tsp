import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("JIT security group resources properties")
model JitSecurityGroupResourceProperties {
  @doc("Instance identificator. Required.")
  instanceId: string;

  @doc("Cloud identifier for the JIT security group. Possible options are PROD, blackforest, fairfax, mooncake, ex, rx. Required.")
  cloud: string;

  @doc("Elevated security group.")
  elevatedSecurityGroup?: ResourceSecurityGroup;

  @doc("Corp security group.")
  corpSecurityGroup?: ResourceSecurityGroup;

  @doc("Provisioning mode type.")
  provisioningMode?: ProvisioningMode;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: FicpProvisioningState;
}

@doc("Resource security group type")
model ResourceSecurityGroup {
  @doc("JIT Scenario.")
  scenario: string;

  @doc("JIT Service name.")
  serviceName: string;

  @doc("JIT Security group.")
  securityGroup: string;
}

@doc("jitSecurityGroup Resource")
model JitSecurityGroupResource
  is ProxyResource<JitSecurityGroupResourceProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("jitSecurityGroupResources") // Start with lower case. Should be plural
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface JitSecurityGroup {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<JitSecurityGroupResource>;
  listBySubscription is ArmListBySubscription<JitSecurityGroupResource>;
  listByResourceGroup is ArmResourceListByParent<JitSecurityGroupResource>;
  get is ArmResourceRead<JitSecurityGroupResource>;
}
