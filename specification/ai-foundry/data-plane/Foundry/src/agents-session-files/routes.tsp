import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "../agents/managed-models.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

/**
 * Session-scoped file operations shared by Hosted and Managed agent sandboxes.
 *
 * These endpoints enable uploading, downloading, listing, and deleting
 * files within a Session workspace. Hosted retains its existing ADC sandbox behavior.
 * Managed uses the service-generated Session ID, the ManagedAgents preview opt-in,
 * existing endpoint interact/action authorization, and Session creator isolation.
 * An available Managed Environment is required; these operations do not create a
 * standalone Environment or Vault, and POST events does not upload file bytes.
 * All file content is streamed
 * end-to-end (no buffering in Agents service memory).
 *
 * Sessions are scoped to agent endpoints (not individual versions), allowing
 * the endpoint to evolve the backing agent version independently of the session lifecycle.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@tag("Agent Session Files")
interface AgentSessionFiles {
  /**
   * Uploads binary file content to the specified path in the session sandbox.
   * The service stores the file relative to the session home directory and rejects payloads larger than 50 MB.
   */
  #suppress "@azure-tools/typespec-azure-core/byos" "The file is targeting the per-session files mounted to a foundry agent"
  @summary("Upload a session file")
  @put
  @route("/agents/{agent_name}/endpoint/sessions/{agent_session_id}/files/content")
  @extension("x-ms-foundry-meta", ManagedAgentsConditionalPreviews)
  uploadSessionFile is FoundryDataPlaneOperation<
    {
      ...WithConditionalFoundryPreviewHeader<AgentDefinitionOptInKeys.managed_agents_v1_preview>;
      ...UploadSessionFileParams;
    },
    ResourceCreatedResponse<SessionFileWriteResponse>
  >;

  /**
   * Downloads the file at the specified sandbox path as a binary stream.
   * The path is resolved relative to the session home directory.
   */
  @summary("Download a session file")
  @get
  @route("/agents/{agent_name}/endpoint/sessions/{agent_session_id}/files/content")
  @extension("x-ms-foundry-meta", ManagedAgentsConditionalPreviews)
  downloadSessionFile is FoundryDataPlaneOperation<
    {
      ...WithConditionalFoundryPreviewHeader<AgentDefinitionOptInKeys.managed_agents_v1_preview>;
      ...DownloadSessionFileParams;
    },
    bytes
  >;

  /**
   * Returns files and directories at the specified path in the session sandbox.
   * The response includes only the immediate children of the target directory and defaults to the session home directory when no path is supplied.
   */
  @summary("List session files")
  @get
  @list
  @route("/agents/{agent_name}/endpoint/sessions/{agent_session_id}/files")
  @extension("x-ms-foundry-meta", ManagedAgentsConditionalPreviews)
  listSessionFiles is FoundryDataPlaneOperation<
    {
      ...WithConditionalFoundryPreviewHeader<AgentDefinitionOptInKeys.managed_agents_v1_preview>;
      ...ListSessionFilesParams;
      ...CommonPageQueryParameters;
    },
    SessionDirectoryListResponse
  >;

  /**
   * Deletes the specified file or directory from the session sandbox.
   * When `recursive` is false, deleting a non-empty directory returns 409 Conflict.
   */
  @summary("Delete a session file")
  @delete
  @route("/agents/{agent_name}/endpoint/sessions/{agent_session_id}/files")
  @extension("x-ms-foundry-meta", ManagedAgentsConditionalPreviews)
  deleteSessionFile is FoundryDataPlaneOperation<
    {
      ...WithConditionalFoundryPreviewHeader<AgentDefinitionOptInKeys.managed_agents_v1_preview>;
      ...DeleteSessionFileParams;
    },
    void
  >;
}
