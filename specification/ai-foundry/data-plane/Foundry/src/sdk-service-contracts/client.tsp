import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-core/experimental";
import "@azure-tools/openai-typespec/views/client-emitters/models/responses";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core.Experimental;

#suppress "@azure-tools/typespec-azure-core/experimental-feature" ""
@clientNamespace("Azure.AI.Agents.Contracts.V2")
namespace Azure.AI.Projects {
  union _AdditionalToolTypes {
    remote_tool: "remote_tool",
  }
  @@copyVariants(OpenAI.ToolType, _AdditionalToolTypes);

  model RemoteToolArgument {
    /** The name of the remote tool. */
    name?: string;

    /** The description of the remote tool. */
    description?: string;

    /** The arguments for the remote tool. */
    arguments?: {
      connection_id?: string;
      knowledge_sources?: {
        connection_id?: string;
        query_parameters?: Record<string>;
        index_id?: string;
        index_connection_id?: string;
        index_details?: {
          index_configuration?: {
            index_name?: string;
          };
        };
        ...Record<unknown>;
      }[];
      ...Record<unknown>;
    };
  }

  model RemoteTool extends OpenAI.Tool {
    type: "remote_tool";
    tool_arguments?: RemoteToolArgument[];
  }

  union _AdditionalOutputItemTypes {
    remote_tool: "remote_tool",
  }

  @@copyVariants(OpenAI.OutputItemType, _AdditionalOutputItemTypes);

  model OutputItemRemoteToolCall extends OpenAI.OutputItem {
    type: "remote_tool";
  }

  union _AdditionalToolChoiceParamTypes {
    remote_tool: "remote_tool",
  }

  @@copyVariants(OpenAI.ToolChoiceParamType, _AdditionalToolChoiceParamTypes);

  model RemoteToolChoiceParam extends OpenAI.ToolChoiceParam {
    type: "remote_tool";

    /** Name of the tool in the remote tool server to use. */
    name: string;
  }

  @@copyProperties(OpenAI.CreateResponse,
    {
      rai_config?: string,
      internal_metadata?: {
        feature_flags?: string[],
        web_search?: {
          custom_search_config_id?: string,
          custom_search_resource_id?: string,
        },
        `user-context`?: {
          `request-id`?: string,
          oid?: string,
          tid?: string,
          appid?: string,
          `auth-type`?: string,
          `token-type`?: string,
          upn: string,
          `user-agent`?: string,
          `ms-user-agent`?: string,
          ...Record<string>,
        },
        `response-context`?: {
          `agent-name`?: string,
          `agent-version`?: string,
          `agent-version-id`?: string,
          `agent-kind`?: string,
          `model`?: string,
          `top-p`?: string,
          temperature?: string,
          tools?: {
            `tool-name`?: string,
            `tool-type`?: string,
          }[],
          `reasoning-summary`?: string,
          `max-tool-calls`?: string,
          `parallel-tool-calls`?: boolean,
          `max-output-tokens`?: int32,
          `previous-response-id`?: string,
          `agent-version-created-at`?: utcDateTime,
          `agent-version-description`?: string,
          `hosted-agent-image`?: string,
          ...Record<string>,
        },
        `application-context`?: {
          `resource-id`?: string,
          `subscription-id`?: string,
          `tenant-id`?: string,
          region?: string,
          `creation-date`?: utcDateTime,
          `user-isolation-key`?: string,
          `chat-isolation-key`?: string,
          `application-id`?: string,
        },
        `defender-for-ai-context`?: {
          enabled?: boolean,
        },
      },
      resolved_agent_version?: AgentVersionObject,
    }
  );

  model InternalServiceMemorySearchTool extends MemorySearchTool {
    memory_store_id?: string;
    chat_summary_enabled?: boolean;
    user_profile_enabled?: boolean;
    user_profile_details?: string;
    chat_model?: string;
    embedding_model?: string;
  }

  // Propagate "id" to base of output items, not every union variant
  @@copyProperties(OpenAI.OutputItem,
    {
      id?: string,
    }
  );

  // To avoid conflicts with Azure.Response
  @@clientName(OpenAI.Response, "ResponseObject");

  // Remove created_by from specific models to avoid and facilitate base union
  @@withoutOmittedProperties(OpenAI.OutputItemFunctionShellCallOutput,
    "created_by"
  );
  @@withoutOmittedProperties(OpenAI.OutputItemFunctionShellCall, "created_by");
  @@withoutOmittedProperties(OpenAI.OutputItemCompactionBody, "created_by");
  @@withoutOmittedProperties(OpenAI.OutputItemApplyPatchToolCallOutput,
    "created_by"
  );
  @@withoutOmittedProperties(OpenAI.OutputItemApplyPatchToolCall, "created_by");
}
