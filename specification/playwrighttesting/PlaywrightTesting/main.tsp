// cheat-sheet - https://microsoft.github.io/typespec/standard-library/http/cheat-sheet
// tsp compile main.tsp --emit @azure-tools/typespec-autorest

import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Autorest;

@server(
  "https://api.playwright-int.io",
  "Azure Playwright Service API Endpoint"
)
@useAuth(
  [
    OAuth2Auth<[
      {
        type: OAuth2FlowType.implicit,
        authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
        scopes: ["https://preview.playwright-int.io/.default"],
      }
    ]>
  ]
)
@service({
  title: "Microsoft PlaywrightTesting AuthManager Service API",
})
@versioned(Microsoft.PlaywrightTesting.AuthManager.Versions)
namespace Microsoft.PlaywrightTesting.AuthManager;

@doc("The PlaywrightTesting Auth Manager service version.")
enum Versions {
  @doc("Version 2023-10-01-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2023-10-01-preview`,
}

// Models ////////////////////

@doc("An account is a parent resource for most of the other service resources. It's directly mapped to an ARM resource and helps to create a link between control-plane and data-plane resources.")
@resource("accounts")
model Account {
  @key("accountId")
  @doc("The account id.")
  @visibility("read")
  accountId: string;

  @doc("The ARM fully-qualified resource id for the account.")
  @visibility("read")
  resourceId: string;

  @doc("The account name.")
  @visibility("read")
  name: string;

  @doc("The Azure tenant id of the account.")
  @visibility("read")
  tenantId?: uuid;

  @doc("The account resource ARM location, for eg. eastus, southeastasia.")
  @visibility("read")
  location: string;

  @doc("The regionalAffinity feature enablement status for the account.")
  @visibility("read")
  regionalAffinity?: EnablementStatus = EnablementStatus.Enabled;

  @doc("The scalableExecution feature enablement status for the account.")
  @visibility("read")
  scalableExecution?: EnablementStatus = EnablementStatus.Enabled;

  @doc("The reporting feature enablement status for the account.")
  @visibility("read")
  reporting?: EnablementStatus = EnablementStatus.Disabled;
}

@doc("Model of an access-key linked to an account.")
@resource("access-keys")
@parentResource(Account)
model AccessKey {
  @key("accessKeyId")
  @doc("The access-key id.")
  @visibility("read")
  accessKeyId: uuid;

  @doc("The access-key name.")
  @visibility("read", "create")
  name: string;

  @doc("The access-key JWT token.")
  @visibility("read")
  jwtToken?: string;

  @doc("The access-key createdAt utcDateTime.")
  @visibility("read")
  createdAt: utcDateTime;

  @doc("The access-key expiryAt utcDateTime.")
  @visibility("read", "create")
  expiryAt: utcDateTime;

  @doc("The access-key state.")
  @visibility("read")
  state: AccessKeyState;
}

@doc("The access-key state.")
enum AccessKeyState {
  @doc("The access-key is Active.")
  Active,

  @doc("The access-key is Expired.")
  Expired,
}

@doc("The enablement status of a feature.")
enum EnablementStatus {
  @doc("The feature is Enabled.")
  Enabled,

  @doc("The feature is Disabled.")
  Disabled,
}

// Operations ////////////////////

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

interface AccessKeys {
  // AccessKey Operations

  @doc("Creates an access-key with given access-key id in guid format.")
  @example("./AccessKeys_CreateAccessKey.json", "AccessKeys_CreateAccessKey")
  createAccessKey is Operations.ResourceCreateOrReplace<AccessKey>;

  @doc("Get an access-key for given access-key id in guid format.")
  @example("./AccessKeys_GetAccessKey.json", "AccessKeys_GetAccessKey")
  getAccessKey is Operations.ResourceRead<AccessKey>;

  @doc("Revoke an access-key with given access-key id in guid format.")
  @example("./AccessKeys_DeleteAccessKey.json", "AccessKeys_DeleteAccessKey")
  deleteAccessKey is Operations.ResourceDelete<AccessKey>;

  @doc("List access-keys for a given accountId.")
  @example("./AccessKeys_ListAccessKeys.json", "AccessKeys_ListAccessKeys")
  listAccessKeys is Operations.ResourceList<AccessKey>;
}

interface Accounts {
  // Accounts Operations
  @doc("Get details of the ARM resource mapped to an account for the given accountId.")
  @example("./Accounts_GetAccount.json", "Accounts_GetAccount")
  getAccount is Operations.ResourceRead<Account>;
}
