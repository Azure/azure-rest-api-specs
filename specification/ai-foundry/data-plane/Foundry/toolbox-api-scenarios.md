# Toolbox API Scenarios

## Overview

The Toolbox API enables teams to package, version, and share tool collections as MCP servers. This document covers three primary scenarios:

1. **Developer consumption** — Using the default project toolbox to access all Foundry tools without any CRUD operations
2. **Publishing external MCP** — How a team publishes and versions an MCP server for consumption by external teams
3. **Toolbox administration** — CRUD operations, traffic routing, version management, and RBAC

### Key Concepts

- **Default toolbox**: Every Foundry project has a built-in `default` toolbox that exposes all project-configured tools (Web Search, Azure AI Search, Code Interpreter, etc.) via a single MCP endpoint
- **Custom toolboxes**: Teams can create named toolboxes with specific tool definitions for sharing
- **Versioning**: Each toolbox update creates an immutable version; MCP endpoints can point to `latest` or a pinned version
- **RBAC**: Role-based access control determines who can read, write, or administer toolboxes

### MCP Endpoints

| URL Pattern | Behavior |
|-------------|----------|
| `https://<project-endpoint>/mcp` | Default project toolbox (all Foundry tools) |
| `https://<project-endpoint>/toolboxes/<name>/mcp` | Custom toolbox — serves `default_version` if set, otherwise **latest** |
| `https://<project-endpoint>/toolboxes/<name>/versions/<version>/mcp` | Custom toolbox, **pinned** version |

---

## Scenario 1: Developer Consumption via Default Toolbox

**Use case:** A developer builds an agent that connects to the project's default MCP endpoint. Tool configurations are passed at invocation time to control tool behavior (e.g., which index to search, query type, connection IDs). The model provides arguments; the developer controls configuration. No toolbox CRUD is required.

### Generic MCP Tool Invocation with Tool Configuration

When calling MCP tools, the developer can pass `tool_configuration` alongside model-provided arguments. This separates user/model input from developer-controlled settings:

```python
import os
import requests
from typing import Any, Dict, List, Optional


MCP_ENDPOINT = f"https://{os.environ['PROJECT_ENDPOINT']}/mcp"


def find_tool_config(tool_name: str, tool_configs: List[Dict[str, Any]]) -> Optional[Dict[str, Any]]:
    """Find the configuration for a specific tool by name."""
    for config in tool_configs:
        if config.get("tool_name") == tool_name:
            return config.get("tool_configuration")
    return None


def call_mcp_tool(
    tool_name: str,
    arguments: Dict[str, Any],
    tool_configs: List[Dict[str, Any]]
) -> Dict[str, Any]:
    """
    Call MCP server's tools/call endpoint with separate tool_configuration in params.
    
    Args:
        tool_name: Name of the MCP tool to invoke
        arguments: Model-provided arguments (e.g., query text, user input)
        tool_configs: Developer-defined configurations (e.g., index names, connection IDs)
    
    Returns:
        Tool execution result from MCP server
    """
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {os.environ['FOUNDRY_AUTH_TOKEN']}"
    }
    
    # Find the relevant tool configuration
    tool_configuration = find_tool_config(tool_name, tool_configs)
    
    # Merge model arguments with developer configuration
    merged_arguments = {
        **arguments,                              # Model-provided arguments
        "tool_configuration": tool_configuration  # Developer-controlled configuration
    }
    
    payload = {
        "jsonrpc": "2.0",
        "id": 1,
        "method": "tools/call",
        "params": {
            "name": tool_name,
            "arguments": merged_arguments
        }
    }
    
    response = requests.post(MCP_ENDPOINT, json=payload, headers=headers)
    return response.json()["result"]
```

### Define Tool Configurations per Request

