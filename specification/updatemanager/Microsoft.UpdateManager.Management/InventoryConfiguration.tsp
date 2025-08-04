import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.UpdateManager;

@doc("Enabled state for inventory features.")
@added(Versions.v2025_08_01_preview)
union InventoryEnabledState {
  @doc("Inventory is enabled")
  True: "true",

  @doc("Inventory is disabled")
  False: "false",

  string,
}

@doc("Enabled state for assessment features.")
@added(Versions.v2025_08_01_preview)
union AssessmentEnabledState {
  @doc("Assessment is enabled")
  True: "true",

  @doc("Assessment is disabled")
  False: "false",

  string,
}

@added(Versions.v2025_08_01_preview)
model InventoryConfiguration
  is TrackedResource<InventoryConfigurationProperties> {
  ...ResourceNameParameter<InventoryConfiguration>;
}

@doc("Properties of the InventoryConfiguration resource.")
@added(Versions.v2025_08_01_preview)
model InventoryConfigurationProperties {
  @doc("Object for Windows-related inventory, with potential future extension to Linux.")
  windows?: WindowsInventoryProperties;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Object for Windows-related inventory.")
@added(Versions.v2025_08_01_preview)
model WindowsInventoryProperties {
  @doc("Software object. It can later be extended to include files, certificates, and another inventory.")
  software?: WindowsSoftwareInventoryProperties;
}

@doc("Software inventory properties.")
@added(Versions.v2025_08_01_preview)
model WindowsSoftwareInventoryProperties {
  @doc("Toggle Inventory on/off. Inventory will not happen if flag is false.")
  enabled: InventoryEnabledState = InventoryEnabledState.True;

  @doc("Object containing assessment specific properties.")
  assessment?: WindowsSoftwareAssessmentProperties;
}

@doc("Assessment properties for Windows software.")
@added(Versions.v2025_08_01_preview)
model WindowsSoftwareAssessmentProperties {
  @doc("Toggle assessment on/off.")
  enabled: AssessmentEnabledState = AssessmentEnabledState.True;

  @doc("Includes collectionIds for assessment. Limited to 1 for now.")
  @maxItems(1)
  collectionIds: string[];
}

@armResourceOperations
@added(Versions.v2025_08_01_preview)
interface InventoryConfigurations {
  get is ArmResourceRead<InventoryConfiguration>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<InventoryConfiguration>;
  update is ArmTagsPatchAsync<InventoryConfiguration>;
  delete is ArmResourceDeleteWithoutOkAsync<InventoryConfiguration>;
  listByResourceGroup is ArmResourceListByParent<InventoryConfiguration>;
  listBySubscription is ArmListBySubscription<InventoryConfiguration>;
}
