import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridCompute;

model Settings is Azure.ResourceManager.ProxyResource<SettingsProperties> {
  ...ResourceNameParameter<
    Resource = Settings,
    KeyName = "settingsResourceName",
    SegmentName = "settings",
    NamePattern = "default"
  >;
}

alias SettingsOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /**
     * The name of the base Resource Provider.
     */
    @path
    @segment("providers")
    @key
    @pattern("[a-zA-Z0-9-_\\.]+")
    baseProvider: string;

    /**
     * The name of the base Resource Type.
     */
    @path
    @key
    @pattern("[a-zA-Z0-9-_\\.]+")
    baseResourceType: string;

    /**
     * The name of the base resource.
     */
    @path
    @key
    @pattern("[a-zA-Z0-9-_\\.]+")
    baseResourceName: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<Settings>;
  },
  {
    ...Extension.ExtensionProviderNamespace<Settings>;

    /**
     * The name of the settings resource.
     */
    @path
    @key
    @segment("settings")
    @pattern("default")
    settingsResourceName: string;
  },
  "Settings"
>;

@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface SettingsOperationGroup {
  /**
   * Returns the base Settings for the target resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Settings_Get")
  @tag("Settings")
  get is SettingsOps.Read<Settings>;

  /**
   * Updates the base Settings of the target resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Settings_Update")
  @tag("Settings")
  update is SettingsOps.CreateOrUpdateSync<Settings>;

  /**
   * Update the base Settings of the target resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Settings_Patch")
  @tag("Settings")
  patch is SettingsOps.CustomPatchSync<Settings, PatchModel = Settings>;
}

@@doc(Settings.name, "The name of the settings resource.");
@@doc(Settings.properties, "Settings properties");
@@doc(SettingsOperationGroup.update::parameters.resource, "Settings details");
@@doc(SettingsOperationGroup.patch::parameters.properties, "Settings details");
