import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CostManagement;
// FIXME: Setting has no properties property
/**
 * Setting definition.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@discriminator("kind")
model Setting
  is Azure.ResourceManager.Legacy.DiscriminatedProxyResource<SettingsKind> {
  ...ResourceNameParameter<
    Resource = Setting,
    KeyName = "type",
    SegmentName = "settings",
    NamePattern = "",
    Type = SettingType
  >;
}

@armResourceOperations
interface SettingsOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,

        /** undefined */
        @path
        @key
        scope: string,

        /** the provider namespace */
        @path
        @segment("providers")
        @key
        providerNamespace: "Microsoft.CostManagement",
      },
      {},
      {
        /**
         * Setting type.
         */
        @path
        @key
        @segment("settings")
        type: SettingType,
      }
    > {}

@armResourceOperations
interface Settings {
  /**
   * Get the setting from the given scope by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/rest/api/cost-management/")
  getByScope is SettingsOps.Read<Setting, ErrorType = ErrorResponse>;

  /**
   * Create or update a setting within the given scope.
   */
  createOrUpdateByScope is SettingsOps.CreateOrUpdateSync<
    Setting,
    ErrorType = ErrorResponse
  >;

  /**
   * Delete a setting within the given scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/rest/api/cost-management/")
  deleteByScope is SettingsOps.DeleteSync<Setting, ErrorType = ErrorResponse>;

  /**
   * List all cost management settings in the requested scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/rest/api/cost-management/")
  list is SettingsOps.List<
    Setting,
    Response = ArmResponse<SettingsListResult>,
    ErrorType = ErrorResponse
  >;
}

@@doc(Setting.name, "Setting type.");
@@doc(Settings.createOrUpdateByScope::parameters.resource,
  "Setting to be created or updated."
);
