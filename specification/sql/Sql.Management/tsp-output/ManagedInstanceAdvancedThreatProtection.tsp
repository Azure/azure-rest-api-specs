import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A managed instance Advanced Threat Protection.
 */
@parentResource(ManagedInstance)
model ManagedInstanceAdvancedThreatProtection
  is ProxyResource<AdvancedThreatProtectionProperties> {
  /**
   * The name of the Advanced Threat Protection state.
   */
  @path
  @key("advancedThreatProtectionName")
  @segment("advancedThreatProtectionSettings")
  name: AdvancedThreatProtectionName;
}

@armResourceOperations
interface ManagedInstanceAdvancedThreatProtections {
  /**
   * Get a managed instance's Advanced Threat Protection state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedInstanceAdvancedThreatProtectionSettings_Get")
  get is ArmResourceRead<ManagedInstanceAdvancedThreatProtection>;

  /**
   * Creates or updates Advanced Threat Protection settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedInstanceAdvancedThreatProtectionSettings_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedInstanceAdvancedThreatProtection>;

  /**
   * Get the managed instance's Advanced Threat Protection settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedInstanceAdvancedThreatProtectionSettings_ListByInstance")
  listByInstance is ArmResourceListByParent<ManagedInstanceAdvancedThreatProtection>;
}

@@projectedName(ManagedInstanceAdvancedThreatProtections.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedInstanceAdvancedThreatProtections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedInstanceAdvancedThreatProtections.createOrUpdate::parameters.resource,
  "The managed instance Advanced Threat Protection state."
);
