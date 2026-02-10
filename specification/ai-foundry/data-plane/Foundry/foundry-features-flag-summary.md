# Operations Summary

| Operation Group | Operation | Method | Path | Foundry-Features Header |
|-----------------|-----------|--------|------|-------------------------|
| Red Team | List | GET | `/redTeams/runs` | None |
| Red Team | Get | GET | `/redTeams/runs/{name}` | None |
| Red Team | Create | POST | `/redTeams/runs:run` | Optional: `RedTeams=V1Preview` |
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
| Insights | List | GET | `/insights` | None |
| Insights | Get | GET | `/insights/{id}` | None |
| Schedules | List | GET | `/schedules` | None |
| Schedules | Delete | DELETE | `/schedules/{id}` | None |
| Schedules | Get | GET | `/schedules/{id}` | None |
| Schedules | CreateOrUpdate | PUT | `/schedules/{id}` | None |
| Schedules | List Runs | GET | `/schedules/{id}/runs` | None |
| Schedules | Get Run | GET | `/schedules/{schedule_id}/runs/{run_id}` | Required: `Insights=V1Preview` |
| Evaluation Rules | List | GET | `/evaluationrules` | None |
| Evaluation Rules | Get | GET | `/evaluationrules/{id}` | None |
| Evaluation Rules | Delete | DELETE | `/evaluationrules/{id}` | None |
| Evaluation Rules | CreateOrUpdate | PUT | `/evaluationrules/{id}` | None |
| Evaluation Taxonomies | List | GET | `/evaluationtaxonomies` | None |
| Evaluation Taxonomies | Get | GET | `/evaluationtaxonomies/{name}` | None |
| Evaluation Taxonomies | Delete | DELETE | `/evaluationtaxonomies/{name}` | None |
| Evaluation Taxonomies | Create | PUT | `/evaluationtaxonomies/{name}` | Optional: `Evaluations=V1Preview` |
| Evaluation Taxonomies | Update | PATCH | `/evaluationtaxonomies/{name}` | Optional: `Evaluations=V1Preview` |
