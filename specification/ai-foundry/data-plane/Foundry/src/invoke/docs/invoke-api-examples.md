# Invoke API Examples

This document provides scenario-based examples for the Foundry Agent Invoke API. Each example shows complete request/response payloads using the current API specification.

---

## Table of Contents

1. [Simple Text Query](#simple-text-query)
2. [Multi-turn Conversation](#multi-turn-conversation)
3. [Multimodal Input - Image Analysis](#multimodal-input---image-analysis)
4. [Multimodal Input - Document Processing](#multimodal-input---document-processing)
5. [File References (Platform-Managed)](#file-references-platform-managed)
6. [Human-in-the-Loop - Tool Approval](#human-in-the-loop---tool-approval)
7. [Human-in-the-Loop - Form Input](#human-in-the-loop---form-input)
8. [Streaming Response (SSE Events)](#streaming-response-sse-events)
9. [Custom Parameters and Configuration](#custom-parameters-and-configuration)
10. [SSE Event Types Reference](#sse-event-types-reference)

---

## Simple Text Query

Basic text-only interaction with an agent.

### Request

```http
POST /invoke HTTP/1.1
Content-Type: application/json

{
  "agent_def": {
    "name": "customer-support-bot",
    "version": "1"
  },
  "input": "What is your return policy?"
}
```

### Response (Terminal Event)

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

## Multi-turn Conversation

Continuing a conversation using `session_id`.

### First Request

```http
POST /invoke HTTP/1.1
Content-Type: application/json

{
  "agent_def": {
    "name": "travel-assistant",
    "version": "1"
  },
  "input": "I need to book a flight to New York"
}
```

### First Response

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

### Follow-up Request

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

### Follow-up Response

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

## Multimodal Input - Image Analysis

Send an image for analysis using base64 encoding.

### Request

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
  ]
}
```

### Response

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

## Multimodal Input - Document Processing

Send a PDF document using URL reference.

### Request

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
  ]
}
```

### Response

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

## File References (Platform-Managed)

Using platform-managed files via `file_id`.

### Request

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
  ]
}
```

### Response

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

## Human-in-the-Loop - Tool Approval

Agent requests approval before executing a sensitive action.

### Initial Request

```http
POST /invoke HTTP/1.1
Content-Type: application/json

{
  "agent_def": {
    "name": "booking-assistant",
    "version": "1"
  },
  "input": "Book a flight from SEA to JFK on March 15"
}
```

### Initial Response (Interrupt for Approval)

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

### Resume Request (User Approves)

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

### Final Response (Booking Confirmed)

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

## Human-in-the-Loop - Form Input

Agent requests additional information from user.

### Initial Request

```http
POST /invoke HTTP/1.1
Content-Type: application/json

{
  "agent_def": {
    "name": "support-ticket-agent",
    "version": "1"
  },
  "input": "I need help with my account"
}
```

### Initial Response (Interrupt for Form Data)

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

### Resume Request (User Submits Form)

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

### Final Response (Ticket Created)

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

## Streaming Response (SSE Events)

Example SSE event stream showing how text is streamed with `content.delta` and interrupts are delivered with `content.final`.

### Request

```http
POST /invoke HTTP/1.1
Content-Type: application/json
Accept: text/event-stream

{
  "agent_def": {
    "name": "booking-assistant",
    "version": "1"
  },
  "input": "Book a flight from Seattle to New York on March 15"
}
```

### Response Stream (SSE)

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
data: {"seq":15,"status":"awaiting_input","metadata":{},"completed_at":1738900005}
```

---

## Custom Parameters and Configuration

Using request parameters for custom agent configuration and telemetry. Structured data in responses is returned as `StructuredDataContentItem`.

### Request with Custom Parameters

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
  }
}
```

### Response with Structured Data

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

## SSE Event Types Reference

Quick reference for all SSE event types in streaming responses:

| Event Type               | Purpose                                  | Key Fields                                                |
| ------------------------ | ---------------------------------------- | --------------------------------------------------------- |
| `invoke.created`         | Invocation started                       | `seq`, `session_id`, `created_at`                         |
| `output.content.delta`   | Incremental content update (merge)       | `seq`, `index`, `item_type`, `delta`, `final`             |
| `output.content.final`   | Complete content item (replace)          | `seq`, `index`, `item`                                    |
| `invoke.completed`       | Terminal event                           | `seq`, `status`, `metadata`, `error`, `completed_at`      |

### Delta vs Final Events

- **Delta events**: Used for incremental streaming where content is built up over time (e.g., text generation).
  Client merges delta properties with existing content.
- **Final events**: Used for atomic content items that don't support incremental updates (e.g., images, files, interrupts).
  Client replaces entire content at index.

---

## Notes

- All timestamps (`created_at`, `completed_at`) are Unix seconds
- `session_id` is generated by the platform if not provided
- String `input` is automatically converted to `[{"content": [{"item_type": "text", "text": "..."}]}]`
- Request `params` must be an object (can be empty `{}`)
- `output.content` is always an array of `ContentItem` objects
- Structured data (e.g., citations, telemetry) should be included as `StructuredDataContentItem` in the output content array
- Content items support three delivery mechanisms: `file_id` (platform-managed), `url` (remote), or `data` (base64)

