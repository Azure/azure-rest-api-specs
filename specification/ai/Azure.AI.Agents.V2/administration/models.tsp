import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace OpenAI;
/** Represents an individual Admin API key in an org. */
@extension(
  "x-oaiMeta",
  #{
    name: "The admin API key object",
    example: "{\n  \"object\": \"organization.admin_api_key\",\n  \"id\": \"key_abc\",\n  \"name\": \"Main Admin Key\",\n  \"redacted_value\": \"sk-admin...xyz\",\n  \"created_at\": 1711471533,\n  \"last_used_at\": 1711471534,\n  \"owner\": {\n    \"type\": \"user\",\n    \"object\": \"organization.user\",\n    \"id\": \"user_123\",\n    \"name\": \"John Doe\",\n    \"created_at\": 1711471533,\n    \"role\": \"owner\"\n  }\n}\n",
  }
)
model AdminApiKey {
  /** The object type, which is always `organization.admin_api_key` */
  @extension("x-stainless-const", true)
  object: string;

  /** The identifier, which can be referenced in API endpoints */
  id: string;

  /** The name of the API key */
  name: string;

  /** The redacted value of the API key */
  redacted_value: string;

  /** The value of the API key. Only shown on create. */
  value?: string;

  /** The Unix timestamp (in seconds) of when the API key was created */
  created_at: int64;

  /** The Unix timestamp (in seconds) of when the API key was last used */
  last_used_at: int64 | null;

  owner: {
    type?: string;
    object?: string;
    id?: string;
    name?: string;
    created_at?: int64;
    role?: string;
  };
}

model ApiKeyList {
  object?: string;
  data?: AdminApiKey[];
  has_more?: boolean;
  first_id?: string;
  last_id?: string;
}

/** A log of a user action or configuration change within this organization. */
@extension(
  "x-oaiMeta",
  #{
    name: "The audit log object",
    example: "{\n    \"id\": \"req_xxx_20240101\",\n    \"type\": \"api_key.created\",\n    \"effective_at\": 1720804090,\n    \"actor\": {\n        \"type\": \"session\",\n        \"session\": {\n            \"user\": {\n                \"id\": \"user-xxx\",\n                \"email\": \"user@example.com\"\n            },\n            \"ip_address\": \"127.0.0.1\",\n            \"user_agent\": \"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36\"\n        }\n    },\n    \"api_key.created\": {\n        \"id\": \"key_xxxx\",\n        \"data\": {\n            \"scopes\": [\"resource.operation\"]\n        }\n    }\n}\n",
  }
)
model AuditLog {
  /** The ID of this log. */
  id: string;

  type: AuditLogEventType;

  /** The Unix timestamp (in seconds) of the event. */
  effective_at: integer;

  /** The project that the action was scoped to. Absent for actions not scoped to projects. Note that any admin actions taken via Admin API keys are associated with the default project. */
  project?: {
    id?: string;
    name?: string;
  };

  actor: AuditLogActor;

  /** The details for events with this `type`. */
  `api_key.created`?: {
    id?: string;
    data?: {
      scopes?: string[];
    };
  };

  /** The details for events with this `type`. */
  `api_key.updated`?: {
    id?: string;
    changes_requested?: {
      scopes?: string[];
    };
  };

  /** The details for events with this `type`. */
  `api_key.deleted`?: {
    id?: string;
  };

  /** The project and fine-tuned model checkpoint that the checkpoint permission was created for. */
  `checkpoint_permission.created`?: {
    id?: string;
    data?: {
      project_id?: string;
      fine_tuned_model_checkpoint?: string;
    };
  };

  /** The details for events with this `type`. */
  `checkpoint_permission.deleted`?: {
    id?: string;
  };

  /** The details for events with this `type`. */
  `invite.sent`?: {
    id?: string;
    data?: {
      email?: string;
      role?: string;
    };
  };

  /** The details for events with this `type`. */
  `invite.accepted`?: {
    id?: string;
  };

  /** The details for events with this `type`. */
  `invite.deleted`?: {
    id?: string;
  };

  /** The details for events with this `type`. */
  `login.failed`?: {
    error_code?: string;
    error_message?: string;
  };

  /** The details for events with this `type`. */
  `logout.failed`?: {
    error_code?: string;
    error_message?: string;
  };

  /** The details for events with this `type`. */
  `organization.updated`?: {
    id?: string;
    changes_requested?: {
      title?: string;
      description?: string;
      name?: string;
      threads_ui_visibility?: string;
      usage_dashboard_visibility?: string;
      api_call_logging?: string;
      api_call_logging_project_ids?: string;
    };
  };

  /** The details for events with this `type`. */
  `project.created`?: {
    id?: string;
    data?: {
      name?: string;
      title?: string;
    };
  };

  /** The details for events with this `type`. */
  `project.updated`?: {
    id?: string;
    changes_requested?: {
      title?: string;
    };
  };

  /** The details for events with this `type`. */
  `project.archived`?: {
    id?: string;
  };

  /** The details for events with this `type`. */
  `rate_limit.updated`?: {
    id?: string;
    changes_requested?: {
      max_requests_per_1_minute?: integer;
      max_tokens_per_1_minute?: integer;
      max_images_per_1_minute?: integer;
      max_audio_megabytes_per_1_minute?: integer;
      max_requests_per_1_day?: integer;
      batch_1_day_max_input_tokens?: integer;
    };
  };

  /** The details for events with this `type`. */
  `rate_limit.deleted`?: {
    id?: string;
  };

  /** The details for events with this `type`. */
  `service_account.created`?: {
    id?: string;
    data?: {
      role?: string;
    };
  };

  /** The details for events with this `type`. */
  `service_account.updated`?: {
    id?: string;
    changes_requested?: {
      role?: string;
    };
  };

  /** The details for events with this `type`. */
  `service_account.deleted`?: {
    id?: string;
  };

  /** The details for events with this `type`. */
  `user.added`?: {
    id?: string;
    data?: {
      role?: string;
    };
  };

  /** The details for events with this `type`. */
  `user.updated`?: {
    id?: string;
    changes_requested?: {
      role?: string;
    };
  };

  /** The details for events with this `type`. */
  `user.deleted`?: {
    id?: string;
  };

  /** The details for events with this `type`. */
  `certificate.created`?: {
    id?: string;
    name?: string;
  };

  /** The details for events with this `type`. */
  `certificate.updated`?: {
    id?: string;
    name?: string;
  };

  /** The details for events with this `type`. */
  `certificate.deleted`?: {
    id?: string;
    name?: string;
    certificate?: string;
  };

  /** The details for events with this `type`. */
  `certificates.activated`?: {
    certificates?: {
      id?: string;
      name?: string;
    }[];
  };

  /** The details for events with this `type`. */
  `certificates.deactivated`?: {
    certificates?: {
      id?: string;
      name?: string;
    }[];
  };
}