```python
# --- Configuration for knowledge base search ---
kb_tool_configs = [
    {
        "tool_name": "azure_ai_search",
        "tool_configuration": {
            "project_connection_id": os.environ["AI_SEARCH_PROJECT_CONNECTION_ID"],
            "index_name": "products-index",
            "query_type": "vector_semantic_hybrid",
        }
    },
]

# Model decides to call azure_ai_search with query "pricing tiers"
result1 = call_mcp_tool(
    tool_name="azure_ai_search",
    arguments={"query": "What are the product pricing tiers?"},  # Model-provided
    tool_configs=kb_tool_configs,  # Developer-controlled
)
print(f"KB search result: {result1}")


# --- Configuration for web search + code interpreter ---
web_code_tool_configs = [
    {
        "tool_name": "web_search",
        "tool_configuration": {
            "project_connection_id": os.environ["WEB_SEARCH_CONNECTION_ID"],
            "market": "en-US",
            "safe_search": "moderate",
        }
    },
    {
        "tool_name": "code_interpreter",
        "tool_configuration": {
            "timeout_seconds": 60,
            "allowed_languages": ["python"],
        }
    },
]

# Model decides to call web_search
result2 = call_mcp_tool(
    tool_name="web_search",
    arguments={"query": "Python async best practices 2026"},
    tool_configs=web_code_tool_configs,
)
print(f"Web search result: {result2}")


# --- Full toolset configuration ---
full_tool_configs = [
    {
        "tool_name": "azure_ai_search",
        "tool_configuration": {
            "project_connection_id": os.environ["AI_SEARCH_PROJECT_CONNECTION_ID"],
            "indexes": [
                {"index_name": "products-index", "query_type": "vector_semantic_hybrid"},
                {"index_name": "support-docs-index", "query_type": "semantic"},
            ],
        }
    },
    {
        "tool_name": "web_search",
        "tool_configuration": {
            "project_connection_id": os.environ["WEB_SEARCH_CONNECTION_ID"],
        }
    },
    {
        "tool_name": "code_interpreter",
        "tool_configuration": {}
    },
    {
        "tool_name": "file_search",
        "tool_configuration": {
            "vector_store_ids": [os.environ["VECTOR_STORE_ID"]],
        }
    },
]

# Model decides to call azure_ai_search
result3 = call_mcp_tool(
    tool_name="azure_ai_search",
    arguments={"query": "Compare product docs with competitor pricing"},
    tool_configs=full_tool_configs,
)
print(f"Full toolset result: {result3}")
```

### LangGraph Integration with Tool Configuration

When using LangGraph, wrap the MCP tool calls to inject configuration:

```python
from langchain_mcp_adapters.client import MultiServerMCPClient
from langgraph.prebuilt import create_react_agent
from langchain_openai import AzureChatOpenAI
from langchain_core.tools import tool

llm = AzureChatOpenAI(
    azure_deployment=os.getenv("MODEL_DEPLOYMENT_NAME"),
    api_version="2025-04-01-preview",
)

project_endpoint = os.getenv("PROJECT_ENDPOINT")

# Define tool configurations for this session
session_tool_configs = [
    {
        "tool_name": "azure_ai_search",
        "tool_configuration": {
            "project_connection_id": os.environ["AI_SEARCH_PROJECT_CONNECTION_ID"],
            "index_name": "products-index",
            "query_type": "vector_semantic_hybrid",
        }
    },
    {
        "tool_name": "web_search",
        "tool_configuration": {
            "project_connection_id": os.environ["WEB_SEARCH_CONNECTION_ID"],
        }
    },
]

# Create wrapper tools that inject configuration
@tool
def azure_ai_search(query: str) -> str:
    """Search the knowledge base for relevant documents."""
    result = call_mcp_tool(
        tool_name="azure_ai_search",
        arguments={"query": query},
        tool_configs=session_tool_configs,
    )
    return result.get("content", "")

@tool
def web_search(query: str) -> str:
    """Search the web for information."""
    result = call_mcp_tool(
        tool_name="web_search",
        arguments={"query": query},
        tool_configs=session_tool_configs,
    )
    return result.get("content", "")

# Create agent with configured tools
agent = create_react_agent(
    llm,
    [azure_ai_search, web_search],
    prompt="You are a helpful assistant. Use the available tools to answer questions.",
)

# Run the agent — tool configurations are injected automatically
result = await agent.ainvoke({
    "messages": [{"role": "user", "content": "What are our pricing tiers?"}]
})
print(result["messages"][-1].content)
```

### Key Pattern: Separation of Concerns

| Component | Controlled By | Example |
|-----------|--------------|---------|
| `arguments` | Model | `{"query": "pricing tiers"}` |
| `tool_configuration` | Developer | `{"index_name": "products-index", "query_type": "semantic"}` |
| `merged_arguments` | MCP Server | Both combined for tool execution |

This pattern ensures:
- **Model flexibility**: The model provides user-intent arguments
- **Developer control**: Configurations like connection IDs, indexes, and query types are set per-request
- **Security**: Sensitive settings (connection IDs) never come from model output

### Alternative: Using `_meta` for Tool Configuration

Instead of merging configuration into `arguments`, use MCP's `_meta` field to keep configuration separate:

