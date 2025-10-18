import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./client.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft Genome Resource Provider API */
@armProviderNamespace
@service(#{
  title: "Microsoft Genome Resource Provider API",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.Genome;

/** The available API versions. */
enum Versions {
  /** The 2025-10-07 API version. */
  `2025-10-07`: "2025-10-07",
}

/** Genome account resource. */
model GenomeAccount is TrackedResource<GenomeAccountProperties> {
  /** The name of the genome account within the specified resource group. */
  @maxLength(24)
  @minLength(3)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  @path
  @key("accountName")
  @segment("accounts")
  name: string;

  /** The name of the deployment environment (e.g., dev, test, ppe, prod) where the genome account resource is provisioned. */
  environmentName: string;

  /** The Kind of the resource. */
  kind?: string;

  /** The resource model definition representing SKU */
  sku?: Sku;

  /** Identity for the resource. */
  identity?: Identity;
}

@armResourceOperations
interface GenomeAccounts {
  /** Get details of a Genome account. */
  get is ArmResourceRead<GenomeAccount>;

  /** Provision a new Genome account. */
  create is ArmResourceCreateOrUpdateAsync<GenomeAccount>;

  /** Update properties of an existing Genome account. */
  update is ArmCustomPatchAsync<GenomeAccount, GenomeAccountUpdate>;

  /** Delete a Genome account. */
  delete is ArmResourceDeleteWithoutOkAsync<GenomeAccount>;

  /** List all Genome accounts belonging to a resource group. */
  listByResourceGroup is ArmResourceListByParent<GenomeAccount>;

  /** List all Genome accounts. */
  listBySubscription is ArmListBySubscription<GenomeAccount>;
}