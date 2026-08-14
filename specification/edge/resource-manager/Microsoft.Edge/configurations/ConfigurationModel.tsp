namespace Microsoft.Edge;

@doc("Available configuration models")
union ConfigurationModel {
  @doc("Configuration model Application")
  Application: "Application",

  @doc("Configuration model Common")
  Common: "Common",

  string,
}