```python
def call_mcp_tool_with_meta(
    tool_name: str,
    arguments: Dict[str, Any],
    tool_configs: List[Dict[str, Any]]
) -> Dict[str, Any]:
    """
    Call MCP server using _meta for tool configuration (MCP-idiomatic approach).
    
    The _meta field is a standard MCP extension point for out-of-band data
    that doesn't belong in the tool's input schema.
    """
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {os.environ['FOUNDRY_AUTH_TOKEN']}"
    }
    
    tool_configuration = find_tool_config(tool_name, tool_configs)
    
    payload = {
        "jsonrpc": "2.0",
        "id": 1,
        "method": "tools/call",
        "params": {
            "name": tool_name,
            "arguments": arguments,  # Model-provided only — clean separation
            "_meta": {
                "tool_configuration": tool_configuration  # Developer-controlled
            }
        }
    }
    
    response = requests.post(MCP_ENDPOINT, json=payload, headers=headers)
    return response.json()["result"]


# Usage remains the same
result = call_mcp_tool_with_meta(
    tool_name="azure_ai_search",
    arguments={"query": "What are the pricing tiers?"},
    tool_configs=[
        {
            "tool_name": "azure_ai_search",
            "tool_configuration": {
                "project_connection_id": os.environ["AI_SEARCH_PROJECT_CONNECTION_ID"],
                "index_name": "products-index",
                "query_type": "vector_semantic_hybrid",
            }
        }
    ],
)
```

### Comparison: `arguments` vs `_meta` Approaches

| Aspect | `tool_configuration` in `arguments` | `_meta` field |
|--------|-------------------------------------|---------------|
| **MCP Compliance** | Non-standard — extends arguments | Standard — `_meta` is MCP-defined |
| **Schema Validation** | May conflict with tool's JSON Schema | Clean — `_meta` is ignored by schema |
| **Framework Compatibility** | Requires framework-specific handling | Works with any MCP client |
| **Server Implementation** | Server extracts from arguments | Server reads from `_meta` |
| **Debugging** | Config mixed with user input | Clear separation in logs |

**Recommendation:**
- Use **`_meta`** if Foundry MCP servers support it — cleaner, more idiomatic
- Use **`arguments`** merge if legacy servers expect config in arguments

### Choosing the Right Approach

| Approach | When to Use | Pros | Cons |
|----------|-------------|------|------|
| **Per-call `_meta`** | Config varies per request (e.g., different indexes for different queries) | Fine-grained control, MCP-idiomatic | More complex client code |
| **Per-call `arguments`** | Legacy servers, simple merging | Simple implementation | Pollutes argument schema |
| **Server-side defaults** | Config is baked into toolbox definition | Zero client config | No runtime flexibility |

---

## Scenario 2: Publishing an External MCP Server

**Use case:** The Platform team creates a versioned toolbox that external teams (e.g., Customer Support, Analytics) can consume via MCP. The Platform team controls tool definitions and versioning; consumers just connect to the MCP endpoint.

### Publisher Side: Create and Version a Toolbox

```python
import os
from azure.identity import DefaultAzureCredential
from azure.ai.projects import AIProjectClient

# Platform team's project client
project_client = AIProjectClient(
    endpoint=os.getenv("PROJECT_ENDPOINT"),
    credential=DefaultAzureCredential(),
)

# Create a toolbox for external consumption
toolbox = project_client.toolboxes.create_toolbox(
    name="platform-utilities",
    description="Shared utility tools for all teams",
    metadata={"team": "platform", "support": "platform-team@company.com"},
    tools=[
        {
            "type": "azure_ai_search",
            "azure_ai_search": {
                "indexes": [
                    {
                        "project_connection_id": os.environ["AI_SEARCH_PROJECT_CONNECTION_ID"],
                        "index_name": "customer-data-index",
                        "query_type": "vector_semantic_hybrid",
                    }
                ]
            },
        },
        {
            "type": "web_search",
            "web_search": {
                "connection": {
                    "project_connection_id": os.environ["WEB_SEARCH_CONNECTION_ID"]
                }
            },
        },
        {
            "type": "code_interpreter",
            "code_interpreter": {},
        },
    ],
)

print(f"Published toolbox: {toolbox.name}")
print(f"Version: {toolbox.versions.latest.version}")
print(f"MCP endpoint: https://{os.getenv('PROJECT_ENDPOINT')}/toolboxes/platform-utilities/mcp")
# Output:
#   Published toolbox: platform-utilities
#   Version: 1
#   MCP endpoint: https://.../toolboxes/platform-utilities/mcp
```

### Publisher Side: Release a New Version

