import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VaultModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataReplication;
@doc("Email configuration model.")
@parentResource(VaultModel)
model EmailConfigurationModel
  is ProxyResource<EmailConfigurationModelProperties> {
  @doc("The email configuration name.")
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("emailConfigurationName")
  @segment("alertSettings")
  name: string;
}

@armResourceOperations
interface EmailConfigurationModels {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the details of the alert configuration setting.")
  @operationId("EmailConfiguration_Get")
  get is ArmResourceRead<EmailConfigurationModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates an alert configuration setting for the given vault.")
  @operationId("EmailConfiguration_Create")
  create is ArmResourceCreateOrReplaceSync<EmailConfigurationModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the list of alert configuration settings for the given vault.")
  @operationId("EmailConfiguration_List")
  list is ArmResourceListByParent<EmailConfigurationModel>;
}

@@projectedName(EmailConfigurationModels.create::parameters.resource,
  "json",
  "body"
);
@@extension(EmailConfigurationModels.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(EmailConfigurationModels.create::parameters.resource,
  "EmailConfiguration model."
);