/** The event type. */
enum AuditLogEventType {
  `api_key.created`,
  `api_key.updated`,
  `api_key.deleted`,
  `checkpoint_permission.created`,
  `checkpoint_permission.deleted`,
  `invite.sent`,
  `invite.accepted`,
  `invite.deleted`,
  `login.succeeded`,
  `login.failed`,
  `logout.succeeded`,
  `logout.failed`,
  `organization.updated`,
  `project.created`,
  `project.updated`,
  `project.archived`,
  `service_account.created`,
  `service_account.updated`,
  `service_account.deleted`,
  `rate_limit.updated`,
  `rate_limit.deleted`,
  `user.added`,
  `user.updated`,
  `user.deleted`,
}

/** The actor who performed the audit logged action. */
model AuditLogActor {
  /** The type of actor. Is either `session` or `api_key`. */
  type?: "session" | "api_key";

  session?: AuditLogActorSession;
  api_key?: AuditLogActorApiKey;
}

/** The session in which the audit logged action was performed. */
model AuditLogActorSession {
  user?: AuditLogActorUser;

  /** The IP address from which the action was performed. */
  ip_address?: string;
}

/** The user who performed the audit logged action. */
model AuditLogActorUser {
  /** The user id. */
  id?: string;

  /** The user email. */
  email?: string;
}

/** The API Key used to perform the audit logged action. */
model AuditLogActorApiKey {
  /** The tracking id of the API key. */
  id?: string;

  /** The type of API key. Can be either `user` or `service_account`. */
  type?: "user" | "service_account";

  user?: AuditLogActorUser;
  service_account?: AuditLogActorServiceAccount;
}

/** The service account that performed the audit logged action. */
model AuditLogActorServiceAccount {
  /** The service account id. */
  id?: string;
}

