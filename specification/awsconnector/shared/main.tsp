using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;

namespace Microsoft.AwsConnector;
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
alias AwsCommonProperties = {
  @doc("Gets and sets the property publicCloudConnectorsResourceId.")
  publicCloudConnectorsResourceId?: string;

  @doc("Gets and sets the property awsAccountId.")
  awsAccountId?: string;

  @doc("Gets and sets the property awsResourceName.")
  awsResourceName?: string;

  @doc("Gets and sets the property awsSourceSchema.")
  awsSourceSchema?: string;

  @doc("Gets and sets the property awsSdkVersion.")
  awsSdkVersion?: string;

  @doc("Gets and sets the property awsRegion.")
  awsRegion?: string;

  @doc("Gets and sets the property awsTags.")
  awsTags?: Record<string>;

  @visibility("read")
  @doc("Gets and sets the property provisioningState.The status of the last operation.")
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
