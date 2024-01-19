import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
@doc("Defines web application firewall policy.")
model WebApplicationFirewallPolicy
  is TrackedResource<WebApplicationFirewallPolicyProperties> {
  @doc("The name of the Web Application Firewall Policy.")
  @maxLength(128)
  @path
  @key("policyName")
  @segment("FrontDoorWebApplicationFirewallPolicies")
  name: string;

  @doc("Gets a unique read-only string that changes whenever the resource is updated.")
  etag?: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface WebApplicationFirewallPolicies {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve protection policy with specified name within a resource group.")
  @operationId("Policies_Get")
  get is ArmResourceRead<WebApplicationFirewallPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update policy with specified rule set name within a resource group.")
  @operationId("Policies_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<WebApplicationFirewallPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Patch a specific frontdoor webApplicationFirewall policy for tags update under the specified subscription and resource group.")
  @operationId("Policies_Update")
  update is ArmCustomPatchAsync<WebApplicationFirewallPolicy, TagsObject>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes Policy")
  @operationId("Policies_Delete")
  delete is ArmResourceDeleteAsync<WebApplicationFirewallPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all of the protection policies within a resource group.")
  @operationId("Policies_List")
  list is ArmResourceListByParent<WebApplicationFirewallPolicy>;
}

@@projectedName(WebApplicationFirewallPolicies.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(WebApplicationFirewallPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(WebApplicationFirewallPolicies.createOrUpdate::parameters.resource,
  "Policy to be created."
);
@@projectedName(WebApplicationFirewallPolicies.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(WebApplicationFirewallPolicies.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(WebApplicationFirewallPolicies.update::parameters.properties,
  "FrontdoorWebApplicationFirewallPolicy parameters to be patched."
);
