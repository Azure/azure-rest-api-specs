# Operations Summary

This is a report shows all the preview operations, and which value the caller is
required to set for the HTTP request header named "Foundry-Features".

| Operation Group | Operation | Method | Path | Foundry-Features Header |
|-----------------|-----------|--------|------|-------------------------|
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
| Evaluation Rules | List | GET | `/evaluationrules` | Optional: `Evaluations=V1Preview` |
| Evaluation Rules | Get | GET | `/evaluationrules/{id}` | Optional: `Evaluations=V1Preview` |
| Evaluation Rules | Delete | DELETE | `/evaluationrules/{id}` | Optional: `Evaluations=V1Preview` |
| Evaluation Rules | CreateOrUpdate | PUT | `/evaluationrules/{id}` | Optional: `Evaluations=V1Preview` |
| Evaluation Taxonomies | List | GET | `/evaluationtaxonomies` | Required: `Evaluations=V1Preview` |
| Evaluation Taxonomies | Get | GET | `/evaluationtaxonomies/{name}` | Required: `Evaluations=V1Preview` |
| Evaluation Taxonomies | Delete | DELETE | `/evaluationtaxonomies/{name}` | Required: `Evaluations=V1Preview` |
| Evaluation Taxonomies | Create | PUT | `/evaluationtaxonomies/{name}` | Required: `Evaluations=V1Preview` |
| Evaluation Taxonomies | Update | PATCH | `/evaluationtaxonomies/{name}` | Required: `Evaluations=V1Preview` |
