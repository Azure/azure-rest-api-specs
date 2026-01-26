# Tool Resources with Handlebar Templates and Structured Inputs

## Overview

This document demonstrates how to use handlebar templates inline within tool definitions with
`structured_inputs` to enable runtime configuration of Azure Foundry agent tools.

Handlebar templates enable flexible, runtime-configurable agent tools by:

1. **Using templates in existing tool properties** - Templates are supported directly on
   properties like `vector_store_ids`, `file_ids`, `headers`, `container`, and MCP server
   configuration.
2. **Supporting optional inputs** - Empty string values in `file_ids` and `vector_store_ids`
   are automatically stripped at runtime, enabling flexible input counts.
3. **Adapting to different contexts** - The same agent definition works with different
   resources, credentials, and data sources via runtime configuration.

---

## Supported Properties

The following tool properties support handlebar templates:

| Tool Type | Property | Type | Description |
|-----------|----------|------|-------------|
| `file_search` | `vector_store_ids` | `string[]` | Array of vector store IDs. Templates apply to individual array items. Empty values are automatically stripped. |
| `code_interpreter` | `container` | `string \| object` | Container ID (as string) or container configuration object. When using object form, `file_ids` within the container can be templated. |
| `code_interpreter` | `container.file_ids` | `string[]` | Array of file IDs when `container.type` is `"auto"`. Templates apply to individual array items. Empty values are automatically stripped. |
| `mcp` | `server_label` | `string` | Label for the MCP server. |
| `mcp` | `server_url` | `string` | URL for the MCP server. |
| `mcp` | `headers` | `object` | HTTP headers as key-value pairs. Templates apply to individual header values. |

**Note**: Templates work on individual string values within arrays and objects. For arrays
like `vector_store_ids` and `file_ids`, each item can contain a template. For objects like
`headers`, each property value can contain a template.

---

## Use Cases

### 1. File Search - Dynamic Vector Stores

**Scenario**: Customer support agent that uses different vector stores based on customer tier.

**Agent Definition:**

```json
{
  "description": "Customer support agent with tiered knowledge bases",
  "definition": {
    "kind": "prompt",
    "model": "gpt-4o",
    "instructions": "You are a support agent for {{company_name}}.",
    "tools": [
      {
        "type": "file_search",
        "vector_store_ids": [
          "vs_base_kb",
          "{{tier_specific_kb}}"
        ]
      }
    ],
    "structured_inputs": {
      "company_name": {
        "description": "Company name for branding",
        "default_value": "Acme Corp"
      },
      "tier_specific_kb": {
        "description": "Vector store ID for customer tier",
        "required": true,
        "schema": {"type": "string"}
      }
    }
  }
}
```

**Runtime Usage:**

```json
{
  "agent": {"type": "agent_reference", "name": "support-agent", "version": "1"},
  "input": [{"type": "text", "text": "How do I upgrade my account?"}],
  "structured_inputs": {
    "company_name": "Acme Corp",
    "tier_specific_kb": "vs_premium_kb_2024"
  }
}
```

---

### 2. Code Interpreter - Auto Container with flexible File Loading

**Scenario**: Financial reporting agent that processes variable number of data files.

**Agent Definition:**

```json
{
  "description": "Financial reporting agent with flexible file loading",
  "definition": {
    "kind": "prompt",
    "model": "gpt-4o",
    "instructions": "You are a financial analyst preparing reports for {{fiscal_period}}.",
    "tools": [
      {
        "type": "code_interpreter",
        "container": {
          "type": "auto",
          "file_ids": [
            "{{template_file}}",
            "{{data_file_1}}",
            "{{data_file_2}}",
            "{{data_file_3}}",
            "{{data_file_4}}",
            "{{data_file_5}}"
          ]
        }
      }
    ],
    "structured_inputs": {
      "fiscal_period": {
        "description": "Fiscal period for the report",
        "required": true
      },
      "template_file": {
        "description": "Report template file ID",
        "required": true,
        "schema": {"type": "string"}
      },
      "data_file_1": {
        "description": "Data file 1 (optional)",
        "default_value": "",
        "schema": {"type": "string"}
      },
      "data_file_2": {
        "description": "Data file 2 (optional)",
        "default_value": "",
        "schema": {"type": "string"}
      },
      "data_file_3": {
        "description": "Data file 3 (optional)",
        "default_value": "",
        "schema": {"type": "string"}
      },
      "data_file_4": {
        "description": "Data file 4 (optional)",
        "default_value": "",
        "schema": {"type": "string"}
      },
      "data_file_5": {
        "description": "Data file 5 (optional)",
        "default_value": "",
        "schema": {"type": "string"}
      }
    }
  }
}
```

**Runtime Usage (with 3 data files):**

```json
{
  "agent": {"type": "agent_reference", "name": "financial-agent", "version": "1"},
  "input": [{"type": "text", "text": "Generate Q1 report"}],
  "structured_inputs": {
    "fiscal_period": "Q1 2026",
    "template_file": "file_template_v3",
    "data_file_1": "file_revenue_q1",
    "data_file_2": "file_expenses_q1",
    "data_file_3": "file_cashflow_q1"
  }
}
```

**Note**: Empty `data_file_4` and `data_file_5` are automatically stripped, resulting in only
4 files loaded at runtime.

---

### 3. Code Interpreter - Container ID Template

**Scenario**: Data analysis agent with runtime container selection.

**Agent Definition:**

