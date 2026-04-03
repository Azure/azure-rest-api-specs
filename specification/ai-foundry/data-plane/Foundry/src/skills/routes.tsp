import "../common/models.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

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
   * Creates a skill from a gzip package.
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
  @route("/skills/{skill_name}")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  getSkill is FoundryDataPlaneOperation<
    GetSkillRequest & SkillsPreviewHeader,
    SkillObject
  >;

  /**
   * Downloads a skill package.
   */
  @get
  @route("/skills/{skill_name}:download")
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
  @route("/skills/{skill_name}")
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
  @route("/skills/{skill_name}")
  @extension("x-ms-foundry-meta", SkillsRequiredPreviews)
  deleteSkill is FoundryDataPlaneOperation<
    DeleteSkillRequest & SkillsPreviewHeader,
    DeleteSkillResponse
  >;
}
