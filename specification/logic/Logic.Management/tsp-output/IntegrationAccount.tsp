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

namespace Microsoft.Logic;
/**
 * The integration account.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
model IntegrationAccount extends Resource {
  /**
   * The integration account name.
   */
  @path
  @key("integrationAccountName")
  @segment("integrationAccounts")
  @visibility("read")
  name: string;

  /**
   * The sku.
   */
  sku?: IntegrationAccountSku;

  /**
   * The integration account properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: IntegrationAccountProperties;
}

@armResourceOperations
interface IntegrationAccounts {
  /**
   * Gets an integration account.
   */
  get is ArmResourceRead<IntegrationAccount>;

  /**
   * Creates or updates an integration account.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<IntegrationAccount>;

  /**
   * Updates an integration account.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<IntegrationAccount, IntegrationAccount>;

  /**
   * Deletes an integration account.
   */
  delete is ArmResourceDeleteSync<IntegrationAccount>;

  /**
   * Gets a list of integration accounts by resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationAccounts_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    IntegrationAccount,
    {
      ...BaseParameters<IntegrationAccount>;

      /**
       * The number of items to be included in the result.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * Gets a list of integration accounts by subscription.
   */
  listBySubscription is ArmListBySubscription<IntegrationAccount>;

  /**
   * Gets the integration account callback URL.
   */
  listCallbackUrl is ArmResourceActionSync<
    IntegrationAccount,
    GetCallbackUrlParameters,
    CallbackUrl
  >;

  /**
   * Gets the integration account's Key Vault keys.
   */
  listKeyVaultKeys is ArmResourceActionSync<
    IntegrationAccount,
    ListKeyVaultKeysDefinition,
    KeyVaultKeyCollection
  >;

  /**
   * Logs the integration account's tracking events.
   */
  logTrackingEvents is ArmResourceActionSync<
    IntegrationAccount,
    TrackingEventsDefinition,
    void
  >;

  /**
   * Regenerates the integration account access key.
   */
  regenerateAccessKey is ArmResourceActionSync<
    IntegrationAccount,
    RegenerateActionParameter,
    IntegrationAccount
  >;
}

@@projectedName(IntegrationAccounts.createOrUpdate::parameters.resource,
  "json",
  "integrationAccount"
);
@@extension(IntegrationAccounts.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "integrationAccount"
);
@@doc(IntegrationAccounts.createOrUpdate::parameters.resource,
  "The integration account."
);
@@projectedName(IntegrationAccounts.update::parameters.properties,
  "json",
  "integrationAccount"
);
@@extension(IntegrationAccounts.update::parameters.properties,
  "x-ms-client-name",
  "integrationAccount"
);
@@doc(IntegrationAccounts.update::parameters.properties,
  "The integration account."
);
@@projectedName(IntegrationAccounts.listCallbackUrl::parameters.body,
  "json",
  "parameters"
);
@@extension(IntegrationAccounts.listCallbackUrl::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(IntegrationAccounts.listCallbackUrl::parameters.body,
  "The callback URL parameters."
);
@@projectedName(IntegrationAccounts.listKeyVaultKeys::parameters.body,
  "json",
  "listKeyVaultKeys"
);
@@extension(IntegrationAccounts.listKeyVaultKeys::parameters.body,
  "x-ms-client-name",
  "listKeyVaultKeys"
);
@@doc(IntegrationAccounts.listKeyVaultKeys::parameters.body,
  "The key vault parameters."
);
@@projectedName(IntegrationAccounts.logTrackingEvents::parameters.body,
  "json",
  "logTrackingEvents"
);
@@extension(IntegrationAccounts.logTrackingEvents::parameters.body,
  "x-ms-client-name",
  "logTrackingEvents"
);
@@doc(IntegrationAccounts.logTrackingEvents::parameters.body,
  "The callback URL parameters."
);
@@projectedName(IntegrationAccounts.regenerateAccessKey::parameters.body,
  "json",
  "regenerateAccessKey"
);
@@extension(IntegrationAccounts.regenerateAccessKey::parameters.body,
  "x-ms-client-name",
  "regenerateAccessKey"
);
@@doc(IntegrationAccounts.regenerateAccessKey::parameters.body,
  "The access key type."
);
