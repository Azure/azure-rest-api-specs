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
| Agents | Create (JSON or code upload) | POST | `/agents` | Optional: `ContainerAgents=V1Preview`, `WorkflowAgents=V1Preview`, `A2AAgents=V1Preview` |
| Agents | Update (JSON or code upload) | POST | `/agents/{agent_name}` | Optional: `ContainerAgents=V1Preview`, `WorkflowAgents=V1Preview`, `A2AAgents=V1Preview` |
| Agents | Create Version (JSON or code upload) | POST | `/agents/{agent_name}/versions` | Optional: `ContainerAgents=V1Preview`, `WorkflowAgents=V1Preview`, `A2AAgents=V1Preview` |
| Agents | Create From Manifest | POST | `/agents:import` | Required when the materialized hosted agent declares `a2a` in `protocol_versions`: `A2AAgents=V1Preview` |
| Agents | Update From Manifest | POST | `/agents/{agent_name}/import` | Required when the materialized hosted agent declares `a2a` in `protocol_versions`: `A2AAgents=V1Preview` |
| Agents | Create Version From Manifest | POST | `/agents/{agent_name}/versions:import` | Required when the materialized hosted agent version declares `a2a` in `protocol_versions`: `A2AAgents=V1Preview` |
| Agents | Update Endpoint | PATCH | `/agents/{agent_name}` | Required only when modifying a hosted agent's A2A passthrough endpoint configuration: `A2AAgents=V1Preview` |
| Evaluation Rules | CreateOrUpdate | PUT | `/evaluationrules/{id}` | Optional: `Evaluations=V1Preview` |
| Data Generation Jobs | Create | POST | `/data_generation_jobs` | Required for `type: conversations`, `type: traces` with `generate_test_case_rubric: true`, `scenario: supervised_finetuning_preview`, or `scenario: reinforcement_finetuning_preview`: `DataGenerationJobs=V1Preview`; not required for ordinary evaluation turn samples without rubric generation |

Note that only v1 operations are included in the above table. If an operation (or interface) is decorated with `@removed(Versions.v1)` the are not included here.

### A2A agents

Only hosted-agent A2A passthrough is in preview. Creating or modifying a hosted
agent definition that declares `a2a` in `protocol_versions` requires
`Foundry-Features: A2AAgents=V1Preview`. The header is supported on the JSON
and multipart code-upload agent create, update, and create-version writes, on
manifest imports that materialize a hosted agent, and on endpoint PATCH when it
modifies a hosted agent's A2A passthrough configuration, in both `v1` and
`virtual-public-preview`.

Prompt-agent A2A translation remains GA: configuring
`agent_endpoint.protocol_configuration.a2a` for a prompt agent (including
through endpoint PATCH) does not require the A2A opt-in, and the header can be
omitted. Other protocols, agent-card updates, and
getting, listing, deleting, or referencing existing agents do not require it.
A2A inference is out of scope for this opt-in. The `x-ms-foundry-meta`
annotations describe this preview contract; they do not implement runtime
enforcement.

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
| Memory Stores | Create Memory Item | POST | `/memory_stores/{name}/items` | Required: `MemoryStores=V1Preview` |
| Memory Stores | List Memory Items | GET | `/memory_stores/{name}/items` | Required: `MemoryStores=V1Preview` |
| Memory Stores | Update Memory Item | POST | `/memory_stores/{name}/items/{memory_id}` | Required: `MemoryStores=V1Preview` |
| Memory Stores | Get Memory Item | GET | `/memory_stores/{name}/items/{memory_id}` | Required: `MemoryStores=V1Preview` |
| Memory Stores | Delete Memory Item | DELETE | `/memory_stores/{name}/items/{memory_id}` | Required: `MemoryStores=V1Preview` |
| Skills | Create | POST | `/skills` | Required: `Skills=V1Preview` |
| Skills | Create From Package | POST | `/skills:import` | Required: `Skills=V1Preview` |
| Skills | Get | GET | `/skills/{name}` | Required: `Skills=V1Preview` |
| Skills | Download | GET | `/skills/{name}:download` | Required: `Skills=V1Preview` |
| Skills | List | GET | `/skills` | Required: `Skills=V1Preview` |
| Skills | Update | POST | `/skills/{name}` | Required: `Skills=V1Preview` |
| Skills | Delete | DELETE | `/skills/{name}` | Required: `Skills=V1Preview` |
| Agent Insight Monitors | List | GET | `/agent_insight_monitors` | Required: `AgentInsights=V1Preview` |
| Agent Insight Monitors | Create | POST | `/agent_insight_monitors` | Required: `AgentInsights=V1Preview` |
| Agent Insight Monitors | Get | GET | `/agent_insight_monitors/{monitor_id}` | Required: `AgentInsights=V1Preview` |
| Agent Insight Monitors | Delete | DELETE | `/agent_insight_monitors/{monitor_id}` | Required: `AgentInsights=V1Preview` |
| Agent Insight Monitors | Update | PATCH | `/agent_insight_monitors/{monitor_id}` | Required: `AgentInsights=V1Preview` |
| Agent Insight Monitors | Reset | POST | `/agent_insight_monitors/{monitor_id}:reset` | Required: `AgentInsights=V1Preview` |
| Agent Insight Monitors | Create Run | POST | `/agent_insight_monitors/{monitor_id}/runs` | Required: `AgentInsights=V1Preview` |
| Agent Insight Monitors | List Runs | GET | `/agent_insight_monitors/{monitor_id}/runs` | Required: `AgentInsights=V1Preview` |
| Agent Insight Monitors | Get Run | GET | `/agent_insight_monitors/{monitor_id}/runs/{run_id}` | Required: `AgentInsights=V1Preview` |
| Agent Insight Monitors | Cancel Run | POST | `/agent_insight_monitors/{monitor_id}/runs/{run_id}:cancel` | Required: `AgentInsights=V1Preview` |
| Agent Insight Monitors | List Insights | GET | `/agent_insight_monitors/{monitor_id}/insights` | Required: `AgentInsights=V1Preview` |
| Agent Insight Monitors | Get Insight | GET | `/agent_insight_monitors/{monitor_id}/insights/{insight_id}` | Required: `AgentInsights=V1Preview` |
| Agent Insight Monitors | Update Insight | PATCH | `/agent_insight_monitors/{monitor_id}/insights/{insight_id}` | Required: `AgentInsights=V1Preview` |

Note that only v1 operations are included in the above table. If an operation (or interface) is decorated with `@removed(Versions.v1)` the are not included here.
