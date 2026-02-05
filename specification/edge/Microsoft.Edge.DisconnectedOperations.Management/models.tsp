import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

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

@doc("The disconnected operation properties")
model DisconnectedOperationProperties {
  @visibility(Lifecycle.Read)
  @doc("The resource provisioning state")
  provisioningState?: ResourceProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("The unique GUID of the stamp")
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

@doc("The disconnected operation manifest")
model DisconnectedOperationDeploymentManifest {
  @visibility(Lifecycle.Read)
  @doc("The resource identifier of the disconnected operations resource")
  resourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Edge/disconnectedOperations";
    }
  ]>;

  @visibility(Lifecycle.Read)
  @doc("The resource name")
  resourceName: string;

  @visibility(Lifecycle.Read)
  @doc("The unique GUID of the stamp")
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

  @visibility(Lifecycle.Read)
  @doc("The cloud in which the resource is registered")
  @added(Microsoft.Edge.Versions.v2025_06_01)
  cloud?: string;
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

@doc("The image properties")
model ImageProperties {
  @visibility(Lifecycle.Read)
  @doc("The resource provisioning state")
  provisioningState?: ResourceProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("The version of the package in the format 1.1.1")
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
  @doc("The versions that are compatible for this update package.")
  compatibleVersions?: Array<string>;
}

@doc("The image download properties")
model ImageDownloadResult {
  ...ImageProperties;

  @visibility(Lifecycle.Read)
  @doc("The unique identifier of the download")
  transactionId: string;

  @visibility(Lifecycle.Read)
  @doc("The download URI")
  downloadLink: url;

  @visibility(Lifecycle.Read)
  @doc("The download link expiry time")
  linkExpiry: utcDateTime;
}

@doc("The artifact properties")
model ArtifactProperties {
  @visibility(Lifecycle.Read)
  @doc("The resource provisioning state")
  provisioningState?: ResourceProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("The artifact display order")
  artifactOrder: int32;

  @visibility(Lifecycle.Read)
  @doc("The artifact title")
  title: string;

  @visibility(Lifecycle.Read)
  @doc("The artifact description")
  description: string;

  @visibility(Lifecycle.Read)
  @doc("The artifact size in MB")
  size?: int64;
}

@doc("The artifact download properties")
model ArtifactDownloadResult {
  ...ArtifactProperties;

  @visibility(Lifecycle.Read)
  @doc("The download URI")
  downloadLink: url;

  @visibility(Lifecycle.Read)
  @doc("The download link expiry time")
  linkExpiry: utcDateTime;
}
