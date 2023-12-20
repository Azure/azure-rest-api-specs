import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.HybridConnectivity;

interface Operations extends Azure.ResourceManager.Operations {}

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum EndpointType {
  default,
  custom,
}

@doc("Endpoint details")
model EndpointProperties {
  @doc("The type of endpoint.")
  @projectedName("json", "type")
  endpointType: EndpointType;

  @doc("The resource Id of the connectivity endpoint (optional).")
  resourceId?: string;

  @visibility("read")
  provisioningState?: string;
}

@doc("The endpoint access for the target resource.")
model TargetResourceEndpointAccess {
  @doc("Azure relay hybrid connection access properties")
  relay?: RelayNamespaceAccessProperties;
}

@doc("Azure relay hybrid connection access properties")
model RelayNamespaceAccessProperties {
  @doc("The namespace name.")
  @maxLength(200)
  @minLength(1)
  namespaceName: string;

  @doc("The suffix domain name of relay namespace.")
  @maxLength(100)
  @minLength(1)
  namespaceNameSuffix: string;

  @doc("Azure Relay hybrid connection name for the resource.")
  hybridConnectionName: string;

  @doc("Access key for hybrid connection.")
  @visibility("read")
  accessKey?: string;

  @doc("The expiration of access key in unix time.")
  expiresOn?: int32;
}
