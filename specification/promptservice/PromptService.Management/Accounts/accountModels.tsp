import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.PromptService;

/** Details of the Prompt Service Account. */
model AccountProperties {
  /** The kind of account determining storage topology. */
  accountKind: AccountKind;

  /** Account description. */
  @maxLength(250)
  description?: string;

  /** Encryption settings for the account. */
  encryptionSettings?: EncryptionSettings;

  /** The Azure AD tenant ID associated with this account. */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
