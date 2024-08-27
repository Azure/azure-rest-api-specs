import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

import "./base.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.IoTOperationsMQ;

/**
 * MQ resource type model details.
 *
 * Azure Resource - mq
 * CRD - MQ
 * CRD Version - v1alpha4
 */
@doc("MQ resource")
model MqResource is TrackedResource<MqProperties> {
  @doc("Name of MQ resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("mqName")
  @path
  @segment("mq")
  name: string;

  ...ExtendedLocation;
}

@doc("MQ Resource properties")
model MqProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}
