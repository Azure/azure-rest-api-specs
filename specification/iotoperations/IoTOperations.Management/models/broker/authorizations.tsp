import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

/**
 * broker authorization resource type model details.
 */
@doc("Instance broker authorizations resource")
@parentResource(BrokerResource)
model BrokerAuthorizationResource
  is ProxyResource<BrokerAuthorizationProperties> {
  @doc("Name of Instance broker authorization resource")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("authorizationName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("authorizations")
  name: string;

  // Extended location is not included in ProxyResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@doc("BrokerAuthorization Resource properties")
model BrokerAuthorizationProperties {
  @doc("The list of authorization policies supported by the Authorization Resource.")
  authorizationPolicies: AuthorizationConfig;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Broker AuthorizationConfig properties")
model AuthorizationConfig {
  @doc("Enable caching of the authorization rules.")
  cache?: OperationalMode = OperationalMode.Enabled;

  @doc("The authorization rules to follow. If no rule is set, but Authorization Resource is used that would mean DenyAll.")
  @OpenAPI.extension("x-ms-identifiers", [])
  rules?: AuthorizationRule[];
}

@doc("AuthorizationConfig Rule Properties")
model AuthorizationRule {
  @doc("Give access to Broker methods and topics.")
  @OpenAPI.extension("x-ms-identifiers", [])
  brokerResources: BrokerResourceRule[];

  @doc("Give access to clients based on the following properties.")
  principals: PrincipalDefinition;

  @doc("Give access to state store resources.")
  @OpenAPI.extension("x-ms-identifiers", [])
  stateStoreResources?: StateStoreResourceRule[];
}

@doc("PrincipalDefinition properties of Rule")
model PrincipalDefinition {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("A list of key-value pairs that match the attributes of the clients. The attributes are case-sensitive and must match the attributes provided by the clients during authentication.")
  @OpenAPI.extension("x-ms-identifiers", [])
  attributes?: Record<string>[] = #[];

  @doc("A list of client IDs that match the clients. The client IDs are case-sensitive and must match the client IDs provided by the clients during connection.")
  clientIds?: string[] = #[];

  @doc("A list of usernames that match the clients. The usernames are case-sensitive and must match the usernames provided by the clients during authentication.")
  usernames?: string[] = #[];
}

@doc("Broker Resource Rule properties. This defines the objects that represent the actions or topics, such as - method.Connect, method.Publish, etc.")
model BrokerResourceRule {
  @doc("Give access for a Broker method (i.e., Connect, Subscribe, or Publish).")
  method: BrokerResourceDefinitionMethods;

  @doc("A list of topics or topic patterns that match the topics that the clients can publish or subscribe to. This subfield is required if the method is Publish or Subscribe.")
  topics?: string[] = #[];
}

@doc("BrokerResourceDefinitionMethods methods allowed")
union BrokerResourceDefinitionMethods {
  string,

  @doc("Allowed Connecting to Broker")
  Connect: "Connect",

  @doc("Allowed Publishing to Broker")
  Publish: "Publish",

  @doc("Allowed Subscribing to Broker")
  Subscribe: "Subscribe",
}

@doc("State Store Resource Rule properties.")
model StateStoreResourceRule {
  @doc("Allowed keyTypes pattern, string, binary. The key type used for matching, for example pattern tries to match the key to a glob-style pattern and string checks key is equal to value provided in keys.")
  keyType: StateStoreResourceKeyTypes;

  @doc("Give access to state store keys for the corresponding principals defined. When key type is pattern set glob-style pattern (e.g., '*', 'clients/*').")
  keys: string[];

  @doc("Give access for `Read`, `Write` and `ReadWrite` access level.")
  method: StateStoreResourceDefinitionMethods;
}

@doc("StateStoreResourceKeyTypes properties")
union StateStoreResourceKeyTypes {
  string,

  @doc("Key type - pattern")
  Pattern: "Pattern",

  @doc("Key type - string")
  String: "String",

  @doc("Key type - binary")
  Binary: "Binary",
}

@doc("StateStoreResourceDefinitionMethods methods allowed")
union StateStoreResourceDefinitionMethods {
  string,

  @doc("Get/KeyNotify from Store")
  Read: "Read",

  @doc("Set/Delete in Store")
  Write: "Write",

  @doc("Allowed all operations on Store - Get/KeyNotify/Set/Delete")
  ReadWrite: "ReadWrite",
}
