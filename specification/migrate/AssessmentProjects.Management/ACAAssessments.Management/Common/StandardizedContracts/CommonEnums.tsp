@doc("Machine Boot Type")
union MachineBootType {
  @doc("Unknown - Machine Boot Type")
  Unknown: "Unknown",

  @doc("EFI - Machine Boot Type")
  EFI: "EFI",

  @doc("BIOS - Machine Boot Type")
  Bios: "BIOS",

  @doc("NotSpecified - Machine Boot Type")
  NotSpecified: "NotSpecified",

  string,
}

@doc("Environment Type")
union EnvironmentType {
  @doc("Production - Environment Type")
  Production: "Production",

  @doc("Unknown - Environment Type")
  Unknown: "Unknown",

  @doc("DevTest - Environment Type")
  DevTest: "DevTest",

  string,
}

@doc("Migration Issues Category")
union MigrationIssuesCategory {
  @doc("Issue - Migration Issues Category")
  Issue: "Issue",

  @doc("Warning - Migration Issues Category")
  Warning: "Warning",

  @doc("Internal - Migration Issues Category")
  Internal: "Internal",

  string,
}
