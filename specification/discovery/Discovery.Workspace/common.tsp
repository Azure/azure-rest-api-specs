import "../Discovery.DataPlane.Shared/all.tsp";
import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Versioning;
using Microsoft.Discovery.DataPlane.Shared;

@doc("Enumeration for message sender.")
union Sender {
  /** Sent by Copilot */
  Copilot: "Copilot",

  /** Sent by User */
  You: "You",

  string,
}

@doc("For adding message sender.")
model WithSender {
  @doc("The sender")
  @visibility(Lifecycle.Read)
  @removed(Versions.`2026-02-01-preview`)
  sender: Sender;
}

@doc("For adding version ID.")
model WithVersionId {
  @doc("The version ID")
  @visibility(Lifecycle.Read)
  versionId: string;
}

@doc("For project reference.")
model WithProjectId {
  @doc("The ID of the associated Project")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  projectId: string;
}

@doc("For investigation reference.")
model WithInvestigationId {
  @doc("The ID of the associated Investigation")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  investigationId: string;
}

@doc("For investigation reference.")
model WithInvestigationNameOptional {
  @doc("The Name of the associated Investigation")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  investigationName?: string;
}

@doc("For project name reference.")
model WithProjectNameOptional {
  @doc("The name of the associated Project")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  projectName?: string;
}

@doc("For required project name reference.")
model WithProjectName {
  @doc("The name of the associated Project")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  projectName: string;
}

@doc("For searching by Investigation.")
model WithQueryInvestigationName {
  @doc("The name of the associated Investigation")
  @TypeSpec.Http.query
  investigationName?: string;
}
