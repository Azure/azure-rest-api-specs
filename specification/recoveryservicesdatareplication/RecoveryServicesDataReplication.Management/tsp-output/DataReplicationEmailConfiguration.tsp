import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataReplicationVault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.RecoveryServicesDataReplication;
@doc("Email configuration model.")
@parentResource(DataReplicationVault)
model DataReplicationEmailConfiguration
  is ProxyResource<EmailConfigurationModelProperties> {
  @doc("The email configuration name.")
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("emailConfigurationName")
  @segment("alertSettings")
  name: string;
}

@armResourceOperations
interface DataReplicationEmailConfigurations {
  @doc("Gets the details of the alert configuration setting.")
  get is ArmResourceRead<DataReplicationEmailConfiguration>;
  @doc("Creates an alert configuration setting for the given vault.")
  create is ArmResourceCreateOrReplaceSync<DataReplicationEmailConfiguration>;
  @doc("Gets the list of alert configuration settings for the given vault.")
  list is ArmResourceListByParent<DataReplicationEmailConfiguration>;
}
