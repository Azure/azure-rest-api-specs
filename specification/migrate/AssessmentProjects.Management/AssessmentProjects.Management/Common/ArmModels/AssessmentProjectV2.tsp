import "./AzureResourceProperties.tsp";
import "./PrivateEndpointConnection.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("An Assessment project site resource.")
model AssessmentProject is TrackedResource<ProjectProperties> {
  @doc("Assessment Project Name")
  @segment("assessmentProjects")
  @key("projectName")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;
}

@doc("Properties of a project.")
model ProjectProperties is AzureResourceProperties {
  @doc("Time when this project was created. Date-Time represented in ISO-8601 format.")
  @visibility(Lifecycle.Read)
  createdTimestamp?: utcDateTime;

  @doc("""
    Time when this project was last updated. Date-Time represented in ISO-8601
    format.
    """)
  @visibility(Lifecycle.Read)
  updatedTimestamp?: utcDateTime;

  @doc("Endpoint at which the collector agent can call agent REST API.")
  @visibility(Lifecycle.Read)
  serviceEndpoint?: string;

  @doc("Assessment solution ARM id tracked by Microsoft.Migrate/migrateProjects.")
  assessmentSolutionId?: string;

  @doc("Assessment project status.")
  projectStatus?: ProjectStatus;

  @doc("The ARM id of service map workspace created by customer.")
  customerWorkspaceId?: string;

  @doc("Location of service map workspace created by customer.")
  customerWorkspaceLocation?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  @doc("""
    This value can be set to 'enabled' to avoid breaking changes on existing
    customer resources and templates. If set to 'disabled', traffic over public
    interface is not allowed, and private endpoint connections would be the
    exclusive access method.
    """)
  publicNetworkAccess?: string;

  @doc("The list of private endpoint connections to the project.")
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("""
    The ARM id of the storage account used for interactions when public access is
    disabled.
    """)
  customerStorageAccountArmId?: string;
}

@doc("Project Status.")
union ProjectStatus {
  @doc("Active Status.")
  Active: "Active",

  @doc("Inactive Status.")
  Inactive: "Inactive",

  string,
}
