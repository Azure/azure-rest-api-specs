import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "../main.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace DevCenterService;

@doc("The current status of an async operation.")
@resource("operationstatuses")
@parentResource(Project)
model OperationStatus {
  @doc("Fully qualified ID for the operation status.")
  @visibility("read")
  id: string;

  @doc("The operation id name.")
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-zA-Z0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$")
  @key("operationId")
  @visibility("read")
  name: Azure.Core.uuid;

  @doc("Provisioning state of the resource.")
  status: Azure.Core.Foundations.OperationState;

  @doc("The id of the resource.")
  resourceId?: string;

  @doc("The start time of the operation, in RFC3339 format.")
  startTime?: utcDateTime;

  @doc("The end time of the operation, in RFC3339 format.")
  endTime?: utcDateTime;

  @doc("Percent of the operation that is complete.")
  @minValue(0.0)
  @maxValue(100.0)
  percentComplete?: float64;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "there is no build in type to describe object"
  @doc("Custom operation properties, populated only for a successful operation.")
  properties?: unknown;

  @doc("Operation Error message.")
  error?: Azure.Core.Foundations.Error;
}

@doc("Project details.")
@resource("projects")
model Project {
  @doc("The unique URI of the project.")
  @added(APIVersions.v2024_02_01)
  uri: url;

  @key("projectName")
  @doc("Name of the project.")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @visibility("read")
  name: string;

  @doc("Description of the project.")
  description?: string;

  @doc("""
    When specified, indicates the maximum number of Dev Boxes a single user can
    create across all pools in the project.
    """)
  @minValue(0)
  maxDevBoxesPerUser?: int32;

  @doc("Display name of the pool.")
  @added(APIVersions.v2024_02_01)
  displayName?: string;
}

@doc("Project user.")
@resource("users")
@parentResource(Project)
model User {
  @key("userId")
  @doc("The AAD object id of the user. If value is 'me', the identity is taken from the authentication context.")
  @minLength(2)
  @maxLength(36)
  @pattern("^[a-zA-Z0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$|^me$")
  @visibility("read")
  userId: string;
}

@doc("An ability the user has to perform an action on the project as an admin.")
@added(APIVersions.v2024_05_01_preview)
union ProjectAbilityAsAdmin {
  @doc("User can delete dev boxes.")
  DeleteDevBoxes: "DeleteDevBoxes",

  @doc("User can delete environments.")
  DeleteEnvironments: "DeleteEnvironments",

  @doc("User can delay and skip actions on environments.")
  ManageEnvironmentActions: "ManageEnvironmentActions",

  @doc("User can read dev boxes.")
  ReadDevBoxes: "ReadDevBoxes",

  @doc("User can read actions on environments.")
  ReadEnvironmentActions: "ReadEnvironmentActions",

  @doc("User can read outputs on environments.")
  ReadEnvironmentOutputs: "ReadEnvironmentOutputs",

  @doc("User can read environments.")
  ReadEnvironments: "ReadEnvironments",

  @doc("User can start dev boxes.")
  StartDevBoxes: "StartDevBoxes",

  @doc("User can stop dev boxes.")
  StopDevBoxes: "StopDevBoxes",

  @doc("User can create dev boxes.")
  WriteDevBoxes: "WriteDevBoxes",

  @doc("User can create new environments or replace and update existing ones.")
  WriteEnvironments: "WriteEnvironments",

  string,
}

@doc("An ability the user has to perform an action on the project as a developer.")
@added(APIVersions.v2024_05_01_preview)
union ProjectAbilityAsDeveloper {
  @doc("User can customize their own dev boxes.")
  CustomizeDevBoxes: "CustomizeDevBoxes",

  @doc("User can delete their own dev boxes.")
  DeleteDevBoxes: "DeleteDevBoxes",

  @doc("User can delete environments.")
  DeleteEnvironments: "DeleteEnvironments",

  @doc("User can delay and skip actions on their own dev boxes.")
  ManageDevBoxActions: "ManageDevBoxActions",

  @doc("User can delay and skip actions on environments.")
  ManageEnvironmentActions: "ManageEnvironmentActions",

  @doc("User can read actions on their own dev boxes.")
  ReadDevBoxActions: "ReadDevBoxActions",

  @doc("User can read their own dev boxes.")
  ReadDevBoxes: "ReadDevBoxes",

  @doc("User can read actions on environments.")
  ReadEnvironmentActions: "ReadEnvironmentActions",

  @doc("User can read outputs on environments.")
  ReadEnvironmentOutputs: "ReadEnvironmentOutputs",

  @doc("User can read environments.")
  ReadEnvironments: "ReadEnvironments",

  @doc("User can read remote connections on their own dev boxes.")
  ReadRemoteConnections: "ReadRemoteConnections",

  @doc("User can start their own dev boxes.")
  StartDevBoxes: "StartDevBoxes",

  @doc("User can stop their own dev boxes.")
  StopDevBoxes: "StopDevBoxes",

  @doc("User can create dev boxes.")
  WriteDevBoxes: "WriteDevBoxes",

  @doc("User can create new environments or replace and update existing ones.")
  WriteEnvironments: "WriteEnvironments",

  string,
}

@doc("Abilities a user has on a project.")
@added(APIVersions.v2024_05_01_preview)
model ProjectAbilities {
  @doc("The abilities the user has to perform actions on the project as an admin.")
  abilitiesAsAdmin: ProjectAbilityAsAdmin[];

  @doc("The abilities the user has to perform actions on the project as a developer.")
  abilitiesAsDeveloper: ProjectAbilityAsDeveloper[];
}
