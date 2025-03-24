import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace KeyVault;

/**
 * Description of the pool setting to be updated
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Updates key vault account setting, stores it, then returns the setting name and value to the client.")
@route("/settings/{setting-name}")
@patch(#{ implicitOptionality: false })
op updateSetting is KeyVaultOperation<
  {
    ...SettingNameParameter;

    /**
     * The parameters to update an account setting.
     */
    #suppress "@azure-tools/typespec-azure-core/no-openapi" "Extension needed for backwards compatibility"
    @OpenAPI.extension("x-ms-client-flatten", true)
    @body
    parameters: UpdateSettingRequest;
  },
  Setting
>;

/**
 * Retrieves the setting object of a specified setting name.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Get specified account setting object.")
@route("/settings/{setting-name}")
@get
op getSetting is KeyVaultOperation<
  {
    ...SettingNameParameter;
  },
  Setting
>;

/**
 * Retrieves a list of all the available account settings that can be configured.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("List account settings.")
@route("/settings")
@get
op getSettings is KeyVaultOperation<{}, SettingsListResult>;
