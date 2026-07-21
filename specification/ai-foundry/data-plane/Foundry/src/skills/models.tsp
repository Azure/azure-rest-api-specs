using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

@doc("A skill name following the agentskills.io spec: lowercase letters, numbers, and hyphens only. Must not start or end with a hyphen or contain consecutive hyphens.")
@maxLength(64)
@pattern("^[a-z0-9]([a-z0-9\\-]*[a-z0-9])?$")
scalar SkillName extends string;

const SkillsRequiredPreviews = #{
  required_previews: #[FoundryFeaturesOptInKeys.skills_v1_preview],
};

@doc("Inline content for defining a simple skill without uploading files. Follows the agentskills.io SKILL.md specification.")
@extension("x-ms-foundry-meta", SkillsRequiredPreviews)
model SkillInlineContent {
  @doc("A human-readable description of what the skill does and when to use it.")
  @maxLength(1024)
  description: string;

  @doc("The skill instructions in markdown format. This is the body content of the SKILL.md file.")
  instructions: string;

  @doc("License name or reference to a bundled license file.")
  license?: string;

  @doc("Environment requirements or compatibility notes for the skill.")
  @maxLength(500)
  compatibility?: string;

  @doc("Arbitrary key-value metadata for additional properties.")
  metadata?: Record<string>;

  @doc("List of pre-approved tools the skill may use. Experimental.")
  allowed_tools?: string[];
}

@doc("Multipart request body for creating a skill version from files. Accepts either a single zip file or multiple individual skill files (directory upload). For zip uploads, the server extracts and validates contents. For directory uploads, files are validated as-is.")
@extension("x-ms-foundry-meta", SkillsRequiredPreviews)
model CreateSkillVersionFromFilesBody {
  @doc("Skill files to upload. Upload a single zip file or multiple individual files with relative paths.")
  files: HttpPart<File>[];

  @doc("Whether to set this version as the default. Defaults to false.")
  default?: HttpPart<boolean>;
}

alias GetSkillRequest = {
  @doc("The unique name of the skill.")
  @path
  name: SkillName;
};

alias ListSkillsRequest = {
  ...CommonPageQueryParameters;
};

alias DeleteSkillRequest = {
  @doc("The unique name of the skill.")
  @path
  name: SkillName;
};

@doc("A skill resource.")
@extension("x-ms-foundry-meta", SkillsRequiredPreviews)
model Skill {
  @doc("The unique identifier of the skill.")
  id: string;

  @doc("The unique name of the skill.")
  name: SkillName;

  @doc("A human-readable description of the skill.")
  @maxLength(1024)
  description: string;

  @doc("The Unix timestamp (seconds) when the skill was created.")
  created_at: FoundryTimestamp;

  @doc("The default version for the skill. Can be changed via updateSkill.")
  default_version: string;

  @doc("The latest version for the skill.")
  latest_version: string;
}

@doc("A specific version of a skill.")
@extension("x-ms-foundry-meta", SkillsRequiredPreviews)
model SkillVersion {
  @doc("The unique identifier of the skill version.")
  id: string;

  @doc("The identifier of the parent skill.")
  skill_id: string;

  @doc("The name of the skill version.")
  name: SkillName;

  @doc("The version identifier. Skill versions are immutable.")
  version: string;

  @doc("A human-readable description of the skill version.")
  @maxLength(1024)
  description: string;

  @doc("The Unix timestamp (seconds) when the skill version was created.")
  created_at: FoundryTimestamp;
}

alias CreateSkillVersionRequest = {
  @doc("The name of the skill. If the skill does not exist, it will be created.")
  @path
  name: SkillName;

  @doc("Inline skill content for simple skills without file uploads. Foundry-specific extension.")
  inline_content?: SkillInlineContent;

  @doc("Whether to set this version as the default.")
  default?: boolean;
};

alias GetSkillVersionRequest = {
  @doc("The name of the skill.")
  @path
  name: SkillName;

  @doc("The version identifier to retrieve.")
  @path
  version: string;
};

alias ListSkillVersionsRequest = {
  @doc("The name of the skill to list versions for.")
  @path
  name: SkillName;

  ...CommonPageQueryParameters;
};

alias GetSkillContentRequest = {
  @doc("The name of the skill.")
  @path
  name: SkillName;
};

alias GetSkillVersionContentRequest = {
  @doc("The name of the skill.")
  @path
  name: SkillName;

  @doc("The version to download content for.")
  @path
  version: string;
};

alias UpdateSkillRequest = {
  @doc("The name of the skill to update.")
  @path
  name: SkillName;

  @doc("The version identifier that the skill should point to. When set, the skill's default version will resolve to this version instead of the latest.")
  default_version: string;
};

alias DeleteSkillVersionRequest = {
  @doc("The name of the skill.")
  @path
  name: SkillName;

  @doc("The version identifier to delete.")
  @path
  version: string;
};

@doc("A deleted skill.")
@extension("x-ms-foundry-meta", SkillsRequiredPreviews)
model DeleteSkillResponse {
  @doc("The unique identifier of the deleted skill.")
  id: string;

  @doc("The unique name of the skill.")
  name: SkillName;

  @doc("Whether the skill was successfully deleted.")
  deleted: boolean;
}

@doc("A deleted skill version.")
@extension("x-ms-foundry-meta", SkillsRequiredPreviews)
model DeleteSkillVersionResponse {
  @doc("The unique identifier of the deleted skill version.")
  id: string;

  @doc("The name of the skill.")
  name: SkillName;

  @doc("Whether the skill version was successfully deleted.")
  deleted: boolean;

  @doc("The version that was deleted.")
  version: string;
}

@doc("The response body for downloading a skill package.")
@extension("x-ms-foundry-meta", SkillsRequiredPreviews)
model DownloadSkillResponse {
  @doc("The media type of the returned package content.")
  @header("Content-Type")
  content_type: "application/zip";

  @doc("The zip skill package content.")
  @body
  content: bytes;
}
