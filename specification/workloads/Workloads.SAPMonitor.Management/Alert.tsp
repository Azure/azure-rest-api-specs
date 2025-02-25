using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Workloads;
/**
 * A alert associated with SAP monitor.
 */
@parentResource(Monitor)
@added(Versions.v2024_02_01_preview)
model Alert is ProxyResource<AlertProperties> {
  /**
   * Name of the Alert.
   */
  @pattern("^[a-zA-Z0-9-_]+$")
  @path
  @key("alertName")
  @segment("alerts")
  @visibility(Lifecycle.Read)
  name: string;
}

@added(Versions.v2024_02_01_preview)
@armResourceOperations
interface Alerts {
  /**
   * Gets properties of an alert for the specified subscription, resource group, SAP monitor name, and resource name.
   */
  get is ArmResourceRead<Alert>;

  /**
   * Creates an alert for the specified subscription, resource group, SAP monitor name, and resource name.
   */
  create is ArmResourceCreateOrReplaceAsync<Alert>;

  /**
   * Deletes an alert for the specified subscription, resource group, SAP monitor name, and resource name.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Alert>;

  /**
   * Gets a list of alerts in the specified SAP monitor. The operations returns various properties of each alerts.
   */
  list is ArmResourceListByParent<Alert>;
}

@@minLength(Alert.name, 1);
@@doc(Alert.name, "Name of the SAP monitor alert resource.");
@@doc(Alert.properties, "Alert Instance properties");
@@doc(Alerts.create::parameters.resource,
  "Request body representing a SAP monitor's alert resource"
);
