import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VaultModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataReplication;
/**
 * Email configuration model.
 */
@parentResource(VaultModel)
model EmailConfigurationModel
  is Azure.ResourceManager.ProxyResource<EmailConfigurationModelProperties> {
  ...ResourceNameParameter<
    Resource = EmailConfigurationModel,
    KeyName = "emailConfigurationName",
    SegmentName = "alertSettings",
    NamePattern = "^[a-zA-Z0-9]*$"
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi"
@@OpenAPI.extension(EmailConfiguration.create::parameters.resource,
  "x-ms-client-name",
  "body"
);

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "This resource does not need a delete operation defined"
@armResourceOperations
interface EmailConfiguration {
  /**
   * Gets the details of the alert configuration setting.
   */
  get is ArmResourceRead<EmailConfigurationModel>;

  /**
   * Creates an alert configuration setting for the given vault.
   */
  create is ArmResourceCreateOrReplaceSync<EmailConfigurationModel>;

  /**
   * Gets the list of alert configuration settings for the given vault.
   */
  list is ArmResourceListByParent<EmailConfigurationModel>;
}

@@doc(EmailConfigurationModel.name, "The email configuration name.");
@@doc(EmailConfiguration.create::parameters.resource,
  "EmailConfiguration model."
);
