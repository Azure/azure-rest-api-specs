import "../../Common/ArmModels/AssessmentProjectV2.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Compound assessment resource.")
@parentResource(AssessmentProject)
model CompoundAssessment is ProxyResource<CompoundAssessmentProperties> {
  @doc("Compound Assessment ARM name")
  @key("compoundAssessmentName")
  @segment("webAppCompoundAssessments")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

@doc("Properties of a compound assessment.")
model CompoundAssessmentProperties is AzureResourceProperties {
  @doc("ARM IDs of the target assessments.")
  targetAssessmentArmIds: TargetAssessmentArmIds;

  @doc("Fallback machine assessment ARM ID.")
  fallbackMachineAssessmentArmId?: string;

  @doc("Details of the compound assessment.")
  @visibility(Lifecycle.Read)
  details?: CompoundAssessmentDetails;
}

@doc("ARM IDs of the target assessments.")
model TargetAssessmentArmIds {
  @doc("ARM ID for Azure Kubernetes Service assessment.")
  aks?: string;

  @doc("ARM ID for Azure App Service assessment.")
  azureAppService?: string;

  @doc("ARM ID for Azure App Service Container assessment.")
  azureAppServiceContainer?: string;
}

@doc("Details of the compound assessment.")
model CompoundAssessmentDetails {
  @doc("Timestamp when the assessment was created.")
  createdTimestamp?: utcDateTime;

  @doc("Timestamp when the assessment was last updated.")
  updatedTimestamp?: utcDateTime;

  @doc("Status of the assessment.")
  status: AssessmentStatus;
}