/** Represents an individual `certificate` uploaded to the organization. */
@extension(
  "x-oaiMeta",
  #{
    name: "The certificate object",
    example: "{\n  \"object\": \"certificate\",\n  \"id\": \"cert_abc\",\n  \"name\": \"My Certificate\",\n  \"created_at\": 1234567,\n  \"certificate_details\": {\n    \"valid_at\": 1234567,\n    \"expires_at\": 12345678,\n    \"content\": \"-----BEGIN CERTIFICATE----- MIIGAjCCA...6znFlOW+ -----END CERTIFICATE-----\"\n  }\n}\n",
  }
)
model Certificate {
  /**The object type.

  - If creating, updating, or getting a specific certificate, the object type is `certificate`.
  - If listing, activating, or deactivating certificates for the organization, the object type is `organization.certificate`.
  - If listing, activating, or deactivating certificates for a project, the object type is `organization.project.certificate`.*/
  @extension("x-stainless-const", true)
  object: "certificate" | "organization.certificate" | "organization.project.certificate";

  /** The identifier, which can be referenced in API endpoints */
  id: string;

  /** The name of the certificate. */
  name: string;

  /** The Unix timestamp (in seconds) of when the certificate was uploaded. */
  created_at: integer;

  certificate_details: {
    valid_at?: integer;
    expires_at?: integer;
    content?: string;
  };

  /** Whether the certificate is currently active at the specified scope. Not returned when getting details for a specific certificate. */
  active?: boolean;
}

/** The aggregated costs details of the specific time bucket. */
@extension(
  "x-oaiMeta",
  #{
    name: "Costs object",
    example: "{\n    \"object\": \"organization.costs.result\",\n    \"amount\": {\n      \"value\": 0.06,\n      \"currency\": \"usd\"\n    },\n    \"line_item\": \"Image models\",\n    \"project_id\": \"proj_abc\"\n}\n",
  }
)
model CostsResult {
  @extension("x-stainless-const", true)
  object: "organization.costs.result";

  /** The monetary value in its associated currency. */
  amount?: {
    value?: numeric;
    currency?: string;
  };

  /** When `group_by=line_item`, this field provides the line item of the grouped costs result. */
  line_item?: string | null;

  /** When `group_by=project_id`, this field provides the project ID of the grouped costs result. */
  project_id?: string | null;
}

model DeleteCertificateResponse {
  /** The object type, must be `certificate.deleted`. */
  @extension("x-stainless-const", true)
  object: "certificate.deleted";

  /** The ID of the certificate that was deleted. */
  id: string;
}

/** Represents an individual `invite` to the organization. */
@extension(
  "x-oaiMeta",
  #{
    name: "The invite object",
    example: "{\n  \"object\": \"organization.invite\",\n  \"id\": \"invite-abc\",\n  \"email\": \"user@example.com\",\n  \"role\": \"owner\",\n  \"status\": \"accepted\",\n  \"invited_at\": 1711471533,\n  \"expires_at\": 1711471533,\n  \"accepted_at\": 1711471533,\n  \"projects\": [\n    {\n      \"id\": \"project-xyz\",\n      \"role\": \"member\"\n    }\n  ]\n}\n",
  }
)
model Invite {
  /** The object type, which is always `organization.invite` */
  @extension("x-stainless-const", true)
  object: "organization.invite";

  /** The identifier, which can be referenced in API endpoints */
  id: string;

  /** The email address of the individual to whom the invite was sent */
  email: string;

  /** `owner` or `reader` */
  role: "owner" | "reader";

  /** `accepted`,`expired`, or `pending` */
  status: "accepted" | "expired" | "pending";

  /** The Unix timestamp (in seconds) of when the invite was sent. */
  invited_at: integer;

  /** The Unix timestamp (in seconds) of when the invite expires. */
  expires_at: integer;

  /** The Unix timestamp (in seconds) of when the invite was accepted. */
  accepted_at?: integer;

  /** The projects that were granted membership upon acceptance of the invite. */
  projects?: {
    id?: string;
    role?: "member" | "owner";
  }[];
}

model InviteDeleteResponse {
  /** The object type, which is always `organization.invite.deleted` */
  @extension("x-stainless-const", true)
  object: "organization.invite.deleted";

  id: string;
  deleted: boolean;
}

