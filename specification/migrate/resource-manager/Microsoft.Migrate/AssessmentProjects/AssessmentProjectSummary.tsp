import "./Common/ArmModels/AzureResourceProperties.tsp";
import "@azure-tools/typespec-autorest";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Assessment project summary resource.")
@parentResource(AssessmentProject)
model AssessmentProjectSummary
  is ProxyResource<AssessmentProjectSummaryProperties> {
  @doc("Assessment project summary resource.")
  @key("projectSummaryName")
  @segment("projectSummary")
  @path
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Doesn't have a PUT and hence no need for provisioning state. It is always hydrated by the service."
@doc("Assessment project summary properties class.")
model AssessmentProjectSummaryProperties {
  @doc("""
    Gets the Error summary by feature. Contains number of affected Entities per
    feature.
    """)
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errorSummaryAffectedEntities?: ErrorSummary[];

  @doc("Gets the number of private endpoint connections.")
  @visibility(Lifecycle.Read)
  numberOfPrivateEndpointConnections?: int32;

  @doc("Gets the number of groups created in this project.")
  @visibility(Lifecycle.Read)
  numberOfGroups?: int32;

  @doc("Gets the number of machines part of this project.")
  @visibility(Lifecycle.Read)
  numberOfMachines?: int32;

  @doc("Gets the number of import machines part of this project.")
  @visibility(Lifecycle.Read)
  numberOfImportMachines?: int32;

  @doc("Gets the number of assessments created in this project.")
  @visibility(Lifecycle.Read)
  numberOfAssessments?: int32;

  @doc("Gets the last assessment timestamp.")
  @visibility(Lifecycle.Read)
  lastAssessmentTimestamp?: utcDateTime;
}

@doc("Error summary containing affected entities for each type of assessment.")
model ErrorSummary {
  @doc("Gets the assessment type.")
  @visibility(Lifecycle.Read)
  assessmentType?: string;

  @doc("Gets the affected entity count.")
  @visibility(Lifecycle.Read)
  count?: int32;
}
