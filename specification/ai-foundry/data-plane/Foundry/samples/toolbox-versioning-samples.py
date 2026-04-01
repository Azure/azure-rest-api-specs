"""
Toolbox Versioning Samples

Demonstrates:
1. Creating and evolving toolbox versions (project_client)
2. Pinning a LangGraph agent to a specific toolbox version via MCP endpoint
3. A/B testing two LangGraph agents using different toolbox versions
4. Managing toolbox version lifecycle
"""

import os
import random
import asyncio
from azure.identity import DefaultAzureCredential
from azure.ai.projects import AIProjectClient
from langchain_mcp_adapters.client import MultiServerMCPClient
from langgraph.prebuilt import create_react_agent
from langchain_openai import AzureChatOpenAI

# ---------------------------------------------------------------------------
# Setup
# ---------------------------------------------------------------------------

project_client = AIProjectClient(
    endpoint=os.getenv("PROJECT_ENDPOINT"),
    credential=DefaultAzureCredential(),
)

llm = AzureChatOpenAI(
    azure_deployment=os.getenv("MODEL_DEPLOYMENT_NAME"),
    api_version="2025-04-01-preview",
)


# ===========================================================================
# Sample 1: Create and Evolve a Toolbox
# ===========================================================================

def sample_create_and_evolve_toolbox():
    """Create a toolbox with v1 tools, then add a new version with more tools."""

    with project_client:
        # Create initial toolbox (creates version "1" automatically)
        toolbox = project_client.toolboxes.create_toolbox(
            name="weather-tools",
            description="Basic weather operations",
            metadata={"team": "platform", "owner": "alice"},
            tools=[
                {
                    "type": "function",
                    "function": {
                        "name": "get_current_weather",
                        "description": "Get the current weather for a location",
                        "parameters": {
                            "type": "object",
                            "properties": {
                                "location": {"type": "string", "description": "City name"}
                            },
                            "required": ["location"],
                        },
                    },
                }
            ],
        )
        print(f"Created toolbox: {toolbox.name}, latest version: {toolbox.versions.latest.version}")
        # Output: Created toolbox: weather-tools, latest version: 1

        # Add forecast capability → creates version "2"
        toolbox_v2 = project_client.toolboxes.create_toolbox_version(
            toolbox_name="weather-tools",
            description="Weather operations with forecast support",
            metadata={"team": "platform", "owner": "alice"},
            tools=[
                {
                    "type": "function",
                    "function": {
                        "name": "get_current_weather",
                        "description": "Get the current weather for a location",
                        "parameters": {
                            "type": "object",
                            "properties": {"location": {"type": "string"}},
                            "required": ["location"],
                        },
                    },
                },
                {
                    "type": "function",
                    "function": {
                        "name": "get_forecast",
                        "description": "Get a 7-day weather forecast",
                        "parameters": {
                            "type": "object",
                            "properties": {
                                "location": {"type": "string"},
                                "days": {"type": "integer", "default": 7},
                            },
                            "required": ["location"],
                        },
                    },
                },
            ],
        )
        print(f"Created version: {toolbox_v2.version}")
        # Output: Created version: 2


# ===========================================================================
# Sample 2: Pin Agent to a Toolbox Version via MCP Endpoint
# ===========================================================================

def sample_pin_agent_to_toolbox_via_mcp():
    """
    Each toolbox version is exposed as an MCP server endpoint. Agents connect
    to the toolbox's MCP URL to discover and use its tools at runtime — no
    need to copy tool definitions into the agent.

    URL patterns:
      - Pinned:  https://<project-endpoint>/toolboxes/<name>/versions/<version>/mcp
      - Latest:  https://<project-endpoint>/toolboxes/<name>/mcp
    """

    project_endpoint = os.getenv("PROJECT_ENDPOINT")

    with project_client:
        # Production agent: pinned to toolbox v1 (stable, never changes)
        prod_agent = project_client.agents.create_agent(
            model=os.getenv("MODEL_DEPLOYMENT_NAME"),
            name="weather-agent-prod",
            instructions="You help users with weather questions. Use only the provided tools.",
            tools=[
                {
                    "type": "mcp",
                    "mcp": {
                        "url": f"https://{project_endpoint}/toolboxes/weather-tools/versions/1/mcp",
                    },
                }
            ],
        )
        print(f"Production agent pinned to toolbox v1: {prod_agent.name}")

        # Dev agent: always uses the latest toolbox version
        dev_agent = project_client.agents.create_agent(
            model=os.getenv("MODEL_DEPLOYMENT_NAME"),
            name="weather-agent-dev",
            instructions="You help users with weather questions. You can also provide forecasts.",
            tools=[
                {
                    "type": "mcp",
                    "mcp": {
                        "url": f"https://{project_endpoint}/toolboxes/weather-tools/mcp",
                    },
                }
            ],
        )
        print(f"Dev agent uses latest toolbox: {dev_agent.name}")


# ===========================================================================
# Sample 3: A/B Test with Different Toolbox Versions
# ===========================================================================