```python
# Add new tools in version 2
toolbox_v2 = project_client.toolboxes.create_toolbox_version(
    toolbox_name="platform-utilities",
    description="Added file search capability",
    metadata={"team": "platform", "changelog": "Added file_search tool"},
    tools=[
        # Existing tools
        {"type": "azure_ai_search", "azure_ai_search": {"indexes": [...]}},
        {"type": "web_search", "web_search": {"connection": {...}}},
        {"type": "code_interpreter", "code_interpreter": {}},
        # New tool
        {
            "type": "file_search",
            "file_search": {
                "vector_store_ids": [os.environ["VECTOR_STORE_ID"]]
            },
        },
    ],
)

print(f"Released version: {toolbox_v2.version}")
print(f"Tools: {[t.type for t in toolbox_v2.tools]}")
# Output:
#   Released version: 2
#   Tools: ['azure_ai_search', 'web_search', 'code_interpreter', 'file_search']
```

### Consumer Side: External Team Uses the Published Toolbox

```python
import os
from azure.identity import DefaultAzureCredential
from langchain_mcp_adapters.client import MultiServerMCPClient
from langgraph.prebuilt import create_react_agent
from langchain_openai import AzureChatOpenAI

# Customer Support team's configuration
llm = AzureChatOpenAI(
    azure_deployment=os.getenv("MODEL_DEPLOYMENT_NAME"),
    api_version="2025-04-01-preview",
)

# Platform team's project endpoint (provided to external teams)
platform_endpoint = os.getenv("PLATFORM_PROJECT_ENDPOINT")

# Connect to the published toolbox — use latest for dev, pinned for production
async with MultiServerMCPClient(
    {
        "platform-tools": {
            # Production: pin to a specific version
            "url": f"https://{platform_endpoint}/toolboxes/platform-utilities/versions/1/mcp",
            # Dev: use latest
            # "url": f"https://{platform_endpoint}/toolboxes/platform-utilities/mcp",
            "transport": "streamable_http",
        }
    }
) as mcp_client:
    tools = mcp_client.get_tools()
    print(f"Available platform tools: {[t.name for t in tools]}")

    # Build a support agent using platform tools
    support_agent = create_react_agent(
        llm,
        tools,
        prompt="You are a customer support agent. Use the available tools to help customers.",
    )

    result = await support_agent.ainvoke({
        "messages": [{"role": "user", "content": "Look up customer with ID C-12345 and create a high priority ticket for their billing issue"}]
    })
    print(result["messages"][-1].content)
```

### Version Migration Guide

| Consumer Environment | Recommended URL | Behavior |
|---------------------|-----------------|----------|
| Development | `.../toolboxes/platform-utilities/mcp` | Always latest — picks up new tools immediately |
| Staging | `.../toolboxes/platform-utilities/versions/2/mcp` | Test new version before production |
| Production | `.../toolboxes/platform-utilities/versions/1/mcp` | Stable, pinned version |

---

## Scenario 3: Toolbox Administration (CRUD, Traffic Routing, RBAC)

**Use case:** Platform administrators manage toolbox lifecycle — creating, versioning, deleting toolboxes, routing traffic between versions, and controlling access via RBAC.

### Toolbox CRUD Operations

