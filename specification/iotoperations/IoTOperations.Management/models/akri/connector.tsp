import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

/** AkriConnector resource. */
@added(Versions.`2025-07-01-preview`)
@parentResource(AkriConnectorTemplateResource)
model AkriConnectorResource is ProxyResource<AkriConnectorProperties> {
  /** Name of AkriConnector resource. */
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("connectorName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("connectors")
  name: string;

  /** Edge location of the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation?: ExtendedLocation;
}

/** AkriConnector properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
