using TypeSpec.Http;

namespace Azure.AI.Projects;

const SkillsRequiredPreviews = #{
  conditional_previews: #[FoundryFeaturesOptInKeys.skills_v1_preview],
};

alias CreateSkillRequest = {
  @doc("The unique name of the skill.")
  @maxLength(63)
  name: string;

  @doc("Skill files to upload as a zip package.")
  files: bytes;

  @doc("A human-readable description of the skill.")
  @maxLength(1024)
  description?: string;
};

alias GetSkillRequest = {
  @doc("The unique name of the skill.")
  @path
  name: string;
};

alias ListSkillsRequest = {
  ...CommonPageQueryParameters;
};

alias DeleteSkillRequest = {
  @doc("The unique name of the skill.")
  @path
  name: string;
};

@doc("A skill resource.")
model Skill {
  @doc("The unique identifier of the skill.")
  id: string;

  @doc("The unique name of the skill.")
  @maxLength(63)
  name: string;

  @doc("A human-readable description of the skill.")
  @maxLength(1024)
  description?: string;

  @doc("The Unix timestamp (seconds) when the skill was created.")
  @encode("unixTimestamp", int32)
  created_at: utcDateTime;

  @doc("The default version for the skill. Can be changed via updateSkillDefaultVersion.")
  default_version: string;

  @doc("The latest version for the skill.")
  latest_version: string;

  @doc("The object type, which is always 'skill'.")
  object: "skill";
}

@doc("A specific version of a skill.")
model SkillVersion {
  @doc("The unique identifier of the skill version.")
  id: string;

  @doc("The identifier of the parent skill.")
  skill_id: string;

  @doc("The name of the skill version.")
  @maxLength(63)
  name: string;

  @doc("The version identifier. Skill versions are immutable.")
  version: string;

  @doc("A human-readable description of the skill version.")
  @maxLength(1024)
  description?: string;

  @doc("The Unix timestamp (seconds) when the skill version was created.")
  @encode("unixTimestamp", int32)
  created_at: utcDateTime;

  @doc("The object type, which is always 'skill.version'.")
  object: "skill.version";
}

alias CreateSkillVersionRequest = {
  @doc("The name of the skill. If the skill does not exist, it will be created.")
  @path
  @maxLength(63)
  name: string;

  @doc("Skill files to upload as a zip package.")
  files: bytes;

  @doc("A human-readable description of the skill version.")
  @maxLength(1024)
  description?: string;

  @doc("Whether to set this version as the default.")
  default?: boolean;
};

alias GetSkillVersionRequest = {
  @doc("The name of the skill.")
  @path
  name: string;

  @doc("The version identifier to retrieve.")
  @path
  version: string;
};

alias ListSkillVersionsRequest = {
  @doc("The name of the skill to list versions for.")
  @path
  name: string;

  ...CommonPageQueryParameters;
};

alias GetSkillContentRequest = {
  @doc("The name of the skill.")
  @path
  name: string;
};

alias GetSkillVersionContentRequest = {
  @doc("The name of the skill.")
  @path
  name: string;

  @doc("The version to download content for.")
  @path
  version: string;
};

model UpdateSkillDefaultVersionRequest {
  @doc("The name of the skill to update.")
  @path
  name: string;

  @doc("The version identifier that the skill should point to. When set, the skill's default version will resolve to this version instead of the latest.")
  default_version: string;
}

alias DeleteSkillVersionRequest = {
  @doc("The name of the skill.")
  @path
  name: string;

  @doc("The version identifier to delete.")
  @path
  version: string;
};

@doc("A deleted skill.")
model DeleteSkillResponse {
  @doc("The unique name of the skill.")
  name: string;

  @doc("Whether the skill was successfully deleted.")
  deleted: boolean;
}

@doc("The response body for downloading a skill package.")
model DownloadSkillResponse {
  @doc("The media type of the returned package content.")
  @header("Content-Type")
  content_type: "application/zip";

  @doc("The zip skill package content.")
  @body
  content: bytes;
}
