import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

/**
 * Operations for publishing a Foundry agent to Microsoft 365 / Microsoft Teams.
 *
 * These operations generate and publish a Microsoft Teams app for an existing Foundry agent. The
 * agent is identified by `agent_name` in the route and resolved server-side; the caller must have
 * write access to the agent's workspace.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@tag("Agent Microsoft 365 Publishing")
interface Microsoft365Publishing {
  /**
   * Publishes a Foundry agent to Microsoft 365 / Microsoft Teams and returns the published title and
   * Teams app ids.
   */
  @summary("Publish an agent to Microsoft 365")
  @post
  @route("/agents/{agent_name}/microsoft365/publish")
  publishAgentToMicrosoft365 is FoundryDataPlaneOperation<
    {
      /** The name of the agent to publish. */
      @path agent_name: string;

      ...Microsoft365PublishRequest;
    },
    Microsoft365PublishResponse
  >;

  /**
   * Generates the Microsoft Teams app package (zip) for a Foundry agent from the supplied publish
   * request, without publishing it. Returns the app package as `application/zip`.
   */
  #suppress "@azure-tools/typespec-azure-core/byos" "The app package is generated and returned inline, not stored."
  @summary("Generate a Microsoft 365 app package")
  @post
  @route("/agents/{agent_name}/microsoft365/zip")
  getMicrosoft365AppPackage is FoundryDataPlaneOperation<
    {
      /** The name of the agent to generate the app package for. */
      @path agent_name: string;

      ...Microsoft365PublishRequest;
    },
    Microsoft365AppPackageResponse
  >;

  /**
   * Returns default and previously-published values used to pre-populate a Microsoft 365 publish
   * request for a Foundry agent.
   */
  @summary("Get Microsoft 365 publish defaults")
  @get
  @route("/agents/{agent_name}/microsoft365/publishdefaults")
  getMicrosoft365PublishDefaults is FoundryDataPlaneOperation<
    {
      /** The name of the agent to get publish defaults for. */
      @path agent_name: string;

      /**
       * When true, returns defaults for publishing the agent as an autopilot (digital worker) agent.
       */
      @query publishAsDigitalWorker?: boolean = false;
    },
    Microsoft365PublishDefaults
  >;
}
