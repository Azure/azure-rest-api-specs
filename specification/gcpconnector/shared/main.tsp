using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;

namespace Microsoft.GcpConnector;
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
alias GcpCommonProperties = {
  @doc("Public Cloud Connectors Resource ID")
  publicCloudConnectorsResourceId?: string;

  @doc("GCP Project Number")
  gcpProjectNumber?: string;

  @doc("Fully qualified resource name of the GCP resource")
  resourceName?: string;

  @doc("Public Cloud Resource Name")
  publicCloudResourceName?: string;

  @doc("GCP Source Schema")
  gcpSourceSchema?: string;

  @doc("GCP Region")
  gcpRegion?: string;

  @doc("GCP Tags")
  gcpTags?: Record<string>;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
};

@doc("The provisioning state of a resource.")
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("The resource is being provisioned")
  Provisioning: "Provisioning",

  @doc("The resource is updating")
  Updating: "Updating",

  @doc("The resource is being deleted")
  Deleting: "Deleting",

  @doc("The resource create request has been accepted")
  Accepted: "Accepted",

  string,
}
