import "./Common/AzureResourceProperties.tsp";

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
    @doc("Group ARM name")
    @key("projectSummaryName")
    @segment("projectSummary")
    @path
    name: string;
}

@doc("Assessment project summary properties class.")
model AssessmentProjectSummaryProperties extends AzureResourceProperties {
    //   @doc("""
    // Gets the Error summary by feature. Contains number of affected Entities per
    // feature.
    // """)
    //   @visibility("read")
    //     @added(ApiVersions.v2022_02_02_preview)
    //     errorSummaryAffectedEntities?: ErrorSummary[];

    @doc("Gets the number of private endpoint connections.")
    @visibility("read")
    @added(ApiVersions.v2020_05_01_preview)
    numberOfPrivateEndpointConnections?: int32;

    @doc("Gets the number of groups created in this project.")
    @visibility("read")
    numberOfGroups?: int32;

    @doc("Gets the number of machines part of this project.")
    @visibility("read")
    numberOfMachines?: int32;

    @doc("Gets the number of import machines part of this project.")
    @visibility("read")
    numberOfImportMachines?: int32;

    @doc("Gets the number of assessments created in this project.")
    @visibility("read")
    numberOfAssessments?: int32;

    @doc("Gets the last assessment timestamp.")
    @visibility("read")
    lastAssessmentTimestamp?: utcDateTime;
}

@doc("Error summary containing affected entities for each type of assessment.")
model ErrorSummary {
    @doc("Gets the assessment type.")
    @visibility("read")
    assessmentType?: AssessmentType;

    @doc("Gets the affected entity count.")
    @visibility("read")
    count?: int32;
}
