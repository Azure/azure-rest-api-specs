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
/**
 * PaloAltoNetworks Firewall
 */
model FirewallResource is TrackedResource<FirewallDeploymentProperties> {
  /**
   * Firewall resource name
   */
  @path
  @key("firewallName")
  @segment("firewalls")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface FirewallResources {
  /**
   * Get a FirewallResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Firewalls_Get")
  get is ArmResourceRead<FirewallResource>;

  /**
   * Create a FirewallResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Firewalls_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FirewallResource,
    BaseParameters<FirewallResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update a FirewallResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Firewalls_Update")
  update is ArmCustomPatchSync<FirewallResource, FirewallResourceUpdate>;

  /**
   * Delete a FirewallResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Firewalls_Delete")
  delete is ArmResourceDeleteAsync<
    FirewallResource,
    BaseParameters<FirewallResource>,
    ArmAsyncOperationHeader
  >;

  /**
   * List FirewallResource resources by resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Firewalls_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<FirewallResource>;

  /**
   * List FirewallResource resources by subscription ID
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Firewalls_ListBySubscription")
  listBySubscription is ArmListBySubscription<FirewallResource>;

  /**
   * Get Global Rulestack associated with the Firewall
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Firewalls_getGlobalRulestack")
  getGlobalRulestack is ArmResourceActionSync<
    FirewallResource,
    void,
    GlobalRulestackInfo
  >;

  /**
   * Log Profile for Firewall
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Firewalls_getLogProfile")
  getLogProfile is ArmResourceActionSync<FirewallResource, void, LogSettings>;

  /**
   * support info for firewall.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Firewalls_getSupportInfo")
  getSupportInfo is ArmResourceActionSync<
    FirewallResource,
    void,
    SupportInfo,
    {
      ...BaseParameters<FirewallResource>;

      /**
       * email address on behalf of which this API called
       */
      @query("email")
      email?: string;
    }
  >;

  /**
   * Log Profile for Firewall
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
