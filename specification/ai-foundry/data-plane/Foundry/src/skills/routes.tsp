import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

alias SkillsPreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.skills_v1_preview>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@tag("Skills")
interface Skills {
  /**
   * Retrieves the specified skill and its current configuration.
   */
  @summary("Retrieve a skill")
  @get
  @route("/skills/{name}")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  getSkill is FoundryDataPlaneOperation<
    GetSkillRequest & SkillsPreviewHeader,
    Skill
  >;

  /**
   * Returns the skills available in the current project.
   */
  @summary("List skills")
  @route("/skills")
  @list
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  listSkills is FoundryDataPlaneOperation<
    ListSkillsRequest & SkillsPreviewHeader,
    AgentsPagedResult<Skill>
  >;

  /**
   * Modifies the specified skill's configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @summary("Update a skill")
  @operationId("updateSkill")
  @post
  @route("/skills/{name}")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  updateSkill is FoundryDataPlaneOperation<
    UpdateSkillRequest & SkillsPreviewHeader,
    Skill
  >;

  /**
   * Removes the specified skill and its associated versions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" ""
  @summary("Delete a skill")
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
  @summary("Create a new version of a skill")
  @operationId("createSkillVersion")
  @post
  @route("/skills/{name}/versions")
  @sharedRoute
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  @extension("x-ms-summary-override", "Create a new version of a skill")
  @extension(
    "x-ms-description-override",
    "Creates a new version of a skill. If the skill does not exist, it will be created."
  )
  createSkillVersion is FoundryDataPlaneOperation<
    CreateSkillVersionRequest & SkillsPreviewHeader,
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
   * Returns the available versions for the specified skill.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @summary("List skill versions")
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
   * Retrieves the specified version of a skill by name and version identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @summary("Retrieve a specific version of a skill")
  @operationId("getSkillVersion")
  @get
  @route("/skills/{name}/versions/{version}")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  getSkillVersion is FoundryDataPlaneOperation<
    GetSkillVersionRequest & SkillsPreviewHeader,
    SkillVersion
  >;

  /**
   * Downloads the zip content for the default version of a skill.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @summary("Download the zip content for the default version of a skill")
  @operationId("getSkillContent")
  @get
  @route("/skills/{name}/content")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  getSkillContent is FoundryDataPlaneOperation<
    GetSkillContentRequest & SkillsPreviewHeader,
    DownloadSkillResponse
  >;

  /**
   * Downloads the zip content for a specific version of a skill.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @summary("Download the zip content for a specific version of a skill")
  @operationId("getSkillVersionContent")
  @get
  @route("/skills/{name}/versions/{version}/content")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  getSkillVersionContent is FoundryDataPlaneOperation<
    GetSkillVersionContentRequest & SkillsPreviewHeader,
    DownloadSkillResponse
  >;

  /**
   * Removes the specified version of a skill.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @summary("Delete a specific version of a skill")
  @operationId("deleteSkillVersion")
  @delete
  @route("/skills/{name}/versions/{version}")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  deleteSkillVersion is FoundryDataPlaneOperation<
    DeleteSkillVersionRequest & SkillsPreviewHeader,
    DeleteSkillVersionResponse
  >;
}
