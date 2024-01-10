import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Security;
@doc("The connector setting")
@subscriptionResource
model ConnectorSetting is ProxyResource<ConnectorSettingProperties> {
  @doc("Name of the cloud account connector")
  @key("connectorName")
  @segment("connectors")
  name: string;
}

@armResourceOperations
@projectedName("client", "Connectors")
interface ConnectorSettings_Connectors {
  @doc("Details of a specific cloud account connector")
  get is ArmResourceRead<ConnectorSetting>;

  @doc("Create a cloud account connector or update an existing one. Connect to your cloud account. For AWS, use either account credentials or role-based authentication. For GCP, use account organization credentials.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConnectorSetting>;

  @doc("Delete a cloud account connector from a subscription")
  delete is ArmResourceDeleteSync<ConnectorSetting>;

  @doc("Cloud accounts connectors of a subscription")
  list is ArmResourceListByParent<ConnectorSetting>;
}