model InviteListResponse {
  /** The object type, which is always `list` */
  @extension("x-stainless-const", true)
  object: "list";

  data: Invite[];

  /** The first `invite_id` in the retrieved `list` */
  first_id?: string;

  /** The last `invite_id` in the retrieved `list` */
  last_id?: string;

  /** The `has_more` property is used for pagination to indicate there are additional results. */
  has_more?: boolean;
}

model InviteRequest {
  /** Send an email to this address */
  email: string;

  /** `owner` or `reader` */
  role: "reader" | "owner";

  /** An array of projects to which membership is granted at the same time the org invite is accepted. If omitted, the user will be invited to the default project for compatibility with legacy behavior. */
  projects?: {
    id: string;
    role: "member" | "owner";
  }[];
}

model ListAuditLogsResponse {
  @extension("x-stainless-const", true)
  object: "list";

  data: AuditLog[];
  first_id: string;
  last_id: string;
  has_more: boolean;
}

model ListCertificatesResponse {
  data: Certificate[];
  first_id?: string;
  last_id?: string;
  has_more: boolean;

  @extension("x-stainless-const", true)
  object: "list";
}

model ModifyCertificateRequest {
  /** The updated name for the certificate */
  name: string;
}

/** Represents an individual project. */
@extension(
  "x-oaiMeta",
  #{
    name: "The project object",
    example: "{\n    \"id\": \"proj_abc\",\n    \"object\": \"organization.project\",\n    \"name\": \"Project example\",\n    \"created_at\": 1711471533,\n    \"archived_at\": null,\n    \"status\": \"active\"\n}\n",
  }
)
model Project {
  /** The identifier, which can be referenced in API endpoints */
  id: string;

  /** The object type, which is always `organization.project` */
  @extension("x-stainless-const", true)
  object: "organization.project";

  /** The name of the project. This appears in reporting. */
  name: string;

  /** The Unix timestamp (in seconds) of when the project was created. */
  created_at: integer;

  /** The Unix timestamp (in seconds) of when the project was archived or `null`. */
  archived_at?: integer | null;

  /** `active` or `archived` */
  status: "active" | "archived";
}

/** Represents an individual API key in a project. */
@extension(
  "x-oaiMeta",
  #{
    name: "The project API key object",
    example: "{\n    \"object\": \"organization.project.api_key\",\n    \"redacted_value\": \"sk-abc...def\",\n    \"name\": \"My API Key\",\n    \"created_at\": 1711471533,\n    \"last_used_at\": 1711471534,\n    \"id\": \"key_abc\",\n    \"owner\": {\n        \"type\": \"user\",\n        \"user\": {\n            \"object\": \"organization.project.user\",\n            \"id\": \"user_abc\",\n            \"name\": \"First Last\",\n            \"email\": \"user@example.com\",\n            \"role\": \"owner\",\n            \"created_at\": 1711471533\n        }\n    }\n}\n",
  }
)
model ProjectApiKey {
  /** The object type, which is always `organization.project.api_key` */
  @extension("x-stainless-const", true)
  object: "organization.project.api_key";

  /** The redacted value of the API key */
  redacted_value: string;

  /** The name of the API key */
  name: string;

  /** The Unix timestamp (in seconds) of when the API key was created */
  created_at: integer;

  /** The Unix timestamp (in seconds) of when the API key was last used. */
  last_used_at: integer;

  /** The identifier, which can be referenced in API endpoints */
  id: string;

  owner: {
    type?: "user" | "service_account";
    user?: ProjectUser;
    service_account?: ProjectServiceAccount;
  };
}

/** Represents an individual user in a project. */
@extension(
  "x-oaiMeta",
  #{
    name: "The project user object",
    example: "{\n    \"object\": \"organization.project.user\",\n    \"id\": \"user_abc\",\n    \"name\": \"First Last\",\n    \"email\": \"user@example.com\",\n    \"role\": \"owner\",\n    \"added_at\": 1711471533\n}\n",
  }
)
model ProjectUser {
  /** The object type, which is always `organization.project.user` */
  @extension("x-stainless-const", true)
  object: "organization.project.user";

  /** The identifier, which can be referenced in API endpoints */
  id: string;

  /** The name of the user */
  name: string;

  /** The email address of the user */
  email: string;

  /** `owner` or `member` */
  role: "owner" | "member";

  /** The Unix timestamp (in seconds) of when the project was added. */
  added_at: integer;
}

