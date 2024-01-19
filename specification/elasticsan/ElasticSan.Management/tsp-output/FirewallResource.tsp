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

namespace PaloAltoNetworks.Cloudngfw;
@doc("PaloAltoNetworks Firewall")
model FirewallResource is TrackedResource<FirewallDeploymentProperties> {
  @doc("Firewall resource name")
  @path
  @key("firewallName")
  @segment("firewalls")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface FirewallResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a FirewallResource")
  @operationId("Firewalls_Get")
  get is ArmResourceRead<FirewallResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a FirewallResource")
  @operationId("Firewalls_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    FirewallResource,
    BaseParameters<FirewallResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a FirewallResource")
  @operationId("Firewalls_Update")
  update is ArmCustomPatchSync<FirewallResource, FirewallResourceUpdate>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a FirewallResource")
  @operationId("Firewalls_Delete")
  delete is ArmResourceDeleteAsync<
    FirewallResource,
    BaseParameters<FirewallResource>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List FirewallResource resources by resource group")
  @operationId("Firewalls_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<FirewallResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List FirewallResource resources by subscription ID")
  @operationId("Firewalls_ListBySubscription")
  listBySubscription is ArmListBySubscription<FirewallResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get Global Rulestack associated with the Firewall")
  @operationId("Firewalls_getGlobalRulestack")
  getGlobalRulestack is ArmResourceActionSync<
    FirewallResource,
    void,
    GlobalRulestackInfo
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Log Profile for Firewall")
  @operationId("Firewalls_getLogProfile")
  getLogProfile is ArmResourceActionSync<FirewallResource, void, LogSettings>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("support info for firewall.")
  @operationId("Firewalls_getSupportInfo")
  getSupportInfo is ArmResourceActionSync<
    FirewallResource,
    void,
    SupportInfo,
    {
      ...BaseParameters<FirewallResource>;

      @doc("email address on behalf of which this API called")
      @query("email")
      email?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Log Profile for Firewall")
  @operationId("Firewalls_saveLogProfile")
  saveLogProfile is ArmResourceActionNoContentSync<
    FirewallResource,
    LogSettings
  >;
}

@@projectedName(FirewallResources.saveLogProfile::parameters.body,
  "json",
  "logSettings"
);
@@extension(FirewallResources.saveLogProfile::parameters.body,
  "x-ms-client-name",
  "logSettings"
);
@@doc(FirewallResources.saveLogProfile::parameters.body, "");
