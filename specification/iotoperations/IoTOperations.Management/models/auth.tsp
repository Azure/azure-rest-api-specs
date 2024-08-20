import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

/**
 *
 * Dataflow Authentication Models
 */
@doc("DataflowEndpoint Authentication SystemAssignedManagedIdentity properties")
model DataflowEndpointAuthenticationSystemAssignedManagedIdentity {
  @doc("Audience of the service to authenticate against. Optional; defaults to the audience for Service host configuration.")
  audience?: string;
}

@doc("DataflowEndpoint Authentication UserAssignedManagedIdentity properties")
model DataflowEndpointAuthenticationUserAssignedManagedIdentity {
  @doc("Client ID for the user-assigned managed identity.")
  clientId: string;

  @doc("Resource identifier (application ID URI) of the resource, affixed with the .default suffix.")
  scope?: string;

  @doc("Tenant ID.")
  tenantId: string;
}

@doc("DataflowEndpoint Authentication Sasl properties")
model DataflowEndpointAuthenticationSasl {
  @doc("Type of SASL authentication. Can be PLAIN, SCRAM-SHA-256, or SCRAM-SHA-512.")
  saslType: DataflowEndpointAuthenticationSaslType;

  @doc("Token secret name.")
  secretRef: string;
}

@doc("DataflowEndpoint Authentication Access Token properties")
model DataflowEndpointAuthenticationAccessToken {
  @doc("Token secret name.")
  secretRef: string;
}

@doc("DataflowEndpoint Authentication Sasl Type properties")
union DataflowEndpointAuthenticationSaslType {
  string,

  @doc("PLAIN Type")
  Plain: "Plain",

  @doc("SCRAM_SHA_256 Type")
  ScramSha256: "ScramSha256",

  @doc("SCRAM_SHA_512 Type")
  ScramSha512: "ScramSha512",
}

@doc("Service Account Token for BrokerAuthentication")
model DataflowEndpointAuthenticationServiceAccountToken {
  @doc("Audience of the service account. Optional, defaults to the broker internal service account audience.")
  audience: string;
}

@doc("DataflowEndpoint Authentication X509 properties")
model DataflowEndpointAuthenticationX509 {
  @doc("Secret reference of the X.509 certificate.")
  secretRef: string;
}

/**
 *
 * Broker Authentication Models
 */
@doc("Service Account Token for BrokerAuthentication")
model BrokerAuthenticatorMethodSat {
  @doc("List of allowed audience.")
  audiences: string[];
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

@doc("X509 Certificate Authentication properties.")
model X509ManualCertificate {
  @doc("Kubernetes secret containing an X.509 client certificate. This is a reference to the secret through an identifying name, not the secret itself.")
  secretRef: string;
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

@doc("System and Use Assigned Managed Identity properties")
model ManagedIdentity {
  @doc("System-assigned managed identity authentication.")
  systemAssignedManagedIdentitySettings?: DataflowEndpointAuthenticationSystemAssignedManagedIdentity;

  @doc("User-assigned managed identity authentication.")
  userAssignedManagedIdentitySettings?: DataflowEndpointAuthenticationUserAssignedManagedIdentity;
}
