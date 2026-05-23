import "../common/models.tsp";
import "../servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

alias SkillsPreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.skills_v1_preview>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@tag("Skills")
interface Skills {
  /**
   * Retrieves a skill.
   */
  @get
  @route("/skills/{name}")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  getSkill is FoundryDataPlaneOperation<
    GetSkillRequest & SkillsPreviewHeader,
    Skill
  >;

  /**
   * Returns the list of all skills.
   */
  @route("/skills")
  @list
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  listSkills is FoundryDataPlaneOperation<
    ListSkillsRequest & SkillsPreviewHeader,
    AgentsPagedResult<Skill>
  >;

  /**
   * Update a skill.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @operationId("updateSkill")
  @post
  @route("/skills/{name}")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  updateSkill is FoundryDataPlaneOperation<
    UpdateSkillRequest & SkillsPreviewHeader,
    Skill
  >;

  /**
   * Deletes a skill.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" ""
  @delete
  @route("/skills/{name}")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  deleteSkill is FoundryDataPlaneOperation<
    DeleteSkillRequest & SkillsPreviewHeader,
    DeleteSkillResponse
  >;

  // ── Versioned Skill Operations ────────────────────────

  /**
   * Creates a new version of a skill. If the skill does not exist, it will be created.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @operationId("createSkillVersion")
  @post
  @route("/skills/{name}/versions")
  @sharedRoute
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  createSkillVersion is FoundryDataPlaneOperation<
    CreateSkillVersionRequest & SkillsPreviewHeader,
    SkillVersion
  >;

  /**
   * Creates a new version of a skill from uploaded files via multipart form data.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  #suppress "@azure-tools/typespec-azure-core/byos" "Skill file upload uses multipart form data"
  @operationId("createSkillVersionFromFiles")
  @post
  @route("/skills/{name}/versions")
  @sharedRoute
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  createSkillVersionFromFiles is FoundryDataPlaneOperation<
    {
      @doc("The name of the skill.")
      @path
      name: SkillName;

      @header contentType: "multipart/form-data";
      @multipartBody content: CreateSkillVersionFromFilesBody;
    } & SkillsPreviewHeader,
    SkillVersion
  >;

  /**
   * List all versions of a skill.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @operationId("listSkillVersions")
  @get
  @list
  @route("/skills/{name}/versions")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  listSkillVersions is FoundryDataPlaneOperation<
    ListSkillVersionsRequest & SkillsPreviewHeader,
    AgentsPagedResult<SkillVersion>
  >;

  /**
   * Retrieve a specific version of a skill.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @operationId("getSkillVersion")
  @get
  @route("/skills/{name}/versions/{version}")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  getSkillVersion is FoundryDataPlaneOperation<
    GetSkillVersionRequest & SkillsPreviewHeader,
    SkillVersion
  >;

  /**
   * Download the zip content for the default version of a skill.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @operationId("getSkillContent")
  @get
  @route("/skills/{name}/content")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  getSkillContent is FoundryDataPlaneOperation<
    GetSkillContentRequest & SkillsPreviewHeader,
    DownloadSkillResponse
  >;

  /**
   * Download the zip content for a specific version of a skill.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @operationId("getSkillVersionContent")
  @get
  @route("/skills/{name}/versions/{version}/content")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  getSkillVersionContent is FoundryDataPlaneOperation<
    GetSkillVersionContentRequest & SkillsPreviewHeader,
    DownloadSkillResponse
  >;

  /**
   * Delete a specific version of a skill.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @operationId("deleteSkillVersion")
  @delete
  @route("/skills/{name}/versions/{version}")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  deleteSkillVersion is FoundryDataPlaneOperation<
    DeleteSkillVersionRequest & SkillsPreviewHeader,
    DeleteSkillVersionResponse
  >;
}