/** Represents an individual service account in a project. */
@extension(
  "x-oaiMeta",
  #{
    name: "The project service account object",
    example: "{\n    \"object\": \"organization.project.service_account\",\n    \"id\": \"svc_acct_abc\",\n    \"name\": \"Service Account\",\n    \"role\": \"owner\",\n    \"created_at\": 1711471533\n}\n",
  }
)
model ProjectServiceAccount {
  /** The object type, which is always `organization.project.service_account` */
  @extension("x-stainless-const", true)
  object: "organization.project.service_account";

  /** The identifier, which can be referenced in API endpoints */
  id: string;

  /** The name of the service account */
  name: string;

  /** `owner` or `member` */
  role: "owner" | "member";

  /** The Unix timestamp (in seconds) of when the service account was created */
  created_at: integer;
}

model ProjectApiKeyDeleteResponse {
  @extension("x-stainless-const", true)
  object: "organization.project.api_key.deleted";

  id: string;
  deleted: boolean;
}

model ProjectApiKeyListResponse {
  @extension("x-stainless-const", true)
  object: "list";

  data: ProjectApiKey[];
  first_id: string;
  last_id: string;
  has_more: boolean;
}

model ProjectCreateRequest {
  /** The friendly name of the project, this name appears in reports. */
  name: string;
}

model ProjectListResponse {
  @extension("x-stainless-const", true)
  object: "list";

  data: Project[];
  first_id: string;
  last_id: string;
  has_more: boolean;
}

/** Represents a project rate limit config. */
@extension(
  "x-oaiMeta",
  #{
    name: "The project rate limit object",
    example: "{\n    \"object\": \"project.rate_limit\",\n    \"id\": \"rl_ada\",\n    \"model\": \"ada\",\n    \"max_requests_per_1_minute\": 600,\n    \"max_tokens_per_1_minute\": 150000,\n    \"max_images_per_1_minute\": 10\n}\n",
  }
)
model ProjectRateLimit {
  /** The object type, which is always `project.rate_limit` */
  @extension("x-stainless-const", true)
  object: "project.rate_limit";

  /** The identifier, which can be referenced in API endpoints. */
  id: string;

  /** The model this rate limit applies to. */
  `model`: string;

  /** The maximum requests per minute. */
  max_requests_per_1_minute: integer;

  /** The maximum tokens per minute. */
  max_tokens_per_1_minute: integer;

  /** The maximum images per minute. Only present for relevant models. */
  max_images_per_1_minute?: integer;

  /** The maximum audio megabytes per minute. Only present for relevant models. */
  max_audio_megabytes_per_1_minute?: integer;

  /** The maximum requests per day. Only present for relevant models. */
  max_requests_per_1_day?: integer;

  /** The maximum batch input tokens per day. Only present for relevant models. */
  batch_1_day_max_input_tokens?: integer;
}

model ProjectRateLimitListResponse {
  @extension("x-stainless-const", true)
  object: "list";

  data: ProjectRateLimit[];
  first_id: string;
  last_id: string;
  has_more: boolean;
}

model ProjectRateLimitUpdateRequest {
  /** The maximum requests per minute. */
  max_requests_per_1_minute?: integer;

  /** The maximum tokens per minute. */
  max_tokens_per_1_minute?: integer;

  /** The maximum images per minute. Only relevant for certain models. */
  max_images_per_1_minute?: integer;

  /** The maximum audio megabytes per minute. Only relevant for certain models. */
  max_audio_megabytes_per_1_minute?: integer;

  /** The maximum requests per day. Only relevant for certain models. */
  max_requests_per_1_day?: integer;

  /** The maximum batch input tokens per day. Only relevant for certain models. */
  batch_1_day_max_input_tokens?: integer;
}

model ProjectServiceAccountApiKey {
  /** The object type, which is always `organization.project.service_account.api_key` */
  @extension("x-stainless-const", true)
  object: "organization.project.service_account.api_key";

  value: string;
  name: string;
  created_at: integer;
  id: string;
}

model ProjectServiceAccountCreateRequest {
  /** The name of the service account being created. */
  name: string;
}

model ProjectServiceAccountCreateResponse {
  @extension("x-stainless-const", true)
  object: "organization.project.service_account";

  id: string;
  name: string;

  /** Service accounts can only have one role of type `member` */
  @extension("x-stainless-const", true)
  role: "member";

  created_at: integer;
  api_key: ProjectServiceAccountApiKey;
}

