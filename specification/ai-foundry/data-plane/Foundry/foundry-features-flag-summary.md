# "Foundry-Features" HTTP request header

## Guidelines

Guidelines on when an opt-in HTTP request header is needed:

1. If the entire operation is preview, require a header for everything (all HTTP methods and sub-paths) and do not require intensive, viral adoption of "preview" infixes on schema component names and discriminator values.
1. If a preview instead conditionally impacts behavior in an otherwise GA API, only require the header when creating or updating a persisted preview-enabled "thing," and apply "preview" infixes wherever possible to component names and discriminator values.
1. GA APIs referencing an already-created preview "thing" don't expressly require a header, nor do get/list/delete operations.

## v1 GA routes with optional "Foundry-Features" HTTP request header to enable preview features

You will need to include this HTTP request header, with a value specified below,
in order to enable preview features on these GA routes.

| Operation Group | Operation | Method | Path | Foundry-Features Header Value |
|-----------------|-----------|--------|------|-------------------------------|
| Agents | Create | POST | `/agents` | Optional: `ContainerAgents=V1Preview`, `CodeAgents=V1Preview`, `HostedAgents=V1Preview`, `WorkflowAgents=V1Preview` |
| Agents | Update | POST | `/agents/{agent_name}` | Optional: `ContainerAgents=V1Preview`, `CodeAgents=V1Preview`, `HostedAgents=V1Preview`, `WorkflowAgents=V1Preview` |
| Agents | Create Version | POST | `/agents/{agent_name}/versions` | Optional: `ContainerAgents=V1Preview`, `CodeAgents=V1Preview`, `HostedAgents=V1Preview`, `WorkflowAgents=V1Preview` |
| Evaluation Rules | CreateOrUpdate | PUT | `/evaluationrules/{id}` | Optional: `Evaluations=V1Preview` |

## v1 Preview routes with required "Foundry-Features" HTTP header to enable preview features

You must include this HTTP request header, with the value specified below,
in order to successfully complete operations using these routes.

