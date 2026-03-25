import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common.tsp";
import "./Accounts/accountModels.tsp";
import "./Containers/containerModels.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Microsoft.PromptService Resource Provider management API. */
@armProviderNamespace("Microsoft.PromptService")
@service(#{ title: "Azure Prompt Service Resource Provider" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.PromptService;

/** The available API versions. */
enum Versions {
  /** 2026-01-01-preview version */
  @useDependency(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_01_01_preview: "2026-01-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

/** A Prompt Service Account resource */
model Account is TrackedResource<AccountProperties> {
  /** The name of the prompt service account */
  @pattern("^[a-z0-9][a-z0-9-]{1,22}[a-z0-9]$")
  @key("accountName")
  @segment("accounts")
  @path
  name: string;
}

@armResourceOperations(Account)
interface Accounts {
  /** Get a Prompt Service Account. */
  get is ArmResourceRead<Account>;

  /** Create or update a Prompt Service Account. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Account>;

  /** Update tags on a Prompt Service Account. */
  update is ArmTagsPatchAsync<Account>;

  /** Delete a Prompt Service Account. */
  delete is ArmResourceDeleteWithoutOkAsync<Account>;

  /** List Prompt Service Accounts by resource group. */
  listByResourceGroup is ArmResourceListByParent<Account>;

  /** List Prompt Service Accounts by subscription. */
  listBySubscription is ArmListBySubscription<Account>;
}

/** A container resource within a Prompt Service Account */
@parentResource(Account)
model Container is ProxyResource<ContainerProperties> {
  /** The name of the container */
  @pattern("^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$")
  @key("containerName")
  @segment("containers")
  @path
  name: string;
}

@armResourceOperations(Container)
interface Containers {
  /** Get a container in a Prompt Service Account. */
  get is ArmResourceRead<Container>;

  /** Create or update a container in a Prompt Service Account. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Container>;

  /** Delete a container from a Prompt Service Account. */
  delete is ArmResourceDeleteWithoutOkAsync<Container>;

  /** List all containers in a Prompt Service Account. */
  listByAccount is ArmResourceListByParent<Container>;
}