def sample_ab_test_with_toolbox_versions():
    """
    Create two agent versions that each point to a different toolbox version
    via MCP endpoint, then set up traffic splitting for A/B testing.

    Flow:
      1. Create agent v1 → MCP endpoint pinned to toolbox v1
      2. Create agent v2 → MCP endpoint pinned to toolbox v2
      3. Configure the agent endpoint to split traffic 50/50
    """

    project_endpoint = os.getenv("PROJECT_ENDPOINT")

    with project_client:
        # --- Step 1: Create agent v1 pointing to toolbox v1 via MCP ---
        agent = project_client.agents.create_agent(
            model=os.getenv("MODEL_DEPLOYMENT_NAME"),
            name="weather-agent",
            instructions="You help users with weather questions.",
            tools=[
                {
                    "type": "mcp",
                    "mcp": {
                        "url": f"https://{project_endpoint}/toolboxes/weather-tools/versions/1/mcp",
                    },
                }
            ],
        )
        print(f"Created agent v1 with toolbox v1: {agent.versions.latest.version}")

        # --- Step 2: Create agent v2 pointing to toolbox v2 via MCP ---
        project_client.agents.create_agent(
            model=os.getenv("MODEL_DEPLOYMENT_NAME"),
            name="weather-agent",  # same name → creates new version
            instructions="You help users with weather questions. You can also provide forecasts.",
            tools=[
                {
                    "type": "mcp",
                    "mcp": {
                        "url": f"https://{project_endpoint}/toolboxes/weather-tools/versions/2/mcp",
                    },
                }
            ],
        )
        print("Created agent v2 with toolbox v2")

        # --- Step 3: Set up 50/50 traffic split for A/B testing ---
        project_client.agents.update_agent_endpoint(
            name="weather-agent",
            endpoint={
                "version_selector": {
                    "version_selection_rules": [
                        {
                            "type": "FixedRatio",
                            "agentVersion": "1",
                            "traffic_percentage": 50,
                        },
                        {
                            "type": "FixedRatio",
                            "agentVersion": "2",
                            "traffic_percentage": 50,
                        },
                    ]
                },
                "protocols": ["responses"],
            },
        )
        print("Configured 50/50 A/B split: agent v1 (toolbox v1) vs agent v2 (toolbox v2)")


# ===========================================================================
# Sample 4: Promote Winning Toolbox Version
# ===========================================================================

def sample_promote_winning_version():
    """
    After an A/B test, promote the winning toolbox version to 100% traffic
    and clean up the losing agent version.
    """

    with project_client:
        # A/B test showed v2 (with forecast) is better → route 100% to v2
        project_client.agents.update_agent_endpoint(
            name="weather-agent",
            endpoint={
                "version_selector": {
                    "version_selection_rules": [
                        {
                            "type": "FixedRatio",
                            "agentVersion": "2",
                            "traffic_percentage": 100,
                        },
                    ]
                },
                "protocols": ["responses"],
            },
        )
        print("Promoted agent v2 (toolbox v2) to 100% traffic")

        # Optionally, delete the losing agent version
        result = project_client.agents.delete_agent_version(
            name="weather-agent", version="1"
        )
        print(f"Deleted agent v1: {result.deleted}")


# ===========================================================================
# Sample 5: Version Override for Testing
# ===========================================================================

def sample_version_override():
    """
    While the endpoint routes to v2 by default, a developer can override
    to test a specific agent version (which uses a specific toolbox version).
    """

    # Default endpoint points to agent v2 (toolbox v2), but we target v1
    agent_client = project_client.get_endpoint_responses_client_for_agent(
        agent_name="weather-agent",
        version_override="1",
    )

    response = agent_client.create_response(
        input="What's the weather in Seattle?",
    )
    print(f"Response from agent v1 (toolbox v1): {response}")


# ===========================================================================
# Sample 6: Manage Toolbox Version Lifecycle
# ===========================================================================

def sample_toolbox_version_lifecycle():
    """
    Full lifecycle: list versions, delete a bad version, verify latest updated.
    """

    with project_client:
        # List all versions
        versions = project_client.toolboxes.list_toolbox_versions(
            toolbox_name="weather-tools"
        )
        print("All versions:")
        for v in versions.data:
            print(f"  version={v.version}, description={v.description}, created_at={v.created_at}")

        # Suppose v3 was buggy → delete it
        result = project_client.toolboxes.delete_toolbox_version(
            toolbox_name="weather-tools", version="3"
        )
        print(f"Deleted version 3: {result.deleted}")

        # Verify latest reverted to v2
        toolbox = project_client.toolboxes.get_toolbox(toolbox_name="weather-tools")
        print(f"Latest version is now: {toolbox.versions.latest.version}")
        # Output: Latest version is now: 2

        # Clean up: delete entire toolbox (all versions)
        # result = project_client.toolboxes.delete_toolbox(toolbox_name="weather-tools")
        # print(f"Deleted toolbox: {result.deleted}")


# ===========================================================================
# Run samples
# ===========================================================================

if __name__ == "__main__":
    sample_create_and_evolve_toolbox()
    sample_pin_agent_to_toolbox_via_mcp()
    sample_ab_test_with_toolbox_versions()
    sample_promote_winning_version()
    # sample_version_override()  # requires endpoint setup
    sample_toolbox_version_lifecycle()
