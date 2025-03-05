using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Workloads;

@parentResource(Monitor)
@added(Versions.v2024_02_01_preview)
model AlertTemplate is ProxyResource<AlertTemplateProperties> {
  /**
   * A alert template associated with SAP monitor.
   */
  @pattern("^[a-zA-Z0-9-_]+$")
  @path
  @key("alertTemplateName")
  @segment("alertTemplates")
  @visibility(Lifecycle.Read)
  name: string;
}

@added(Versions.v2024_02_01_preview)
@armResourceOperations
interface AlertTemplates {
  /**
   * Gets properties of an alert template for the specified subscription, resource group, SAP monitor name, and resource name.
   */
  get is ArmResourceRead<AlertTemplate>;

  /**
   * Gets a list of alert templates in the specified SAP monitor. The operations returns various properties of each alert template.
   */
  list is ArmResourceListByParent<
    AlertTemplate,
    Parameters = {
      /**
       * The provider type for filtering alert templates.
       */
      @minLength(1)
      @query("providerType")
      providerType?: string;
    }
  >;
}

@@minLength(AlertTemplate.name, 1);
@@doc(AlertTemplate.name, "SAP monitor alert template resource name.");
@@doc(AlertTemplate.properties, "Alert Template properties");
