import "../../Common/StandardizedContracts/CommonEnums.tsp";
import "../../Common/StandardizedContracts/Scope.tsp";
import "../../Common/StandardizedContracts/CommonModels.tsp";
import "../../Common/StandardizedContracts/AssessmentProperties.tsp";
import "../../DataModels/Assessment/ACAAssessmentSettings.tsp";
import "../../Common/ArmModels/AssessmentProjectV2.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("ARM model of ACA Assessment.")
@parentResource(AssessmentProject)
model ACAAssessment is ProxyResource<ACAAssessmentProperties> {
  @doc("ACA Assessment Name.")
  @segment("acaAssessments")
  @key("assessmentName")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  @visibility(Lifecycle.Read)
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("ACA Assessment Properties.")
model ACAAssessmentProperties
  is AssessmentProperties<Scope, ACAAssessmentSettings, AssessmentDetails>;
