import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace KeyVault;
/**
 * A EkmConnection model object.
 */
@added(KeyVault.Versions.v2026_01_01_preview)
model EkmConnection {
  /**
   * EKM proxy FQDN (Fully Qualified Domain Name). Only allowed characters are a-z, A-Z, 0-9, hyphen (-), dot (.), and colon (:).
   */
  host: string;

  /**
   * Optional path prefix for the EKM proxy (if any).
   */
  @encodedName("application/json", "path_prefix")
  pathPrefix?: string;

  /**
   * The root CA certificate chain that issued the proxy server's certificate. An array of certificates in the certificate chain, each in DER format and base64 encoded.
   */
  @encodedName("application/json", "server_ca_certificates")
  serverCaCertificates: bytes[];

  /**
   * The subject common name of the server certificate of EKM Proxy.
   */
  @encodedName("application/json", "server_subject_common_name")
  serverSubjectCommonName?: string;

  /**
   * The connectivity mode used to reach the EKM proxy. Defaults to "Public". In "PrivateEndpoint" mode, the host field holds the name of a private endpoint (peName) instead of a DNS name or IP address.
   */
  @added(KeyVault.Versions.v2026_07_01_preview)
  connectivityMode?: EkmConnectivityMode;
}

/**
 * EKM proxy client certificate information.
 */
@added(KeyVault.Versions.v2026_01_01_preview)
model EkmProxyClientCertificateInfo {
  /**
   * The client root CA certificate chain to authenticate to the EKM proxy. An array of certificates in the certificate chain, each in DER format and base64 encoded.
   */
  @encodedName("application/json", "ca_certificates")
  @visibility(Lifecycle.Read)
  caCertificates: bytes[];

  /**
   * The subject common name of the client certificate used to authenticate to the EKM proxy.
   */
  @encodedName("application/json", "subject_common_name")
  @visibility(Lifecycle.Read)
  subjectCommonName: string;
}

/**
 * EKM proxy information.
 */
@added(KeyVault.Versions.v2026_01_01_preview)
model EkmProxyInfo {
  /**
   * The highest version of proxy interface API supported by the EKM Proxy.
   */
  @encodedName("application/json", "api_version")
  apiVersion: string;

  /**
   * The name of the proxy vendor.
   */
  @encodedName("application/json", "proxy_vendor")
  proxyVendor: string;

  /**
   * The name of the proxy product and its version.
   */
  @encodedName("application/json", "proxy_name")
  proxyName: string;

  /**
   * The name of the EKM vendor.
   */
  @encodedName("application/json", "ekm_vendor")
  ekmVendor: string;

  /**
   * The name of the EKM product and its version.
   */
  @encodedName("application/json", "ekm_product")
  ekmProduct: string;
}

/**
 * The connectivity mode used to reach the EKM proxy.
 */
@added(KeyVault.Versions.v2026_07_01_preview)
union EkmConnectivityMode {
  string,

  /**
   * The EKM proxy is reachable over the public internet; host is a DNS name or IP address.
   */
  Public: "Public",

  /**
   * The EKM proxy is reachable through a private endpoint; host is the name of a private endpoint (peName).
   */
  PrivateEndpoint: "PrivateEndpoint",
}

/**
 * The status of the connection between the private endpoint and the Private Link Service.
 */
@added(KeyVault.Versions.v2026_07_01_preview)
union EkmPrivateEndpointConnectionStatus {
  string,

  /**
   * The connection is awaiting approval by the Private Link Service owner.
   */
  Pending: "Pending",

  /**
   * The connection has been approved by the Private Link Service owner.
   */
  Approved: "Approved",

  /**
   * The connection has been rejected by the Private Link Service owner.
   */
  Rejected: "Rejected",

  /**
   * The connection has been disconnected by the Private Link Service owner.
   */
  Disconnected: "Disconnected",
}

/**
 * The provisioning state of the EKM proxy private endpoint.
 */
@added(KeyVault.Versions.v2026_07_01_preview)
union EkmPrivateEndpointProvisioningState {
  string,

  /**
   * The private endpoint has been successfully provisioned.
   */
  Succeeded: "Succeeded",

  /**
   * The private endpoint provisioning failed.
   */
  Failed: "Failed",

  /**
   * The private endpoint is being updated.
   */
  Updating: "Updating",

  /**
   * The private endpoint is being deleted.
   */
  Deleting: "Deleting",
}

