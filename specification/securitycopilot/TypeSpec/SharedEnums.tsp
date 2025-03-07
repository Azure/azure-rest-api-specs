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

@doc("Auth Location")
enum AuthLocationEnum {
  @doc("Using Header")
  Header,

  @doc("Using QueryParams")
  QueryParams,
}

@doc("Token Credential Types")
enum TokenCredentialEnum {
  @doc("None")
  None,

  @doc("UserTokenCredential type")
  UserTokenCredential,

  @doc("ServiceTokenCredential type")
  ServiceTokenCredential,
}

@doc("Type of prompt")
enum PromptType
{
    @doc("Unknown")
    Unknown,

    @doc("context")
    Context,

    @doc("Skill type prompt")
    Prompt,

    @doc("Skill type Skill")
    Skill
}