```json
{
  "description": "Data analysis agent with runtime container selection",
  "definition": {
    "kind": "prompt",
    "model": "gpt-4o",
    "instructions": "You are a data analyst for {{environment}}.",
    "tools": [
      {
        "type": "code_interpreter",
        "container": "{{container_id}}"
      }
    ],
    "structured_inputs": {
      "environment": {
        "description": "Environment name",
        "required": true
      },
      "container_id": {
        "description": "Pre-configured container ID",
        "required": true,
        "schema": {"type": "string"}
      }
    }
  }
}
```

**Runtime Usage:**

```json
{
  "agent": {"type": "agent_reference", "name": "data-analyst", "version": "1"},
  "input": [{"type": "text", "text": "Analyze the dataset"}],
  "structured_inputs": {
    "environment": "Production",
    "container_id": "container_prod_py311_v2"
  }
}
```

**Note**: Enables runtime selection of pre-configured containers with different Python
environments and pre-loaded file sets.

---

### 4. MCP - Dynamic Server Configuration

**Scenario**: Development agent with runtime-configurable MCP server and authentication.

**Agent Definition:**

```json
{
  "description": "Development agent with dynamic MCP configuration",
  "definition": {
    "kind": "prompt",
    "model": "gpt-4o",
    "instructions": "You are a development assistant for {{project_name}}.",
    "tools": [
      {
        "type": "mcp",
        "server_label": "{{server_label}}",
        "server_url": "{{server_url}}",
        "require_approval": "never",
        "headers": {
          "Authorization": "{{auth_token}}",
          "X-Project-ID": "{{project_id}}"
        }
      }
    ],
    "structured_inputs": {
      "project_name": {
        "description": "Project name",
        "required": true
      },
      "server_label": {
        "description": "MCP server label",
        "required": true,
        "schema": {"type": "string"}
      },
      "server_url": {
        "description": "MCP server URL",
        "required": true,
        "schema": {"type": "string"}
      },
      "auth_token": {
        "description": "Authentication token",
        "required": true,
        "schema": {"type": "string"}
      },
      "project_id": {
        "description": "Project identifier",
        "required": true,
        "schema": {"type": "string"}
      }
    }
  }
}
```

**Runtime Usage:**

```json
{
  "agent": {"type": "agent_reference", "name": "dev-assistant", "version": "1"},
  "input": [{"type": "text", "text": "List recent commits"}],
  "structured_inputs": {
    "project_name": "CloudSync API",
    "server_label": "cloudsync-repo",
    "server_url": "https://gitmcp.io/myorg/cloudsync-api",
    "auth_token": "Bearer ghp_xxxxxxxxxxxx",
    "project_id": "proj_12345"
  }
}
```

---

### 5. Multi-Tool Agent

**Scenario**: Research analyst combining file search, code interpreter, and MCP tools with
dynamic configuration.

**Agent Definition:**

```json
{
  "description": "Research analyst with multiple dynamic tools",
  "definition": {
    "kind": "prompt",
    "model": "gpt-4o",
    "instructions": "You are a research analyst for {{client_name}}.",
    "tools": [
      {
        "type": "file_search",
        "vector_store_ids": [
          "vs_base_library",
          "{{client_kb_1}}",
          "{{client_kb_2}}",
          "{{client_kb_3}}"
        ]
      },
      {
        "type": "code_interpreter",
        "container": {
          "type": "auto",
          "file_ids": [
            "{{analysis_file_1}}",
            "{{analysis_file_2}}"
          ]
        }
      },
      {
        "type": "mcp",
        "server_label": "{{api_label}}",
        "server_url": "{{api_url}}",
        "require_approval": "never",
        "headers": {
          "Authorization": "{{api_key}}",
          "X-Client-ID": "{{client_id}}"
        }
      }
    ],
    "structured_inputs": {
      "client_name": {"description": "Client name", "required": true},
      "client_id": {"description": "Client identifier", "required": true},
      "client_kb_1": {
        "description": "Client KB 1",
        "default_value": "",
        "schema": {"type": "string"}
      },
      "client_kb_2": {
        "description": "Client KB 2",
        "default_value": "",
        "schema": {"type": "string"}
      },
      "client_kb_3": {
        "description": "Client KB 3",
        "default_value": "",
        "schema": {"type": "string"}
      },
      "analysis_file_1": {
        "description": "Analysis file 1",
        "default_value": "",
        "schema": {"type": "string"}
      },
      "analysis_file_2": {
        "description": "Analysis file 2",
        "default_value": "",
        "schema": {"type": "string"}
      },
      "api_label": {"description": "API label", "required": true},
      "api_url": {"description": "API URL", "required": true},
      "api_key": {"description": "API key", "required": true}
    }
  }
}
```

**Runtime Usage:**

```json
{
  "agent": {"type": "agent_reference", "name": "research-analyst", "version": "1"},
  "input": [{"type": "text", "text": "Analyze market trends"}],
  "structured_inputs": {
    "client_name": "TechStart Inc",
    "client_id": "client_001",
    "client_kb_1": "vs_client_reports",
    "client_kb_2": "vs_industry_data",
    "analysis_file_1": "file_market_data",
    "api_label": "market-data-api",
    "api_url": "https://api.marketdata.com/mcp",
    "api_key": "Bearer sk_live_xxxxxxxxxxxx"
  }
}
```

**Note**: Empty `client_kb_3` and `analysis_file_2` are automatically stripped.
