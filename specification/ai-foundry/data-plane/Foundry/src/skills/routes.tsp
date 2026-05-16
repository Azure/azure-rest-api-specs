import "../common/models.tsp";
import "../servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects;

@@usage(UpdateSkillDefaultVersionRequest, Usage.input);
@@access(UpdateSkillDefaultVersionRequest, Access.public);

alias SkillsPreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.skills_v1_preview>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@tag("Skills")
interface Skills {
  /**
   * Creates a skill.
   */
  @post
  @route("/skills")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  createSkill is FoundryDataPlaneOperation<
    CreateSkillRequest & SkillsPreviewHeader,
    ResourceCreatedResponse<SkillObject>
  >;

  /**
   * Creates a skill from a zip package.
   */
  @post
  @route("/skills:import")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  createSkillFromPackage is FoundryDataPlaneOperation<
    CreateSkillFromPackageRequest & SkillsPreviewHeader,
    ResourceCreatedResponse<SkillObject>
  >;

  /**
   * Retrieves a skill.
   */
  @get
  @route("/skills/{name}")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  getSkill is FoundryDataPlaneOperation<
    GetSkillRequest & SkillsPreviewHeader,
    SkillObject
  >;

  /**
   * Downloads a skill package.
   */
  @get
  @route("/skills/{name}:download")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  downloadSkill is FoundryDataPlaneOperation<
    DownloadSkillRequest & SkillsPreviewHeader,
    DownloadSkillResponse
  >;

  /**
   * Returns the list of all skills.
   */
  @route("/skills")
  @list
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  listSkills is FoundryDataPlaneOperation<
    ListSkillsRequest & SkillsPreviewHeader,
    AgentsPagedResult<SkillObject>
  >;

  /**
   * Updates an existing skill.
   */
  @post
  @route("/skills/{name}")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  updateSkill is FoundryDataPlaneOperation<
    UpdateSkillRequest & SkillsPreviewHeader,
    SkillObject
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
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  createSkillVersion is FoundryDataPlaneOperation<
    CreateSkillVersionRequest & SkillsPreviewHeader,
    SkillVersionObject
  >;

  /**
   * Creates a new version of a skill from a zip package. If the skill does not exist, it will be created.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @operationId("createSkillVersionFromPackage")
  @post
  @route("/skills/{name}/versions:import")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  createSkillVersionFromPackage is FoundryDataPlaneOperation<
    CreateSkillVersionFromPackageRequest & SkillsPreviewHeader,
    SkillVersionObject
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
    AgentsPagedResult<SkillVersionObject>
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
    SkillVersionObject
  >;

  /**
   * Downloads the zip package for a specific version of a skill.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @operationId("downloadSkillVersion")
  @get
  @route("/skills/{name}/versions/{version}:download")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  downloadSkillVersion is FoundryDataPlaneOperation<
    DownloadSkillVersionRequest & SkillsPreviewHeader,
    DownloadSkillResponse
  >;

  /**
   * Update a skill to point to a specific version.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @operationId("updateSkillDefaultVersion")
  @patch
  @route("/skills/{name}")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  updateSkillDefaultVersion is FoundryDataPlaneOperation<
    UpdateSkillDefaultVersionRequest & SkillsPreviewHeader,
    SkillObject
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
    void
  >;
}
