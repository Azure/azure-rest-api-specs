import "./Common/AzureResourceProperties.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("An Assessment project site resource.")
model AssessmentProject is TrackedResource<ProjectProperties> {
    @key("projectName")
    @segment("assessmentProjects")
    @doc("Assessment Project Name")
    @path
    name: string;
}

@doc("Properties of a project.")
model ProjectProperties extends AzureResourceProperties {
    @doc("Time when this project was created. Date-Time represented in ISO-8601 format.")
    @visibility("read")
    createdTimestamp?: utcDateTime;

    @doc("""
Time when this project was last updated. Date-Time represented in ISO-8601
format.
""")
    @visibility("read")
    updatedTimestamp?: utcDateTime;

    @doc("Endpoint at which the collector agent can call agent REST API.")
    @visibility("read")
    serviceEndpoint?: string;

    @doc("Assessment solution ARM id tracked by Microsoft.Migrate/migrateProjects.")
    assessmentSolutionId?: string;

    @doc("Assessment project status.")
    projectStatus?: ProjectStatus;

    @doc("The ARM id of service map workspace created by customer.")
    customerWorkspaceId?: string;

    @doc("Location of service map workspace created by customer.")
    customerWorkspaceLocation?: string;

    @doc("Number of groups created in the project.")
    @visibility("read")
    numberOfGroups?: int32;

    @doc("Number of machines in the project.")
    @visibility("read")
    numberOfMachines?: int32;

    @doc("Number of assessments created in the project.")
    @visibility("read")
    numberOfAssessments?: int32;

    @doc("""
Time when last assessment was created. Date-Time represented in ISO-8601
format. This value will be null until assessment is created.
""")
    @visibility("read")
    lastAssessmentTimestamp?: utcDateTime;

    @doc("""
This value can be set to 'enabled' to avoid breaking changes on existing
customer resources and templates. If set to 'disabled', traffic over public
interface is not allowed, and private endpoint connections would be the
exclusive access method.
""")
    @added(ApiVersions.v2019_10_01)
    publicNetworkAccess?: string;

    @doc("The list of private endpoint connections to the project.")
    @visibility("read")
    @added(ApiVersions.v2019_10_01)
    privateEndpointConnections?: PrivateEndpointConnection[];

    @doc("""
The ARM id of the storage account used for interactions when public access is
disabled.
""")
    @added(ApiVersions.v2019_10_01)
    customerStorageAccountArmId?: string;
}

enum ProjectStatus {
    "Active",
    "Inactive",
}
