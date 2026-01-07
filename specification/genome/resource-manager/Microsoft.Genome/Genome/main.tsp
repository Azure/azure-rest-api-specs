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
using Azure.ResourceManager;

/** Microsoft Genome Resource Provider API */
@armProviderNamespace
@service(#{ title: "Microsoft Genome Resource Provider API" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.Genome;

/** Operations interface for the resource provider. */
interface Operations extends Azure.ResourceManager.Operations {}

/** The available API versions. */
enum Versions {
  /** The 2021-08-01-preview API version. */
  `2021-08-01-preview`: "2021-08-01-preview",
}

/** Genome account resource. */
model GenomeAccount
  is Azure.ResourceManager.TrackedResource<GenomeAccountProperties> {
  /** The name of the genome account within the specified resource group. */
  @maxLength(24)
  @minLength(3)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  @path
  @key("accountName")
  @segment("accounts")
  name: string;

  /** The Kind of the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Standard ARM envelope property"
  kind?: string;

  /** The resource model definition representing SKU */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Standard ARM envelope property"
  sku?: Sku;

  /** Identity for the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Standard ARM envelope property"
  identity?: Identity;
}

@armResourceOperations
interface GenomeAccounts {
  /** Get details of a Genome account. */
  get is ArmResourceRead<GenomeAccount>;

  /** Provision a new Genome account. */
  create is ArmResourceCreateOrUpdateAsync<GenomeAccount>;

  /** Update properties of an existing Genome account. */
  update is ArmResourcePatchAsync<GenomeAccount, GenomeAccountProperties>;

  /** Delete a Genome account. */
  delete is ArmResourceDeleteWithoutOkAsync<GenomeAccount>;

  /** List all Genome accounts belonging to a resource group. */
  listByResourceGroup is ArmResourceListByParent<GenomeAccount>;

  /** List all Genome accounts. */
  listBySubscription is ArmListBySubscription<GenomeAccount>;
}
