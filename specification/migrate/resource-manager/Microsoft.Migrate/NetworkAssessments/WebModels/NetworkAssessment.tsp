import "../Common/StandardizedContracts/AssessmentProperties.tsp";
import "../Common/StandardizedContracts/Scope.tsp";
import "../Common/ArmModels/AssessmentProjectV2.tsp";
import "../Common/NetworkEnums.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("Network Assessment REST resource.")
@parentResource(AssessmentProject)
model NetworkAssessment is ProxyResource<NetworkAssessmentProperties> {
  @doc("Network Assessment ARM name.")
  @key("assessmentName")
  @segment("networkAssessments")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

@doc("Network assessment properties class.")
model NetworkAssessmentProperties
  is AssessmentProperties<Scope, NetworkAssessmentSettings, AssessmentDetails> {
  @doc("The ARM IDs of partner assessments included in this network assessment.")
  assessmentArmIds?: armResourceIdentifier[];
}

@doc("Network-specific settings for network design.")
model NetworkSettings {
  @doc("Whether to mimic the on-premises network topology.")
  mimicOnPremNetwork?: boolean;

  @doc("Whether to use WAF and CAF guidelines for network design.")
  useWafAndCafForNetworkDesign?: boolean;

  @doc("Whether to include platform network components.")
  includePlatformNetworkComponents?: boolean;
}

@doc("Network assessment settings class.")
model NetworkAssessmentSettings is AssessmentSettings {
  @doc("The azure security offering type.")
  azureSecurityOfferingType?: AzureSecurityOfferingType;

  @doc("Gets or sets the network settings.")
  networkSettings?: NetworkSettings;
}
