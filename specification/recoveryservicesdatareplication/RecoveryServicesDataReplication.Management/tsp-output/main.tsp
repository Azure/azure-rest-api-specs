import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./DraModel.tsp";
import "./EmailConfigurationModel.tsp";
import "./EventModel.tsp";
import "./FabricModel.tsp";
import "./PolicyModel.tsp";
import "./ProtectedItemModel.tsp";
import "./RecoveryPointModel.tsp";
import "./ReplicationExtensionModel.tsp";
import "./VaultModel.tsp";
import "./WorkflowModel.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * A first party Azure service enabling the data replication.
 */
@armProviderNamespace
@useAuth(AadOauth2Auth<["user_impersonation"]>)
@service({
  title: "Azure Site Recovery Management Service API",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.DataReplication;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2021-02-16-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_02_16_preview: "2021-02-16-preview",
}
