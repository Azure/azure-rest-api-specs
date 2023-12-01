import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.ProgrammableConnectivity;

/// Interfaces

interface Networks {
  list is Operations.ResourceList<Network>;

  retrieve is Operations.ResourceAction<
    NetworkRetrieveEndpoint,
    NetworkDevice,
    Network
  >;
}

/// Endpoints

@resource("Network")
@doc("Static endpoint to access Network API")
model NetworkRetrieveEndpoint {
  @key("action")
  @doc("Static endpoint")
  @visibility("read")
  action: CommonActionEnum;
}

/// Common models

@doc("Represents a Device whose Network is searched for")
model NetworkDevice {
  // TODO - is there a good way to commonise the phone number definition and still capture that it's sometimes required and sometimes optional?
  @doc("Phone number in E.164 format (starting with country code), and optionally prefixed with '+'")
  @pattern("^\\+?[0-9]{5,15}$")
  phoneNumber: string;
}