/**
 * The type of a long-running EKM proxy private endpoint operation.
 */
@added(KeyVault.Versions.v2026_07_01_preview)
union EkmPrivateEndpointOperationType {
  string,

  /**
   * A private endpoint create operation.
   */
  Create: "Create",

  /**
   * A private endpoint delete operation.
   */
  Delete: "Delete",
}

/**
 * The status of a long-running EKM proxy private endpoint operation.
 */
@added(KeyVault.Versions.v2026_07_01_preview)
@lroStatus
union EkmPrivateEndpointOperationStatus {
  string,

  /**
   * The operation is in progress.
   */
  InProgress: "InProgress",

  /**
   * The operation successfully completed.
   */
  Succeeded: "Succeeded",

  /**
   * The operation failed.
   */
  Failed: "Failed",
}

/**
 * Parameters to create an EKM proxy private endpoint.
 */
@added(KeyVault.Versions.v2026_07_01_preview)
model EkmPrivateEndpointCreateParameters {
  /**
   * Alias of the Private Link Service that the private endpoint connects to.
   */
  privateLinkServiceId: string;

  /**
   * An optional message shown to the Private Link Service owner when approving the private endpoint connection.
   */
  requestMessage?: string;
}

/**
 * The properties of an EKM proxy private endpoint.
 */
@added(KeyVault.Versions.v2026_07_01_preview)
model EkmPrivateEndpointProperties {
  /**
   * Alias of the Private Link Service that the private endpoint connects to.
   */
  @visibility(Lifecycle.Read)
  privateLinkServiceId?: string;

  /**
   * The name of the private link service connection, generated by the service.
   */
  @visibility(Lifecycle.Read)
  privateLinkServiceConnectionName?: string;
}

/**
 * The state of the connection between the private endpoint and the Private Link Service.
 */
@added(KeyVault.Versions.v2026_07_01_preview)
model EkmPrivateEndpointConnectionState {
  /**
   * The status of the private link service connection.
   */
  @visibility(Lifecycle.Read)
  status?: EkmPrivateEndpointConnectionStatus;

  /**
   * A description of the current connection state.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Any actions required from the customer to maintain the connection.
   */
  @visibility(Lifecycle.Read)
  actionsRequired?: string;
}

/**
 * An EKM proxy private endpoint.
 */
@added(KeyVault.Versions.v2026_07_01_preview)
model EkmPrivateEndpoint {
  /**
   * The name of the private endpoint (peName).
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The Azure region where the private endpoint is provisioned.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * The provisioning state of the private endpoint.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: EkmPrivateEndpointProvisioningState;

  /**
   * The properties of the private endpoint.
   */
  @visibility(Lifecycle.Read)
  properties?: EkmPrivateEndpointProperties;

  /**
   * The state of the connection between the private endpoint and the Private Link Service.
   */
  @visibility(Lifecycle.Read)
  privateLinkServiceConnectionState?: EkmPrivateEndpointConnectionState;
}

/**
 * The result of a request to list EKM proxy private endpoints.
 */
@added(KeyVault.Versions.v2026_07_01_preview)
model EkmPrivateEndpointListResult {
  /**
   * The list of EKM proxy private endpoints.
   */
  @visibility(Lifecycle.Read)
  value?: EkmPrivateEndpoint[];
}

/**
 * A long-running operation on an EKM proxy private endpoint.
 */
@added(KeyVault.Versions.v2026_07_01_preview)
model EkmPrivateEndpointOperation {
  /**
   * Identifier for the private endpoint operation.
   */
  jobId?: string;

  /**
   * The name of the private endpoint (peName) the operation applies to.
   */
  privateEndpointName?: string;

  /**
   * The type of the operation.
   */
  operationType?: EkmPrivateEndpointOperationType;

  /**
   * The status of the operation.
   */
  status?: EkmPrivateEndpointOperationStatus;

  /**
   * The status details of the operation.
   */
  statusDetails?: string;

  /**
   * The start time of the operation in UTC.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Intentionally nullable attribute"
  @encode("unixTimestamp", int32)
  startTime?: utcDateTime | null;

  /**
   * The end time of the operation in UTC.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Intentionally nullable attribute"
  @encode("unixTimestamp", int32)
  endTime?: utcDateTime | null;

  /**
   * Error encountered, if any, during the operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Intentionally nullable model"
  error?: Error;
}