model ProjectServiceAccountDeleteResponse {
  @extension("x-stainless-const", true)
  object: "organization.project.service_account.deleted";

  id: string;
  deleted: boolean;
}

model ProjectServiceAccountListResponse {
  @extension("x-stainless-const", true)
  object: "list";

  data: ProjectServiceAccount[];
  first_id: string;
  last_id: string;
  has_more: boolean;
}

model ProjectUpdateRequest {
  /** The updated name of the project, this name appears in reports. */
  name: string;
}

model ProjectUserCreateRequest {
  /** The ID of the user. */
  user_id: string;

  /** `owner` or `member` */
  role: "owner" | "member";
}

model ProjectUserDeleteResponse {
  @extension("x-stainless-const", true)
  object: "organization.project.user.deleted";

  id: string;
  deleted: boolean;
}

model ProjectUserListResponse {
  object: string;
  data: ProjectUser[];
  first_id: string;
  last_id: string;
  has_more: boolean;
}

model ProjectUserUpdateRequest {
  /** `owner` or `member` */
  role: "owner" | "member";
}

model ToggleCertificatesRequest {
  @maxItems(10)
  @minItems(1)
  certificate_ids: string[];
}

model UploadCertificateRequest {
  /** An optional name for the certificate */
  name?: string;

  /** The certificate content in PEM format */
  content: string;
}

/** The aggregated audio speeches usage details of the specific time bucket. */
@extension(
  "x-oaiMeta",
  #{
    name: "Audio speeches usage object",
    example: "{\n    \"object\": \"organization.usage.audio_speeches.result\",\n    \"characters\": 45,\n    \"num_model_requests\": 1,\n    \"project_id\": \"proj_abc\",\n    \"user_id\": \"user-abc\",\n    \"api_key_id\": \"key_abc\",\n    \"model\": \"tts-1\"\n}\n",
  }
)
model UsageAudioSpeechesResult {
  @extension("x-stainless-const", true)
  object: "organization.usage.audio_speeches.result";

  /** The number of characters processed. */
  characters: integer;

  /** The count of requests made to the model. */
  num_model_requests: integer;

  /** When `group_by=project_id`, this field provides the project ID of the grouped usage result. */
  project_id?: string | null;

  /** When `group_by=user_id`, this field provides the user ID of the grouped usage result. */
  user_id?: string | null;

  /** When `group_by=api_key_id`, this field provides the API key ID of the grouped usage result. */
  api_key_id?: string | null;

  /** When `group_by=model`, this field provides the model name of the grouped usage result. */
  `model`?: string | null;
}

/** The aggregated audio transcriptions usage details of the specific time bucket. */
@extension(
  "x-oaiMeta",
  #{
    name: "Audio transcriptions usage object",
    example: "{\n    \"object\": \"organization.usage.audio_transcriptions.result\",\n    \"seconds\": 10,\n    \"num_model_requests\": 1,\n    \"project_id\": \"proj_abc\",\n    \"user_id\": \"user-abc\",\n    \"api_key_id\": \"key_abc\",\n    \"model\": \"tts-1\"\n}\n",
  }
)
model UsageAudioTranscriptionsResult {
  @extension("x-stainless-const", true)
  object: "organization.usage.audio_transcriptions.result";

  /** The number of seconds processed. */
  seconds: integer;

  /** The count of requests made to the model. */
  num_model_requests: integer;

  /** When `group_by=project_id`, this field provides the project ID of the grouped usage result. */
  project_id?: string | null;

  /** When `group_by=user_id`, this field provides the user ID of the grouped usage result. */
  user_id?: string | null;

  /** When `group_by=api_key_id`, this field provides the API key ID of the grouped usage result. */
  api_key_id?: string | null;

  /** When `group_by=model`, this field provides the model name of the grouped usage result. */
  `model`?: string | null;
}

/** The aggregated code interpreter sessions usage details of the specific time bucket. */
@extension(
  "x-oaiMeta",
  #{
    name: "Code interpreter sessions usage object",
    example: "{\n    \"object\": \"organization.usage.code_interpreter_sessions.result\",\n    \"num_sessions\": 1,\n    \"project_id\": \"proj_abc\"\n}\n",
  }
)
model UsageCodeInterpreterSessionsResult {
  @extension("x-stainless-const", true)
  object: "organization.usage.code_interpreter_sessions.result";

  /** The number of code interpreter sessions. */
  num_sessions?: integer;

  /** When `group_by=project_id`, this field provides the project ID of the grouped usage result. */
  project_id?: string | null;
}

