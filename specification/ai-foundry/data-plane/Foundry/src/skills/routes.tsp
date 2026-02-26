import "../common/models.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@tag("Skills")
interface Skills {
  /**
   * Creates a skill.
   */
  @post
  @route("/skills")
  createSkill is FoundryDataPlaneOperation<
    {
      ...CreateSkillRequest;
    },
    SkillObject
  >;

  /**
   * Creates a skill from a GZip package.
   */
  @post
  @route("/skills:import")
  createSkillFromPackage is FoundryDataPlaneOperation<
    {
      ...CreateSkillFromPackageRequest;
    },
    SkillObject
  >;

  /**
   * Retrieves a skill.
   */
  @get
  @route("/skills/{skill_name}")
  getSkill is FoundryDataPlaneOperation<
    {
      /** The unique name of the skill. */
      @path skill_name: string;
    },
    SkillObject
  >;

  /**
   * Downloads a skill package.
   */
  @get
  @route("/skills/{skill_name}:download")
  downloadSkill is FoundryDataPlaneOperation<
    {
      /** The unique name of the skill. */
      @path skill_name: string;
    },
    DownloadSkillResponse
  >;

  /**
   * Returns the list of all skills.
   */
  @route("/skills")
  @list
  listSkills is FoundryDataPlaneOperation<
    {
      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<SkillObject>
  >;

  /**
   * Updates an existing skill.
   */
  @post
  @route("/skills/{skill_name}")
  updateSkill is FoundryDataPlaneOperation<
    {
      /** The unique name of the skill. */
      @path skill_name: string;

      ...UpdateSkillRequest;
    },
    SkillObject
  >;

  /**
   * Deletes a skill.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" ""
  @delete
  @route("/skills/{skill_name}")
  deleteSkill is FoundryDataPlaneOperation<
    {
      /** The unique name of the skill. */
      @path skill_name: string;
    },
    DeleteSkillResponse
  >;
}
