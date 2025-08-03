import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("Defines the array of allowlists for a secret")
model Allowlists {
  @doc("Allowlist elements")
  @Azure.ResourceManager.identifiers(#[])
  elements: Allowlist[];
}

@doc("Defines the allowlist element for a secret.")
model Allowlist {
  @doc("Gets or sets the type of the allowlist.")
  type: AllowlistType;

  @doc("Gets or sets the values of the allowlist. A list of values are separated by semicolon.")
  values: string;
}

@doc("Defines where the secret should be replicated to.")
model ReplicationScope {
  @doc("Replication Type")
  type: ReplicationType;

  @doc("The regions the secret will be replicated to (Applicable when the type of replication is SpecifiedDsmsRegions). Regions are separated by semicolon.")
  regions: string;
}

@doc("Certificate Type")
union CertificateType {
  @doc("Chained certificate")
  Chained: "Chained",

  @doc("Self-signed certificate")
  SelfSigned: "SelfSigned",

  string,
}

@doc("Replication Type")
union ReplicationType {
  @doc("This secret is not replicated to other dSMS instance")
  Local: "Local",

  @doc("This secret can be replicated to all dSMS instances")
  AllDsmsRegions: "AllDsmsRegions",

  @doc("This secret can only be replicated to the specified dSMS instances")
  SpecifiedDsmsRegions: "SpecifiedDsmsRegions",

  string,
}

@doc("Allowlist Type")
union AllowlistType {
  @doc("Allowlisting a service")
  ServiceID: "ServiceID",

  @doc("Allowlisting subscription ID for creating storage account objects")
  SubscriptionID: "SubscriptionID",

  @doc("Allowlisting a DNS domain for creating chained certificates")
  DnsDomain: "DnsDomain",

  @doc("Allowlisting a service tree ID")
  ServiceTreeID: "ServiceTreeID",

  string,
}

@doc("CA type")
union CaType {
  @doc("SSLAdmin CA")
  SSLAdmin: "SSLAdmin",

  @doc("AME CA")
  AME: "AME",

  string,
}

@doc("sslAdminCertificateDsms properties")
model DsmsCertificateProperties {
  @doc("Name of the certificate")
  certificateName: string;

  @doc("Certificate type, Chained or SelfSigned")
  certificateType: CertificateType;

  @doc("Root path of the certificate")
  rootPath: string;

  @doc("Define in which region of dSMS to provision the storage account, such as global-dsms.dsms.%(HostNameSuffix), uswest-dsms.dsms.%(HostNameSuffix). This is used only when provision storage account in non-home-dsms endpoint.")
  dsmsDns?: string;

  @doc("Certificate allowlist in dSMS.")
  allowlists?: Allowlists;

  @doc("Certificate Replication in dSMS.")
  replicationScope?: ReplicationScope;

  @doc("Certificate Subject name, e.g. \"CN=DsmsEv2Extension\" or \"CN=ev2-dsms.dsms.core.azure-test.net\"")
  subjectName: string;

  @doc("Certificate Subject Alternate Name, e.g. \"DNS=ev2-dsms.dsms.core.azure-test.net\"")
  subjectAlternativeName?: string;

  @doc("CA to use, \"SSLAdmin\" or \"AME\"")
  caName?: CaType; // Can be a part of provisioning ResultData output, and get PATCHed back from FRP.

  @doc("Valid days of this certificate (Self-signed certificates only)")
  validDays?: int32;

  #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Maintaining compatibility with current SDKs."
  @doc("Enable CA signing (Self-signed certificates only)")
  selfSigningMethod?: "CertificateAuthority" | "SelfSigned" | string;

  @doc("The Azure location")
  @added(Versions.v2024_06_24_preview)
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: CertificateProvisioningState;

  @added(Versions.v2024_06_24_preview)
  @doc("Self-signed Certificate DSMS name; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  selfSignedCertificateDsmsName?: string;

  @added(Versions.v2024_06_24_preview)
  @doc("Chained Certificate DSMS name; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  chainedCertificateDsmsName?: string;

  @added(Versions.v2024_06_24_preview)
  @doc("Automatically injected if the environment is a child trusted island; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  edgeSiteChildTrustIsland?: string;
}

@doc("dsmsCertificate Resource")
model DsmsCertificateResource
  is ProxyResource<DsmsCertificateProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dsmsCertificates") // Start with lower case. Should be plural
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Microsoft.AzCIS provider resource types don't support delete operations for now. We do not support delete due to security issues with giving permissions for delete. We do plan for it in future."
@armResourceOperations
interface DsmsCertificate {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DsmsCertificateResource>;
  listBySubscription is ArmListBySubscription<DsmsCertificateResource>;
  listByResourceGroup is ArmResourceListByParent<DsmsCertificateResource>;
  get is ArmResourceRead<DsmsCertificateResource>;
}
