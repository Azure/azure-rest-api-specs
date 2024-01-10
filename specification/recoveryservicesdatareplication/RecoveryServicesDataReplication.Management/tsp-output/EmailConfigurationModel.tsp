import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./VaultModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DataReplication;
@doc("Email configuration model.")
@parentResource(VaultModel)
model EmailConfigurationModel
  is ProxyResource<EmailConfigurationModelProperties> {
  @doc("The email configuration name.")
  @pattern("^[a-zA-Z0-9]*$")
  @key("emailConfigurationName")
  @segment("alertSettings")
  name: string;
}

@armResourceOperations
@projectedName("client", "EmailConfiguration")
interface EmailConfigurationModels_EmailConfiguration {
  @doc("Gets the details of the alert configuration setting.")
  get is ArmResourceRead<EmailConfigurationModel>;

  @doc("Creates an alert configuration setting for the given vault.")
  create is ArmResourceCreateOrReplaceSync<EmailConfigurationModel>;

  @doc("Gets the list of alert configuration settings for the given vault.")
  list is ArmResourceListByParent<EmailConfigurationModel>;
}
