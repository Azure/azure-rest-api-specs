import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Attestation;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Status of attestation service.")
enum AttestationServiceStatus {
  Ready,
  NotReady,
  Error,
}

@doc("The public network access type for API calls to the Attestation Provider.")
enum PublicNetworkAccessType {
  @doc("Enables public network connectivity to the Attestation Provider REST APIs.")
  Enabled,
  @doc("Disables public network connectivity to the Attestation Provider REST APIs.")
  Disabled,
}

@doc("The private endpoint connection status.")
enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
}

@doc("The current provisioning state.")
enum PrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

@doc("Definition object with the name and properties of an operation.")
model OperationsDefinition {
  @doc("Name of the operation.")
  name?: string;

  @doc("Display object with properties of the operation.")
  display?: OperationsDisplayDefinition;
}

@doc("Display object with properties of the operation.")
model OperationsDisplayDefinition {
  @doc("Resource provider of the operation.")
  provider?: string;

  @doc("Resource for the operation.")
  resource?: string;

  @doc("Short description of the operation.")
  operation?: string;

  @doc("Description of the operation.")
  description?: string;
}

@doc("An error response from Attestation.")
@error
model CloudError {
  @doc("An error response from Attestation.")
  error?: CloudErrorBody;
}

@doc("An error response from Attestation.")
model CloudErrorBody {
  @doc("An identifier for the error. Codes are invariant and are intended to be consumed programmatically.")
  code?: string;

  @doc("A message describing the error, intended to be suitable for displaying in a user interface.")
  message?: string;
}

