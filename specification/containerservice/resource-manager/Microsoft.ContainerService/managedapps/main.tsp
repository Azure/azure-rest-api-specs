import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./managedapp.tsp";

using Http;
using Rest;
using Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.ContainerService Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.ContainerService management service" })
@versioned(Microsoft.ContainerService.Versions)
namespace Microsoft.ContainerService;

/** The available API versions. */
enum Versions {
  /** 2026-06-02-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_06_02_preview: "2026-06-02-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface Apps {
  // Managed App Operations
  get is ArmResourceRead<ManagedApp>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedApp>;
  delete is ArmResourceDeleteWithoutOkAsync<ManagedApp>;
  rollback is ArmResourceActionAsync<
    ManagedApp,
    ManagedAppRollbackPostParameters,
    ManagedApp
  >;
}

@armResourceOperations
// Managed App Revision Operations
interface ManagedAppRevisions {
  get is ArmResourceRead<ManagedAppRevision>;
  listByManagedApp is ArmResourceListByParent<ManagedAppRevision>;
}
