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

/** A Service Account Resource */
model ServiceAccount is TrackedResource<ServiceAccountProperties> {
  /** The name of the Service Account */
  @key("serviceAccountName")
  @segment("serviceAccounts")
  @path
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name: string;
}

/** Properties for a realm reference */
model RealmReference {
  /** The type of realm */
  type: string;
}

/** The properties of Service Account */
model ServiceAccountProperties {
  /** List of realms associated with the service account */
  realms: RealmReference[];

  /** List of reply to addresses */
  replyToAddresses: string[];

  /** Required authentication methods */
  authenticationRequirements: string[];

  /** Whether credentials have been removed */
  credentialsRemoved: boolean;

  /** Display name of the service account */
  displayName?: string;

  /** Owner of the service account */
  owner: string;

  /** List of claim provisioning settings */
  claimProvisionings: string[];

  /** Account property settings */
  accountProperties: string[];

  /** Custom claims */
  claims: Record<string>;

  /** Version of the account */
  accountVersion: string;

  /** Container identifier */
  containerId?: string;

  /** List of trusted certificate subjects */
  trustedCertificateSubjects: string[];

  /** Application principal ID */
  applicationPrincipalId: string;

  /** Object ID */
  objectId: string;

  /** Type of account */
  accountType: string;

  /** Version number */
  version: int32;

  /** Last modified date */
  modifiedDate?: string;

  /** Creation date */
  createdDate?: string;

  /** Last modifier */
  modifiedBy?: string;

  /** Creator */
  createdBy?: string;
}
