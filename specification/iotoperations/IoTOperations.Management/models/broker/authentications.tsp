import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.IoTOperations.Brokers;

/**
 * broker authentication resource type model details.
 */
@doc("Instance broker authentication resource")
@parentResource(BrokerResource)
model AuthenticationResource
  is ProxyResource<AuthenticationProperties> {
  @doc("Name of Instance broker authentication resource")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("authenticationName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("authentications")
  name: string;

  // Extended location is not included in ProxyResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@doc("Authentication Resource properties")
model AuthenticationProperties {
  @doc("Defines a set of Broker authentication methods to be used on `BrokerListeners`. For each array element one authenticator type supported.")
  @OpenAPI.extension("x-ms-identifiers", [])
  authenticationMethods: AuthenticatorMethods[];

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Set of broker authentication policies. Only one method is supported for each entry.")
model AuthenticatorMethods {
  @doc("Custom authentication configuration.")
  method: AuthenticationMethod;

  @doc("Custom authentication configuration.")
  customSettings?: AuthenticatorMethodCustom;

  @doc("ServiceAccountToken authentication configuration.")
  serviceAccountTokenSettings?: AuthenticatorMethodSat;

  @doc("X.509 authentication configuration.")
  x509Settings?: AuthenticatorMethodX509;
}

@doc("Authentication Mode")
union AuthenticationMethod {
  string,

  @doc("Custom authentication configuration.")
  Custom: "Custom",

  @doc("ServiceAccountToken authentication configuration.")
  ServiceAccountToken: "ServiceAccountToken",

  @doc("X.509 authentication configuration.")
  X509: "X509",
}
