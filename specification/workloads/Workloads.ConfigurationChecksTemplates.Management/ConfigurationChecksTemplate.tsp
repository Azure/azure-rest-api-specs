import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Workloads;

@doc("Configuration checks template resource.")
model ConfigurationChecksTemplate
  is ExtensionResource<ConfigurationChecksTemplateProperties> {
  @doc("The name of the configuration check template.")
  @key("configurationChecksTemplateName")
  @segment("configurationChecksTemplates")
  @pattern("^[a-zA-Z0-9-]{3,63}$")
  @path
  name: string;
}

@armResourceOperations
interface ConfigurationChecksTemplates {
  get is ArmResourceRead<ConfigurationChecksTemplate>;
  listByResourceGroup is ArmResourceListByParent<ConfigurationChecksTemplate>;

  /**
   * Update configuration checks template resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ConfigurationChecksTemplate,
    ConfigurationChecksTemplateUpdateRequest
  >;

  /**
   * Evaluate the configuration check template resource on demand.
   */
  onDemandEvaluation is ArmResourceActionAsync<
    ConfigurationChecksTemplate,
    void,
    Azure.ResourceManager.Foundations.OperationStatusResult
  >;
}

@@doc(ConfigurationChecksTemplate.name,
  "The name of the configuration check template resource."
);

@@doc(ConfigurationChecksTemplates.update::parameters.properties,
  "Request body to update the configuration check template resource."
);
