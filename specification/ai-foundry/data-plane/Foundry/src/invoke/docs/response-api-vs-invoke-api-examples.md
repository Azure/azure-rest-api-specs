# Response API vs Invoke API: Example Comparison

This document provides side-by-side examples of request and response payloads for the **OpenAI Response API** and the **Azure AI Foundry Invoke API**, highlighting the key differences in design philosophy and structure.

---

## Table of Contents

1. [Overview](#overview)
2. [Simple Text Query](#simple-text-query)
3. [Multimodal Input](#multimodal-input)
4. [Tool Calling](#tool-calling)
5. [Agent Chaining](#agent-chaining)
6. [Key Differences Summary](#key-differences-summary)

---

## Overview

### Response API (OpenAI-based)
- **Philosophy**: Chat-centric, conversation-based API with roles (user/assistant)
- **Model**: Follows OpenAI's Responses API with Azure extensions
- **Endpoint**: `POST /openai/v1/responses`
- **State Management**: Conversation history maintained through input items
- **Output**: Array of OutputItem objects with types and metadata

### Invoke API (Azure AI Foundry)
- **Philosophy**: Agent-centric, simplified message passing
- **Model**: Custom design for hosted container agents
- **Endpoint**: `POST /invoke`
- **State Management**: Session-based with session_id
- **Output**: Single message with optional content items

---

## Simple Text Query

### Response API Request

```json
POST /openai/v1/responses
{
  "agent_reference": {
    "name": "my-weather-agent",
    "version": "1.0.0"
  },
  "input": [
    {
      "type": "message",
      "role": "user",
      "content": [
        {
          "type": "input_text",
          "text": "What's the weather in Seattle?"
        }
      ]
    }
  ]
}
```

### Response API Response (Non-streaming)

```json
{
  "id": "resp_abc123",
  "object": "response",
  "status": "completed",
  "status_details": null,
  "output": [
    {
      "id": "item_123",
      "type": "message",
      "role": "assistant",
      "status": "completed",
      "content": [
        {
          "type": "text",
          "text": "I'll check the weather in Seattle for you."
        }
      ]
    },
    {
      "id": "item_124",
      "type": "mcp_tool_call",
      "call_id": "call_mcp_123",
      "name": "weather-mcp-server/get_weather",
      "status": "completed",
      "arguments": "{\"location\": \"Seattle\", \"unit\": \"fahrenheit\"}"
    },
    {
      "id": "item_125",
      "type": "mcp_tool_call_output",
      "call_id": "call_mcp_123",
      "output": "{\"temperature\": 52, \"conditions\": \"cloudy\", \"location\": \"Seattle\"}",
      "status": "completed"
    },
    {
      "id": "item_126",
      "type": "message",
      "role": "assistant",
      "status": "completed",
      "content": [
        {
          "type": "text",
          "text": "The current weather in Seattle is 52°F and cloudy."
        }
      ]
    }
  ],
  "usage": {
    "prompt_tokens": 150,
    "completion_tokens": 75,
    "total_tokens": 225
  },
  "created_at": 1234567890
}
```

### Invoke API Request

```json
POST /invoke
{
  "agent_def": {
    "name": "my-weather-agent",
    "version": "1.0.0"
  },
  "input": "What's the weather in Seattle?"
}
```

**Note**: The input can be a simple string for text queries. No need for roles or message structure.

### Invoke API Response (Non-streaming)

```json
{
  "status": "completed",
  "session_id": "session_abc123",
  "output": {
    "content": "The current weather in Seattle is 52°F and cloudy."
  },
  "metadata": {},
  "created_at": "2024-01-15T10:30:00Z",
  "completed_at": "2024-01-15T10:30:05Z"
}
```

**Key Difference**: Response API exposes all MCP server tool calls as separate items in the output array. Invoke API hides tool execution by default, returning only the final answer (tool details can be included in metadata if needed).

---

## Multimodal Input

### Response API Request

```json
POST /openai/v1/responses
{
  "agent_reference": {
    "name": "image-analyzer",
    "version": "2.0.0"
  },
  "input": [
    {
      "type": "message",
      "role": "user",
      "content": [
        {
          "type": "input_text",
          "text": "What's in this image?"
        },
        {
          "type": "input_image",
          "image_url": {
            "url": "https://example.com/photo.jpg"
          }
        }
      ]
    }
  ]
}
```

### Response API Response

```json
{
  "id": "resp_img001",
  "object": "response",
  "status": "completed",
  "output": [
    {
      "id": "item_127",
      "type": "message",
      "role": "assistant",
      "status": "completed",
      "content": [
        {
          "type": "text",
          "text": "The image shows a sunset over the ocean with palm trees in the foreground. The colors are predominantly orange and purple in the sky."
        }
      ]
    }
  ],
  "created_at": 1234567890
}
```

### Invoke API Request

```json
POST /invoke
{
  "agent_def": {
    "name": "image-analyzer",
    "version": "2.0.0"
  },
  "input": {
    "content": [
      {
        "content_type": "text/plain",
        "text": "What's in this image?"
      },
      {
        "content_type": "image/jpeg",
        "url": "https://example.com/photo.jpg"
      }
    ]
  }
}
```

**Note**: Content items use standard MIME types (e.g., `image/jpeg`) instead of specialized types like `input_image`.

### Invoke API Response

```json
{
  "status": "completed",
  "session_id": "session_img001",
  "output": {
    "content": [
      {
        "content_type": "text/plain",
        "text": "The image shows a sunset over the ocean with palm trees in the foreground. The colors are predominantly orange and purple in the sky."
      }
    ]
  },
  "created_at": "2024-01-15T10:35:00Z",
  "completed_at": "2024-01-15T10:35:03Z"
}
```

---

## Tool Calling

Tool calling with client-side functions requires a multi-turn interaction where the agent requests a function call, the client executes it, and then submits the result back.

### Response API - Turn 1: Initial Request

```json
POST /openai/v1/responses
{
  "agent_reference": {
    "name": "data-analyst",
    "version": "1.0.0"
  },
  "tools": [
    {
      "type": "function",
      "function": {
        "name": "query_database",
        "description": "Query the analytics database",
        "parameters": {
          "type": "object",
          "properties": {
            "query": {
              "type": "string",
              "description": "SQL query to execute"
            }
          },
          "required": ["query"]
        }
      }
    }
  ],
  "input": [
    {
      "type": "message",
      "role": "user",
      "content": [
        {
          "type": "input_text",
          "text": "How many users signed up last month?"
        }
      ]
    }
  ]
}
```

### Response API - Turn 1: Response (function_call)

```json
{
  "id": "resp_tool001",
  "object": "response",
  "status": "incomplete",
  "status_details": {
    "type": "incomplete",
    "reason": "tool_calls"
  },
  "output": [
    {
      "id": "item_128",
      "type": "function_call",
      "call_id": "call_db001",
      "name": "query_database",
      "status": "in_progress",
      "arguments": "{\"query\": \"SELECT COUNT(*) FROM users WHERE signup_date >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month')\"}"
    }
  ],
  "created_at": 1234567890
}
```

**Note**: Status is `incomplete` with reason `tool_calls`, indicating the client needs to execute the function.

### Response API - Turn 2: Submit function_call_output

The client executes the function and submits the result:

```json
POST /openai/v1/responses/resp_tool001
{
  "agent_reference": {
    "name": "data-analyst",
    "version": "1.0.0"
  },
  "prev_response_id": "resp_tool001",
  "input": [
    {
      "type": "function_call_output",
      "call_id": "call_db001",
      "output": "{\"count\": 1523}"
    }
  ]
}
```

### Response API - Turn 2: Final Response

```json
{
  "id": "resp_tool001",
  "object": "response",
  "status": "completed",
  "output": [
    {
      "id": "item_128",
      "type": "function_call",
      "call_id": "call_db001",
      "name": "query_database",
      "status": "completed",
      "arguments": "{\"query\": \"SELECT COUNT(*) FROM users WHERE signup_date >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month')\"}"
    },
    {
      "id": "item_129",
      "type": "function_call_output",
      "call_id": "call_db001",
      "output": "{\"count\": 1523}",
      "status": "completed"
    },
    {
      "id": "item_130",
      "type": "message",
      "role": "assistant",
      "status": "completed",
      "content": [
        {
          "type": "text",
          "text": "Last month, 1,523 users signed up."
        }
      ]
    }
  ],
  "created_at": 1234567890
}
```

---

### Invoke API - Turn 1: Initial Request

```json
POST /invoke
{
  "agent_def": {
    "name": "data-analyst",
    "version": "1.0.0"
  },
  "input": "How many users signed up last month?"
}
```

**Note**: Client-side tools are configured in the agent definition, not passed in the request.

### Invoke API - Turn 1: Response (tool_call interrupt)

```json
{
  "status": "awaiting_input",
  "session_id": "session_tool001",
  "interrupt": {
    "type": "function_call",
    "id": "interrupt_tool_db001",
    "function_name": "query_database",
    "arguments": {
      "query": "SELECT COUNT(*) FROM users WHERE signup_date >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month')"
    }
  },
  "created_at": "2024-01-15T10:40:00Z"
}
```

**Note**: The agent pauses execution with a `tool_call` interrupt, requesting client-side execution.

### Invoke API - Turn 2: Submit tool result and get final answer

The client executes the function and submits the result:

```json
POST /invoke
{
  "agent_def": {
    "name": "data-analyst",
    "version": "1.0.0"
  },
  "session_id": "session_tool001",
  "interrupt": {
    "id": "interrupt_tool_db001",
    "payload": {
        "count": 1523
    }
  }
}
```

### Invoke API - Turn 2: Final Response

```json
{
  "status": "completed",
  "session_id": "session_tool001",
  "output": {
    "content": "Last month, 1,523 users signed up."
  },
  "metadata": {},
  "created_at": "2024-01-15T10:40:00Z",
  "completed_at": "2024-01-15T10:40:04Z"
}
```

**Key Differences**:
- **Response API**: Uses `incomplete` status with `tool_calls` reason, then resumes with response ID
- **Invoke API**: Uses `tool_call` interrupt type, resumes with `session_id` + interrupt resume data
- **Response API**: Function output submitted as input item of type `function_call_output`
- **Invoke API**: Tool result submitted in interrupt resume payload
- Both return the final answer in Turn 2 after receiving the tool output

---

## Agent Chaining

### Response API - Calling a Sub-Agent

**Request to Orchestrator Agent:**

```json
POST /openai/v1/responses
{
  "agent_reference": {
    "name": "orchestrator-agent",
    "version": "1.0.0"
  },
  "input": [
    {
      "type": "message",
      "role": "user",
      "content": [
        {
          "type": "input_text",
          "text": "Analyze sales data and send report to manager"
        }
      ]
    }
  ]
}
```

**Orchestrator calls Data-Analyst Agent (internal):**

The orchestrator must:
1. Extract relevant data from the output of the data-analyst agent
2. Transform it into the format expected by the email-agent
3. Make a second API call to the email-agent

```json
POST /openai/v1/responses
{
  "agent_reference": {
    "name": "data-analyst-agent",
    "version": "1.0.0"
  },
  "input": [
    {
      "type": "message",
      "role": "user",
      "content": [
        {
          "type": "input_text",
          "text": "Analyze Q4 sales data"
        }
      ]
    }
  ]
}
```

**Data-Analyst Response:**

```json
{
  "id": "resp_data001",
  "object": "response",
  "status": "completed",
  "output": [
    {
      "id": "item_132",
      "type": "message",
      "role": "assistant",
      "content": [
        {
          "type": "text",
          "text": "Q4 sales analysis complete. Revenue increased 15% YoY."
        }
      ]
    }
  ]
}
```

**Orchestrator then calls Email Agent (requires transformation):**

The orchestrator must extract the text from the data-analyst's message and format it for the email agent.

```json
POST /openai/v1/responses
{
  "model": "gpt-4",
  "agent_reference": {
    "name": "email-agent",
    "version": "1.0.0"
  },
  "input": [
    {
      "type": "message",
      "role": "user",
      "content": [
        {
          "type": "input_text",
          "text": "Send email with content: Q4 sales analysis complete. Revenue increased 15% YoY."
        }
      ]
    }
  ]
}
```

### Invoke API - Calling a Sub-Agent (Zero-Translation)

**Request to Orchestrator Agent:**

```json
POST /invoke
{
  "agent_def": {
    "name": "orchestrator-agent",
    "version": "1.0.0"
  },
  "input": "Analyze sales data and send report to manager"
}
```

**Orchestrator calls Data-Analyst Agent (internal, zero-translation):**

The orchestrator can directly pass the input to the data-analyst agent:

```json
POST /invoke
{
  "agent_def": {
    "name": "data-analyst-agent",
    "version": "1.0.0"
  },
  "input": "Analyze Q4 sales data",
  "metadata": {
    "parent_session": "session_orch001"
  }
}
```

**Data-Analyst Response:**

```json
{
  "status": "completed",
  "session_id": "session_data001",
  "output": {
    "content": [
      {
        "content_type": "text/plain",
        "text": "Q4 sales analysis complete. Revenue increased 15% YoY."
      },
      {
        "content_type": "image/png",
        "url": "https://storage.example.com/chart_q4.png",
        "filename": "q4_sales_chart.png"
      }
    ]
  },
  "created_at": "2024-01-15T11:00:00Z",
  "completed_at": "2024-01-15T11:00:05Z"
}
```

**Orchestrator calls Email Agent (direct passthrough):**

The orchestrator can **directly pass** the output from data-analyst to the email agent without transformation:

```json
POST /invoke
{
  "agent_def": {
    "name": "email-agent",
    "version": "1.0.0"
  },
  "input": {
    "content": [
      {
        "content_type": "text/plain",
        "text": "Send this analysis to manager@example.com: Q4 sales analysis complete. Revenue increased 15% YoY."
      },
      {
        "content_type": "image/png",
        "url": "https://storage.example.com/chart_q4.png",
        "filename": "q4_sales_chart.png"
      }
    ]
  },
  "metadata": {
    "parent_session": "session_orch001",
    "upstream_session": "session_data001"
  }
}
```

**Key Advantage**: The output format from one agent **is identical** to the input format for the next agent. No transformation needed!

---