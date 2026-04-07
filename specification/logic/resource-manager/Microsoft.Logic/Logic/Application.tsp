import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./applicationModels.tsp";
import "./AutomationProject.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Logic;

/**
 * The application resource. An application represents a ContainerApp of kind 'workflowapp'
 * that is registered under an automation project. Applications are managed by their
 * parent automation project for lifecycle operations.
 */
@parentResource(AutomationProject)
model Application is ProxyResource<ApplicationProperties> {
  ...ResourceNameParameter<
    Resource = Application,
    KeyName = "applicationName",
    SegmentName = "applications",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_]{0,62}[a-zA-Z0-9]$"
  >;
}

@armResourceOperations
interface Applications {
  /**
   * Gets an application registered under the automation project.
   */
  get is ArmResourceRead<Application>;

  /**
   * Creates or updates an application registration under the automation project.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Application>;

  /**
   * Deletes an application registration from the automation project.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Application>;

  /**
   * Gets a list of applications registered under the automation project.
   */
  listByParent is ArmResourceListByParent<Application>;
}

@@doc(Application.name, "The application name.");
@@minLength(Application.name, 2);
@@maxLength(Application.name, 64);
@@doc(Application.properties, "The application properties.");
@@doc(Applications.createOrUpdate::parameters.resource,
  "The application definition."
);
