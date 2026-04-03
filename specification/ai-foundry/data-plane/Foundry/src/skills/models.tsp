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
  content_type: "application/gzip";

  @doc("The gzip package used to create the skill.")
  @body
  body: bytes;
};

alias UpdateSkillRequest = {
  @doc("The unique name of the skill.")
  @path
  skill_name: string;

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
  skill_name: string;
};

alias DownloadSkillRequest = {
  @doc("The unique name of the skill.")
  @path
  skill_name: string;
};

alias ListSkillsRequest = {
  ...CommonPageQueryParameters;
};

alias DeleteSkillRequest = {
  @doc("The unique name of the skill.")
  @path
  skill_name: string;
};

@doc("A skill object.")
model SkillObject {
  @doc("The unique identifier of the skill.")
  skill_id: string;

  @doc("Whether the skill was created from a gzip blob package.")
  has_blob: boolean;

  @doc("The unique name of the skill.")
  @maxLength(63)
  name: string;

  @doc("A human-readable description of the skill.")
  @maxLength(1024)
  description?: string;

  ...MetadataPropertyForRequest;
}

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
  content_type: "application/gzip";

  @doc("The gzip skill package content.")
  @body
  body: bytes;
}
