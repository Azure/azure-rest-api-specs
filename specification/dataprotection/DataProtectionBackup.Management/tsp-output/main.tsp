import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BackupVaultResource.tsp";
import "./BaseBackupPolicyResource.tsp";
import "./BackupInstanceResource.tsp";
import "./AzureBackupRecoveryPointResource.tsp";
import "./AzureBackupJobResource.tsp";
import "./DeletedBackupInstanceResource.tsp";
import "./ResourceGuardResource.tsp";
import "./ResourceGuardProxyBaseResource.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Open API 2.0 Specs for Azure Data Protection service
 */
@armProviderNamespace
@service({
  title: "Data Protection Client",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v4)
namespace Microsoft.DataProtection;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-11-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_11_01: "2023-11-01",
}
