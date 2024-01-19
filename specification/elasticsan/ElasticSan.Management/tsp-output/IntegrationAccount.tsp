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
@doc("The integration account.")
model IntegrationAccount is TrackedResource<IntegrationAccountProperties> {
  @doc("The integration account name.")
  @path
  @key("integrationAccountName")
  @segment("integrationAccounts")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface IntegrationAccounts {
  @doc("Gets an integration account.")
  get is ArmResourceRead<IntegrationAccount>;

  @doc("Creates or updates an integration account.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<IntegrationAccount>;

  @doc("Updates an integration account.")
  update is ArmCustomPatchSync<IntegrationAccount, IntegrationAccount>;

  @doc("Deletes an integration account.")
  delete is ArmResourceDeleteSync<IntegrationAccount>;

  @doc("Gets a list of integration accounts by resource group.")
  listByResourceGroup is ArmResourceListByParent<
    IntegrationAccount,
    {
      ...BaseParameters<IntegrationAccount>;

      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;
    }
  >;

  @doc("Gets a list of integration accounts by subscription.")
  listBySubscription is ArmListBySubscription<IntegrationAccount>;

  @doc("Gets the integration account callback URL.")
  listCallbackUrl is ArmResourceActionSync<
    IntegrationAccount,
    GetCallbackUrlParameters,
    CallbackUrl
  >;

  @doc("Gets the integration account's Key Vault keys.")
  listKeyVaultKeys is ArmResourceActionSync<
    IntegrationAccount,
    ListKeyVaultKeysDefinition,
    KeyVaultKeyCollection
  >;

  @doc("Logs the integration account's tracking events.")
  logTrackingEvents is ArmResourceActionSync<
    IntegrationAccount,
    TrackingEventsDefinition,
    void
  >;

  @doc("Regenerates the integration account access key.")
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