```python
import os
from azure.identity import DefaultAzureCredential
from azure.ai.projects import AIProjectClient

project_client = AIProjectClient(
    endpoint=os.getenv("PROJECT_ENDPOINT"),
    credential=DefaultAzureCredential(),
)

# --- CREATE: Initial toolbox ---
toolbox = project_client.toolboxes.create_toolbox(
    name="analytics-tools",
    description="Analytics and reporting tools",
    metadata={"team": "data", "cost_center": "analytics"},
    tools=[
        {
            "type": "azure_ai_search",
            "azure_ai_search": {
                "indexes": [
                    {
                        "project_connection_id": os.environ["AI_SEARCH_PROJECT_CONNECTION_ID"],
                        "index_name": "analytics-data-index",
                        "query_type": "semantic",
                    }
                ]
            },
        },
        {
            "type": "code_interpreter",
            "code_interpreter": {},
        },
    ],
)
print(f"Created: {toolbox.name} v{toolbox.versions.latest.version}")

# --- READ: Get toolbox and version details ---
toolbox = project_client.toolboxes.get_toolbox(toolbox_name="analytics-tools")
print(f"Toolbox: {toolbox.name}")
print(f"Latest version: {toolbox.versions.latest.version}")
print(f"Description: {toolbox.versions.latest.description}")

# Get specific version
version_1 = project_client.toolboxes.get_toolbox_version(
    toolbox_name="analytics-tools",
    version="1",
)
print(f"Version 1 tools: {[t.type for t in version_1.tools]}")

# --- LIST: All toolboxes and versions ---
all_toolboxes = project_client.toolboxes.list_toolboxes()
for tb in all_toolboxes.data:
    print(f"  {tb.name} (latest: v{tb.versions.latest.version})")

all_versions = project_client.toolboxes.list_toolbox_versions(toolbox_name="analytics-tools")
for v in all_versions.data:
    print(f"  v{v.version}: {v.description} ({len(v.tools)} tools)")

# --- UPDATE: Create new version ---
toolbox_v2 = project_client.toolboxes.create_toolbox_version(
    toolbox_name="analytics-tools",
    description="Added web search and file search",
    metadata={"team": "data", "changelog": "v2: Added web_search and file_search"},
    tools=[
        # Existing tools
        {"type": "azure_ai_search", "azure_ai_search": {"indexes": [...]}},
        {"type": "code_interpreter", "code_interpreter": {}},
        # New tools
        {
            "type": "web_search",
            "web_search": {
                "connection": {
                    "project_connection_id": os.environ["WEB_SEARCH_CONNECTION_ID"]
                }
            },
        },
        {
            "type": "file_search",
            "file_search": {
                "vector_store_ids": [os.environ["VECTOR_STORE_ID"]]
            },
        },
    ],
)
print(f"Created version: {toolbox_v2.version}")

# --- DELETE: Remove a version ---
result = project_client.toolboxes.delete_toolbox_version(
    toolbox_name="analytics-tools",
    version="1",
)
print(f"Deleted version 1: {result.deleted}")

# --- DELETE: Remove entire toolbox ---
result = project_client.toolboxes.delete_toolbox(toolbox_name="analytics-tools")
print(f"Deleted toolbox: {result.deleted}")
```

### Traffic Routing Between Versions

The toolbox object has a mutable `default_version` property that controls which version the MCP endpoint (`/toolboxes/<name>/mcp`) resolves to. When `default_version` is not set, the endpoint serves the latest version. Use `update_toolbox` to pin or change the active version.

```python
project_endpoint = os.getenv("PROJECT_ENDPOINT")

# Initially, /toolboxes/analytics-tools/mcp serves the latest version (v2)
toolbox = project_client.toolboxes.get_toolbox(toolbox_name="analytics-tools")
print(f"Default version: {toolbox.default_version}")  # None — serves latest
print(f"Latest version: {toolbox.versions.latest.version}")  # "2"

# Pin the MCP endpoint to version 1 (e.g., while validating v2)
toolbox = project_client.toolboxes.update_toolbox(
    toolbox_name="analytics-tools",
    default_version="1",
)
print(f"MCP endpoint now serves: v{toolbox.default_version}")
# https://.../toolboxes/analytics-tools/mcp → serves v1

# After validation, promote v2 by updating default_version
toolbox = project_client.toolboxes.update_toolbox(
    toolbox_name="analytics-tools",
    default_version="2",
)
print(f"MCP endpoint now serves: v{toolbox.default_version}")
# https://.../toolboxes/analytics-tools/mcp → serves v2

# Reset to always serve latest (default behavior)
toolbox = project_client.toolboxes.update_toolbox(
    toolbox_name="analytics-tools",
    default_version=None,
)
print(f"MCP endpoint now serves: latest (v{toolbox.versions.latest.version})")

# Consumers can always bypass default_version by pinning to a specific version URL
# https://.../toolboxes/analytics-tools/versions/1/mcp → always v1
# https://.../toolboxes/analytics-tools/versions/2/mcp → always v2
```

### Version Routing Summary

| URL Pattern | Resolved Version |
|-------------|-----------------|
| `.../toolboxes/analytics-tools/mcp` | `default_version` if set, otherwise latest |
| `.../toolboxes/analytics-tools/versions/1/mcp` | Always version 1 |
| `.../toolboxes/analytics-tools/versions/2/mcp` | Always version 2 |

### RBAC Note

> **Note:** Toolbox is a data-plane object that follows the same authentication model as the Agent service. Both publishers and consumers need at least the **Azure AI User** role on the project to create, read, or invoke toolboxes. 
> How to enable a user with Azure AI User to use Toolbox?
    > solution 

---

## Summary

| Scenario | Primary Use | Key Endpoint |
|----------|-------------|--------------|
| **1. Developer Consumption** | Build agents with Foundry tools, no CRUD | `https://<project>/mcp` (default toolbox) |
| **2. Publishing External MCP** | Share versioned tools across teams | `https://<project>/toolboxes/<name>/mcp` |
| **3. Administration** | CRUD, traffic routing, RBAC | SDK methods + Azure RBAC |
