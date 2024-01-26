import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Account.tsp";
import "./ConsumerInvitation.tsp";
import "./DataSet.tsp";
import "./DataSetMapping.tsp";
import "./Invitation.tsp";
import "./Share.tsp";
import "./ProviderShareSubscription.tsp";
import "./ShareSubscription.tsp";
import "./SynchronizationSetting.tsp";
import "./Trigger.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Creates a Microsoft.DataShare management client.
 */
@armProviderNamespace
@useAuth(AadOauth2Auth<["user_impersonation"]>)
@service({
  title: "DataShareManagementClient",
})
@versioned(Versions)
namespace Microsoft.DataShare;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2021-08-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_08_01: "2021-08-01",
}
