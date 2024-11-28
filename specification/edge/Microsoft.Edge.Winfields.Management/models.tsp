import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi3";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Edge;

/**
 * Connection Intent
 */
union ConnectionIntent {
  /**
   * Device is connected to cloud.
   */
  Connected: "Connected",

  string,

  /**
   * Device is disconnected from cloud.
   */
  Disconnected: "Disconnected",

  string,
}

/**
 * Billing model
 */
union BillingModel {
  /**
   * Billed on capacity.
   */
  @doc("Billed on capacity.")
  Capacity: "Capacity",

  string,
}

/**
 * Connection status
 */
union ConnectionStatus {
  /**
   * Device is connected to cloud.
   */
  Connected: "Connected",

  string,

  /**
   * Device is disconnected from cloud.
   */
  Disconnected: "Disconnected",

  string,
}

/**
 * Registration status
 */
union RegistrationStatus {
  /**
   * Device is registered to cloud.
   */
  Registered: "Registered",

  string,

  /**
   * Device is not registered to cloud.
   */
  Unregistered: "Unregistered",

  string,
}

@doc("The winfield properties")
model WinfieldProperties {
  @visibility("read")
  @doc("The resource provisioning state")
  provisioningState?: ResourceProvisioningState;

  @visibility("read")
  @doc("The stamp Id")
  stampId: string;

  @visibility("read")
  @doc("The billing model")
  billingModel: BillingModel;

  @doc("The connection intent")
  connectionIntent: ConnectionIntent;

  @visibility("read")
  @doc("The connection status")
  connectionStatus?: ConnectionStatus;

  @doc("The registration intent")
  @visibility("update", "read")
  registrationStatus?: RegistrationStatus;

  @doc("The device version")
  @visibility("update", "read")
  deviceVersion?: string;
}

@doc("The winfield manifest")
model WinfieldDeploymentManifest {
  @visibility("read")
  @doc("The resource Id")
  resourceId: string;

  @visibility("read")
  @doc("The resource name")
  resourceName: string;

  @visibility("read")
  @doc("The stamp Id")
  stampId: string;

  @visibility("read")
  @doc("The resource location")
  location: string;

  @visibility("read")
  @doc("The billing model")
  billingModel: BillingModel;

  @visibility("read")
  @doc("The connection intent")
  connectionIntent: ConnectionIntent;
}

/**
 * Release Type
 */
union ReleaseType {
  /**
   * Release is a new install.
   */
  Install: "Install",

  string,

  /**
   * Release is update.
   */
  Update: "Update",

  string,
}

@doc("The winfield image properties")
model ImageProperties {
  @visibility("read")
  @doc("The resource provisioning state")
  provisioningState?: ResourceProvisioningState;

  @visibility("read")
  @doc("The release version")
  releaseVersion: string;

  @visibility("read")
  @doc("The release name")
  releaseDisplayName: string;

  @visibility("read")
  @doc("The release notes")
  releaseNotes: string;

  @visibility("read")
  @doc("The release date")
  releaseDate: plainDate;

  @visibility("read")
  @doc("The release type")
  releaseType: ReleaseType;

  @visibility("read")
  @doc("The compatible versions")
  compatibleVersions?: Array<string>;
}

@doc("The winfield image download properties")
model ImageDownloadResponse {
  @visibility("read")
  @doc("The release version")
  releaseVersion: string;

  @visibility("read")
  @doc("The release name")
  releaseDisplayName: string;

  @visibility("read")
  @doc("The release notes")
  releaseNotes: string;

  @visibility("read")
  @doc("The release date")
  releaseDate: plainDate;

  @visibility("read")
  @doc("The compatible versions")
  compatibleVersions?: Array<string>;

  @visibility("read")
  @doc("The transaction Id")
  transactionId: string;

  @visibility("read")
  @doc("The download uri")
  downloadLink: url;

  @visibility("read")
  @doc("The release type")
  releaseType: ReleaseType;

  @visibility("read")
  @doc("The download link expiry time")
  linkExpiry: utcDateTime;
}