/** The aggregated completions usage details of the specific time bucket. */
@extension(
  "x-oaiMeta",
  #{
    name: "Completions usage object",
    example: "{\n    \"object\": \"organization.usage.completions.result\",\n    \"input_tokens\": 5000,\n    \"output_tokens\": 1000,\n    \"input_cached_tokens\": 4000,\n    \"input_audio_tokens\": 300,\n    \"output_audio_tokens\": 200,\n    \"num_model_requests\": 5,\n    \"project_id\": \"proj_abc\",\n    \"user_id\": \"user-abc\",\n    \"api_key_id\": \"key_abc\",\n    \"model\": \"gpt-4o-mini-2024-07-18\",\n    \"batch\": false\n}\n",
  }
)
model UsageCompletionsResult {
  @extension("x-stainless-const", true)
  object: "organization.usage.completions.result";

  /** The aggregated number of text input tokens used, including cached tokens. For customers subscribe to scale tier, this includes scale tier tokens. */
  input_tokens: integer;

  /** The aggregated number of text input tokens that has been cached from previous requests. For customers subscribe to scale tier, this includes scale tier tokens. */
  input_cached_tokens?: integer;

  /** The aggregated number of text output tokens used. For customers subscribe to scale tier, this includes scale tier tokens. */
  output_tokens: integer;

  /** The aggregated number of audio input tokens used, including cached tokens. */
  input_audio_tokens?: integer;

  /** The aggregated number of audio output tokens used. */
  output_audio_tokens?: integer;

  /** The count of requests made to the model. */
  num_model_requests: integer;

  /** When `group_by=project_id`, this field provides the project ID of the grouped usage result. */
  project_id?: string | null;

  /** When `group_by=user_id`, this field provides the user ID of the grouped usage result. */
  user_id?: string | null;

  /** When `group_by=api_key_id`, this field provides the API key ID of the grouped usage result. */
  api_key_id?: string | null;

  /** When `group_by=model`, this field provides the model name of the grouped usage result. */
  `model`?: string | null;

  /** When `group_by=batch`, this field tells whether the grouped usage result is batch or not. */
  batch?: boolean | null;
}

/** The aggregated embeddings usage details of the specific time bucket. */
@extension(
  "x-oaiMeta",
  #{
    name: "Embeddings usage object",
    example: "{\n    \"object\": \"organization.usage.embeddings.result\",\n    \"input_tokens\": 20,\n    \"num_model_requests\": 2,\n    \"project_id\": \"proj_abc\",\n    \"user_id\": \"user-abc\",\n    \"api_key_id\": \"key_abc\",\n    \"model\": \"text-embedding-ada-002-v2\"\n}\n",
  }
)
model UsageEmbeddingsResult {
  @extension("x-stainless-const", true)
  object: "organization.usage.embeddings.result";

  /** The aggregated number of input tokens used. */
  input_tokens: integer;

  /** The count of requests made to the model. */
  num_model_requests: integer;

  /** When `group_by=project_id`, this field provides the project ID of the grouped usage result. */
  project_id?: string | null;

  /** When `group_by=user_id`, this field provides the user ID of the grouped usage result. */
  user_id?: string | null;

  /** When `group_by=api_key_id`, this field provides the API key ID of the grouped usage result. */
  api_key_id?: string | null;

  /** When `group_by=model`, this field provides the model name of the grouped usage result. */
  `model`?: string | null;
}

/** The aggregated images usage details of the specific time bucket. */
@extension(
  "x-oaiMeta",
  #{
    name: "Images usage object",
    example: "{\n    \"object\": \"organization.usage.images.result\",\n    \"images\": 2,\n    \"num_model_requests\": 2,\n    \"size\": \"1024x1024\",\n    \"source\": \"image.generation\",\n    \"project_id\": \"proj_abc\",\n    \"user_id\": \"user-abc\",\n    \"api_key_id\": \"key_abc\",\n    \"model\": \"dall-e-3\"\n}\n",
  }
)
model UsageImagesResult {
  @extension("x-stainless-const", true)
  object: "organization.usage.images.result";

  /** The number of images processed. */
  images: integer;

  /** The count of requests made to the model. */
  num_model_requests: integer;

  /** When `group_by=source`, this field provides the source of the grouped usage result, possible values are `image.generation`, `image.edit`, `image.variation`. */
  source?: string | null;

  /** When `group_by=size`, this field provides the image size of the grouped usage result. */
  size?: string | null;

  /** When `group_by=project_id`, this field provides the project ID of the grouped usage result. */
  project_id?: string | null;

  /** When `group_by=user_id`, this field provides the user ID of the grouped usage result. */
  user_id?: string | null;

  /** When `group_by=api_key_id`, this field provides the API key ID of the grouped usage result. */
  api_key_id?: string | null;

  /** When `group_by=model`, this field provides the model name of the grouped usage result. */
  `model`?: string | null;
}