@doc("Status of attestation service.")
model StatusResult {
  @doc("Trust model for the attestation provider.")
  trustModel?: string;

  @doc("Status of attestation service.")
  status?: AttestationServiceStatus;

  @doc("Gets the uri of attestation service")
  attestUri?: string;

  @doc("Controls whether traffic from the public network is allowed to access the Attestation Provider APIs.")
  publicNetworkAccess?: PublicNetworkAccessType;

  @doc("List of private endpoint connections associated with the attestation provider.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];
}

@doc("Properties of the PrivateEndpointConnectProperties.")
model PrivateEndpointConnectionProperties {
  @doc("The resource of private end point.")
  privateEndpoint?: PrivateEndpoint;

  @doc("A collection of information about the state of the connection between service consumer and provider.")
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  @doc("The provisioning state of the private endpoint connection resource.")
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

@doc("The Private Endpoint resource.")
model PrivateEndpoint {
  @doc("The ARM identifier for Private Endpoint")
  @visibility("read")
  id?: string;
}

@doc("A collection of information about the state of the connection between service consumer and provider.")
model PrivateLinkServiceConnectionState {
  @doc("Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.")
  status?: PrivateEndpointServiceConnectionStatus;

  @doc("The reason for approval/rejection of the connection.")
  description?: string;

  @doc("A message indicating if changes on the service provider require any updates on the consumer.")
  actionsRequired?: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;
}

@doc("Parameters for creating an attestation provider")
model AttestationServiceCreationParams {
  @doc("The supported Azure location where the attestation provider should be created.")
  location: string;

  @doc("The tags that will be assigned to the attestation provider.")
  tags?: Record<string>;

  @doc("Properties of the attestation provider")
  properties: AttestationServiceCreationSpecificParams;
}

@doc("Client supplied parameters used to create a new attestation provider.")
model AttestationServiceCreationSpecificParams {
  @doc("Controls whether traffic from the public network is allowed to access the Attestation Provider APIs.")
  publicNetworkAccess?: PublicNetworkAccessType;

  @doc("JSON Web Key Set defining a set of X.509 Certificates that will represent the parent certificate for the signing certificate used for policy operations")
  policySigningCertificates?: JsonWebKeySet;
}

model JsonWebKeySet {
  @doc("""
The value of the \"keys\" parameter is an array of JWK values.  By
default, the order of the JWK values within the array does not imply
an order of preference among them, although applications of JWK Sets
can choose to assign a meaning to the order for their purposes, if
desired.
""")
  keys?: JsonWebKey[];
}

model JsonWebKey {
  @doc("""
The \"alg\" (algorithm) parameter identifies the algorithm intended for
use with the key.  The values used should either be registered in the
IANA \"JSON Web Signature and Encryption Algorithms\" registry
established by [JWA] or be a value that contains a Collision-
Resistant Name.
""")
  alg?: string;

  @doc("The \"crv\" (curve) parameter identifies the curve type")
  crv?: string;

  @doc("RSA private exponent or ECC private key")
  d?: string;

  @doc("RSA Private Key Parameter")
  dp?: string;

  @doc("RSA Private Key Parameter")
  dq?: string;

  @doc("RSA public exponent, in Base64")
  e?: string;

  @doc("Symmetric key")
  k?: string;

  @doc("""
The \"kid\" (key ID) parameter is used to match a specific key.  This
is used, for instance, to choose among a set of keys within a JWK Set
during key rollover.  The structure of the \"kid\" value is
unspecified.  When \"kid\" values are used within a JWK Set, different
keys within the JWK Set SHOULD use distinct \"kid\" values.  (One
example in which different keys might use the same \"kid\" value is if
they have different \"kty\" (key type) values but are considered to be
equivalent alternatives by the application using them.)  The \"kid\"
value is a case-sensitive string.
""")
  kid?: string;

  @doc("""
The \"kty\" (key type) parameter identifies the cryptographic algorithm
family used with the key, such as \"RSA\" or \"EC\". \"kty\" values should
either be registered in the IANA \"JSON Web Key Types\" registry
established by [JWA] or be a value that contains a Collision-
Resistant Name.  The \"kty\" value is a case-sensitive string.
""")
  kty: string;

  @doc("RSA modulus, in Base64")
  n?: string;

  @doc("RSA secret prime")
  p?: string;

  @doc("RSA secret prime, with p < q")
  q?: string;

  @doc("RSA Private Key Parameter")
  qi?: string;

  @doc("""
Use (\"public key use\") identifies the intended use of
the public key. The \"use\" parameter is employed to indicate whether
a public key is used for encrypting data or verifying the signature
on data. Values are commonly \"sig\" (signature) or \"enc\" (encryption).
""")
  use?: string;

  @doc("X coordinate for the Elliptic Curve point")
  x?: string;

  @doc("""
The \"x5c\" (X.509 certificate chain) parameter contains a chain of one
or more PKIX certificates [RFC5280].  The certificate chain is
represented as a JSON array of certificate value strings.  Each
string in the array is a base64-encoded (Section 4 of [RFC4648] --
not base64url-encoded) DER [ITU.X690.1994] PKIX certificate value.
The PKIX certificate containing the key value MUST be the first
certificate.
""")
  @projectedName("json", "x5c")
  x5C?: string[];

  @doc("Y coordinate for the Elliptic Curve point")
  y?: string;
}

@doc("Parameters for patching an attestation provider")
model AttestationServicePatchParams {
  @doc("The tags that will be assigned to the attestation provider.")
  tags?: Record<string>;

  @doc("Properties of the attestation provider")
  properties?: AttestationServicePatchSpecificParams;
}

@doc("Client supplied parameters used to patch an existing attestation provider.")
model AttestationServicePatchSpecificParams {
  @doc("Controls whether traffic from the public network is allowed to access the Attestation Provider APIs.")
  publicNetworkAccess?: PublicNetworkAccessType;
}

@doc("A list of private link resources")
model PrivateLinkResourceListResult {
  @doc("Array of private link resources")
  value?: PrivateLinkResource[];
}

@doc("A private link resource")
model PrivateLinkResource extends Resource {
  @doc("Resource properties.")
  properties?: PrivateLinkResourceProperties;
}

@doc("Properties of a private link resource.")
model PrivateLinkResourceProperties {
  @doc("The private link resource group id.")
  @visibility("read")
  groupId?: string;

  @doc("The private link resource required member names.")
  @visibility("read")
  requiredMembers?: string[];

  @doc("The private link resource Private link DNS zone name.")
  requiredZoneNames?: string[];
}
