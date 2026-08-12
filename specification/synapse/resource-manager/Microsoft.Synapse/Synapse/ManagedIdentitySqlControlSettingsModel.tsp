import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * Sql Control Settings for workspace managed identity
 */
@singleton("default")
@parentResource(Workspace)
model ManagedIdentitySqlControlSettingsModel
  is Azure.ResourceManager.ProxyResource<ManagedIdentitySqlControlSettingsModelProperties> {
  ...ResourceNameParameter<
    Resource = ManagedIdentitySqlControlSettingsModel,
    KeyName = "managedIdentitySqlControlSetting",
    SegmentName = "managedIdentitySqlControlSettings",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ManagedIdentitySqlControlSettingsModels {
  /**
   * Get Managed Identity Sql Control Settings
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceManagedIdentitySqlControlSettings_Get")
  get is ArmResourceRead<ManagedIdentitySqlControlSettingsModel>;

  /**
   * Create or update Managed Identity Sql Control Settings
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceManagedIdentitySqlControlSettings_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedIdentitySqlControlSettingsModel>;
}

@@doc(ManagedIdentitySqlControlSettingsModel.name, "");
@@doc(
  ManagedIdentitySqlControlSettingsModel.properties,
  "Sql Control Settings for workspace managed identity"
);
@@doc(
  ManagedIdentitySqlControlSettingsModels.createOrUpdate::parameters.resource,
  "Managed Identity Sql Control Settings"
);
