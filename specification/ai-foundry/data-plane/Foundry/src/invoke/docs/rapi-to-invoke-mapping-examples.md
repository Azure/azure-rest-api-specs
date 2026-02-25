# RAPI to Invoke API Mapping Examples

This document shows how the OpenAI Responses API (RAPI) maps to the Invoke API for hosted agents.
Each example demonstrates the same scenario using both APIs side-by-side, showing exact 1-1 mappings
for all 10 scenarios from the invoke-api-examples.md document.

---

## Table of Contents

1. [Simple Text Query](#1-simple-text-query)
2. [Multi-turn Conversation](#2-multi-turn-conversation)
3. [Multimodal Input - Image Analysis](#3-multimodal-input---image-analysis)
4. [Multimodal Input - Document Processing](#4-multimodal-input---document-processing)
5. [File References (Platform-Managed)](#5-file-references-platform-managed)
6. [Human-in-the-Loop - Tool Approval](#6-human-in-the-loop---tool-approval)
7. [Human-in-the-Loop - Form Input](#7-human-in-the-loop---form-input)
8. [Streaming Response (SSE Events)](#8-streaming-response-sse-events)
9. [Custom Parameters and Configuration](#9-custom-parameters-and-configuration)
10. [Complete Mapping Reference](#10-complete-mapping-reference)

---

## Mapping Summary

| RAPI Concept | Invoke API Concept | Notes |
| ------------ | ------------------ | ----- |
| `agent_reference` | `agent_def` | Agent identification |
| `conversation_id` | `session_id` | Session derived from hash(agent_name, agent_version, conversation_id) |
| `structured_inputs` | `params` | Custom parameters for agent |
| `structured_outputs` output item | `structured_data` content item | Structured data in response |
| `function_call` (name: "handle_interrupt") | `interrupt` content item | HITL pause/approval requests |
| `function_call_output` | `interrupt_resume` content item | Resume after interrupt |
| `message` items | `content` items | Message content |

### Important Notes

- **Session ID Mapping**: The `session_id` in Invoke is not a direct copy of `conversation_id`. Instead, it's computed as a hash of the agent name, agent version, and conversation_id. This ensures that:
  - Calls to the same agent with the same conversation_id always route to the same session
  - Different agents or versions create distinct sessions even with the same conversation_id
  - Session continuity is maintained across multiple turns in a conversation

- **Interrupt Handling**: RAPI uses `function_call` with `name: "handle_interrupt"` which maps to Invoke's `interrupt` content item. The Invoke API does not use an action field; it relies on the item_type to identify interrupts.

---

## 1. Simple Text Query

Basic text-only interaction.

### RAPI Request

```http
POST /openai/v1/responses HTTP/1.1
Content-Type: application/json

{
  "agent_reference": {
    "type": "agent_reference",
    "name": "customer-support-bot",
    "version": "1"
  },
  "input": [
    {
      "type": "message",
      "role": "user",
      "content": [
        {
          "type": "input_text",
          "text": "What is your return policy?"
        }
      ]
    }
  ]
}
```

### RAPI Response

```json
{
  "id": "resp_abc123",
  "object": "response",
  "status": "completed",
  "conversation_id": "conv_abc123",
  "agent_reference": {
    "type": "agent_reference",
    "name": "customer-support-bot",
    "version": "1"
  },
  "output": [
    {
      "id": "msg_001",
      "type": "output_message",
      "role": "assistant",
      "status": "completed",
      "content": [
        {
          "type": "text",
          "text": "Our return policy allows returns within 30 days of purchase with original receipt."
        }
      ]
    }
  ],
  "created_at": 1738900000,
  "completed_at": 1738900003
}
```

### Invoke Request (Internal)

```http
POST /invoke HTTP/1.1
Content-Type: application/json

{
  "agent_def": {
    "name": "customer-support-bot",
    "version": "1"
  },
  "input": "What is your return policy?",
  "session_id": "sess_abc123"
}
```

### Invoke Response (Internal)

```json
{
  "id": "inv_abc123",
  "status": "completed",
  "session_id": "sess_abc123",
  "output": {
    "content": [
      {
        "item_type": "text",
        "text": "Our return policy allows returns within 30 days of purchase with original receipt."
      }
    ]
  },
  "error": null,
  "created_at": 1738900000,
  "completed_at": 1738900003
}
```

---

## 2. Multi-turn Conversation

Continuing a conversation using conversation_id/session_id.

### RAPI Request - First Turn

```http
POST /openai/v1/responses HTTP/1.1
Content-Type: application/json

{
  "agent_reference": {
    "type": "agent_reference",
    "name": "travel-assistant",
    "version": "1"
  },
  "input": [
    {
      "type": "message",
      "role": "user",
      "content": [
        {
          "type": "input_text",
          "text": "I need to book a flight to New York"
        }
      ]
    }
  ]
}
```

### RAPI Response - First Turn

```json
{
  "id": "resp_xyz001",
  "object": "response",
  "status": "completed",
  "conversation_id": "conv_xyz789",
  "agent_reference": {
    "type": "agent_reference",
    "name": "travel-assistant",
    "version": "1"
  },
  "output": [
    {
      "id": "msg_002",
      "type": "output_message",
      "role": "assistant",
      "status": "completed",
      "content": [
        {
          "type": "text",
          "text": "I'd be happy to help you book a flight to New York! When would you like to travel?"
        }
      ]
    }
  ],
  "created_at": 1738900000,
  "completed_at": 1738900002
}
```

### RAPI Request - Follow-up Turn

```http
POST /openai/v1/responses HTTP/1.1
Content-Type: application/json

{
  "agent_reference": {
    "type": "agent_reference",
    "name": "travel-assistant",
    "version": "1"
  },
  "conversation_id": "conv_xyz789",
  "input": [
    {
      "type": "message",
      "role": "user",
      "content": [
        {
          "type": "input_text",
          "text": "Next Friday"
        }
      ]
    }
  ]
}
```

### RAPI Response - Follow-up Turn

```json
{
  "id": "resp_xyz002",
  "object": "response",
  "status": "completed",
  "conversation_id": "conv_xyz789",
  "agent_reference": {
    "type": "agent_reference",
    "name": "travel-assistant",
    "version": "1"
  },
  "output": [
    {
      "id": "msg_003",
      "type": "output_message",
      "role": "assistant",
      "status": "completed",
      "content": [
        {
          "type": "text",
          "text": "Great! I'll search for flights to New York next Friday. What's your departure city?"
        }
      ]
    }
  ],
  "created_at": 1738900005,
  "completed_at": 1738900007
}
```

### Invoke Request - First Turn (Internal)

```http
POST /invoke HTTP/1.1
Content-Type: application/json

{
  "agent_def": {
    "name": "travel-assistant",
    "version": "1"
  },
  "input": "I need to book a flight to New York",
  "session_id": "sess_xyz789"
}
```

### Invoke Response - First Turn (Internal)

```json
{
  "id": "inv_xyz001",
  "status": "completed",
  "session_id": "sess_xyz789",
  "output": {
    "content": [
      {
        "item_type": "text",
        "text": "I'd be happy to help you book a flight to New York! When would you like to travel?"
      }
    ]
  },
  "created_at": 1738900000,
  "completed_at": 1738900002
}
```

### Invoke Request - Follow-up Turn (Internal)

```http
POST /invoke HTTP/1.1
Content-Type: application/json

{
  "agent_def": {
    "name": "travel-assistant",
    "version": "1"
  },
  "input": "Next Friday",
  "session_id": "sess_xyz789"
}
```

### Invoke Response - Follow-up Turn (Internal)

```json
{
  "id": "inv_xyz002",
  "status": "completed",
  "session_id": "sess_xyz789",
  "output": {
    "content": [
      {
        "item_type": "text",
        "text": "Great! I'll search for flights to New York next Friday. What's your departure city?"
      }
    ]
  },
  "created_at": 1738900005,
  "completed_at": 1738900007
}
```

---

## 3. Multimodal Input - Image Analysis

Send an image for analysis using base64 encoding.

### RAPI Request

```http
POST /openai/v1/responses HTTP/1.1
Content-Type: application/json

{
  "agent_reference": {
    "type": "agent_reference",
    "name": "image-analyzer",
    "version": "1"
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
          "image_url": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==",
          "detail": "auto"
        }
      ]
    }
  ]
}
```

### RAPI Response

```json
{
  "id": "resp_img001",
  "object": "response",
  "status": "completed",
  "conversation_id": "conv_img001",
  "agent_reference": {
    "type": "agent_reference",
    "name": "image-analyzer",
    "version": "1"
  },
  "output": [
    {
      "id": "msg_004",
      "type": "output_message",
      "role": "assistant",
      "status": "completed",
      "content": [
        {
          "type": "text",
          "text": "This image shows a simple red square on a white background."
        }
      ]
    }
  ],
  "created_at": 1738900000,
  "completed_at": 1738900004
}
```

### Invoke Request (Internal)

```http
POST /invoke HTTP/1.1
Content-Type: application/json

{
  "agent_def": {
    "name": "image-analyzer",
    "version": "1"
  },
  "input": [
    {
      "content": [
        {
          "item_type": "text",
          "text": "What's in this image?"
        },
        {
          "item_type": "image",
          "data": "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==",
          "content_type": "image/png"
        }
      ]
    }
  ],
  "session_id": "sess_img001"
}
```

### Invoke Response (Internal)

```json
{
  "id": "inv_img001",
  "status": "completed",
  "session_id": "sess_img001",
  "output": {
    "content": [
      {
        "item_type": "text",
        "text": "This image shows a simple red square on a white background."
      }
    ]
  },
  "created_at": 1738900000,
  "completed_at": 1738900004
}
```

---

## 4. Multimodal Input - Document Processing

Send a PDF document using URL reference.

### RAPI Request

```http
POST /openai/v1/responses HTTP/1.1
Content-Type: application/json

{
  "agent_reference": {
    "type": "agent_reference",
    "name": "document-processor",
    "version": "2"
  },
  "input": [
    {
      "type": "message",
      "role": "user",
      "content": [
        {
          "type": "input_text",
          "text": "Summarize the key findings from this quarterly report"
        },
        {
          "type": "input_file",
          "file_url": "https://example.com/reports/q4-2024.pdf",
          "filename": "Q4-2024-Report.pdf"
        }
      ]
    }
  ]
}
```

### RAPI Response

```json
{
  "id": "resp_doc001",
  "object": "response",
  "status": "completed",
  "conversation_id": "conv_doc001",
  "agent_reference": {
    "type": "agent_reference",
    "name": "document-processor",
    "version": "2"
  },
  "output": [
    {
      "id": "msg_005",
      "type": "output_message",
      "role": "assistant",
      "status": "completed",
      "content": [
        {
          "type": "text",
          "text": "Key findings from Q4 2024:\n- Revenue increased 15% YoY\n- Customer acquisition up 23%\n- Operating margin improved to 18%"
        }
      ]
    },
    {
      "id": "item_struct001",
      "type": "structured_outputs",
      "output": {
        "pages_processed": 45,
        "processing_time_ms": 3420
      }
    }
  ],
  "created_at": 1738900000,
  "completed_at": 1738900008
}
```

### Invoke Request (Internal)

```http
POST /invoke HTTP/1.1
Content-Type: application/json

{
  "agent_def": {
    "name": "document-processor",
    "version": "2"
  },
  "input": [
    {
      "content": [
        {
          "item_type": "text",
          "text": "Summarize the key findings from this quarterly report"
        },
        {
          "item_type": "file",
          "url": "https://example.com/reports/q4-2024.pdf",
          "file_name": "Q4-2024-Report.pdf",
          "content_type": "application/pdf"
        }
      ]
    }
  ],
  "session_id": "sess_doc001"
}
```

### Invoke Response (Internal)

```json
{
  "id": "inv_doc001",
  "status": "completed",
  "session_id": "sess_doc001",
  "output": {
    "content": [
      {
        "item_type": "text",
        "text": "Key findings from Q4 2024:\n- Revenue increased 15% YoY\n- Customer acquisition up 23%\n- Operating margin improved to 18%"
      },
      {
        "item_type": "structured_data",
        "data": {
          "pages_processed": 45,
          "processing_time_ms": 3420
        }
      }
    ]
  },
  "created_at": 1738900000,
  "completed_at": 1738900008
}
```

---

## 5. File References (Platform-Managed)

Using platform-managed files via `file_id`.

### RAPI Request

```http
POST /openai/v1/responses HTTP/1.1
Content-Type: application/json

{
  "agent_reference": {
    "type": "agent_reference",
    "name": "data-analyzer",
    "version": "1"
  },
  "input": [
    {
      "type": "message",
      "role": "user",
      "content": [
        {
          "type": "input_text",
          "text": "Analyze the sales data and create a trend chart"
        },
        {
          "type": "input_file",
          "file_id": "file_abc123",
          "filename": "sales-data-2024.csv"
        }
      ]
    }
  ]
}
```

### RAPI Response

```json
{
  "id": "resp_data001",
  "object": "response",
  "status": "completed",
  "conversation_id": "conv_data001",
  "agent_reference": {
    "type": "agent_reference",
    "name": "data-analyzer",
    "version": "1"
  },
  "output": [
    {
      "id": "msg_006",
      "type": "output_message",
      "role": "assistant",
      "status": "completed",
      "content": [
        {
          "type": "text",
          "text": "I've analyzed the sales data. Here's the trend chart showing monthly growth:"
        },
        {
          "type": "image_file",
          "image_file": {
            "file_id": "file_chart456"
          }
        }
      ]
    },
    {
      "id": "item_struct002",
      "type": "structured_outputs",
      "output": {
        "records_analyzed": 12450,
        "chart_generated": true
      }
    }
  ],
  "created_at": 1738900000,
  "completed_at": 1738900015
}
```

### Invoke Request (Internal)

```http
POST /invoke HTTP/1.1
Content-Type: application/json

{
  "agent_def": {
    "name": "data-analyzer",
    "version": "1"
  },
  "input": [
    {
      "content": [
        {
          "item_type": "text",
          "text": "Analyze the sales data and create a trend chart"
        },
        {
          "item_type": "file",
          "file_id": "file_abc123",
          "file_name": "sales-data-2024.csv",
          "content_type": "text/csv"
        }
      ]
    }
  ],
  "session_id": "sess_data001"
}
```

### Invoke Response (Internal)

```json
{
  "id": "inv_data001",
  "status": "completed",
  "session_id": "sess_data001",
  "output": {
    "content": [
      {
        "item_type": "text",
        "text": "I've analyzed the sales data. Here's the trend chart showing monthly growth:"
      },
      {
        "item_type": "image",
        "file_id": "file_chart456",
        "file_name": "sales-trend-chart.png",
        "content_type": "image/png"
      },
      {
        "item_type": "structured_data",
        "data": {
          "records_analyzed": 12450,
          "chart_generated": true
        }
      }
    ]
  },
  "created_at": 1738900000,
  "completed_at": 1738900015
}
```

---

## 6. Human-in-the-Loop - Tool Approval

Agent requests approval before executing a sensitive action.

### RAPI Request - Initial

```http
POST /openai/v1/responses HTTP/1.1
Content-Type: application/json

{
  "agent_reference": {
    "type": "agent_reference",
    "name": "booking-assistant",
    "version": "1"
  },
  "input": [
    {
      "type": "message",
      "role": "user",
      "content": [
        {
          "type": "input_text",
          "text": "Book a flight from SEA to JFK on March 15"
        }
      ]
    }
  ]
}
```

### RAPI Response - Interrupt

```json
{
  "id": "resp_book001",
  "object": "response",
  "status": "incomplete",
  "conversation_id": "conv_book001",
  "agent_reference": {
    "type": "agent_reference",
    "name": "booking-assistant",
    "version": "1"
  },
  "output": [
    {
      "id": "msg_007",
      "type": "output_message",
      "role": "assistant",
      "status": "completed",
      "content": [
        {
          "type": "text",
          "text": "I found a flight that matches your requirements:"
        }
      ]
    },
    {
      "id": "call_int001",
      "type": "function_call",
      "call_id": "int_approve789",
      "name": "handle_interrupt",
      "status": "in_progress",
      "arguments": "{\"interrupt_type\":\"approval\",\"details\":{\"flight\":\"UA 1234\",\"departure\":\"SEA 08:00 AM\",\"arrival\":\"JFK 04:30 PM\",\"price\":\"$450\",\"date\":\"2025-03-15\"},\"message\":\"Please confirm to proceed with this booking.\"}"
    }
  ],
  "created_at": 1738900000,
  "completed_at": null
}
```

### RAPI Request - Resume

```http
POST /openai/v1/responses HTTP/1.1
Content-Type: application/json

{
  "agent_reference": {
    "type": "agent_reference",
    "name": "booking-assistant",
    "version": "1"
  },
  "conversation_id": "conv_book001",
  "input": [
    {
      "type": "function_call_output",
      "call_id": "int_approve789",
      "output": "{\"approved\":true}"
    }
  ]
}
```

### RAPI Response - Completed

```json
{
  "id": "resp_book002",
  "object": "response",
  "status": "completed",
  "conversation_id": "conv_book001",
  "agent_reference": {
    "type": "agent_reference",
    "name": "booking-assistant",
    "version": "1"
  },
  "output": [
    {
      "id": "msg_008",
      "type": "output_message",
      "role": "assistant",
      "status": "completed",
      "content": [
        {
          "type": "text",
          "text": "✅ Booking confirmed! Flight UA 1234 from Seattle to New York on March 15. Confirmation number: ABC123XYZ"
        }
      ]
    },
    {
      "id": "item_struct003",
      "type": "structured_outputs",
      "output": {
        "confirmation_number": "ABC123XYZ",
        "total_charged": "$450"
      }
    }
  ],
  "created_at": 1738900020,
  "completed_at": 1738900023
}
```

### Invoke Request - Initial (Internal)

```http
POST /invoke HTTP/1.1
Content-Type: application/json

{
  "agent_def": {
    "name": "booking-assistant",
    "version": "1"
  },
  "input": "Book a flight from SEA to JFK on March 15",
  "session_id": "sess_book001"
}
```

### Invoke Response - Interrupt (Internal)

```json
{
  "id": "inv_book001",
  "status": "awaiting_input",
  "session_id": "sess_book001",
  "output": {
    "content": [
      {
        "item_type": "text",
        "text": "I found a flight that matches your requirements:"
      },
      {
        "item_type": "interrupt",
        "interrupt_id": "int_approve789",
        "interrupt_type": "approval",
        "details": {
          "flight": "UA 1234",
          "departure": "SEA 08:00 AM",
          "arrival": "JFK 04:30 PM",
          "price": "$450",
          "date": "2025-03-15"
        },
        "message": "Please confirm to proceed with this booking."
      }
    ]
  },
  "created_at": 1738900000,
  "completed_at": null
}
```

### Invoke Request - Resume (Internal)

```http
POST /invoke HTTP/1.1
Content-Type: application/json

{
  "agent_def": {
    "name": "booking-assistant",
    "version": "1"
  },
  "input": [
    {
      "content": [
        {
          "item_type": "interrupt_resume",
          "interrupt_id": "int_approve789",
          "payload": {
            "approved": true
          }
        }
      ]
    }
  ],
  "session_id": "sess_book001"
}
```

### Invoke Response - Completed (Internal)

```json
{
  "id": "inv_book002",
  "status": "completed",
  "session_id": "sess_book001",
  "output": {
    "content": [
      {
        "item_type": "text",
        "text": "✅ Booking confirmed! Flight UA 1234 from Seattle to New York on March 15. Confirmation number: ABC123XYZ"
      },
      {
        "item_type": "structured_data",
        "data": {
          "confirmation_number": "ABC123XYZ",
          "total_charged": "$450"
        }
      }
    ]
  },
  "created_at": 1738900020,
  "completed_at": 1738900023
}
```

---

## 7. Human-in-the-Loop - Form Input

Agent requests additional information from user.

### RAPI Request - Initial

```http
POST /openai/v1/responses HTTP/1.1
Content-Type: application/json

{
  "agent_reference": {
    "type": "agent_reference",
    "name": "support-ticket-agent",
    "version": "1"
  },
  "input": [
    {
      "type": "message",
      "role": "user",
      "content": [
        {
          "type": "input_text",
          "text": "I need help with my account"
        }
      ]
    }
  ]
}
```

### RAPI Response - Interrupt

```json
{
  "id": "resp_support001",
  "object": "response",
  "status": "incomplete",
  "conversation_id": "conv_support001",
  "agent_reference": {
    "type": "agent_reference",
    "name": "support-ticket-agent",
    "version": "1"
  },
  "output": [
    {
      "id": "msg_009",
      "type": "output_message",
      "role": "assistant",
      "status": "completed",
      "content": [
        {
          "type": "text",
          "text": "I'll help you with your account issue. I need some additional information:"
        }
      ]
    },
    {
      "id": "call_int002",
      "type": "function_call",
      "call_id": "int_form123",
      "name": "handle_interrupt",
      "status": "in_progress",
      "arguments": "{\"interrupt_type\":\"form_input\",\"form_schema\":{\"fields\":[{\"name\":\"account_id\",\"type\":\"text\",\"label\":\"Account ID\",\"required\":true},{\"name\":\"issue_type\",\"type\":\"select\",\"label\":\"Issue Type\",\"options\":[\"Login Problem\",\"Billing Question\",\"Feature Request\",\"Other\"],\"required\":true},{\"name\":\"description\",\"type\":\"textarea\",\"label\":\"Description\",\"required\":true}]}}"
    }
  ],
  "created_at": 1738900000,
  "completed_at": null
}
```

### RAPI Request - Resume

```http
POST /openai/v1/responses HTTP/1.1
Content-Type: application/json

{
  "agent_reference": {
    "type": "agent_reference",
    "name": "support-ticket-agent",
    "version": "1"
  },
  "conversation_id": "conv_support001",
  "input": [
    {
      "type": "function_call_output",
      "call_id": "int_form123",
      "output": "{\"account_id\":\"ACC-98765\",\"issue_type\":\"Login Problem\",\"description\":\"I cannot log in with my password\"}"
    }
  ]
}
```

### RAPI Response - Completed

```json
{
  "id": "resp_support002",
  "object": "response",
  "status": "completed",
  "conversation_id": "conv_support001",
  "agent_reference": {
    "type": "agent_reference",
    "name": "support-ticket-agent",
    "version": "1"
  },
  "output": [
    {
      "id": "msg_010",
      "type": "output_message",
      "role": "assistant",
      "status": "completed",
      "content": [
        {
          "type": "text",
          "text": "Support ticket created successfully! Ticket #TKT-54321. Our team will respond within 24 hours."
        }
      ]
    },
    {
      "id": "item_struct004",
      "type": "structured_outputs",
      "output": {
        "ticket_id": "TKT-54321",
        "priority": "high",
        "assigned_to": "support-tier-1"
      }
    }
  ],
  "created_at": 1738900030,
  "completed_at": 1738900032
}
```

### Invoke Request - Initial (Internal)

```http
POST /invoke HTTP/1.1
Content-Type: application/json

{
  "agent_def": {
    "name": "support-ticket-agent",
    "version": "1"
  },
  "input": "I need help with my account",
  "session_id": "sess_support001"
}
```

### Invoke Response - Interrupt (Internal)

```json
{
  "id": "inv_support001",
  "status": "awaiting_input",
  "session_id": "sess_support001",
  "output": {
    "content": [
      {
        "item_type": "text",
        "text": "I'll help you with your account issue. I need some additional information:"
      },
      {
        "item_type": "interrupt",
        "interrupt_id": "int_form123",
        "interrupt_type": "form_input",
        "form_schema": {
          "fields": [
            {
              "name": "account_id",
              "type": "text",
              "label": "Account ID",
              "required": true
            },
            {
              "name": "issue_type",
              "type": "select",
              "label": "Issue Type",
              "options": ["Login Problem", "Billing Question", "Feature Request", "Other"],
              "required": true
            },
            {
              "name": "description",
              "type": "textarea",
              "label": "Description",
              "required": true
            }
          ]
        }
      }
    ]
  },
  "created_at": 1738900000,
  "completed_at": null
}
```

### Invoke Request - Resume (Internal)

```http
POST /invoke HTTP/1.1
Content-Type: application/json

{
  "agent_def": {
    "name": "support-ticket-agent",
    "version": "1"
  },
  "input": [
    {
      "content": [
        {
          "item_type": "interrupt_resume",
          "interrupt_id": "int_form123",
          "payload": {
            "account_id": "ACC-98765",
            "issue_type": "Login Problem",
            "description": "I cannot log in with my password"
          }
        }
      ]
    }
  ],
  "session_id": "sess_support001"
}
```

### Invoke Response - Completed (Internal)

```json
{
  "id": "inv_support002",
  "status": "completed",
  "session_id": "sess_support001",
  "output": {
    "content": [
      {
        "item_type": "text",
        "text": "Support ticket created successfully! Ticket #TKT-54321. Our team will respond within 24 hours."
      },
      {
        "item_type": "structured_data",
        "data": {
          "ticket_id": "TKT-54321",
          "priority": "high",
          "assigned_to": "support-tier-1"
        }
      }
    ]
  },
  "created_at": 1738900030,
  "completed_at": 1738900032
}
```

---

## 8. Streaming Response (SSE Events)

Example SSE event stream showing how text is streamed and interrupts are delivered.

### RAPI Request

```http
POST /openai/v1/responses HTTP/1.1
Content-Type: application/json
Accept: text/event-stream

{
  "agent_reference": {
    "type": "agent_reference",
    "name": "booking-assistant",
    "version": "1"
  },
  "input": [
    {
      "type": "message",
      "role": "user",
      "content": [
        {
          "type": "input_text",
          "text": "Book a flight from Seattle to New York on March 15"
        }
      ]
    }
  ]
}
```

### RAPI Response Stream (SSE)

```text
event: response.created
data: {"type":"response.created","response":{"id":"resp_stream001","object":"response","created_at":1738900000,"status":"in_progress","conversation_id":"conv_stream001","agent_reference":{"type":"agent_reference","name":"booking-assistant","version":"1"},"output":[],"completed_at":null},"sequence_number":1}

event: response.in_progress
data: {"type":"response.in_progress","response":{"id":"resp_stream001","object":"response","created_at":1738900000,"status":"in_progress","conversation_id":"conv_stream001","agent_reference":{"type":"agent_reference","name":"booking-assistant","version":"1"},"output":[],"completed_at":null},"sequence_number":2}

event: response.output_item.added
data: {"type":"response.output_item.added","output_index":0,"item":{"id":"msg_001","type":"message","status":"in_progress","role":"assistant","content":[]},"sequence_number":3}

event: response.content_part.added
data: {"type":"response.content_part.added","item_id":"msg_001","output_index":0,"content_index":0,"part":{"type":"output_text","text":"","annotations":[]},"sequence_number":4}

event: response.output_text.delta
data: {"type":"response.output_text.delta","item_id":"msg_001","output_index":0,"content_index":0,"delta":"I","sequence_number":5}

event: response.output_text.delta
data: {"type":"response.output_text.delta","item_id":"msg_001","output_index":0,"content_index":0,"delta":"'ll","sequence_number":6}

event: response.output_text.delta
data: {"type":"response.output_text.delta","item_id":"msg_001","output_index":0,"content_index":0,"delta":" help","sequence_number":7}

event: response.output_text.delta
data: {"type":"response.output_text.delta","item_id":"msg_001","output_index":0,"content_index":0,"delta":" you","sequence_number":8}

event: response.output_text.delta
data: {"type":"response.output_text.delta","item_id":"msg_001","output_index":0,"content_index":0,"delta":" book","sequence_number":9}

event: response.output_text.delta
data: {"type":"response.output_text.delta","item_id":"msg_001","output_index":0,"content_index":0,"delta":" that","sequence_number":10}

event: response.output_text.delta
data: {"type":"response.output_text.delta","item_id":"msg_001","output_index":0,"content_index":0,"delta":" flight","sequence_number":11}

event: response.output_text.delta
data: {"type":"response.output_text.delta","item_id":"msg_001","output_index":0,"content_index":0,"delta":".","sequence_number":12}

event: response.output_text.delta
data: {"type":"response.output_text.delta","item_id":"msg_001","output_index":0,"content_index":0,"delta":" I","sequence_number":13}

event: response.output_text.delta
data: {"type":"response.output_text.delta","item_id":"msg_001","output_index":0,"content_index":0,"delta":" found","sequence_number":14}

event: response.output_text.delta
data: {"type":"response.output_text.delta","item_id":"msg_001","output_index":0,"content_index":0,"delta":" a","sequence_number":15}

event: response.output_text.delta
data: {"type":"response.output_text.delta","item_id":"msg_001","output_index":0,"content_index":0,"delta":" flight","sequence_number":16}

event: response.output_text.delta
data: {"type":"response.output_text.delta","item_id":"msg_001","output_index":0,"content_index":0,"delta":":","sequence_number":17}

event: response.output_text.done
data: {"type":"response.output_text.done","item_id":"msg_001","output_index":0,"content_index":0,"text":"I'll help you book that flight. I found a flight:","sequence_number":18}

event: response.content_part.done
data: {"type":"response.content_part.done","item_id":"msg_001","output_index":0,"content_index":0,"part":{"type":"output_text","text":"I'll help you book that flight. I found a flight:","annotations":[]},"sequence_number":19}

event: response.output_item.done
data: {"type":"response.output_item.done","output_index":0,"item":{"id":"msg_001","type":"message","status":"completed","role":"assistant","content":[{"type":"output_text","text":"I'll help you book that flight. I found a flight:","annotations":[]}]},"sequence_number":20}

event: response.output_item.added
data: {"type":"response.output_item.added","output_index":1,"item":{"id":"call_int003","type":"function_call","call_id":"int_book789","name":"handle_interrupt","status":"in_progress","arguments":""},"sequence_number":21}

event: response.function_call_arguments.delta
data: {"type":"response.function_call_arguments.delta","item_id":"call_int003","output_index":1,"delta":"{\"interrupt_type\":\"approval\",\"details\":{\"flight\":\"UA 1234\",\"departure\":\"SEA 08:00 AM\",\"arrival\":\"JFK 04:30 PM\",\"price\":\"$450\",\"date\":\"2025-03-15\"},\"message\":\"Please confirm to proceed with this booking.\"}","sequence_number":22}

event: response.function_call_arguments.done
data: {"type":"response.function_call_arguments.done","item_id":"call_int003","output_index":1,"arguments":"{\"interrupt_type\":\"approval\",\"details\":{\"flight\":\"UA 1234\",\"departure\":\"SEA 08:00 AM\",\"arrival\":\"JFK 04:30 PM\",\"price\":\"$450\",\"date\":\"2025-03-15\"},\"message\":\"Please confirm to proceed with this booking.\"}","sequence_number":23}

event: response.output_item.done
data: {"type":"response.output_item.done","output_index":1,"item":{"id":"call_int003","type":"function_call","call_id":"int_book789","name":"handle_interrupt","status":"in_progress","arguments":"{\"interrupt_type\":\"approval\",\"details\":{\"flight\":\"UA 1234\",\"departure\":\"SEA 08:00 AM\",\"arrival\":\"JFK 04:30 PM\",\"price\":\"$450\",\"date\":\"2025-03-15\"},\"message\":\"Please confirm to proceed with this booking.\"}"},"sequence_number":24}

event: response.completed
data: {"type":"response.completed","response":{"id":"resp_stream001","object":"response","created_at":1738900000,"status":"incomplete","conversation_id":"conv_stream001","agent_reference":{"type":"agent_reference","name":"booking-assistant","version":"1"},"output":[{"id":"msg_001","type":"message","status":"completed","role":"assistant","content":[{"type":"output_text","text":"I'll help you book that flight. I found a flight:","annotations":[]}]},{"id":"call_int003","type":"function_call","call_id":"int_book789","name":"handle_interrupt","status":"in_progress","arguments":"{\"interrupt_type\":\"approval\",\"details\":{\"flight\":\"UA 1234\",\"departure\":\"SEA 08:00 AM\",\"arrival\":\"JFK 04:30 PM\",\"price\":\"$450\",\"date\":\"2025-03-15\"},\"message\":\"Please confirm to proceed with this booking.\"}"}],"completed_at":1738900005},"sequence_number":25}
```

### Invoke Request (Internal)

```http
POST /invoke HTTP/1.1
Content-Type: application/json
Accept: text/event-stream

{
  "agent_def": {
    "name": "booking-assistant",
    "version": "1"
  },
  "input": "Book a flight from Seattle to New York on March 15",
  "session_id": "sess_stream001"
}
```

### Invoke Response Stream (SSE, Internal)

```text
event: invoke.created
data: {"seq":0,"session_id":"sess_stream001","created_at":1738900000}

event: output.content.delta
data: {"seq":1,"index":0,"item_type":"text","delta":{"text":"I"},"final":false}

event: output.content.delta
data: {"seq":2,"index":0,"item_type":"text","delta":{"text":"'ll"},"final":false}

event: output.content.delta
data: {"seq":3,"index":0,"item_type":"text","delta":{"text":" help"},"final":false}

event: output.content.delta
data: {"seq":4,"index":0,"item_type":"text","delta":{"text":" you"},"final":false}

event: output.content.delta
data: {"seq":5,"index":0,"item_type":"text","delta":{"text":" book"},"final":false}

event: output.content.delta
data: {"seq":6,"index":0,"item_type":"text","delta":{"text":" that"},"final":false}

event: output.content.delta
data: {"seq":7,"index":0,"item_type":"text","delta":{"text":" flight"},"final":false}

event: output.content.delta
data: {"seq":8,"index":0,"item_type":"text","delta":{"text":"."},"final":false}

event: output.content.delta
data: {"seq":9,"index":0,"item_type":"text","delta":{"text":" I"},"final":false}

event: output.content.delta
data: {"seq":10,"index":0,"item_type":"text","delta":{"text":" found"},"final":false}

event: output.content.delta
data: {"seq":11,"index":0,"item_type":"text","delta":{"text":" a"},"final":false}

event: output.content.delta
data: {"seq":12,"index":0,"item_type":"text","delta":{"text":" flight"},"final":false}

event: output.content.delta
data: {"seq":13,"index":0,"item_type":"text","delta":{"text":":"},"final":true}

event: output.content.final
data: {"seq":14,"index":1,"item":{"item_type":"interrupt","interrupt_id":"int_book789","interrupt_type":"approval","details":{"flight":"UA 1234","departure":"SEA 08:00 AM","arrival":"JFK 04:30 PM","price":"$450","date":"2025-03-15"},"message":"Please confirm to proceed with this booking."}}

event: invoke.completed
data: {"seq":15,"status":"awaiting_input","completed_at":1738900005}
```

---

## 9. Custom Parameters and Configuration

Using request parameters for custom agent configuration and telemetry.

### RAPI Request

```http
POST /openai/v1/responses HTTP/1.1
Content-Type: application/json

{
  "agent_reference": {
    "type": "agent_reference",
    "name": "research-assistant",
    "version": "1"
  },
  "structured_inputs": {
    "user_id": "user_12345",
    "search_depth": "comprehensive",
    "max_results": 10,
    "preferred_sources": ["arxiv", "ieee", "acm"],
    "trace_id": "trace_abc789"
  },
  "input": [
    {
      "type": "message",
      "role": "user",
      "content": [
        {
          "type": "input_text",
          "text": "Find recent papers on quantum computing"
        }
      ]
    }
  ]
}
```

### RAPI Response

```json
{
  "id": "resp_research001",
  "object": "response",
  "status": "completed",
  "conversation_id": "conv_research001",
  "agent_reference": {
    "type": "agent_reference",
    "name": "research-assistant",
    "version": "1"
  },
  "output": [
    {
      "id": "msg_011",
      "type": "output_message",
      "role": "assistant",
      "status": "completed",
      "content": [
        {
          "type": "text",
          "text": "I found 8 recent papers on quantum computing published in the last 6 months. Here are the top 3:\n\n1. 'Advances in Quantum Error Correction' (arXiv, 2024)\n2. 'Scalable Quantum Computing Architectures' (IEEE, 2024)\n3. 'Quantum Algorithms for Machine Learning' (ACM, 2024)"
        }
      ]
    },
    {
      "id": "item_struct005",
      "type": "structured_outputs",
      "output": {
        "papers_found": 8,
        "sources_searched": ["arxiv", "ieee", "acm"],
        "search_duration_ms": 2340,
        "trace_id": "trace_abc789",
        "citations": [
          {
            "title": "Advances in Quantum Error Correction",
            "url": "https://arxiv.org/abs/2024.12345",
            "year": 2024
          }
        ]
      }
    }
  ],
  "created_at": 1738900000,
  "completed_at": 1738900005
}
```

### Invoke Request (Internal)

```http
POST /invoke HTTP/1.1
Content-Type: application/json

{
  "agent_def": {
    "name": "research-assistant",
    "version": "1"
  },
  "input": "Find recent papers on quantum computing",
  "params": {
    "user_id": "user_12345",
    "search_depth": "comprehensive",
    "max_results": 10,
    "preferred_sources": ["arxiv", "ieee", "acm"],
    "trace_id": "trace_abc789"
  },
  "session_id": "sess_research001"
}
```

### Invoke Response (Internal)

```json
{
  "id": "inv_research001",
  "status": "completed",
  "session_id": "sess_research001",
  "output": {
    "content": [
      {
        "item_type": "text",
        "text": "I found 8 recent papers on quantum computing published in the last 6 months. Here are the top 3:\n\n1. 'Advances in Quantum Error Correction' (arXiv, 2024)\n2. 'Scalable Quantum Computing Architectures' (IEEE, 2024)\n3. 'Quantum Algorithms for Machine Learning' (ACM, 2024)"
      },
      {
        "item_type": "structured_data",
        "data": {
          "papers_found": 8,
          "sources_searched": ["arxiv", "ieee", "acm"],
          "search_duration_ms": 2340,
          "trace_id": "trace_abc789",
          "citations": [
            {
              "title": "Advances in Quantum Error Correction",
              "url": "https://arxiv.org/abs/2024.12345",
              "year": 2024
            }
          ]
        }
      }
    ]
  },
  "created_at": 1738900000,
  "completed_at": 1738900005
}
```

---

## 10. Complete Mapping Reference

### Request Mapping

1. **Agent Identification**
   - RAPI: `agent_reference` object with `type`, `name`, `version`
   - Invoke: `agent_def` object with `name`, `version`

2. **Session Tracking**
   - RAPI: `conversation_id` (string)
   - Invoke: `session_id` (string) - computed as hash(agent_name, agent_version, conversation_id)

3. **Input Content**
   - RAPI: `messages` array with `role` and `content` items
   - Invoke: `input` (string or InvokeMessage array)

4. **Custom Parameters**
   - RAPI: `structured_inputs` (object)
   - Invoke: `params` (object)

5. **Resume After Interrupt**
   - RAPI: `function_call_output` content item with `call_id` and `output`
   - Invoke: `interrupt_resume` content item with `interrupt_id` and `payload`

### Response Mapping

1. **Status**
   - RAPI: `status` ("completed", "incomplete", "failed", "cancelled")
   - Invoke: `status` ("completed", "awaiting_input", "failed")

2. **Text Content**
   - RAPI: `message` output item with `text` content
   - Invoke: `text` content item

3. **Image Content**
   - RAPI: `image_file` content in message
   - Invoke: `image` content item

4. **File Content**
   - RAPI: `file` content in message
   - Invoke: `file` content item

5. **Structured Data**
   - RAPI: `structured_outputs` output item
   - Invoke: `structured_data` content item

6. **Interrupts/HITL**
   - RAPI: `function_call` with name "handle_interrupt"
   - Invoke: `interrupt` content item

### SSE Event Mapping

| RAPI Event | Invoke Event | Purpose |
| ---------- | ------------ | ------- |
| `response.created` | `invoke.created` | Response/invocation started |
| `output.item.delta` | `output.content.delta` | Incremental content update |
| `output.item.final` | `output.content.final` | Complete atomic item |
| `response.completed` | `invoke.completed` | Terminal event |

---

## Notes

- RAPI is designed to be OpenAI-compatible, following the Responses API specification
- When RAPI receives a request for a hosted agent, it internally calls the Invoke API
- The mapping layer handles conversion between RAPI's message-based structure and Invoke's content-based structure
- **Session ID Mapping**: `conversation_id` in RAPI maps to `session_id` in Invoke, but it's not a direct copy. The `session_id` is computed as a hash of the agent name, agent version, and conversation_id. This ensures session continuity and proper routing across multiple turns
- **Interrupt Handling**: The function name "handle_interrupt" in RAPI is used specifically for human-in-the-loop scenarios and maps to Invoke's `interrupt` content item
- All timestamps are Unix seconds in both APIs
- `status` values map between the two APIs: "incomplete" (RAPI) ↔ "awaiting_input" (Invoke)