/** The aggregated moderations usage details of the specific time bucket. */
@extension(
  "x-oaiMeta",
  #{
    name: "Moderations usage object",
    example: "{\n    \"object\": \"organization.usage.moderations.result\",\n    \"input_tokens\": 20,\n    \"num_model_requests\": 2,\n    \"project_id\": \"proj_abc\",\n    \"user_id\": \"user-abc\",\n    \"api_key_id\": \"key_abc\",\n    \"model\": \"text-moderation\"\n}\n",
  }
)
model UsageModerationsResult {
  @extension("x-stainless-const", true)
  object: "organization.usage.moderations.result";

  /** The aggregated number of input tokens used. */
  input_tokens: integer;

  /** The count of requests made to the model. */
  num_model_requests: integer;

  /** When `group_by=project_id`, this field provides the project ID of the grouped usage result. */
  project_id?: string | null;

  /** When `group_by=user_id`, this field provides the user ID of the grouped usage result. */
  user_id?: string | null;

  /** When `group_by=api_key_id`, this field provides the API key ID of the grouped usage result. */
  api_key_id?: string | null;

  /** When `group_by=model`, this field provides the model name of the grouped usage result. */
  `model`?: string | null;
}

model UsageResponse {
  @extension("x-stainless-const", true)
  object: "page";

  data: UsageTimeBucket[];
  has_more: boolean;
  next_page: string;
}

model UsageTimeBucket {
  @extension("x-stainless-const", true)
  object: "bucket";

  start_time: integer;
  end_time: integer;
  result: (
    | UsageCompletionsResult
    | UsageEmbeddingsResult
    | UsageModerationsResult
    | UsageImagesResult
    | UsageAudioSpeechesResult
    | UsageAudioTranscriptionsResult
    | UsageVectorStoresResult
    | UsageCodeInterpreterSessionsResult
    | CostsResult)[];
}

/** The aggregated vector stores usage details of the specific time bucket. */
@extension(
  "x-oaiMeta",
  #{
    name: "Vector stores usage object",
    example: "{\n    \"object\": \"organization.usage.vector_stores.result\",\n    \"usage_bytes\": 1024,\n    \"project_id\": \"proj_abc\"\n}\n",
  }
)
model UsageVectorStoresResult {
  @extension("x-stainless-const", true)
  object: "organization.usage.vector_stores.result";

  /** The vector stores usage in bytes. */
  usage_bytes: integer;

  /** When `group_by=project_id`, this field provides the project ID of the grouped usage result. */
  project_id?: string | null;
}

/** Represents an individual `user` within an organization. */
@extension(
  "x-oaiMeta",
  #{
    name: "The user object",
    example: "{\n    \"object\": \"organization.user\",\n    \"id\": \"user_abc\",\n    \"name\": \"First Last\",\n    \"email\": \"user@example.com\",\n    \"role\": \"owner\",\n    \"added_at\": 1711471533\n}\n",
  }
)
model User {
  /** The object type, which is always `organization.user` */
  @extension("x-stainless-const", true)
  object: "organization.user";

  /** The identifier, which can be referenced in API endpoints */
  id: string;

  /** The name of the user */
  name: string;

  /** The email address of the user */
  email: string;

  /** `owner` or `reader` */
  role: "owner" | "reader";

  /** The Unix timestamp (in seconds) of when the user was added. */
  added_at: integer;
}

model UserDeleteResponse {
  @extension("x-stainless-const", true)
  object: "organization.user.deleted";

  id: string;
  deleted: boolean;
}

model UserListResponse {
  @extension("x-stainless-const", true)
  object: "list";

  data: User[];
  first_id: string;
  last_id: string;
  has_more: boolean;
}

model UserRoleUpdateRequest {
  /** `owner` or `reader` */
  role: "owner" | "reader";
}
