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

@doc("The disconnected operation properties")
model DisconnectedOperationProperties {
  @visibility("read")
  @doc("The resource provisioning state")
  provisioningState?: ResourceProvisioningState;

  @visibility("read")
  @doc("The unique Id of the stamp")
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

@doc("The disconnected operation manifest")
model DisconnectedOperationDeploymentManifest {
  @visibility("read")
  @doc("The resource Id of the disconnected operations resource")
  resourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Edge/disconnectedOperations";
    }
  ]>;

  @visibility("read")
  @doc("The resource name")
  resourceName: string;

  @visibility("read")
  @doc("The unique Id of the stamp")
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

@doc("The image properties")
model ImageProperties {
  @visibility("read")
  @doc("The resource provisioning state")
  provisioningState?: ResourceProvisioningState;

  @visibility("read")
  @doc("The version of the package in the format 1.1.1")
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
  @doc("The versions that are compatible for this update package.")
  compatibleVersions?: Array<string>;
}

@doc("The image download properties")
model ImageDownloadResponse {
  ...ImageProperties;

  @visibility("read")
  @doc("The unique Id of the download")
  transactionId: string;

  @visibility("read")
  @doc("The download uri")
  downloadLink: url;

  @visibility("read")
  @doc("The download link expiry time")
  linkExpiry: utcDateTime;
}