| Operation Group | Operation | Method | Path | Foundry-Features Header Value |
|-----------------|-----------|--------|------|-------------------------------|
| Evaluators | List Latest Versions | GET | `/evaluators` | Required: `Evaluations=V1Preview` |
| Evaluators | List Versions | GET | `/evaluators/{name}/versions` | Required: `Evaluations=V1Preview` |
| Evaluators | Create Version | POST | `/evaluators/{name}/versions` | Required: `Evaluations=V1Preview` |
| Evaluators | Get Version | GET | `/evaluators/{name}/versions/{version}` | Required: `Evaluations=V1Preview` |
| Evaluators | Delete Version | DELETE | `/evaluators/{name}/versions/{version}` | Required: `Evaluations=V1Preview` |
| Evaluators | Update Version | PATCH | `/evaluators/{name}/versions/{version}` | Required: `Evaluations=V1Preview` |
| Insights | Generate | POST | `/insights` | Required: `Insights=V1Preview` |
| Insights | List | GET | `/insights` |  Required: `Insights=V1Preview` |
| Insights | Get | GET | `/insights/{id}` |  Required: `Insights=V1Preview` |
| Schedules | List | GET | `/schedules` | Required: `Schedules=V1Preview` |
| Schedules | Delete | DELETE | `/schedules/{id}` | Required: `Schedules=V1Preview` |
| Schedules | Get | GET | `/schedules/{id}` | Required: `Schedules=V1Preview` |
| Schedules | CreateOrUpdate | PUT | `/schedules/{id}` | Required: `Schedules=V1Preview` |
| Schedules | List Runs | GET | `/schedules/{id}/runs` | Required: `Schedules=V1Preview` |
| Schedules | Get Run | GET | `/schedules/{schedule_id}/runs/{run_id}` | Required: `Schedules=V1Preview` |
| Evaluation Taxonomies | List | GET | `/evaluationtaxonomies` | Required: `Evaluations=V1Preview` |
| Evaluation Taxonomies | Get | GET | `/evaluationtaxonomies/{name}` | Required: `Evaluations=V1Preview` |
| Evaluation Taxonomies | Delete | DELETE | `/evaluationtaxonomies/{name}` | Required: `Evaluations=V1Preview` |
| Evaluation Taxonomies | Create | PUT | `/evaluationtaxonomies/{name}` | Required: `Evaluations=V1Preview` |
| Evaluation Taxonomies | Update | PATCH | `/evaluationtaxonomies/{name}` | Required: `Evaluations=V1Preview` |
| Red Team | List | GET | `/redTeams/runs` | Required: `RedTeams=V1Preview` |
| Red Team | Get | GET | `/redTeams/runs/{name}` | Required: `RedTeams=V1Preview` |
| Red Team | Create | POST | `/redTeams/runs:run` | Required: `RedTeams=V1Preview` |
| Memory Stores | Create | POST | `/memory_stores` | Required: `MemoryStores=V1Preview` |
| Memory Stores | List | GET | `/memory_stores` | Required: `MemoryStores=V1Preview` |
| Memory Stores | Update | POST | `/memory_stores/{name}` | Required: `MemoryStores=V1Preview` |
| Memory Stores | Get | GET | `/memory_stores/{name}` | Required: `MemoryStores=V1Preview` |
| Memory Stores | Delete | DELETE | `/memory_stores/{name}` | Required: `MemoryStores=V1Preview` |
| Memory Stores | Get Update Result | GET | `/memory_stores/{name}/updates/{update_id}` | Required: `MemoryStores=V1Preview` |
| Memory Stores | Delete Scope Memories | POST | `/memory_stores/{name}:delete_scope` | Required: `MemoryStores=V1Preview` |
| Memory Stores | Search Memories | POST | `/memory_stores/{name}:search_memories` | Required: `MemoryStores=V1Preview` |
| Memory Stores | Update Memories | POST | `/memory_stores/{name}:update_memories` | Required: `MemoryStores=V1Preview` |
| Agents | Create Agent From Code | POST | `/agents` | Required: `CodeAgents=V1Preview` |
| Agents | Update Agent From Code | POST | `/agents/{agent_name}` | Required: `CodeAgents=V1Preview` |
| Agents | Create Agent Version From Code | POST | `/agents/{agent_name}/versions` | Required: `CodeAgents=V1Preview` |
| Agents | Patch Agent | PATCH | `/agents/{agent_name}` | Required: `AgentEndpoints=V1Preview` |
| Agent Invocations | Get OpenAPI Spec | GET | `/agents/{agent_name}/endpoint/protocols/invocations/docs/openapi.json` | Required: `HostedAgents=V1Preview` |
| Agent Invocations | Create | POST | `/agents/{agent_name}/endpoint/protocols/invocations` | Required: `HostedAgents=V1Preview` |
| Agent Invocations | Get | GET | `/agents/{agent_name}/endpoint/protocols/invocations/{invocation_id}` | Required: `HostedAgents=V1Preview` |
| Agent Invocations | Cancel | POST | `/agents/{agent_name}/endpoint/protocols/invocations/{invocation_id}/cancel` | Required: `HostedAgents=V1Preview` |
| Agent Session Files | Upload | PUT | `/agents/{agent_name}/endpoint/sessions/{session_id}/files/content` | Required: `HostedAgents=V1Preview` |
| Agent Session Files | Download | GET | `/agents/{agent_name}/endpoint/sessions/{session_id}/files/content` | Required: `HostedAgents=V1Preview` |
| Agent Session Files | List | GET | `/agents/{agent_name}/endpoint/sessions/{session_id}/files` | Required: `HostedAgents=V1Preview` |
| Agent Session Files | Delete | DELETE | `/agents/{agent_name}/endpoint/sessions/{session_id}/files` | Required: `HostedAgents=V1Preview` |
| Managed Agent Identity Blueprints | CreateOrUpdate | PUT | `/managedAgentIdentityBlueprints/{blueprint_name}` | Required: `AgentEndpoints=V1Preview` |
| Managed Agent Identity Blueprints | Get | GET | `/managedAgentIdentityBlueprints/{blueprint_name}` | Required: `AgentEndpoints=V1Preview` |
| Managed Agent Identity Blueprints | Delete | DELETE | `/managedAgentIdentityBlueprints/{blueprint_name}` | Required: `AgentEndpoints=V1Preview` |
| Managed Agent Identity Blueprints | List | GET | `/managedAgentIdentityBlueprints` | Required: `AgentEndpoints=V1Preview` |
| Skills | Create | POST | `/skills` | Required: `Skills=V1Preview` |
| Skills | Create From Package | POST | `/skills:import` | Required: `Skills=V1Preview` |
| Skills | Get | GET | `/skills/{skill_name}` | Required: `Skills=V1Preview` |
| Skills | Download | GET | `/skills/{skill_name}:download` | Required: `Skills=V1Preview` |
| Skills | List | GET | `/skills` | Required: `Skills=V1Preview` |
| Skills | Update | POST | `/skills/{skill_name}` | Required: `Skills=V1Preview` |
| Skills | Delete | DELETE | `/skills/{skill_name}` | Required: `Skills=V1Preview` |
| Toolboxes | Create Version | POST | `/toolboxes/{toolbox_name}/versions` | Required: `Toolboxes=V1Preview` |
| Toolboxes | Get | GET | `/toolboxes/{toolbox_name}` | Required: `Toolboxes=V1Preview` |
| Toolboxes | List | GET | `/toolboxes` | Required: `Toolboxes=V1Preview` |
| Toolboxes | List Versions | GET | `/toolboxes/{toolbox_name}/versions` | Required: `Toolboxes=V1Preview` |
| Toolboxes | Get Version | GET | `/toolboxes/{toolbox_name}/versions/{version}` | Required: `Toolboxes=V1Preview` |
| Toolboxes | Update | PATCH | `/toolboxes/{toolbox_name}` | Required: `Toolboxes=V1Preview` |
| Toolboxes | Delete | DELETE | `/toolboxes/{toolbox_name}` | Required: `Toolboxes=V1Preview` |
| Toolboxes | Delete Version | DELETE | `/toolboxes/{toolbox_name}/versions/{version}` | Required: `Toolboxes=V1Preview` |
