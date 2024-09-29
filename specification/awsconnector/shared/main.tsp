using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;

namespace Microsoft.AwsConnector;
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
alias AwsCommonProperties = {
  @doc("Public Cloud Connectors Resource ID")
  publicCloudConnectorsResourceId?: string;

  @doc("AWS Account ID")
  awsAccountId?: string;

  @doc("Amazon Resource Name (ARN)")
  arn?: string;

  @doc("Public Cloud Resource Name")
  publicCloudResourceName?: string;

  @doc("AWS Source Schema")
  awsSourceSchema?: string;

  @doc("AWS Region")
  awsRegion?: string;

  @doc("AWS Tags")
  awsTags?: Record<string>;

  @visibility("read")
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
