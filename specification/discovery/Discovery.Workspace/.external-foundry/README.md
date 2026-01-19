# Vendored Foundry Dependencies

This directory contains vendored TypeSpec models from Azure AI Projects (Foundry)
and OpenAI external types required for Discovery's AgentsV2 integration.

## Source

- **Repository**: azure-rest-api-specs-pr
- **Path**: specification/ai/Azure.AI.Projects

## Version

- **Commit**: Based on original source from ai/Azure.AI.Projects
- **Date**: December 16, 2025
- **OpenAI Commit**: 81687c58ac963af5c35cbfcf87c09481109723ec (Oct 3, 2025)

## Files Included

### OpenAI External Types (from .external-readonly/openai.external.typespec/)
- `openai.external/common/models.tsp` - Error, FunctionObject, Metadata
- `openai.external/common/custom.tsp` - ResponseFormat, pagination aliases
- `openai.external/common/main.tsp` - Import wrapper
- `openai.external/specialized-types/models.tsp` - ComparisonFilter, VectorStoreFileAttributes
- `openai.external/specialized-types/main.tsp` - Import wrapper
- `openai.external/responses/models.tsp` - Core response types (CreateResponse, Response, ItemParam, ItemResource, Tool, etc.)
- `openai.external/responses/custom.tsp` - ReasoningItemSummaryPart, CreateResponse, Response extensions
- `openai.external/responses/main.tsp` - Import wrapper
- `openai.external/responses/custom/items.tsp` - ItemType union, all item param/resource models
- `openai.external/responses/custom/items.messages.tsp` - Message role models

### Azure OpenAI Types (from .external-readonly/azure.openai.v1.typespec/)
- `azure.openai.v1/models/responses.tsp` - Azure-specific overrides (@@doc, @@changePropertyType)

### Foundry Types (from Azure.AI.Projects/)
- `Azure.AI.Projects/common/models.tsp` - ApiError, AgentOperation, AssetBase, etc.
- `Azure.AI.Projects/responses/models.tsp` - Foundry extensions (@@copyProperties for created_by, agent, structured_inputs)
- `Azure.AI.Projects/agents/models.tsp` - Agent models (CreateAgentRequest, AgentObject, AgentDefinition, PromptAgentDefinition, etc.)
- `Azure.AI.Projects/tools/models.tsp` - Azure-specific tool extensions (BingGroundingAgentTool, AzureAISearchAgentTool, SharepointAgentTool, etc.)

## Purpose

These files enable Discovery to:
1. Import OpenAI response types (ItemParam, ItemResource, CreateResponse, Response)
2. Get Foundry extensions automatically (created_by on ItemResource, agent/structured_inputs on requests/responses)
3. Define subset models (DiscoveryFoundryCreateRequest, DiscoveryFoundryResponse) that reference these types

## Import Chain

```
Discovery imports Azure.AI.Projects/responses/models.tsp
  → Imports azure.openai.v1/models/responses.tsp (Azure overrides)
    → Imports openai.external/responses/models.tsp (base OpenAI types)
      → Imports openai.external/common and specialized-types
  → Runs @@copyProperties to extend OpenAI types with Foundry additions
```

## Update Instructions

1. Check for updates in source repo (specification/ai/Azure.AI.Projects)
2. Copy updated files maintaining the same structure
3. Update import paths if needed (relative paths within .external-foundry/)
4. Run `tsp compile` to verify no breaking changes
5. Update this README with new commit hash and date

## Notes

- All import paths have been updated to use relative paths within this directory
- Azure-specific tools (Bing, SharePoint, Azure AI Search, etc.) are now included in tools/models.tsp
