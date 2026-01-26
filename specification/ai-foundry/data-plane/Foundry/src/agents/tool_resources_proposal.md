# Tool Resources with Handlebar Templates and Structured Inputs

## Overview
This document demonstrates how to use handlebar templates in tool definitions with structured_inputs to enable runtime configuration of Azure Foundry agent tools.

---

## Sample 1: File Search - Single Vector Store with Template

**Use Case:** Customer support agent that uses different vector stores based on customer tier.

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
          "{{vector_store_id}}"
        ]
      }
    ],
    "structured_inputs": {
      "company_name": {
        "description": "Company name for branding",
        "default_value": "Acme Corp",
        "required": false
      },
      "vector_store_id": {
        "description": "Vector store ID for customer tier knowledge base",
        "required": true,
        "schema": {
          "type": "string"
        }
      }
    }
  }
}
```

**Response Creation:**
```json
{
  "agent": {
    "type": "agent_reference",
    "name": "support-agent",
    "version": "1"
  },
  "input": [{"type": "text", "text": "How do I upgrade my account?"}],
  "structured_inputs": {
    "company_name": "Acme Corp",
    "vector_store_id": "vs_premium_kb_2024"
  }
}
```

---

## Sample 2: File Search - Multiple Vector Stores with Template Array

**Use Case:** Legal research agent that searches across multiple jurisdiction-specific document stores.

```json
{
  "description": "Legal research agent with multi-jurisdiction support",
  "definition": {
    "kind": "prompt",
    "model": "gpt-4o",
    "instructions": "You are a legal research assistant for {{law_firm_name}}.",
    "tools": [
      {
        "type": "file_search",
        "vector_store_ids_template": "{{jurisdiction_vector_stores}}"
      }
    ],
    "structured_inputs": {
      "law_firm_name": {
        "description": "Law firm name",
        "default_value": "Legal Partners LLP",
        "required": false
      },
      "jurisdiction_vector_stores": {
        "description": "Array of vector store IDs for each jurisdiction",
        "required": true,
        "schema": {
          "type": "array",
          "items": {"type": "string"},
          "minItems": 1
        }
      }
    }
  }
}
```

**Response Creation:**
```json
{
  "agent": {
    "type": "agent_reference",
    "name": "legal-research-agent",
    "version": "1"
  },
  "input": [{"type": "text", "text": "Find precedents on contract law"}],
  "structured_inputs": {
    "law_firm_name": "Legal Partners LLP",
    "jurisdiction_vector_stores": [
      "vs_ca_law_2024",
      "vs_ny_law_2024",
      "vs_federal_law_2024"
    ]
  }
}
```

---

## Sample 3: File Search - Hybrid (Static + Dynamic Vector Stores)

**Use Case:** Product documentation agent with a base knowledge store plus customer-specific documents.

```json
{
  "description": "Product support with customer-specific documentation",
  "definition": {
    "kind": "prompt",
    "model": "gpt-4o",
    "instructions": "You are a product support agent for {{customer_name}}.",
    "tools": [
      {
        "type": "file_search",
        "vector_store_ids": [
          "vs_base_product_docs_2024"
        ],
        "vector_store_ids_template": "{{customer_vector_stores}}"
      }
    ],
    "structured_inputs": {
      "customer_name": {
        "description": "Customer name for personalization",
        "required": true
      },
      "customer_vector_stores": {
        "description": "Customer-specific documentation stores",
        "required": false,
        "schema": {
          "type": "array",
          "items": {"type": "string"}
        }
      }
    }
  }
}
```

**Response Creation:**
```json
{
  "agent": {
    "type": "agent_reference",
    "name": "product-support-agent",
    "version": "1"
  },
  "input": [{"type": "text", "text": "How do I configure SSO?"}],
  "structured_inputs": {
    "customer_name": "Enterprise Corp",
    "customer_vector_stores": [
      "vs_enterprise_corp_custom_docs",
      "vs_enterprise_corp_integrations"
    ]
  }
}
```

---

## Sample 4: Code Interpreter - Container with Template

**Use Case:** Data analysis agent with environment-specific container configurations.

```json
{
  "description": "Data analysis agent with configurable runtime environment",
  "definition": {
    "kind": "prompt",
    "model": "gpt-4o",
    "instructions": "You are a data analyst for {{department}}.",
    "tools": [
      {
        "type": "code_interpreter",
        "container": "{{container_id}}"
      }
    ],
    "structured_inputs": {
      "department": {
        "description": "Department name",
        "default_value": "Analytics Team",
        "required": false
      },
      "container_id": {
        "description": "Container ID for the runtime environment",
        "required": true,
        "schema": {
          "type": "string"
        }
      }
    }
  }
}
```

**Response Creation:**
```json
{
  "agent": {
    "type": "agent_reference",
    "name": "data-analysis-agent",
    "version": "1"
  },
  "input": [{"type": "text", "text": "Analyze Q4 sales data"}],
  "structured_inputs": {
    "department": "Sales Analytics",
    "container_id": "container_prod_analytics_v2"
  }
}
```

---

## Sample 5: Code Interpreter - Auto Container with File Templates

**Use Case:** Financial reporting agent that processes different file sets based on report type.

```json
{
  "description": "Financial reporting agent with dynamic file loading",
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
            "{{template_file_id}}"
          ],
          "file_ids_template": "{{data_file_ids}}"
        }
      }
    ],
    "structured_inputs": {
      "fiscal_period": {
        "description": "Fiscal period for the report",
        "required": true
      },
      "template_file_id": {
        "description": "Report template file ID",
        "required": true,
        "schema": {
          "type": "string"
        }
      },
      "data_file_ids": {
        "description": "Array of data file IDs to process",
        "required": true,
        "schema": {
          "type": "array",
          "items": {"type": "string"},
          "minItems": 1
        }
      }
    }
  }
}
```

**Response Creation:**
```json
{
  "agent": {
    "type": "agent_reference",
    "name": "financial-reporting-agent",
    "version": "1"
  },
  "input": [{"type": "text", "text": "Generate the quarterly report"}],
  "structured_inputs": {
    "fiscal_period": "Q1 2026",
    "template_file_id": "file_earnings_template_v3",
    "data_file_ids": [
      "file_q1_revenue_2026",
      "file_q1_expenses_2026",
      "file_q1_cashflow_2026"
    ]
  }
}
```

---

## Sample 6: MCP - Server Configuration with Templates

**Use Case:** Development agent that connects to different MCP servers based on project context.

```json
{
  "description": "Development agent with dynamic MCP server connections",
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
          "Authorization": "{{auth_token}}"
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
        "schema": {
          "type": "string"
        }
      },
      "server_url": {
        "description": "MCP server URL",
        "required": true,
        "schema": {
          "type": "string"
        }
      },
      "auth_token": {
        "description": "Authentication token for MCP server",
        "required": true,
        "schema": {
          "type": "string"
        }
      }
    }
  }
}
```

**Response Creation:**
```json
{
  "agent": {
    "type": "agent_reference",
    "name": "dev-assistant-agent",
    "version": "1"
  },
  "input": [{"type": "text", "text": "List recent commits on the main branch"}],
  "structured_inputs": {
    "project_name": "CloudSync API",
    "server_label": "cloudsync-api-repo",
    "server_url": "https://gitmcp.io/myorg/cloudsync-api",
    "auth_token": "Bearer ghp_xxxxxxxxxxxx"
  }
}
```

---

## Sample 7: MCP - Headers Template for Dynamic Authentication

**Use Case:** Enterprise integration agent with multiple authentication headers.

```json
{
  "description": "Enterprise integration agent with dynamic auth headers",
  "definition": {
    "kind": "prompt",
    "model": "gpt-4o",
    "instructions": "You are an integration assistant for {{user_name}}.",
    "tools": [
      {
        "type": "mcp",
        "server_label": "enterprise-api-gateway",
        "server_url": "https://api.enterprise.com/mcp",
        "require_approval": "never",
        "headers": {
          "X-Service-Name": "{{service_name}}"
        },
        "headers_template": "{{auth_headers}}"
      }
    ],
    "structured_inputs": {
      "user_name": {
        "description": "User name for personalization",
        "required": true
      },
      "auth_headers": {
        "description": "Dynamic authentication headers",
        "required": true,
        "schema": {
          "type": "object",
          "properties": {
            "Authorization": {"type": "string"},
            "X-User-ID": {"type": "string"},
            "X-Tenant-ID": {"type": "string"}
          },
          "required": ["Authorization"]
        }
      }
    }
  }
}
```

**Response Creation:**
```json
{
  "agent": {
    "type": "agent_reference",
    "name": "enterprise-integration-agent",
    "version": "1"
  },
  "input": [{"type": "text", "text": "Fetch customer records from CRM"}],
  "structured_inputs": {
    "user_name": "Jane Smith",
    "auth_headers": {
      "Authorization": "Bearer eyJhbGc...",
      "X-User-ID": "user_12345",
      "X-Tenant-ID": "tenant_acme_corp"
    }
  }
}
```

---

## Sample 8: Multi-Tool Agent - Combined Templates

**Use Case:** Research analyst with file search, code interpreter, and external API access.

```json
{
  "description": "Research analyst with multiple tool configurations",
  "definition": {
    "kind": "prompt",
    "model": "gpt-4o",
    "instructions": "You are a research analyst for {{client_name}}.",
    "tools": [
      {
        "type": "file_search",
        "vector_store_ids": [
          "vs_base_research_library"
        ],
        "vector_store_ids_template": "{{client_vector_stores}}"
      },
      {
        "type": "code_interpreter",
        "container": {
          "type": "auto",
          "file_ids_template": "{{analysis_file_ids}}"
        }
      },
      {
        "type": "mcp",
        "server_label": "{{data_provider_label}}",
        "server_url": "{{data_provider_url}}",
        "require_approval": "never",
        "headers": {
          "Authorization": "{{data_provider_api_key}}",
          "X-Client-ID": "{{client_id}}"
        }
      }
    ],
    "structured_inputs": {
      "client_name": {
        "description": "Client name",
        "required": true
      },
      "client_id": {
        "description": "Client identifier",
        "required": true
      },
      "client_vector_stores": {
        "description": "Client-specific knowledge bases",
        "required": false,
        "schema": {
          "type": "array",
          "items": {"type": "string"}
        }
      },
      "analysis_file_ids": {
        "description": "Files for code analysis",
        "required": false,
        "schema": {
          "type": "array",
          "items": {"type": "string"}
        }
      },
      "data_provider_label": {
        "description": "External data provider label",
        "required": true
      },
      "data_provider_url": {
        "description": "External data provider MCP URL",
        "required": true
      },
      "data_provider_api_key": {
        "description": "API key for data provider",
        "required": true
      }
    }
  }
}
```

**Response Creation:**
```json
{
  "agent": {
    "type": "agent_reference",
    "name": "research-analyst-agent",
    "version": "1"
  },
  "input": [{"type": "text", "text": "Analyze market trends for Q1 2026"}],
  "structured_inputs": {
    "client_name": "TechStart Inc",
    "client_id": "client_techstart_001",
    "client_vector_stores": [
      "vs_techstart_previous_reports",
      "vs_techstart_industry_data"
    ],
    "analysis_file_ids": [
      "file_competitor_data_q1",
      "file_market_trends_q1"
    ],
    "data_provider_label": "market-data-api",
    "data_provider_url": "https://api.marketdata.com/mcp",
    "data_provider_api_key": "Bearer sk_live_xxxxxxxxxxxx"
  }
}
```

---

## Sample 9: Dynamic Tool Selection with Conditional Templates

**Use Case:** Customer service agent that adapts tools based on customer segment.

```json
{
  "description": "Adaptive customer service agent",
  "definition": {
    "kind": "prompt",
    "model": "gpt-4o",
    "instructions": "You are a customer service agent for {{company_name}}.",
    "tools": [
      {
        "type": "file_search",
        "vector_store_ids_template": "{{knowledge_base_ids}}"
      },
      {
        "type": "mcp",
        "server_label": "{{crm_server_label}}",
        "server_url": "{{crm_server_url}}",
        "require_approval": "never",
        "headers_template": "{{crm_auth_headers}}"
      }
    ],
    "structured_inputs": {
      "company_name": {
        "description": "Company name",
        "default_value": "Global Services Inc",
        "required": false
      },
      "knowledge_base_ids": {
        "description": "Knowledge base vector stores for customer segment",
        "required": true,
        "schema": {
          "type": "array",
          "items": {"type": "string"},
          "minItems": 1
        }
      },
      "crm_server_label": {
        "description": "CRM server label",
        "required": true
      },
      "crm_server_url": {
        "description": "CRM server URL",
        "required": true
      },
      "crm_auth_headers": {
        "description": "CRM authentication headers",
        "required": true,
        "schema": {
          "type": "object"
        }
      }
    }
  }
}
```

**Response Creation (Enterprise Customer):**
```json
{
  "agent": {
    "type": "agent_reference",
    "name": "customer-service-agent",
    "version": "1"
  },
  "input": [{"type": "text", "text": "I need help with our enterprise agreement"}],
  "structured_inputs": {
    "company_name": "Global Services Inc",
    "knowledge_base_ids": [
      "vs_enterprise_kb",
      "vs_legal_contracts",
      "vs_premium_support"
    ],
    "crm_server_label": "enterprise-crm",
    "crm_server_url": "https://crm.enterprise.internal/mcp",
    "crm_auth_headers": {
      "Authorization": "Bearer ent_token_xxx",
      "X-Segment": "enterprise",
      "X-Priority": "high"
    }
  }
}
```
