import "./Common/AzureResourceProperties.tsp";

using Autorest;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Migrate;

@doc("Group resource.")
@parentResource(AssessmentProject)
model Group is ProxyResource<GroupProperties> {
    @doc("Group ARM name")
    @key("groupName")
    @segment("groups")
    @path
    name: string;
}

@doc("Properties of group resource.")
model GroupProperties extends AzureResourceProperties {
    @doc("Whether the group has been created and is valid.")
    @visibility("read")
    groupStatus?: GroupStatus;

    @doc("Number of machines part of this group.")
    @visibility("read")
    machineCount?: int32;

    @doc("List of References to Assessments created on this group.")
    @visibility("read")
    assessments?: string[];

    @doc("If the assessments are in running state.")
    @visibility("read")
    areAssessmentsRunning?: boolean;

    @doc("Time when this group was created. Date-Time represented in ISO-8601 format.")
    @visibility("read")
    createdTimestamp?: utcDateTime;

    @doc("Time when this group was last updated. Date-Time represented in ISO-8601 format.")
    @visibility("read")
    updatedTimestamp?: utcDateTime;

    @doc("The type of group.")
    groupType?: GroupType;
}

enum GroupStatus {
    "Created",
    "Updated",
    "Running",
    "Completed",
    "Invalid",
}

@doc("Properties of group update.")
model UpdateGroupBody {
    @doc("For optimistic concurrency control.")
    eTag?: string;

    @doc("Properties of the group.")
    properties?: GroupBodyProperties;
}

@doc("Body properties of group update.")
model GroupBodyProperties {
    @doc("Whether to add or remove the machines.")
    operationType?: GroupUpdateOperation;

    @doc("List of machine names that are part of this group.")
    machines?: string[];
}

enum GroupUpdateOperation {
    "Add",
    "Remove",
}
