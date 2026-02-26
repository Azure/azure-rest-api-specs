import "../../Common/StandardizedContracts/CommonEnums.tsp";
import "../../Common/StandardizedContracts/Scope.tsp";
import "../../Common/StandardizedContracts/CommonModels.tsp";
import "../../Common/StandardizedContracts/AssessmentProperties.tsp";
import "../../DataModels/Assessment/AKSAssessmentSettings.tsp";
import "../../Common/ArmModels/AssessmentProjectV2.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("ARM model of AKS Assessment.")
@parentResource(AssessmentProject)
model AKSAssessment is ProxyResource<AKSAssessmentProperties> {
  @doc("AKS Assessment Name.")
  @segment("aksAssessments")
  @key("assessmentName")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  @visibility(Lifecycle.Read)
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("AKS Assessment Properties.")
model AKSAssessmentProperties
  is AssessmentProperties<Scope, AKSAssessmentSettings, AssessmentDetails>;
