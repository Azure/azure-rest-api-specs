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

namespace Microsoft.Cdn;
@doc("Defines web application firewall policy for Azure CDN.")
model CdnWebApplicationFirewallPolicy
  is TrackedResource<CdnWebApplicationFirewallPolicyProperties> {
  @doc("The name of the CdnWebApplicationFirewallPolicy.")
  @maxLength(128)
  @path
  @key("policyName")
  @segment("cdnWebApplicationFirewallPolicies")
  name: string;

  @doc("Gets a unique read-only string that changes whenever the resource is updated.")
  etag?: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface CdnWebApplicationFirewallPolicies {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve protection policy with specified name within a resource group.")
  @operationId("Policies_Get")
  get is ArmResourceRead<CdnWebApplicationFirewallPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update policy with specified rule set name within a resource group.")
  @operationId("Policies_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CdnWebApplicationFirewallPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update an existing CdnWebApplicationFirewallPolicy with the specified policy name under the specified subscription and resource group")
  @operationId("Policies_Update")
  update is ArmCustomPatchAsync<
    CdnWebApplicationFirewallPolicy,
    CdnWebApplicationFirewallPolicyPatchParameters
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes Policy")
  @operationId("Policies_Delete")
  delete is ArmResourceDeleteSync<CdnWebApplicationFirewallPolicy>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists all of the protection policies within a resource group.")
  @operationId("Policies_List")
  list is ArmResourceListByParent<CdnWebApplicationFirewallPolicy>;
}

@@projectedName(CdnWebApplicationFirewallPolicies.createOrUpdate::parameters.resource,
  "json",
  "cdnWebApplicationFirewallPolicy"
);
@@extension(CdnWebApplicationFirewallPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "cdnWebApplicationFirewallPolicy"
);
@@doc(CdnWebApplicationFirewallPolicies.createOrUpdate::parameters.resource,
  "Policy to be created."
);
@@projectedName(CdnWebApplicationFirewallPolicies.update::parameters.properties,
  "json",
  "cdnWebApplicationFirewallPolicyPatchParameters"
);
@@extension(CdnWebApplicationFirewallPolicies.update::parameters.properties,
  "x-ms-client-name",
  "cdnWebApplicationFirewallPolicyPatchParameters"
);
@@doc(CdnWebApplicationFirewallPolicies.update::parameters.properties,
  "CdnWebApplicationFirewallPolicy parameters to be patched."
);
