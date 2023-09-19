@doc("The type for a source that was used in generating the output of a skill")
enum SkillSourceType {
  @doc("Uri")
  Uri,

  @doc("StringType")
  StringType,
}

@doc("Level for progress logs")
enum ProgressLogLevel {
  @doc("Error log")
  Error,

  @doc("Warning log")
  Warning,

  @doc("Information log")
  Information,

  @doc("Verbose log")
  Verbose,
}
