import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common.tsp";
import "./rack.tsp";

using Rest;
using Azure.ResourceManager;

namespace Microsoft.SupercomputerInfrastructure;

/** A switch in the network. */
@parentResource(Supercomputer)
model Switch is ProxyResource<SwitchProperties> {
  ...ResourceNameParameter<Switch>;
}

/** The properties of a switch. */
model SwitchProperties {
  /** The status of the last operation on this switch */
  @visibility(Lifecycle.Read)
  provisioningState?: TopologicalProvisioningState;

  /** The network type of the switch. */
  networkType: NetworkType;

  /** The cluster that the switch is associated with, if any. */
  clusterId?: string;
}

/** The type of the network the switch resides in. */
union NetworkType {
  /** The switch is within a backend network. */
  Backend: "Backend",

  string,
}

/** The request body a retrieve data action over a switch. */
model RetrieveDataRequest {
  /** The gNMI paths of the read operation. */
  paths: string[];
}

/** The response of a retrieve data action over a switch. */
model RetrieveDataResponse {
  /** The value of the retrieve data action. */
  @OpenAPI.extension("x-ms-identifiers", #["path", "value"])
  value: RetrieveDataOutput[];
}

/** The output of a retrieve data action over a switch. */
model RetrieveDataOutput {
  /** The gNMI path of the read operation. */
  path: string;

  /** The value of the read operation. */
  value: string;
}

@armResourceOperations
interface Switches {
  get is ArmResourceRead<Switch>;
  retrieveData is ArmResourceActionAsync<
    Switch,
    RetrieveDataRequest,
    RetrieveDataResponse
  >;
  listBySupercomputer is ArmResourceListByParent<Switch>;
}
