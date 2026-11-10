import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Skills use OpenAI path versioning."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Skills follow the OpenAI API contract."
@tag("Skills")
interface Skills {
  /**
   * Retrieves the specified skill and its current configuration.
   */
  @summary("Retrieve a skill")
  @get
  @route("/openai/v1/skills/{name}")
  getSkill is OpenAIOperation<GetSkillRequest, Skill>;

  /**
   * Returns the skills available in the current project.
   */
  @summary("List skills")
  @route("/openai/v1/skills")
  @list
  listSkills is OpenAIOperation<ListSkillsRequest, AgentsPagedResult<Skill>>;

  /**
   * Modifies the specified skill's configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @summary("Update a skill")
  @operationId("updateSkill")
  @post
  @route("/openai/v1/skills/{name}")
  updateSkill is OpenAIOperation<UpdateSkillRequest, Skill>;

  /**
   * Removes the specified skill and its associated versions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-types" "Type kept for backward compatibility"
  @summary("Delete a skill")
  @delete
  @route("/openai/v1/skills/{name}")
  deleteSkill is OpenAIOperation<DeleteSkillRequest, DeleteSkillResponse>;

  // ── Versioned Skill Operations ────────────────────────

  /**
   * Creates a new version of a skill. If the skill does not exist, it will be created.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @summary("Create a new version of a skill")
  @operationId("createSkillVersion")
  @post
  @route("/openai/v1/skills/{name}/versions")
  @sharedRoute
  @extension("x-ms-summary-override", "Create a new version of a skill")
  @extension(
    "x-ms-description-override",
    "Creates a new version of a skill. If the skill does not exist, it will be created."
  )
  createSkillVersion is OpenAIOperation<
    CreateSkillVersionRequest,
    SkillVersion
  >;

  /**
   * Creates a new version of a skill from uploaded files via multipart form data.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  #suppress "@azure-tools/typespec-azure-core/byos" "Skill file upload uses multipart form data"
  @summary("Create a skill version from uploaded files")
  @operationId("createSkillVersionFromFiles")
  @post
  @route("/openai/v1/skills/{name}/versions")
  @sharedRoute
  createSkillVersionFromFiles is OpenAIOperation<
    {
      @doc("The public ID of an existing skill, or the skill name when creating a new skill.")
      @path
      name: SkillIdentifier;

      /** The content type of the request body. */
      @header contentType: "multipart/form-data";

      /** The multipart request content. */
      @multipartBody content: CreateSkillVersionFromFilesBody;
    },
    SkillVersion
  >;

  /**
   * Returns the available versions for the specified skill.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @summary("List skill versions")
  @operationId("listSkillVersions")
  @get
  @list
  @route("/openai/v1/skills/{name}/versions")
  listSkillVersions is OpenAIOperation<
    ListSkillVersionsRequest,
    AgentsPagedResult<SkillVersion>
  >;

  /**
   * Retrieves the specified version of a skill by public ID and version identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @summary("Retrieve a specific version of a skill")
  @operationId("getSkillVersion")
  @get
  @route("/openai/v1/skills/{name}/versions/{version}")
  getSkillVersion is OpenAIOperation<GetSkillVersionRequest, SkillVersion>;

  /**
   * Downloads the zip content for the default version of a skill.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @summary("Download the zip content for the default version of a skill")
  @operationId("getSkillContent")
  @get
  @route("/openai/v1/skills/{name}/content")
  getSkillContent is OpenAIOperation<
    GetSkillContentRequest,
    DownloadSkillResponse
  >;

  /**
   * Downloads the zip content for a specific version of a skill.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @summary("Download the zip content for a specific version of a skill")
  @operationId("getSkillVersionContent")
  @get
  @route("/openai/v1/skills/{name}/versions/{version}/content")
  getSkillVersionContent is OpenAIOperation<
    GetSkillVersionContentRequest,
    DownloadSkillResponse
  >;

  /**
   * Removes the specified version of a skill.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @summary("Delete a specific version of a skill")
  @operationId("deleteSkillVersion")
  @delete
  @route("/openai/v1/skills/{name}/versions/{version}")
  deleteSkillVersion is OpenAIOperation<
    DeleteSkillVersionRequest,
    DeleteSkillVersionResponse
  >;
}
