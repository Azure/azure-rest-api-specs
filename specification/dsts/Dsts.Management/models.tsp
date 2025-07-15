import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Dsts;

@added(Versions.v2025_05_23_preview)
@doc("Application Resource")
@parentResource(TenantLocationResource)
model Application is ProxyResource<ApplicationProperties> {
  @doc("The name of the Application")
  @key("applicationName")
  @segment("applications")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

@added(Versions.v2025_05_23_preview)
@doc("A claim associated with an application")
model ApplicationClaim {
  @doc("The name of the claim")
  name: string;

  @doc("The value of the claim")
  value: string;
}

@added(Versions.v2025_05_23_preview)
@doc("Properties for a realm reference")
model RealmReference {
  @doc("The type of realm")
  type: string;
}

@added(Versions.v2025_05_23_preview)
@doc("The provisioning state for the Application")
union ProvisioningState {
  @doc("Resource has been successfully provisioned")
  Succeeded: "Succeeded",

  @doc("Resource provisioning has failed")
  Failed: "Failed",

  @doc("Resource provisioning was canceled")
  Canceled: "Canceled",

  @doc("Resource provisioning request is in progress")
  Accepted: "Accepted",

  @doc("Resource provisioning request is being processed")
  Processing: "Processing",

  @doc("Resource provisioning request is being updating")
  Updating: "Updating",

  @doc("Resource provisioning request status is unknown")
  Unknown: "Unknown",

  string,
}

@added(Versions.v2025_06_10_preview)
@doc("Endpoint Resource")
@parentResource(TenantLocationResource)
model Endpoint is ProxyResource<EndpointProperties> {
  @doc("The name of the Endpoint")
  @key("endpointName")
  @segment("endpoints")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;
}

@added(Versions.v2025_06_10_preview)
@doc("The properties of Endpoint")
model EndpointProperties {
  @doc("The provisioning state of the Endpoint")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The hostname for the endpoint")
  hostname?: string;
}

@added(Versions.v2025_05_23_preview)
@doc("The properties of Application")
@parentResource(TenantLocationResource)
model ApplicationProperties {
  @doc("The provisioning state of the Application")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("List of realms associated with the application")
  @OpenAPI.extension("x-ms-identifiers", #["type"])
  realms?: RealmReference[];

  @doc("List of reply to addresses")
  replyToAddresses?: string[];

  @doc("Required authentication methods")
  authenticationRequirements?: string[];

  @doc("Whether credentials have been removed")
  credentialsRemoved?: boolean;

  @doc("Display name of the application")
  displayName?: string;

  @doc("Owner of the application")
  owner?: string;

  @doc("List of claim provisioning settings")
  claimProvisionings?: string[];

  @doc("Account property settings")
  accountProperties?: string[];

  @doc("Account claims")
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  claims?: ApplicationClaim[];

  @doc("Version of the account")
  accountVersion?: string;

  @doc("Container identifier")
  containerId?: string;

  @doc("List of trusted certificate subjects")
  trustedCertificateSubjects?: string[];

  @doc("Application principal ID")
  applicationPrincipalId?: string;

  @doc("Object ID")
  objectId?: string;

  @doc("Type of account")
  accountType?: string;

  @doc("Version number")
  version?: int32;

  @doc("Last modified date")
  modifiedDate?: string;

  @doc("Creation date")
  createdDate?: string;

  @doc("Last modifier")
  modifiedBy?: string;

  @doc("Creator")
  @visibility(Lifecycle.Read)
  createdBy?: string;
}
