import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DeviceUpdate;
/**
 * Device Update update account details.
 */
model UpdateAccount
  is Azure.ResourceManager.TrackedResource<UpdateAccountProperties> {
  ...ResourceNameParameter<
    Resource = UpdateAccount,
    KeyName = "updateAccountName",
    SegmentName = "updateAccounts",
    NamePattern = "^[A-Za-z0-9]+(-[A-Za-z0-9]+)*$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface UpdateAccounts {
  /**
   * Returns update account details for the given update account name.
   */
  get is ArmResourceRead<UpdateAccount>;

  /**
   * Creates or updates an Update Account.
   */
  create is ArmResourceCreateOrReplaceAsync<UpdateAccount>;

  /**
   * Updates update account's patchable properties
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<UpdateAccount, UpdateAccountUpdate>;

  /**
   * Deletes an update account.
   */
  delete is ArmResourceDeleteWithoutOkAsync<UpdateAccount>;

  /**
   * Returns list of Update Accounts.
   */
  listByResourceGroup is ArmResourceListByParent<UpdateAccount>;

  /**
   * Returns list of Update Accounts.
   */
  listBySubscription is ArmListBySubscription<UpdateAccount>;

  /**
   * Calculate the highest version updates for the Account.
   */
  calculateHighestVersionUpdates is ArmResourceActionSync<
    UpdateAccount,
    void,
    DeviceClassUpdatableDevicesList
  >;

  /**
   * Calculate update compliance for the Account.
   */
  calculateUpdateCompliance is ArmResourceActionSync<
    UpdateAccount,
    void,
    UpdateCompliance
  >;

  /**
   * Import update into given update account.
   */
  importUpdate is ArmResourceActionNoResponseContentAsync<
    UpdateAccount,
    ImportUpdateRequest
  >;

  /**
   * Check if the Update Account name is available
   */
  checkNameAvailability is checkGlobalNameAvailability;
}

@@maxLength(UpdateAccount.name, 36);
@@minLength(UpdateAccount.name, 3);
@@doc(UpdateAccount.name, "Account name.");
@@doc(UpdateAccounts.create::parameters.resource, "Update Account details.");
@@doc(UpdateAccounts.update::parameters.properties, "Updated Update Account.");
@@doc(UpdateAccounts.importUpdate::parameters.body,
  "The update to be imported (see schema https://json.schemastore.org/azure-deviceupdate-import-manifest-5.0.json for details)."
);

@@encodedName(UpdateAccounts.create::parameters.resource,
  "application/json",
  "UpdateAccount"
);
@@clientName(UpdateAccounts.create::parameters.resource, "UpdateAccount");

@@encodedName(UpdateAccounts.update::parameters.properties,
  "application/json",
  "updateAccountUpdatePayload"
);
@@clientName(UpdateAccounts.update::parameters.properties,
  "updateAccountUpdatePayload"
);

@@encodedName(UpdateAccounts.importUpdate::parameters.body,
  "application/json",
  "updateToImport"
);
@@clientName(UpdateAccounts.importUpdate::parameters.body, "updateToImport");
