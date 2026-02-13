import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

/** AkriService resource. */
@added(Versions.`2026-03-01`)
@parentResource(InstanceResource)
model AkriServiceResource is ProxyResource<AkriServiceProperties> {
  /** Name of AkriService resource. */
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("akriServiceName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("akriServices")
  name: string;

  /** Edge location of the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation?: ExtendedLocation;
}

/** AkriService properties. */
@added(Versions.`2026-03-01`)
model AkriServiceProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** The status for the service. */
  @visibility(Lifecycle.Read)
  status?: AkriServiceStatus;
}

/** AkriService status. */
@added(Versions.`2026-03-01`)
model AkriServiceStatus {
  /** The health state of the AkriService. */
  @visibility(Lifecycle.Read)
  healthState?: ResourceHealthStatus;
}
