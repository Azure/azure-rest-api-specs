import "./shared.tsp";
import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Versioning;
using Microsoft.Discovery.Common;
using Microsoft.Discovery.Workspace;

@doc("Enumeration for message sender.")
union Sender {
  /** Sent by Copilot */
  Copilot: "Copilot",

  /** Sent by User */
  You: "You",

  string,
}

/** For adding message sender. */
alias WithSender = {
  @doc("The sender")
  @visibility(Lifecycle.Read)
  @removed(Versions.`2026-02-01-preview`)
  sender: Sender;
};

/** For investigation reference. */
alias WithInvestigationNameOptional = {
  @doc("The Name of the associated Investigation")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  investigationName?: string;
};

/** For project name reference. */
alias WithProjectNameOptional = {
  @doc("The name of the associated Project")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  projectName?: string;
};

/** For required project name reference. */
alias WithProjectName = {
  @doc("The name of the associated Project")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  projectName: string;
};

/** For searching by Investigation. */
alias WithQueryInvestigationName = {
  @doc("The name of the associated Investigation")
  @TypeSpec.Http.query
  investigationName?: string;
};
