import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of the Runtime Environment type.
 */
@parentResource(AutomationAccount)
model RuntimeEnvironment
  is Azure.ResourceManager.TrackedResource<RuntimeEnvironmentProperties> {
  ...ResourceNameParameter<
    Resource = RuntimeEnvironment,
    KeyName = "runtimeEnvironmentName",
    SegmentName = "runtimeEnvironments",
    NamePattern = "^[a-zA-Z][a-zA-Z-_0-9]*$"
  >;
}

@armResourceOperations
interface RuntimeEnvironments {
  /**
   * Get information about the Runtime Environment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/runtimeEnvironmentOperations")
  get is ArmResourceRead<RuntimeEnvironment>;

  /**
   * Create or update Runtime Environment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/runtimeEnvironmentOperations")
  create is ArmResourceCreateOrReplaceSync<RuntimeEnvironment>;

  /**
   * Update an Runtime Environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/automationaccountoperations")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    RuntimeEnvironment,
    PatchModel = RuntimeEnvironmentUpdateParameters
  >;

  /**
   * Delete the Runtime Environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/runtimeEnvironmentOperations")
  delete is ArmResourceDeleteSync<RuntimeEnvironment>;

  /**
   * Retrieve a list of RuntimeEnvironments.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/runbookoperations")
  listByAutomationAccount is ArmResourceListByParent<RuntimeEnvironment>;
}

@@doc(RuntimeEnvironment.name, "The name of the Runtime Environment.");
@@doc(RuntimeEnvironment.properties,
  "Gets or sets the Runtime Environment properties."
);
@@doc(RuntimeEnvironments.create::parameters.resource,
  "Parameters supplied to the create  the runtime environment."
);
@@doc(RuntimeEnvironments.update::parameters.properties,
  "Parameters supplied to the Runtime Environment"
);
