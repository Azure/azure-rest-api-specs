import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

/**
 * broker authentication resource type model details.
 */
@doc("Instance broker authentication resource")
@parentResource(BrokerResource)
model BrokerAuthenticationResource
  is TrackedResource<BrokerAuthenticationProperties> {
  @doc("Name of Instance broker authentication resource")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("authenticationName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("authentications")
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@doc("BrokerAuthentication Resource properties")
model BrokerAuthenticationProperties {
  @doc("Defines a set of MQTT authentication methods to be used on `BrokerListeners`. For each array element one authenticator type supported.")
  @OpenAPI.extension("x-ms-identifiers", [])
  authenticationMethods: BrokerAuthenticatorMethods[];

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Set of broker authentication policies. Only one method is supported for each entry.")
model BrokerAuthenticatorMethods {
  @doc("Custom authentication configuration.")
  mode: BrokerAuthenticationMode;

  @doc("Custom authentication configuration.")
  custom?: BrokerAuthenticatorMethodCustom;

  @doc("ServiceAccountToken authentication configuration.")
  serviceAccountToken?: BrokerAuthenticatorMethodSat;

  @doc("X.509 authentication configuration.")
  x509?: BrokerAuthenticatorMethodX509;
}

@doc("Broker Authentication Mode")
union BrokerAuthenticationMode {
  string,

  @doc("Custom authentication configuration.")
  Custom: "Custom",

  @doc("ServiceAccountToken authentication configuration.")
  ServiceAccountToken: "ServiceAccountToken",

  @doc("X.509 authentication configuration.")
  X509: "X509",
}

@doc("Custom method for BrokerAuthentication")
model BrokerAuthenticatorMethodCustom {
  @doc("Optional authentication needed for authenticating with the custom authentication server.")
  auth?: BrokerAuthenticatorCustomAuth;

  @doc("Optional CA certificate for validating the custom authentication server's certificate.")
  caCertConfigMap?: string;

  @doc("Endpoint of the custom authentication server. Must be an HTTPS endpoint.")
  @pattern("^https://.*$")
  endpoint: url;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("Additional HTTP headers to pass to the custom authentication server.")
  headers?: Record<string>;
}

@doc("Custom Authentication properties")
model BrokerAuthenticatorCustomAuth {
  @doc("X509 Custom Auth type details.")
  x509: X509ManualCertificate;
}

@doc("Service Account Token for BrokerAuthentication")
model BrokerAuthenticatorMethodSat {
  @doc("List of allowed audience.")
  audiences: string[];
}

@doc("X509 for BrokerAuthentication.")
model BrokerAuthenticatorMethodX509 {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("X509 authorization attributes properties.")
  authorizationAttributes?: Record<BrokerAuthenticatorMethodX509Attributes>;

  @doc("Name of the trusted client ca cert resource.")
  trustedClientCaCert?: string = "client-ca";
}

@doc("BrokerAuthenticatorMethodX509Attributes properties.")
model BrokerAuthenticatorMethodX509Attributes {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("Attributes object.")
  attributes: Record<string>;

  @doc("Subject of the X509 attribute.")
  subject: string;
}
