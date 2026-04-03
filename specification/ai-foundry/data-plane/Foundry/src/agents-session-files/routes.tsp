import "../common/models.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

/**
 * Session-scoped file operations for hosted agent sandboxes.
 *
 * These endpoints enable uploading, downloading, listing, and deleting
 * files within a live ADC sandbox session. All file content is streamed
 * end-to-end (no buffering in Agents service memory).
 *
 * Sessions are scoped to agents (not versions), giving optionality to
 * mutate the associated agent version independently of the session lifecycle.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@tag("Agent Session Files")
interface AgentSessionFiles {
  /**
   * Upload a file to the session sandbox via binary stream.
   * Maximum file size is 50 MB. Uploads exceeding this limit return 413 Payload Too Large.
   */
  #suppress "@azure-tools/typespec-azure-core/byos" "The file is targeting the per-session files mounted to a foundry agent"
  @put
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/files/content")
  @extension(
    "x-ms-foundry-meta",
    #{ required_previews: #[AgentDefinitionOptInKeys.hosted_agents_v1_preview] }
  )
  uploadSessionFile is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.hosted_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The session ID. */
      @path session_id: string;

      /** The destination file path within the sandbox, relative to the session home directory. */
      @query path: string;

      /** The binary file content to upload. */
      @header("Content-Type") contentType: "application/octet-stream";

      @body content: bytes;
    },
    SessionFileWriteResponse
  >;

  /**
   * Download a file from the session sandbox as a binary stream.
   */
  @get
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/files/content")
  @extension(
    "x-ms-foundry-meta",
    #{ required_previews: #[AgentDefinitionOptInKeys.hosted_agents_v1_preview] }
  )
  downloadSessionFile is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.hosted_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The session ID. */
      @path session_id: string;

      /** The file path to download from the sandbox, relative to the session home directory. */
      @query path: string;
    },
    bytes
  >;

  /**
   * List files and directories at a given path in the session sandbox.
   * Returns only the immediate children of the specified directory (non-recursive).
   */
  @get
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/files")
  @extension(
    "x-ms-foundry-meta",
    #{ required_previews: #[AgentDefinitionOptInKeys.hosted_agents_v1_preview] }
  )
  listSessionFiles is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.hosted_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The session ID. */
      @path session_id: string;

      /** The directory path to list, relative to the session home directory. */
      @query path: string;
    },
    SessionDirectoryListResponse
  >;

  /**
   * Delete a file or directory from the session sandbox.
   * If `recursive` is false (default) and the target is a non-empty directory, the API returns 409 Conflict.
   */
  @delete
  @route("/agents/{agent_name}/endpoint/sessions/{session_id}/files")
  @extension(
    "x-ms-foundry-meta",
    #{ required_previews: #[AgentDefinitionOptInKeys.hosted_agents_v1_preview] }
  )
  deleteSessionFile is FoundryDataPlanePreviewOperation<
    AgentDefinitionOptInKeys.hosted_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The session ID. */
      @path session_id: string;

      /** The file or directory path to delete, relative to the session home directory. */
      @query path: string;

      /** Whether to recursively delete directory contents. Defaults to false. */
      @query recursive?: boolean = false;
    },
    void
  >;
}
