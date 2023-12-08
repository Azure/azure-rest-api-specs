import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./DataShareAccount.tsp";
import "./DataShareConsumerInvitation.tsp";
import "./ShareDataSet.tsp";
import "./ShareDataSetMapping.tsp";
import "./DataShareInvitation.tsp";
import "./DataShare.tsp";
import "./ProviderShareSubscription.tsp";
import "./ShareSubscription.tsp";
import "./DataShareSynchronizationSetting.tsp";
import "./DataShareTrigger.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "DataShareManagementClient",
})
@versioned(Versions)
@doc("Creates a Microsoft.DataShare management client.")
namespace Azure.ResourceManager.DataShare;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_08_01: "2021-08-01",
}
