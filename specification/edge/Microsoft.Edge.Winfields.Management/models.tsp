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
  @visibility(Lifecycle.Read)
  @doc("The resource provisioning state")
  provisioningState?: ResourceProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("The stamp Id")
  stampId: string;

  @visibility(Lifecycle.Read)
  @doc("The billing model")
  billingModel: BillingModel;

  @doc("The connection intent")
  connectionIntent: ConnectionIntent;

  @visibility(Lifecycle.Read)
  @doc("The connection status")
  connectionStatus?: ConnectionStatus;

  @doc("The registration intent")
  @visibility(Lifecycle.Update, Lifecycle.Read)
  registrationStatus?: RegistrationStatus;

  @doc("The device version")
  @visibility(Lifecycle.Update, Lifecycle.Read)
  deviceVersion?: string;
}

@doc("The winfield manifest")
model WinfieldDeploymentManifest {
  @visibility(Lifecycle.Read)
  @doc("The resource Id")
  resourceId: string;

  @visibility(Lifecycle.Read)
  @doc("The resource name")
  resourceName: string;

  @visibility(Lifecycle.Read)
  @doc("The stamp Id")
  stampId: string;

  @visibility(Lifecycle.Read)
  @doc("The resource location")
  location: string;

  @visibility(Lifecycle.Read)
  @doc("The billing model")
  billingModel: BillingModel;

  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  @doc("The resource provisioning state")
  provisioningState?: ResourceProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("The release version")
  releaseVersion: string;

  @visibility(Lifecycle.Read)
  @doc("The release name")
  releaseDisplayName: string;

  @visibility(Lifecycle.Read)
  @doc("The release notes")
  releaseNotes: string;

  @visibility(Lifecycle.Read)
  @doc("The release date")
  releaseDate: plainDate;

  @visibility(Lifecycle.Read)
  @doc("The release type")
  releaseType: ReleaseType;

  @visibility(Lifecycle.Read)
  @doc("The compatible versions")
  compatibleVersions?: Array<string>;
}

@doc("The winfield image download properties")
model ImageDownloadResponse {
  @visibility(Lifecycle.Read)
  @doc("The release version")
  releaseVersion: string;

  @visibility(Lifecycle.Read)
  @doc("The release name")
  releaseDisplayName: string;

  @visibility(Lifecycle.Read)
  @doc("The release notes")
  releaseNotes: string;

  @visibility(Lifecycle.Read)
  @doc("The release date")
  releaseDate: plainDate;

  @visibility(Lifecycle.Read)
  @doc("The compatible versions")
  compatibleVersions?: Array<string>;

  @visibility(Lifecycle.Read)
  @doc("The transaction Id")
  transactionId: string;

  @visibility(Lifecycle.Read)
  @doc("The download uri")
  downloadLink: url;

  @visibility(Lifecycle.Read)
  @doc("The release type")
  releaseType: ReleaseType;

  @visibility(Lifecycle.Read)
  @doc("The download link expiry time")
  linkExpiry: utcDateTime;
}
