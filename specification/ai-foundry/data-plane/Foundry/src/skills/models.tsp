using TypeSpec.Http;

namespace Azure.AI.Projects;

const SkillsRequiredPreviews = #{
  conditional_previews: #[FoundryFeaturesOptInKeys.skills_v1_preview],
};

alias CreateSkillRequest = {
  @doc("The unique name of the skill.")
  @maxLength(63)
  name: string;

  @doc("A human-readable description of the skill.")
  @maxLength(1024)
  description?: string;

  @doc("Instructions that define the behavior of the skill.")
  @maxLength(102400)
  instructions?: string;

  ...MetadataPropertyForRequest;
};

alias CreateSkillFromPackageRequest = {
  @doc("The content type of the incoming skill package payload.")
  @header("Content-Type")
  content_type: "application/zip";

  @doc("The zip package used to create the skill.")
  @body
  content: bytes;
};

alias UpdateSkillRequest = {
  @doc("The unique name of the skill.")
  @path
  name: string;

  @doc("A human-readable description of the skill.")
  @maxLength(1024)
  description?: string;

  @doc("Instructions that define the behavior of the skill.")
  @maxLength(102400)
  instructions?: string;

  ...MetadataPropertyForRequest;
};

alias GetSkillRequest = {
  @doc("The unique name of the skill.")
  @path
  name: string;
};

alias DownloadSkillRequest = {
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

@doc("A skill object.")
model SkillObject {
  @doc("The unique identifier of the skill.")
  skill_id: string;

  @doc("Whether the skill was created from a zip blob package.")
  has_blob: boolean;

  @doc("The unique name of the skill.")
  @maxLength(63)
  name: string;

  @doc("A human-readable description of the skill.")
  @maxLength(1024)
  description?: string;

  @doc("The version identifier that the skill currently points to. Defaults to the latest version. Can be changed via updateSkillDefaultVersion.")
  default_version?: string;

  ...MetadataPropertyForRequest;
}

@doc("A specific version of a skill.")
model SkillVersionObject {
  ...MetadataPropertyForResponse;

  @doc("The unique identifier of the skill version.")
  id: string;

  @doc("The name of the skill.")
  @maxLength(63)
  name: string;

  @doc("The version identifier of the skill. Skill versions are immutable and every update creates a new version.")
  version: string;

  @doc("A human-readable description of the skill.")
  @maxLength(1024)
  description?: string;

  @doc("Instructions that define the behavior of the skill.")
  @maxLength(102400)
  instructions?: string;

  @doc("Whether the skill version was created from a zip blob package.")
  has_blob: boolean;

  @doc("The Unix timestamp (seconds) when the skill version was created.")
  @encode("unixTimestamp", int32)
  created_at: utcDateTime;
}

alias CreateSkillVersionRequest = {
  @doc("The name of the skill. If the skill does not exist, it will be created.")
  @path
  @maxLength(63)
  name: string;

  @doc("A human-readable description of the skill.")
  @maxLength(1024)
  description?: string;

  @doc("Instructions that define the behavior of the skill.")
  @maxLength(102400)
  instructions?: string;

  ...MetadataPropertyForRequest;
};

alias CreateSkillVersionFromPackageRequest = {
  @doc("The name of the skill. If the skill does not exist, it will be created.")
  @path
  @maxLength(63)
  name: string;

  @doc("The content type of the incoming skill package payload.")
  @header("Content-Type")
  content_type: "application/zip";

  @doc("The zip package used to create the skill version.")
  @body
  content: bytes;
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

alias DownloadSkillVersionRequest = {
  @doc("The name of the skill.")
  @path
  name: string;

  @doc("The version identifier to download.")
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

@doc("A deleted skill Object")
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
