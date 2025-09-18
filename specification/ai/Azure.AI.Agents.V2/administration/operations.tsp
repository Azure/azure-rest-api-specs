import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";
import "../common/models.tsp";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace OpenAI;
/** List organization API keys */
@summary("List all organization and project API keys.")
@get
@route("/organization/admin_api_keys")
@extension(
  "x-oaiMeta",
  #{
    name: "List all organization and project API keys.",
    group: "administration",
    returns: "A list of admin and project API key objects.",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"object\": \"organization.admin_api_key\",\n      \"id\": \"key_abc\",\n      \"name\": \"Main Admin Key\",\n      \"redacted_value\": \"sk-admin...def\",\n      \"created_at\": 1711471533,\n      \"last_used_at\": 1711471534,\n      \"owner\": {\n        \"type\": \"service_account\",\n        \"object\": \"organization.service_account\",\n        \"id\": \"sa_456\",\n        \"name\": \"My Service Account\",\n        \"created_at\": 1711471533,\n        \"role\": \"member\"\n      }\n    }\n  ],\n  \"first_id\": \"key_abc\",\n  \"last_id\": \"key_abc\",\n  \"has_more\": false\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/organization/admin_api_keys?after=key_abc&limit=20 \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
      },
    },
  }
)
op `admin-api-keys-list`(
  @query(#{ explode: true })
  after?: string | null,

  @query(#{ explode: true })
  order?: "asc" | "desc" = "asc",

  @query(#{ explode: true })
  limit?: integer = 20,
): ApiKeyList;

/** Create an organization admin API key */
@summary("Create admin API key")
@post
@route("/organization/admin_api_keys")
@extension(
  "x-oaiMeta",
  #{
    name: "Create admin API key",
    group: "administration",
    returns: "The created [AdminApiKey](https://platform.openai.com/docs/api-reference/admin-api-keys/object) object.",
    examples: #{
      response: "{\n  \"object\": \"organization.admin_api_key\",\n  \"id\": \"key_xyz\",\n  \"name\": \"New Admin Key\",\n  \"redacted_value\": \"sk-admin...xyz\",\n  \"created_at\": 1711471533,\n  \"last_used_at\": 1711471534,\n  \"owner\": {\n    \"type\": \"user\",\n    \"object\": \"organization.user\",\n    \"id\": \"user_123\",\n    \"name\": \"John Doe\",\n    \"created_at\": 1711471533,\n    \"role\": \"owner\"\n  },\n  \"value\": \"sk-admin-1234abcd\"\n}\n",
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/organization/admin_api_keys \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{\n      \"name\": \"New Admin Key\"\n  }'\n",
      },
    },
  }
)
op `admin-api-keys-create`(
  @body
  body: {
    name: string;
  },
): AdminApiKey;

/** Delete an organization admin API key */
@summary("Delete admin API key")
@delete
@route("/organization/admin_api_keys/{key_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Delete admin API key",
    group: "administration",
    returns: "A confirmation object indicating the key was deleted.",
    examples: #{
      response: "{\n  \"id\": \"key_abc\",\n  \"object\": \"organization.admin_api_key.deleted\",\n  \"deleted\": true\n}\n",
      request: #{
        curl: "curl -X DELETE https://api.openai.com/v1/organization/admin_api_keys/key_abc \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
      },
    },
  }
)
op `admin-api-keys-delete`(
  @path
  key_id: string,
): Body<{
  id?: string;
  object?: string;
  deleted?: boolean;
}>;

/** Retrieve a single organization API key */
@summary("Retrieve admin API key")
@get
@route("/organization/admin_api_keys/{key_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve admin API key",
    group: "administration",
    returns: "The requested [AdminApiKey](https://platform.openai.com/docs/api-reference/admin-api-keys/object) object.",
    examples: #{
      response: "{\n  \"object\": \"organization.admin_api_key\",\n  \"id\": \"key_abc\",\n  \"name\": \"Main Admin Key\",\n  \"redacted_value\": \"sk-admin...xyz\",\n  \"created_at\": 1711471533,\n  \"last_used_at\": 1711471534,\n  \"owner\": {\n    \"type\": \"user\",\n    \"object\": \"organization.user\",\n    \"id\": \"user_123\",\n    \"name\": \"John Doe\",\n    \"created_at\": 1711471533,\n    \"role\": \"owner\"\n  }\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/organization/admin_api_keys/key_abc \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
      },
    },
  }
)
op `admin-api-keys-get`(
  @path
  key_id: string,
): AdminApiKey;

/** List user actions and configuration changes within this organization. */
@summary("List audit logs")
@get
@route("/organization/audit_logs")
@extension(
  "x-oaiMeta",
  #{
    name: "List audit logs",
    group: "audit-logs",
    returns: "A list of paginated [Audit Log](https://platform.openai.com/docs/api-reference/audit-logs/object) objects.",
    examples: #{
      response: "{\n    \"object\": \"list\",\n    \"data\": [\n        {\n            \"id\": \"audit_log-xxx_yyyymmdd\",\n            \"type\": \"project.archived\",\n            \"effective_at\": 1722461446,\n            \"actor\": {\n                \"type\": \"api_key\",\n                \"api_key\": {\n                    \"type\": \"user\",\n                    \"user\": {\n                        \"id\": \"user-xxx\",\n                        \"email\": \"user@example.com\"\n                    }\n                }\n            },\n            \"project.archived\": {\n                \"id\": \"proj_abc\"\n            },\n        },\n        {\n            \"id\": \"audit_log-yyy__20240101\",\n            \"type\": \"api_key.updated\",\n            \"effective_at\": 1720804190,\n            \"actor\": {\n                \"type\": \"session\",\n                \"session\": {\n                    \"user\": {\n                        \"id\": \"user-xxx\",\n                        \"email\": \"user@example.com\"\n                    },\n                    \"ip_address\": \"127.0.0.1\",\n                    \"user_agent\": \"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36\",\n                    \"ja3\": \"a497151ce4338a12c4418c44d375173e\",\n                    \"ja4\": \"q13d0313h3_55b375c5d22e_c7319ce65786\",\n                    \"ip_address_details\": {\n                      \"country\": \"US\",\n                      \"city\": \"San Francisco\",\n                      \"region\": \"California\",\n                      \"region_code\": \"CA\",\n                      \"asn\": \"1234\",\n                      \"latitude\": \"37.77490\",\n                      \"longitude\": \"-122.41940\"\n                    }\n                }\n            },\n            \"api_key.updated\": {\n                \"id\": \"key_xxxx\",\n                \"data\": {\n                    \"scopes\": [\"resource_2.operation_2\"]\n                }\n            },\n        }\n    ],\n    \"first_id\": \"audit_log-xxx__20240101\",\n    \"last_id\": \"audit_log_yyy__20240101\",\n    \"has_more\": true\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/organization/audit_logs \\\n-H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n-H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Audit Logs")
op `list-audit-logs`(
  /** Return only events whose `effective_at` (Unix seconds) is in this range. */
  @query(#{ explode: true })
  effective_at?: {
    gt?: integer;
    gte?: integer;
    lt?: integer;
    lte?: integer;
  },

  /** Return only events for these projects. */
  @query(#{ explode: true })
  `project_ids[]`?: string[],

  /** Return only events with a `type` in one of these values. For example, `project.created`. For all options, see the documentation for the [audit log object](https://platform.openai.com/docs/api-reference/audit-logs/object). */
  @query(#{ explode: true })
  `event_types[]`?: AuditLogEventType[],

  /** Return only events performed by these actors. Can be a user ID, a service account ID, or an api key tracking ID. */
  @query(#{ explode: true })
  `actor_ids[]`?: string[],

  /** Return only events performed by users with these emails. */
  @query(#{ explode: true })
  `actor_emails[]`?: string[],

  /** Return only events performed on these targets. For example, a project ID updated. */
  @query(#{ explode: true })
  `resource_ids[]`?: string[],

  /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
  @query(#{ explode: true })
  limit?: integer = 20,

  /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
  @query(#{ explode: true })
  after?: string,

  /** A cursor for use in pagination. `before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with obj_foo, your subsequent call can include before=obj_foo in order to fetch the previous page of the list. */
  @query(#{ explode: true })
  before?: string,
): ListAuditLogsResponse;

/** List uploaded certificates for this organization. */
@summary("List organization certificates")
@get
@route("/organization/certificates")
@extension(
  "x-oaiMeta",
  #{
    name: "List organization certificates",
    group: "administration",
    returns: "A list of [Certificate](https://platform.openai.com/docs/api-reference/certificates/object) objects.",
    examples: #{
      request: #{
        curl: "curl https://api.openai.com/v1/organization/certificates \\\n-H \"Authorization: Bearer $OPENAI_ADMIN_KEY\"\n",
      },
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"object\": \"organization.certificate\",\n      \"id\": \"cert_abc\",\n      \"name\": \"My Example Certificate\",\n      \"active\": true,\n      \"created_at\": 1234567,\n      \"certificate_details\": {\n        \"valid_at\": 12345667,\n        \"expires_at\": 12345678\n      }\n    },\n  ],\n  \"first_id\": \"cert_abc\",\n  \"last_id\": \"cert_abc\",\n  \"has_more\": false\n}\n",
    },
  }
)
@tag("Certificates")
op listOrganizationCertificates(
  /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
  @query(#{ explode: true })
  limit?: integer = 20,

  /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
  @query(#{ explode: true })
  after?: string,

  /** Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending order. */
  @query(#{ explode: true })
  order?: "asc" | "desc" = "desc",
): ListCertificatesResponse;

/**Upload a certificate to the organization. This does **not** automatically activate the certificate.

Organizations can upload up to 50 certificates.*/
@summary("Upload certificate")
@post
@route("/organization/certificates")
@extension(
  "x-oaiMeta",
  #{
    name: "Upload certificate",
    group: "administration",
    returns: "A single [Certificate](https://platform.openai.com/docs/api-reference/certificates/object) object.",
    examples: #{
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/organization/certificates \\\n-H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n-H \"Content-Type: application/json\" \\\n-d '{\n  \"name\": \"My Example Certificate\",\n  \"certificate\": \"-----BEGIN CERTIFICATE-----\\\\nMIIDeT...\\\\n-----END CERTIFICATE-----\"\n}'\n",
      },
      response: "{\n  \"object\": \"certificate\",\n  \"id\": \"cert_abc\",\n  \"name\": \"My Example Certificate\",\n  \"created_at\": 1234567,\n  \"certificate_details\": {\n    \"valid_at\": 12345667,\n    \"expires_at\": 12345678\n  }\n}\n",
    },
  }
)
@tag("Certificates")
op uploadCertificate(
  /** The certificate upload payload. */
  @body
  body: UploadCertificateRequest,
): Certificate;

/**Activate certificates at the organization level.

You can atomically and idempotently activate up to 10 certificates at a time.*/
@summary("Activate certificates for organization")
@post
@route("/organization/certificates/activate")
@extension(
  "x-oaiMeta",
  #{
    name: "Activate certificates for organization",
    group: "administration",
    returns: "A list of [Certificate](https://platform.openai.com/docs/api-reference/certificates/object) objects that were activated.",
    examples: #{
      request: #{
        curl: "curl https://api.openai.com/v1/organization/certificates/activate \\\n-H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n-H \"Content-Type: application/json\" \\\n-d '{\n  \"data\": [\"cert_abc\", \"cert_def\"]\n}'\n",
      },
      response: "{\n  \"object\": \"organization.certificate.activation\",\n  \"data\": [\n    {\n      \"object\": \"organization.certificate\",\n      \"id\": \"cert_abc\",\n      \"name\": \"My Example Certificate\",\n      \"active\": true,\n      \"created_at\": 1234567,\n      \"certificate_details\": {\n        \"valid_at\": 12345667,\n        \"expires_at\": 12345678\n      }\n    },\n    {\n      \"object\": \"organization.certificate\",\n      \"id\": \"cert_def\",\n      \"name\": \"My Example Certificate 2\",\n      \"active\": true,\n      \"created_at\": 1234567,\n      \"certificate_details\": {\n        \"valid_at\": 12345667,\n        \"expires_at\": 12345678\n      }\n    },\n  ],\n}\n",
    },
  }
)
@tag("Certificates")
op activateOrganizationCertificates(
  /** The certificate activation payload. */
  @body
  body: ToggleCertificatesRequest,
): ListCertificatesResponse;

/**Deactivate certificates at the organization level.

You can atomically and idempotently deactivate up to 10 certificates at a time.*/
@summary("Deactivate certificates for organization")
@post
@route("/organization/certificates/deactivate")
@extension(
  "x-oaiMeta",
  #{
    name: "Deactivate certificates for organization",
    group: "administration",
    returns: "A list of [Certificate](https://platform.openai.com/docs/api-reference/certificates/object) objects that were deactivated.",
    examples: #{
      request: #{
        curl: "curl https://api.openai.com/v1/organization/certificates/deactivate \\\n-H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n-H \"Content-Type: application/json\" \\\n-d '{\n  \"data\": [\"cert_abc\", \"cert_def\"]\n}'\n",
      },
      response: "{\n  \"object\": \"organization.certificate.deactivation\",\n  \"data\": [\n    {\n      \"object\": \"organization.certificate\",\n      \"id\": \"cert_abc\",\n      \"name\": \"My Example Certificate\",\n      \"active\": false,\n      \"created_at\": 1234567,\n      \"certificate_details\": {\n        \"valid_at\": 12345667,\n        \"expires_at\": 12345678\n      }\n    },\n    {\n      \"object\": \"organization.certificate\",\n      \"id\": \"cert_def\",\n      \"name\": \"My Example Certificate 2\",\n      \"active\": false,\n      \"created_at\": 1234567,\n      \"certificate_details\": {\n        \"valid_at\": 12345667,\n        \"expires_at\": 12345678\n      }\n    },\n  ],\n}\n",
    },
  }
)
@tag("Certificates")
op deactivateOrganizationCertificates(
  /** The certificate deactivation payload. */
  @body
  body: ToggleCertificatesRequest,
): ListCertificatesResponse;

/**Delete a certificate from the organization.

The certificate must be inactive for the organization and all projects.*/
@summary("Delete certificate")
@delete
@route("/organization/certificates/{certificate_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Delete certificate",
    group: "administration",
    returns: "A confirmation object indicating the certificate was deleted.",
    examples: #{
      request: #{
        curl: "curl -X DELETE https://api.openai.com/v1/organization/certificates/cert_abc \\\n-H \"Authorization: Bearer $OPENAI_ADMIN_KEY\"\n",
      },
      response: "{\n  \"object\": \"certificate.deleted\",\n  \"id\": \"cert_abc\"\n}\n",
    },
  }
)
@tag("Certificates")
op deleteCertificate(
  /** Unique ID of the certificate to retrieve. */
  @path
  certificate_id: string,
): DeleteCertificateResponse;

/**Get a certificate that has been uploaded to the organization.

You can get a certificate regardless of whether it is active or not.*/
@summary("Get certificate")
@get
@route("/organization/certificates/{certificate_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Get certificate",
    group: "administration",
    returns: "A single [Certificate](https://platform.openai.com/docs/api-reference/certificates/object) object.",
    examples: #{
      request: #{
        curl: "curl \"https://api.openai.com/v1/organization/certificates/cert_abc?include[]=content\" \\\n-H \"Authorization: Bearer $OPENAI_ADMIN_KEY\"\n",
      },
      response: "{\n  \"object\": \"certificate\",\n  \"id\": \"cert_abc\",\n  \"name\": \"My Example Certificate\",\n  \"created_at\": 1234567,\n  \"certificate_details\": {\n    \"valid_at\": 1234567,\n    \"expires_at\": 12345678,\n    \"content\": \"-----BEGIN CERTIFICATE-----MIIDeT...-----END CERTIFICATE-----\"\n  }\n}\n",
    },
  }
)
@tag("Certificates")
op getCertificate(
  /** Unique ID of the certificate to retrieve. */
  @path
  certificate_id: string,

  /** A list of additional fields to include in the response. Currently the only supported value is `content` to fetch the PEM content of the certificate. */
  @query(#{ explode: true })
  include?: "content"[],
): Certificate;

/** Modify a certificate. Note that only the name can be modified. */
@summary("Modify certificate")
@post
@route("/organization/certificates/{certificate_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Modify certificate",
    group: "administration",
    returns: "The updated [Certificate](https://platform.openai.com/docs/api-reference/certificates/object) object.",
    examples: #{
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/organization/certificates/cert_abc \\\n-H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n-H \"Content-Type: application/json\" \\\n-d '{\n  \"name\": \"Renamed Certificate\"\n}'\n",
      },
      response: "{\n  \"object\": \"certificate\",\n  \"id\": \"cert_abc\",\n  \"name\": \"Renamed Certificate\",\n  \"created_at\": 1234567,\n  \"certificate_details\": {\n    \"valid_at\": 12345667,\n    \"expires_at\": 12345678\n  }\n}\n",
    },
  }
)
@tag("Certificates")
op modifyCertificate(
  /** Unique ID of the certificate to retrieve. */
  @path
  certificate_id: string,

  /** The certificate modification payload. */
  @body
  body: ModifyCertificateRequest,
): Certificate;

/** Get costs details for the organization. */
@summary("Costs")
@get
@route("/organization/costs")
@extension(
  "x-oaiMeta",
  #{
    name: "Costs",
    group: "usage-costs",
    returns: "A list of paginated, time bucketed [Costs](https://platform.openai.com/docs/api-reference/usage/costs_object) objects.",
    examples: #{
      response: "{\n    \"object\": \"page\",\n    \"data\": [\n        {\n            \"object\": \"bucket\",\n            \"start_time\": 1730419200,\n            \"end_time\": 1730505600,\n            \"results\": [\n                {\n                    \"object\": \"organization.costs.result\",\n                    \"amount\": {\n                        \"value\": 0.06,\n                        \"currency\": \"usd\"\n                    },\n                    \"line_item\": null,\n                    \"project_id\": null\n                }\n            ]\n        }\n    ],\n    \"has_more\": false,\n    \"next_page\": null\n}\n",
      request: #{
        curl: "curl \"https://api.openai.com/v1/organization/costs?start_time=1730419200&limit=1\" \\\n-H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n-H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Usage")
op `usage-costs`(
  /** Start time (Unix seconds) of the query time range, inclusive. */
  @query(#{ explode: true })
  start_time: integer,

  /** End time (Unix seconds) of the query time range, exclusive. */
  @query(#{ explode: true })
  end_time?: integer,

  /** Width of each time bucket in response. Currently only `1d` is supported, default to `1d`. */
  @query(#{ explode: true })
  bucket_width?: "1d" = "1d",

  /** Return only costs for these projects. */
  @query(#{ explode: true })
  project_ids?: string[],

  /** Group the costs by the specified fields. Support fields include `project_id`, `line_item` and any combination of them. */
  @query(#{ explode: true })
  group_by?: ("project_id" | "line_item")[],

  /** A limit on the number of buckets to be returned. Limit can range between 1 and 180, and the default is 7. */
  @query(#{ explode: true })
  limit?: integer = 7,

  /** A cursor for use in pagination. Corresponding to the `next_page` field from the previous response. */
  @query(#{ explode: true })
  page?: string,
): UsageResponse;

/** Returns a list of invites in the organization. */
@summary("List invites")
@get
@route("/organization/invites")
@extension(
  "x-oaiMeta",
  #{
    name: "List invites",
    group: "administration",
    returns: "A list of [Invite](https://platform.openai.com/docs/api-reference/invite/object) objects.",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"object\": \"organization.invite\",\n      \"id\": \"invite-abc\",\n      \"email\": \"user@example.com\",\n      \"role\": \"owner\",\n      \"status\": \"accepted\",\n      \"invited_at\": 1711471533,\n      \"expires_at\": 1711471533,\n      \"accepted_at\": 1711471533\n    }\n  ],\n  \"first_id\": \"invite-abc\",\n  \"last_id\": \"invite-abc\",\n  \"has_more\": false\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/organization/invites?after=invite-abc&limit=20 \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Invites")
op `list-invites`(
  /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
  @query(#{ explode: true })
  limit?: integer = 20,

  /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
  @query(#{ explode: true })
  after?: string,
): InviteListResponse;

/** Create an invite for a user to the organization. The invite must be accepted by the user before they have access to the organization. */
@summary("Create invite")
@post
@route("/organization/invites")
@extension(
  "x-oaiMeta",
  #{
    name: "Create invite",
    group: "administration",
    returns: "The created [Invite](https://platform.openai.com/docs/api-reference/invite/object) object.",
    examples: #{
      response: "{\n  \"object\": \"organization.invite\",\n  \"id\": \"invite-def\",\n  \"email\": \"anotheruser@example.com\",\n  \"role\": \"reader\",\n  \"status\": \"pending\",\n  \"invited_at\": 1711471533,\n  \"expires_at\": 1711471533,\n  \"accepted_at\": null,\n  \"projects\": [\n    {\n      \"id\": \"project-xyz\",\n      \"role\": \"member\"\n    },\n    {\n      \"id\": \"project-abc\",\n      \"role\": \"owner\"\n    }\n  ]\n}\n",
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/organization/invites \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{\n      \"email\": \"anotheruser@example.com\",\n      \"role\": \"reader\",\n      \"projects\": [\n        {\n          \"id\": \"project-xyz\",\n          \"role\": \"member\"\n        },\n        {\n          \"id\": \"project-abc\",\n          \"role\": \"owner\"\n        }\n      ]\n  }'\n",
      },
    },
  }
)
@tag("Invites")
op inviteUser(
  /** The invite request payload. */
  @body
  body: InviteRequest,
): Invite;

/** Delete an invite. If the invite has already been accepted, it cannot be deleted. */
@summary("Delete invite")
@delete
@route("/organization/invites/{invite_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Delete invite",
    group: "administration",
    returns: "Confirmation that the invite has been deleted",
    examples: #{
      response: "{\n    \"object\": \"organization.invite.deleted\",\n    \"id\": \"invite-abc\",\n    \"deleted\": true\n}\n",
      request: #{
        curl: "curl -X DELETE https://api.openai.com/v1/organization/invites/invite-abc \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Invites")
op `delete-invite`(
  /** The ID of the invite to delete. */
  @path
  invite_id: string,
): InviteDeleteResponse;

/** Retrieves an invite. */
@summary("Retrieve invite")
@get
@route("/organization/invites/{invite_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve invite",
    group: "administration",
    returns: "The [Invite](https://platform.openai.com/docs/api-reference/invite/object) object matching the specified ID.",
    examples: #{
      response: "{\n    \"object\": \"organization.invite\",\n    \"id\": \"invite-abc\",\n    \"email\": \"user@example.com\",\n    \"role\": \"owner\",\n    \"status\": \"accepted\",\n    \"invited_at\": 1711471533,\n    \"expires_at\": 1711471533,\n    \"accepted_at\": 1711471533\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/organization/invites/invite-abc \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Invites")
op `retrieve-invite`(
  /** The ID of the invite to retrieve. */
  @path
  invite_id: string,
): Invite;

/** Returns a list of projects. */
@summary("List projects")
@get
@route("/organization/projects")
@extension(
  "x-oaiMeta",
  #{
    name: "List projects",
    group: "administration",
    returns: "A list of [Project](https://platform.openai.com/docs/api-reference/projects/object) objects.",
    examples: #{
      response: "{\n    \"object\": \"list\",\n    \"data\": [\n        {\n            \"id\": \"proj_abc\",\n            \"object\": \"organization.project\",\n            \"name\": \"Project example\",\n            \"created_at\": 1711471533,\n            \"archived_at\": null,\n            \"status\": \"active\"\n        }\n    ],\n    \"first_id\": \"proj-abc\",\n    \"last_id\": \"proj-xyz\",\n    \"has_more\": false\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/organization/projects?after=proj_abc&limit=20&include_archived=false \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Projects")
op `list-projects`(
  /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
  @query(#{ explode: true })
  limit?: integer = 20,

  /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
  @query(#{ explode: true })
  after?: string,

  /** If `true` returns all projects including those that have been `archived`. Archived projects are not included by default. */
  @query(#{ explode: true })
  include_archived?: boolean,
): ProjectListResponse;

/** Create a new project in the organization. Projects can be created and archived, but cannot be deleted. */
@summary("Create project")
@post
@route("/organization/projects")
@extension(
  "x-oaiMeta",
  #{
    name: "Create project",
    group: "administration",
    returns: "The created [Project](https://platform.openai.com/docs/api-reference/projects/object) object.",
    examples: #{
      response: "{\n    \"id\": \"proj_abc\",\n    \"object\": \"organization.project\",\n    \"name\": \"Project ABC\",\n    \"created_at\": 1711471533,\n    \"archived_at\": null,\n    \"status\": \"active\"\n}\n",
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/organization/projects \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{\n      \"name\": \"Project ABC\"\n  }'\n",
      },
    },
  }
)
@tag("Projects")
op `create-project`(
  /** The project create request payload. */
  @body
  body: ProjectCreateRequest,
): Project;

/** Retrieves a project. */
@summary("Retrieve project")
@get
@route("/organization/projects/{project_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve project",
    group: "administration",
    description: "Retrieve a project.",
    returns: "The [Project](https://platform.openai.com/docs/api-reference/projects/object) object matching the specified ID.",
    examples: #{
      response: "{\n    \"id\": \"proj_abc\",\n    \"object\": \"organization.project\",\n    \"name\": \"Project example\",\n    \"created_at\": 1711471533,\n    \"archived_at\": null,\n    \"status\": \"active\"\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/organization/projects/proj_abc \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Projects")
op `retrieve-project`(
  /** The ID of the project. */
  @path
  project_id: string,
): Project;

/** Modifies a project in the organization. */
@summary("Modify project")
@post
@route("/organization/projects/{project_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Modify project",
    group: "administration",
    returns: "The updated [Project](https://platform.openai.com/docs/api-reference/projects/object) object.",
    examples: #{
      response: "",
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/organization/projects/proj_abc \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{\n      \"name\": \"Project DEF\"\n  }'\n",
      },
    },
  }
)
@tag("Projects")
op `modify-project`(
  /** The ID of the project. */
  @path
  project_id: string,

  /** The project update request payload. */
  @body
  body: ProjectUpdateRequest,
): Project | {
  /** The status code. */
  @statusCode
  @doc("The status code.")
  statusCode: 400;

  error: Error;
};

/** Returns a list of API keys in the project. */
@summary("List project API keys")
@get
@route("/organization/projects/{project_id}/api_keys")
@extension(
  "x-oaiMeta",
  #{
    name: "List project API keys",
    group: "administration",
    returns: "A list of [ProjectApiKey](https://platform.openai.com/docs/api-reference/project-api-keys/object) objects.",
    examples: #{
      response: "{\n    \"object\": \"list\",\n    \"data\": [\n        {\n            \"object\": \"organization.project.api_key\",\n            \"redacted_value\": \"sk-abc...def\",\n            \"name\": \"My API Key\",\n            \"created_at\": 1711471533,\n            \"last_used_at\": 1711471534,\n            \"id\": \"key_abc\",\n            \"owner\": {\n                \"type\": \"user\",\n                \"user\": {\n                    \"object\": \"organization.project.user\",\n                    \"id\": \"user_abc\",\n                    \"name\": \"First Last\",\n                    \"email\": \"user@example.com\",\n                    \"role\": \"owner\",\n                    \"added_at\": 1711471533\n                }\n            }\n        }\n    ],\n    \"first_id\": \"key_abc\",\n    \"last_id\": \"key_xyz\",\n    \"has_more\": false\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/organization/projects/proj_abc/api_keys?after=key_abc&limit=20 \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Projects")
op `list-project-api-keys`(
  /** The ID of the project. */
  @path
  project_id: string,

  /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
  @query(#{ explode: true })
  limit?: integer = 20,

  /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
  @query(#{ explode: true })
  after?: string,
): ProjectApiKeyListResponse;

/** Deletes an API key from the project. */
@summary("Delete project API key")
@delete
@route("/organization/projects/{project_id}/api_keys/{key_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Delete project API key",
    group: "administration",
    returns: "Confirmation of the key's deletion or an error if the key belonged to a service account",
    examples: #{
      response: "{\n    \"object\": \"organization.project.api_key.deleted\",\n    \"id\": \"key_abc\",\n    \"deleted\": true\n}\n",
      request: #{
        curl: "curl -X DELETE https://api.openai.com/v1/organization/projects/proj_abc/api_keys/key_abc \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Projects")
op `delete-project-api-key`(
  /** The ID of the project. */
  @path
  project_id: string,

  /** The ID of the API key. */
  @path
  key_id: string,
): ProjectApiKeyDeleteResponse | {
  /** The status code. */
  @statusCode
  @doc("The status code.")
  statusCode: 400;

  error: Error;
};

/** Retrieves an API key in the project. */
@summary("Retrieve project API key")
@get
@route("/organization/projects/{project_id}/api_keys/{key_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve project API key",
    group: "administration",
    returns: "The [ProjectApiKey](https://platform.openai.com/docs/api-reference/project-api-keys/object) object matching the specified ID.",
    examples: #{
      response: "{\n    \"object\": \"organization.project.api_key\",\n    \"redacted_value\": \"sk-abc...def\",\n    \"name\": \"My API Key\",\n    \"created_at\": 1711471533,\n    \"last_used_at\": 1711471534,\n    \"id\": \"key_abc\",\n    \"owner\": {\n        \"type\": \"user\",\n        \"user\": {\n            \"object\": \"organization.project.user\",\n            \"id\": \"user_abc\",\n            \"name\": \"First Last\",\n            \"email\": \"user@example.com\",\n            \"role\": \"owner\",\n            \"added_at\": 1711471533\n        }\n    }\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/organization/projects/proj_abc/api_keys/key_abc \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Projects")
op `retrieve-project-api-key`(
  /** The ID of the project. */
  @path
  project_id: string,

  /** The ID of the API key. */
  @path
  key_id: string,
): ProjectApiKey;

/** Archives a project in the organization. Archived projects cannot be used or updated. */
@summary("Archive project")
@post
@route("/organization/projects/{project_id}/archive")
@extension(
  "x-oaiMeta",
  #{
    name: "Archive project",
    group: "administration",
    returns: "The archived [Project](https://platform.openai.com/docs/api-reference/projects/object) object.",
    examples: #{
      response: "{\n    \"id\": \"proj_abc\",\n    \"object\": \"organization.project\",\n    \"name\": \"Project DEF\",\n    \"created_at\": 1711471533,\n    \"archived_at\": 1711471533,\n    \"status\": \"archived\"\n}\n",
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/organization/projects/proj_abc/archive \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Projects")
op `archive-project`(
  /** The ID of the project. */
  @path
  project_id: string,
): Project;

/** List certificates for this project. */
@summary("List project certificates")
@get
@route("/organization/projects/{project_id}/certificates")
@extension(
  "x-oaiMeta",
  #{
    name: "List project certificates",
    group: "administration",
    returns: "A list of [Certificate](https://platform.openai.com/docs/api-reference/certificates/object) objects.",
    examples: #{
      request: #{
        curl: "curl https://api.openai.com/v1/organization/projects/proj_abc/certificates \\\n-H \"Authorization: Bearer $OPENAI_ADMIN_KEY\"\n",
      },
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"object\": \"organization.project.certificate\",\n      \"id\": \"cert_abc\",\n      \"name\": \"My Example Certificate\",\n      \"active\": true,\n      \"created_at\": 1234567,\n      \"certificate_details\": {\n        \"valid_at\": 12345667,\n        \"expires_at\": 12345678\n      }\n    },\n  ],\n  \"first_id\": \"cert_abc\",\n  \"last_id\": \"cert_abc\",\n  \"has_more\": false\n}\n",
    },
  }
)
@tag("Certificates")
op listProjectCertificates(
  /** The ID of the project. */
  @path
  project_id: string,

  /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
  @query(#{ explode: true })
  limit?: integer = 20,

  /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
  @query(#{ explode: true })
  after?: string,

  /** Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending order. */
  @query(#{ explode: true })
  order?: "asc" | "desc" = "desc",
): ListCertificatesResponse;

/**Activate certificates at the project level.

You can atomically and idempotently activate up to 10 certificates at a time.*/
@summary("Activate certificates for project")
@post
@route("/organization/projects/{project_id}/certificates/activate")
@extension(
  "x-oaiMeta",
  #{
    name: "Activate certificates for project",
    group: "administration",
    returns: "A list of [Certificate](https://platform.openai.com/docs/api-reference/certificates/object) objects that were activated.",
    examples: #{
      request: #{
        curl: "curl https://api.openai.com/v1/organization/projects/proj_abc/certificates/activate \\\n-H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n-H \"Content-Type: application/json\" \\\n-d '{\n  \"data\": [\"cert_abc\", \"cert_def\"]\n}'\n",
      },
      response: "{\n  \"object\": \"organization.project.certificate.activation\",\n  \"data\": [\n    {\n      \"object\": \"organization.project.certificate\",\n      \"id\": \"cert_abc\",\n      \"name\": \"My Example Certificate\",\n      \"active\": true,\n      \"created_at\": 1234567,\n      \"certificate_details\": {\n        \"valid_at\": 12345667,\n        \"expires_at\": 12345678\n      }\n    },\n    {\n      \"object\": \"organization.project.certificate\",\n      \"id\": \"cert_def\",\n      \"name\": \"My Example Certificate 2\",\n      \"active\": true,\n      \"created_at\": 1234567,\n      \"certificate_details\": {\n        \"valid_at\": 12345667,\n        \"expires_at\": 12345678\n      }\n    },\n  ],\n}\n",
    },
  }
)
@tag("Certificates")
op activateProjectCertificates(
  /** The ID of the project. */
  @path
  project_id: string,

  /** The certificate activation payload. */
  @body
  body: ToggleCertificatesRequest,
): ListCertificatesResponse;

/**Deactivate certificates at the project level. You can atomically and
idempotently deactivate up to 10 certificates at a time.*/
@summary("Deactivate certificates for project")
@post
@route("/organization/projects/{project_id}/certificates/deactivate")
@extension(
  "x-oaiMeta",
  #{
    name: "Deactivate certificates for project",
    group: "administration",
    returns: "A list of [Certificate](https://platform.openai.com/docs/api-reference/certificates/object) objects that were deactivated.",
    examples: #{
      request: #{
        curl: "curl https://api.openai.com/v1/organization/projects/proj_abc/certificates/deactivate \\\n-H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n-H \"Content-Type: application/json\" \\\n-d '{\n  \"data\": [\"cert_abc\", \"cert_def\"]\n}'\n",
      },
      response: "{\n  \"object\": \"organization.project.certificate.deactivation\",\n  \"data\": [\n    {\n      \"object\": \"organization.project.certificate\",\n      \"id\": \"cert_abc\",\n      \"name\": \"My Example Certificate\",\n      \"active\": false,\n      \"created_at\": 1234567,\n      \"certificate_details\": {\n        \"valid_at\": 12345667,\n        \"expires_at\": 12345678\n      }\n    },\n    {\n      \"object\": \"organization.project.certificate\",\n      \"id\": \"cert_def\",\n      \"name\": \"My Example Certificate 2\",\n      \"active\": false,\n      \"created_at\": 1234567,\n      \"certificate_details\": {\n        \"valid_at\": 12345667,\n        \"expires_at\": 12345678\n      }\n    },\n  ],\n}\n",
    },
  }
)
@tag("Certificates")
op deactivateProjectCertificates(
  /** The ID of the project. */
  @path
  project_id: string,

  /** The certificate deactivation payload. */
  @body
  body: ToggleCertificatesRequest,
): ListCertificatesResponse;

/** Returns the rate limits per model for a project. */
@summary("List project rate limits")
@get
@route("/organization/projects/{project_id}/rate_limits")
@extension(
  "x-oaiMeta",
  #{
    name: "List project rate limits",
    group: "administration",
    returns: "A list of [ProjectRateLimit](https://platform.openai.com/docs/api-reference/project-rate-limits/object) objects.",
    examples: #{
      response: "{\n    \"object\": \"list\",\n    \"data\": [\n        {\n          \"object\": \"project.rate_limit\",\n          \"id\": \"rl-ada\",\n          \"model\": \"ada\",\n          \"max_requests_per_1_minute\": 600,\n          \"max_tokens_per_1_minute\": 150000,\n          \"max_images_per_1_minute\": 10\n        }\n    ],\n    \"first_id\": \"rl-ada\",\n    \"last_id\": \"rl-ada\",\n    \"has_more\": false\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/organization/projects/proj_abc/rate_limits?after=rl_xxx&limit=20 \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
      },
      error_response: "{\n    \"code\": 404,\n    \"message\": \"The project {project_id} was not found\"\n}\n",
    },
  }
)
@tag("Projects")
op `list-project-rate-limits`(
  /** The ID of the project. */
  @path
  project_id: string,

  /** A limit on the number of objects to be returned. The default is 100. */
  @query(#{ explode: true })
  limit?: integer = 100,

  /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
  @query(#{ explode: true })
  after?: string,

  /** A cursor for use in pagination. `before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, beginning with obj_foo, your subsequent call can include before=obj_foo in order to fetch the previous page of the list. */
  @query(#{ explode: true })
  before?: string,
): ProjectRateLimitListResponse;

/** Updates a project rate limit. */
@summary("Modify project rate limit")
@post
@route("/organization/projects/{project_id}/rate_limits/{rate_limit_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Modify project rate limit",
    group: "administration",
    returns: "The updated [ProjectRateLimit](https://platform.openai.com/docs/api-reference/project-rate-limits/object) object.",
    examples: #{
      response: "{\n    \"object\": \"project.rate_limit\",\n    \"id\": \"rl-ada\",\n    \"model\": \"ada\",\n    \"max_requests_per_1_minute\": 600,\n    \"max_tokens_per_1_minute\": 150000,\n    \"max_images_per_1_minute\": 10\n  }\n",
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/organization/projects/proj_abc/rate_limits/rl_xxx \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{\n      \"max_requests_per_1_minute\": 500\n  }'\n",
      },
      error_response: "{\n    \"code\": 404,\n    \"message\": \"The project {project_id} was not found\"\n}\n",
    },
  }
)
@tag("Projects")
op `update-project-rate-limits`(
  /** The ID of the project. */
  @path
  project_id: string,

  /** The ID of the rate limit. */
  @path
  rate_limit_id: string,

  /** The project rate limit update request payload. */
  @body
  body: ProjectRateLimitUpdateRequest,
): ProjectRateLimit | {
  /** The status code. */
  @statusCode
  @doc("The status code.")
  statusCode: 400;

  error: Error;
};

/** Returns a list of service accounts in the project. */
@summary("List project service accounts")
@get
@route("/organization/projects/{project_id}/service_accounts")
@extension(
  "x-oaiMeta",
  #{
    name: "List project service accounts",
    group: "administration",
    returns: "A list of [ProjectServiceAccount](https://platform.openai.com/docs/api-reference/project-service-accounts/object) objects.",
    examples: #{
      response: "{\n    \"object\": \"list\",\n    \"data\": [\n        {\n            \"object\": \"organization.project.service_account\",\n            \"id\": \"svc_acct_abc\",\n            \"name\": \"Service Account\",\n            \"role\": \"owner\",\n            \"created_at\": 1711471533\n        }\n    ],\n    \"first_id\": \"svc_acct_abc\",\n    \"last_id\": \"svc_acct_xyz\",\n    \"has_more\": false\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/organization/projects/proj_abc/service_accounts?after=custom_id&limit=20 \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Projects")
op `list-project-service-accounts`(
  /** The ID of the project. */
  @path
  project_id: string,

  /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
  @query(#{ explode: true })
  limit?: integer = 20,

  /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
  @query(#{ explode: true })
  after?: string,
): ProjectServiceAccountListResponse | {
  /** The status code. */
  @statusCode
  @doc("The status code.")
  statusCode: 400;

  error: Error;
};

/** Creates a new service account in the project. This also returns an unredacted API key for the service account. */
@summary("Create project service account")
@post
@route("/organization/projects/{project_id}/service_accounts")
@extension(
  "x-oaiMeta",
  #{
    name: "Create project service account",
    group: "administration",
    returns: "The created [ProjectServiceAccount](https://platform.openai.com/docs/api-reference/project-service-accounts/object) object.",
    examples: #{
      response: "{\n    \"object\": \"organization.project.service_account\",\n    \"id\": \"svc_acct_abc\",\n    \"name\": \"Production App\",\n    \"role\": \"member\",\n    \"created_at\": 1711471533,\n    \"api_key\": {\n        \"object\": \"organization.project.service_account.api_key\",\n        \"value\": \"sk-abcdefghijklmnop123\",\n        \"name\": \"Secret Key\",\n        \"created_at\": 1711471533,\n        \"id\": \"key_abc\"\n    }\n}\n",
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/organization/projects/proj_abc/service_accounts \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{\n      \"name\": \"Production App\"\n  }'\n",
      },
    },
  }
)
@tag("Projects")
op `create-project-service-account`(
  /** The ID of the project. */
  @path
  project_id: string,

  /** The project service account create request payload. */
  @body
  body: ProjectServiceAccountCreateRequest,
): ProjectServiceAccountCreateResponse | {
  /** The status code. */
  @statusCode
  @doc("The status code.")
  statusCode: 400;

  error: Error;
};

/** Deletes a service account from the project. */
@summary("Delete project service account")
@delete
@route("/organization/projects/{project_id}/service_accounts/{service_account_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Delete project service account",
    group: "administration",
    returns: "Confirmation of service account being deleted, or an error in case of an archived project, which has no service accounts",
    examples: #{
      response: "{\n    \"object\": \"organization.project.service_account.deleted\",\n    \"id\": \"svc_acct_abc\",\n    \"deleted\": true\n}\n",
      request: #{
        curl: "curl -X DELETE https://api.openai.com/v1/organization/projects/proj_abc/service_accounts/svc_acct_abc \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Projects")
op `delete-project-service-account`(
  /** The ID of the project. */
  @path
  project_id: string,

  /** The ID of the service account. */
  @path
  service_account_id: string,
): ProjectServiceAccountDeleteResponse;

/** Retrieves a service account in the project. */
@summary("Retrieve project service account")
@get
@route("/organization/projects/{project_id}/service_accounts/{service_account_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve project service account",
    group: "administration",
    returns: "The [ProjectServiceAccount](https://platform.openai.com/docs/api-reference/project-service-accounts/object) object matching the specified ID.",
    examples: #{
      response: "{\n    \"object\": \"organization.project.service_account\",\n    \"id\": \"svc_acct_abc\",\n    \"name\": \"Service Account\",\n    \"role\": \"owner\",\n    \"created_at\": 1711471533\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/organization/projects/proj_abc/service_accounts/svc_acct_abc \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Projects")
op `retrieve-project-service-account`(
  /** The ID of the project. */
  @path
  project_id: string,

  /** The ID of the service account. */
  @path
  service_account_id: string,
): ProjectServiceAccount;

/** Returns a list of users in the project. */
@summary("List project users")
@get
@route("/organization/projects/{project_id}/users")
@extension(
  "x-oaiMeta",
  #{
    name: "List project users",
    group: "administration",
    returns: "A list of [ProjectUser](https://platform.openai.com/docs/api-reference/project-users/object) objects.",
    examples: #{
      response: "{\n    \"object\": \"list\",\n    \"data\": [\n        {\n            \"object\": \"organization.project.user\",\n            \"id\": \"user_abc\",\n            \"name\": \"First Last\",\n            \"email\": \"user@example.com\",\n            \"role\": \"owner\",\n            \"added_at\": 1711471533\n        }\n    ],\n    \"first_id\": \"user-abc\",\n    \"last_id\": \"user-xyz\",\n    \"has_more\": false\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/organization/projects/proj_abc/users?after=user_abc&limit=20 \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Projects")
op `list-project-users`(
  /** The ID of the project. */
  @path
  project_id: string,

  /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
  @query(#{ explode: true })
  limit?: integer = 20,

  /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
  @query(#{ explode: true })
  after?: string,
): ProjectUserListResponse | {
  /** The status code. */
  @statusCode
  @doc("The status code.")
  statusCode: 400;

  error: Error;
};

/** Adds a user to the project. Users must already be members of the organization to be added to a project. */
@summary("Create project user")
@post
@route("/organization/projects/{project_id}/users")
@extension(
  "x-oaiMeta",
  #{
    name: "Create project user",
    group: "administration",
    returns: "The created [ProjectUser](https://platform.openai.com/docs/api-reference/project-users/object) object.",
    examples: #{
      response: "{\n    \"object\": \"organization.project.user\",\n    \"id\": \"user_abc\",\n    \"email\": \"user@example.com\",\n    \"role\": \"owner\",\n    \"added_at\": 1711471533\n}\n",
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/organization/projects/proj_abc/users \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{\n      \"user_id\": \"user_abc\",\n      \"role\": \"member\"\n  }'\n",
      },
    },
  }
)
@tag("Projects")
op `create-project-user`(
  /** The ID of the project. */
  @path
  project_id: string,

  /** The project user create request payload. */
  @body
  body: ProjectUserCreateRequest,
): ProjectUser | {
  /** The status code. */
  @statusCode
  @doc("The status code.")
  statusCode: 400;

  error: Error;
};

/** Deletes a user from the project. */
@summary("Delete project user")
@delete
@route("/organization/projects/{project_id}/users/{user_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Delete project user",
    group: "administration",
    returns: "Confirmation that project has been deleted or an error in case of an archived project, which has no users",
    examples: #{
      response: "{\n    \"object\": \"organization.project.user.deleted\",\n    \"id\": \"user_abc\",\n    \"deleted\": true\n}\n",
      request: #{
        curl: "curl -X DELETE https://api.openai.com/v1/organization/projects/proj_abc/users/user_abc \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Projects")
op `delete-project-user`(
  /** The ID of the project. */
  @path
  project_id: string,

  /** The ID of the user. */
  @path
  user_id: string,
): ProjectUserDeleteResponse | {
  /** The status code. */
  @statusCode
  @doc("The status code.")
  statusCode: 400;

  error: Error;
};

/** Retrieves a user in the project. */
@summary("Retrieve project user")
@get
@route("/organization/projects/{project_id}/users/{user_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve project user",
    group: "administration",
    returns: "The [ProjectUser](https://platform.openai.com/docs/api-reference/project-users/object) object matching the specified ID.",
    examples: #{
      response: "{\n    \"object\": \"organization.project.user\",\n    \"id\": \"user_abc\",\n    \"name\": \"First Last\",\n    \"email\": \"user@example.com\",\n    \"role\": \"owner\",\n    \"added_at\": 1711471533\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/organization/projects/proj_abc/users/user_abc \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Projects")
op `retrieve-project-user`(
  /** The ID of the project. */
  @path
  project_id: string,

  /** The ID of the user. */
  @path
  user_id: string,
): ProjectUser;

/** Modifies a user's role in the project. */
@summary("Modify project user")
@post
@route("/organization/projects/{project_id}/users/{user_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Modify project user",
    group: "administration",
    returns: "The updated [ProjectUser](https://platform.openai.com/docs/api-reference/project-users/object) object.",
    examples: #{
      response: "{\n    \"object\": \"organization.project.user\",\n    \"id\": \"user_abc\",\n    \"name\": \"First Last\",\n    \"email\": \"user@example.com\",\n    \"role\": \"owner\",\n    \"added_at\": 1711471533\n}\n",
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/organization/projects/proj_abc/users/user_abc \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{\n      \"role\": \"owner\"\n  }'\n",
      },
    },
  }
)
@tag("Projects")
op `modify-project-user`(
  /** The ID of the project. */
  @path
  project_id: string,

  /** The ID of the user. */
  @path
  user_id: string,

  /** The project user update request payload. */
  @body
  body: ProjectUserUpdateRequest,
): ProjectUser | {
  /** The status code. */
  @statusCode
  @doc("The status code.")
  statusCode: 400;

  error: Error;
};

/** Get audio speeches usage details for the organization. */
@summary("Audio speeches")
@get
@route("/organization/usage/audio_speeches")
@extension(
  "x-oaiMeta",
  #{
    name: "Audio speeches",
    group: "usage-audio-speeches",
    returns: "A list of paginated, time bucketed [Audio speeches usage](https://platform.openai.com/docs/api-reference/usage/audio_speeches_object) objects.",
    examples: #{
      response: "{\n    \"object\": \"page\",\n    \"data\": [\n        {\n            \"object\": \"bucket\",\n            \"start_time\": 1730419200,\n            \"end_time\": 1730505600,\n            \"results\": [\n                {\n                    \"object\": \"organization.usage.audio_speeches.result\",\n                    \"characters\": 45,\n                    \"num_model_requests\": 1,\n                    \"project_id\": null,\n                    \"user_id\": null,\n                    \"api_key_id\": null,\n                    \"model\": null\n                }\n            ]\n        }\n    ],\n    \"has_more\": false,\n    \"next_page\": null\n}\n",
      request: #{
        curl: "curl \"https://api.openai.com/v1/organization/usage/audio_speeches?start_time=1730419200&limit=1\" \\\n-H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n-H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Usage")
op `usage-audio-speeches`(
  /** Start time (Unix seconds) of the query time range, inclusive. */
  @query(#{ explode: true })
  start_time: integer,

  /** End time (Unix seconds) of the query time range, exclusive. */
  @query(#{ explode: true })
  end_time?: integer,

  /** Width of each time bucket in response. Currently `1m`, `1h` and `1d` are supported, default to `1d`. */
  @query(#{ explode: true })
  bucket_width?: "1m" | "1h" | "1d" = "1d",

  /** Return only usage for these projects. */
  @query(#{ explode: true })
  project_ids?: string[],

  /** Return only usage for these users. */
  @query(#{ explode: true })
  user_ids?: string[],

  /** Return only usage for these API keys. */
  @query(#{ explode: true })
  api_key_ids?: string[],

  /** Return only usage for these models. */
  @query(#{ explode: true })
  models?: string[],

  /** Group the usage data by the specified fields. Support fields include `project_id`, `user_id`, `api_key_id`, `model` or any combination of them. */
  @query(#{ explode: true })
  group_by?: ("project_id" | "user_id" | "api_key_id" | "model")[],

  /**Specifies the number of buckets to return.
- `bucket_width=1d`: default: 7, max: 31
- `bucket_width=1h`: default: 24, max: 168
- `bucket_width=1m`: default: 60, max: 1440*/
  @query(#{ explode: true })
  limit?: integer,

  /** A cursor for use in pagination. Corresponding to the `next_page` field from the previous response. */
  @query(#{ explode: true })
  page?: string,
): UsageResponse;

/** Get audio transcriptions usage details for the organization. */
@summary("Audio transcriptions")
@get
@route("/organization/usage/audio_transcriptions")
@extension(
  "x-oaiMeta",
  #{
    name: "Audio transcriptions",
    group: "usage-audio-transcriptions",
    returns: "A list of paginated, time bucketed [Audio transcriptions usage](https://platform.openai.com/docs/api-reference/usage/audio_transcriptions_object) objects.",
    examples: #{
      response: "{\n    \"object\": \"page\",\n    \"data\": [\n        {\n            \"object\": \"bucket\",\n            \"start_time\": 1730419200,\n            \"end_time\": 1730505600,\n            \"results\": [\n                {\n                    \"object\": \"organization.usage.audio_transcriptions.result\",\n                    \"seconds\": 20,\n                    \"num_model_requests\": 1,\n                    \"project_id\": null,\n                    \"user_id\": null,\n                    \"api_key_id\": null,\n                    \"model\": null\n                }\n            ]\n        }\n    ],\n    \"has_more\": false,\n    \"next_page\": null\n}\n",
      request: #{
        curl: "curl \"https://api.openai.com/v1/organization/usage/audio_transcriptions?start_time=1730419200&limit=1\" \\\n-H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n-H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Usage")
op `usage-audio-transcriptions`(
  /** Start time (Unix seconds) of the query time range, inclusive. */
  @query(#{ explode: true })
  start_time: integer,

  /** End time (Unix seconds) of the query time range, exclusive. */
  @query(#{ explode: true })
  end_time?: integer,

  /** Width of each time bucket in response. Currently `1m`, `1h` and `1d` are supported, default to `1d`. */
  @query(#{ explode: true })
  bucket_width?: "1m" | "1h" | "1d" = "1d",

  /** Return only usage for these projects. */
  @query(#{ explode: true })
  project_ids?: string[],

  /** Return only usage for these users. */
  @query(#{ explode: true })
  user_ids?: string[],

  /** Return only usage for these API keys. */
  @query(#{ explode: true })
  api_key_ids?: string[],

  /** Return only usage for these models. */
  @query(#{ explode: true })
  models?: string[],

  /** Group the usage data by the specified fields. Support fields include `project_id`, `user_id`, `api_key_id`, `model` or any combination of them. */
  @query(#{ explode: true })
  group_by?: ("project_id" | "user_id" | "api_key_id" | "model")[],

  /**Specifies the number of buckets to return.
- `bucket_width=1d`: default: 7, max: 31
- `bucket_width=1h`: default: 24, max: 168
- `bucket_width=1m`: default: 60, max: 1440*/
  @query(#{ explode: true })
  limit?: integer,

  /** A cursor for use in pagination. Corresponding to the `next_page` field from the previous response. */
  @query(#{ explode: true })
  page?: string,
): UsageResponse;

/** Get code interpreter sessions usage details for the organization. */
@summary("Code interpreter sessions")
@get
@route("/organization/usage/code_interpreter_sessions")
@extension(
  "x-oaiMeta",
  #{
    name: "Code interpreter sessions",
    group: "usage-code-interpreter-sessions",
    returns: "A list of paginated, time bucketed [Code interpreter sessions usage](https://platform.openai.com/docs/api-reference/usage/code_interpreter_sessions_object) objects.",
    examples: #{
      response: "{\n    \"object\": \"page\",\n    \"data\": [\n        {\n            \"object\": \"bucket\",\n            \"start_time\": 1730419200,\n            \"end_time\": 1730505600,\n            \"results\": [\n                {\n                    \"object\": \"organization.usage.code_interpreter_sessions.result\",\n                    \"num_sessions\": 1,\n                    \"project_id\": null\n                }\n            ]\n        }\n    ],\n    \"has_more\": false,\n    \"next_page\": null\n}\n",
      request: #{
        curl: "curl \"https://api.openai.com/v1/organization/usage/code_interpreter_sessions?start_time=1730419200&limit=1\" \\\n-H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n-H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Usage")
op `usage-code-interpreter-sessions`(
  /** Start time (Unix seconds) of the query time range, inclusive. */
  @query(#{ explode: true })
  start_time: integer,

  /** End time (Unix seconds) of the query time range, exclusive. */
  @query(#{ explode: true })
  end_time?: integer,

  /** Width of each time bucket in response. Currently `1m`, `1h` and `1d` are supported, default to `1d`. */
  @query(#{ explode: true })
  bucket_width?: "1m" | "1h" | "1d" = "1d",

  /** Return only usage for these projects. */
  @query(#{ explode: true })
  project_ids?: string[],

  /** Group the usage data by the specified fields. Support fields include `project_id`. */
  @query(#{ explode: true })
  group_by?: "project_id"[],

  /**Specifies the number of buckets to return.
- `bucket_width=1d`: default: 7, max: 31
- `bucket_width=1h`: default: 24, max: 168
- `bucket_width=1m`: default: 60, max: 1440*/
  @query(#{ explode: true })
  limit?: integer,

  /** A cursor for use in pagination. Corresponding to the `next_page` field from the previous response. */
  @query(#{ explode: true })
  page?: string,
): UsageResponse;

/** Get completions usage details for the organization. */
@summary("Completions")
@get
@route("/organization/usage/completions")
@extension(
  "x-oaiMeta",
  #{
    name: "Completions",
    group: "usage-completions",
    returns: "A list of paginated, time bucketed [Completions usage](https://platform.openai.com/docs/api-reference/usage/completions_object) objects.",
    examples: #{
      response: "{\n    \"object\": \"page\",\n    \"data\": [\n        {\n            \"object\": \"bucket\",\n            \"start_time\": 1730419200,\n            \"end_time\": 1730505600,\n            \"results\": [\n                {\n                    \"object\": \"organization.usage.completions.result\",\n                    \"input_tokens\": 1000,\n                    \"output_tokens\": 500,\n                    \"input_cached_tokens\": 800,\n                    \"input_audio_tokens\": 0,\n                    \"output_audio_tokens\": 0,\n                    \"num_model_requests\": 5,\n                    \"project_id\": null,\n                    \"user_id\": null,\n                    \"api_key_id\": null,\n                    \"model\": null,\n                    \"batch\": null\n                }\n            ]\n        }\n    ],\n    \"has_more\": true,\n    \"next_page\": \"page_AAAAAGdGxdEiJdKOAAAAAGcqsYA=\"\n}\n",
      request: #{
        curl: "curl \"https://api.openai.com/v1/organization/usage/completions?start_time=1730419200&limit=1\" \\\n-H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n-H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Usage")
op `usage-completions`(
  /** Start time (Unix seconds) of the query time range, inclusive. */
  @query(#{ explode: true })
  start_time: integer,

  /** End time (Unix seconds) of the query time range, exclusive. */
  @query(#{ explode: true })
  end_time?: integer,

  /** Width of each time bucket in response. Currently `1m`, `1h` and `1d` are supported, default to `1d`. */
  @query(#{ explode: true })
  bucket_width?: "1m" | "1h" | "1d" = "1d",

  /** Return only usage for these projects. */
  @query(#{ explode: true })
  project_ids?: string[],

  /** Return only usage for these users. */
  @query(#{ explode: true })
  user_ids?: string[],

  /** Return only usage for these API keys. */
  @query(#{ explode: true })
  api_key_ids?: string[],

  /** Return only usage for these models. */
  @query(#{ explode: true })
  models?: string[],

  /** If `true`, return batch jobs only. If `false`, return non-batch jobs only. By default, return both. */
  @query(#{ explode: true })
  batch?: boolean,

  /** Group the usage data by the specified fields. Support fields include `project_id`, `user_id`, `api_key_id`, `model`, `batch` or any combination of them. */
  @query(#{ explode: true })
  group_by?: ("project_id" | "user_id" | "api_key_id" | "model" | "batch")[],

  /**Specifies the number of buckets to return.
- `bucket_width=1d`: default: 7, max: 31
- `bucket_width=1h`: default: 24, max: 168
- `bucket_width=1m`: default: 60, max: 1440*/
  @query(#{ explode: true })
  limit?: integer,

  /** A cursor for use in pagination. Corresponding to the `next_page` field from the previous response. */
  @query(#{ explode: true })
  page?: string,
): UsageResponse;

/** Get embeddings usage details for the organization. */
@summary("Embeddings")
@get
@route("/organization/usage/embeddings")
@extension(
  "x-oaiMeta",
  #{
    name: "Embeddings",
    group: "usage-embeddings",
    returns: "A list of paginated, time bucketed [Embeddings usage](https://platform.openai.com/docs/api-reference/usage/embeddings_object) objects.",
    examples: #{
      response: "{\n    \"object\": \"page\",\n    \"data\": [\n        {\n            \"object\": \"bucket\",\n            \"start_time\": 1730419200,\n            \"end_time\": 1730505600,\n            \"results\": [\n                {\n                    \"object\": \"organization.usage.embeddings.result\",\n                    \"input_tokens\": 16,\n                    \"num_model_requests\": 2,\n                    \"project_id\": null,\n                    \"user_id\": null,\n                    \"api_key_id\": null,\n                    \"model\": null\n                }\n            ]\n        }\n    ],\n    \"has_more\": false,\n    \"next_page\": null\n}\n",
      request: #{
        curl: "curl \"https://api.openai.com/v1/organization/usage/embeddings?start_time=1730419200&limit=1\" \\\n-H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n-H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Usage")
op `usage-embeddings`(
  /** Start time (Unix seconds) of the query time range, inclusive. */
  @query(#{ explode: true })
  start_time: integer,

  /** End time (Unix seconds) of the query time range, exclusive. */
  @query(#{ explode: true })
  end_time?: integer,

  /** Width of each time bucket in response. Currently `1m`, `1h` and `1d` are supported, default to `1d`. */
  @query(#{ explode: true })
  bucket_width?: "1m" | "1h" | "1d" = "1d",

  /** Return only usage for these projects. */
  @query(#{ explode: true })
  project_ids?: string[],

  /** Return only usage for these users. */
  @query(#{ explode: true })
  user_ids?: string[],

  /** Return only usage for these API keys. */
  @query(#{ explode: true })
  api_key_ids?: string[],

  /** Return only usage for these models. */
  @query(#{ explode: true })
  models?: string[],

  /** Group the usage data by the specified fields. Support fields include `project_id`, `user_id`, `api_key_id`, `model` or any combination of them. */
  @query(#{ explode: true })
  group_by?: ("project_id" | "user_id" | "api_key_id" | "model")[],

  /**Specifies the number of buckets to return.
- `bucket_width=1d`: default: 7, max: 31
- `bucket_width=1h`: default: 24, max: 168
- `bucket_width=1m`: default: 60, max: 1440*/
  @query(#{ explode: true })
  limit?: integer,

  /** A cursor for use in pagination. Corresponding to the `next_page` field from the previous response. */
  @query(#{ explode: true })
  page?: string,
): UsageResponse;

/** Get images usage details for the organization. */
@summary("Images")
@get
@route("/organization/usage/images")
@extension(
  "x-oaiMeta",
  #{
    name: "Images",
    group: "usage-images",
    returns: "A list of paginated, time bucketed [Images usage](https://platform.openai.com/docs/api-reference/usage/images_object) objects.",
    examples: #{
      response: "{\n    \"object\": \"page\",\n    \"data\": [\n        {\n            \"object\": \"bucket\",\n            \"start_time\": 1730419200,\n            \"end_time\": 1730505600,\n            \"results\": [\n                {\n                    \"object\": \"organization.usage.images.result\",\n                    \"images\": 2,\n                    \"num_model_requests\": 2,\n                    \"size\": null,\n                    \"source\": null,\n                    \"project_id\": null,\n                    \"user_id\": null,\n                    \"api_key_id\": null,\n                    \"model\": null\n                }\n            ]\n        }\n    ],\n    \"has_more\": false,\n    \"next_page\": null\n}\n",
      request: #{
        curl: "curl \"https://api.openai.com/v1/organization/usage/images?start_time=1730419200&limit=1\" \\\n-H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n-H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Usage")
op `usage-images`(
  /** Start time (Unix seconds) of the query time range, inclusive. */
  @query(#{ explode: true })
  start_time: integer,

  /** End time (Unix seconds) of the query time range, exclusive. */
  @query(#{ explode: true })
  end_time?: integer,

  /** Width of each time bucket in response. Currently `1m`, `1h` and `1d` are supported, default to `1d`. */
  @query(#{ explode: true })
  bucket_width?: "1m" | "1h" | "1d" = "1d",

  /** Return only usages for these sources. Possible values are `image.generation`, `image.edit`, `image.variation` or any combination of them. */
  @query(#{ explode: true })
  sources?: ("image.generation" | "image.edit" | "image.variation")[],

  /** Return only usages for these image sizes. Possible values are `256x256`, `512x512`, `1024x1024`, `1792x1792`, `1024x1792` or any combination of them. */
  @query(#{ explode: true })
  sizes?: ("256x256" | "512x512" | "1024x1024" | "1792x1792" | "1024x1792")[],

  /** Return only usage for these projects. */
  @query(#{ explode: true })
  project_ids?: string[],

  /** Return only usage for these users. */
  @query(#{ explode: true })
  user_ids?: string[],

  /** Return only usage for these API keys. */
  @query(#{ explode: true })
  api_key_ids?: string[],

  /** Return only usage for these models. */
  @query(#{ explode: true })
  models?: string[],

  /** Group the usage data by the specified fields. Support fields include `project_id`, `user_id`, `api_key_id`, `model`, `size`, `source` or any combination of them. */
  @query(#{ explode: true })
  group_by?: (
    | "project_id"
    | "user_id"
    | "api_key_id"
    | "model"
    | "size"
    | "source")[],

  /**Specifies the number of buckets to return.
- `bucket_width=1d`: default: 7, max: 31
- `bucket_width=1h`: default: 24, max: 168
- `bucket_width=1m`: default: 60, max: 1440*/
  @query(#{ explode: true })
  limit?: integer,

  /** A cursor for use in pagination. Corresponding to the `next_page` field from the previous response. */
  @query(#{ explode: true })
  page?: string,
): UsageResponse;

/** Get moderations usage details for the organization. */
@summary("Moderations")
@get
@route("/organization/usage/moderations")
@extension(
  "x-oaiMeta",
  #{
    name: "Moderations",
    group: "usage-moderations",
    returns: "A list of paginated, time bucketed [Moderations usage](https://platform.openai.com/docs/api-reference/usage/moderations_object) objects.",
    examples: #{
      response: "{\n    \"object\": \"page\",\n    \"data\": [\n        {\n            \"object\": \"bucket\",\n            \"start_time\": 1730419200,\n            \"end_time\": 1730505600,\n            \"results\": [\n                {\n                    \"object\": \"organization.usage.moderations.result\",\n                    \"input_tokens\": 16,\n                    \"num_model_requests\": 2,\n                    \"project_id\": null,\n                    \"user_id\": null,\n                    \"api_key_id\": null,\n                    \"model\": null\n                }\n            ]\n        }\n    ],\n    \"has_more\": false,\n    \"next_page\": null\n}\n",
      request: #{
        curl: "curl \"https://api.openai.com/v1/organization/usage/moderations?start_time=1730419200&limit=1\" \\\n-H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n-H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Usage")
op `usage-moderations`(
  /** Start time (Unix seconds) of the query time range, inclusive. */
  @query(#{ explode: true })
  start_time: integer,

  /** End time (Unix seconds) of the query time range, exclusive. */
  @query(#{ explode: true })
  end_time?: integer,

  /** Width of each time bucket in response. Currently `1m`, `1h` and `1d` are supported, default to `1d`. */
  @query(#{ explode: true })
  bucket_width?: "1m" | "1h" | "1d" = "1d",

  /** Return only usage for these projects. */
  @query(#{ explode: true })
  project_ids?: string[],

  /** Return only usage for these users. */
  @query(#{ explode: true })
  user_ids?: string[],

  /** Return only usage for these API keys. */
  @query(#{ explode: true })
  api_key_ids?: string[],

  /** Return only usage for these models. */
  @query(#{ explode: true })
  models?: string[],

  /** Group the usage data by the specified fields. Support fields include `project_id`, `user_id`, `api_key_id`, `model` or any combination of them. */
  @query(#{ explode: true })
  group_by?: ("project_id" | "user_id" | "api_key_id" | "model")[],

  /**Specifies the number of buckets to return.
- `bucket_width=1d`: default: 7, max: 31
- `bucket_width=1h`: default: 24, max: 168
- `bucket_width=1m`: default: 60, max: 1440*/
  @query(#{ explode: true })
  limit?: integer,

  /** A cursor for use in pagination. Corresponding to the `next_page` field from the previous response. */
  @query(#{ explode: true })
  page?: string,
): UsageResponse;

/** Get vector stores usage details for the organization. */
@summary("Vector stores")
@get
@route("/organization/usage/vector_stores")
@extension(
  "x-oaiMeta",
  #{
    name: "Vector stores",
    group: "usage-vector-stores",
    returns: "A list of paginated, time bucketed [Vector stores usage](https://platform.openai.com/docs/api-reference/usage/vector_stores_object) objects.",
    examples: #{
      response: "{\n    \"object\": \"page\",\n    \"data\": [\n        {\n            \"object\": \"bucket\",\n            \"start_time\": 1730419200,\n            \"end_time\": 1730505600,\n            \"results\": [\n                {\n                    \"object\": \"organization.usage.vector_stores.result\",\n                    \"usage_bytes\": 1024,\n                    \"project_id\": null\n                }\n            ]\n        }\n    ],\n    \"has_more\": false,\n    \"next_page\": null\n}\n",
      request: #{
        curl: "curl \"https://api.openai.com/v1/organization/usage/vector_stores?start_time=1730419200&limit=1\" \\\n-H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n-H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Usage")
op `usage-vector-stores`(
  /** Start time (Unix seconds) of the query time range, inclusive. */
  @query(#{ explode: true })
  start_time: integer,

  /** End time (Unix seconds) of the query time range, exclusive. */
  @query(#{ explode: true })
  end_time?: integer,

  /** Width of each time bucket in response. Currently `1m`, `1h` and `1d` are supported, default to `1d`. */
  @query(#{ explode: true })
  bucket_width?: "1m" | "1h" | "1d" = "1d",

  /** Return only usage for these projects. */
  @query(#{ explode: true })
  project_ids?: string[],

  /** Group the usage data by the specified fields. Support fields include `project_id`. */
  @query(#{ explode: true })
  group_by?: "project_id"[],

  /**Specifies the number of buckets to return.
- `bucket_width=1d`: default: 7, max: 31
- `bucket_width=1h`: default: 24, max: 168
- `bucket_width=1m`: default: 60, max: 1440*/
  @query(#{ explode: true })
  limit?: integer,

  /** A cursor for use in pagination. Corresponding to the `next_page` field from the previous response. */
  @query(#{ explode: true })
  page?: string,
): UsageResponse;

/** Lists all of the users in the organization. */
@summary("List users")
@get
@route("/organization/users")
@extension(
  "x-oaiMeta",
  #{
    name: "List users",
    group: "administration",
    returns: "A list of [User](https://platform.openai.com/docs/api-reference/users/object) objects.",
    examples: #{
      response: "{\n    \"object\": \"list\",\n    \"data\": [\n        {\n            \"object\": \"organization.user\",\n            \"id\": \"user_abc\",\n            \"name\": \"First Last\",\n            \"email\": \"user@example.com\",\n            \"role\": \"owner\",\n            \"added_at\": 1711471533\n        }\n    ],\n    \"first_id\": \"user-abc\",\n    \"last_id\": \"user-xyz\",\n    \"has_more\": false\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/organization/users?after=user_abc&limit=20 \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Users")
op `list-users`(
  /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
  @query(#{ explode: true })
  limit?: integer = 20,

  /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
  @query(#{ explode: true })
  after?: string,

  /** Filter by the email address of users. */
  @query(#{ explode: true })
  emails?: string[],
): UserListResponse;

/** Deletes a user from the organization. */
@summary("Delete user")
@delete
@route("/organization/users/{user_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Delete user",
    group: "administration",
    returns: "Confirmation of the deleted user",
    examples: #{
      response: "{\n    \"object\": \"organization.user.deleted\",\n    \"id\": \"user_abc\",\n    \"deleted\": true\n}\n",
      request: #{
        curl: "curl -X DELETE https://api.openai.com/v1/organization/users/user_abc \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Users")
op `delete-user`(
  /** The ID of the user. */
  @path
  user_id: string,
): UserDeleteResponse;

/** Retrieves a user by their identifier. */
@summary("Retrieve user")
@get
@route("/organization/users/{user_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve user",
    group: "administration",
    returns: "The [User](https://platform.openai.com/docs/api-reference/users/object) object matching the specified ID.",
    examples: #{
      response: "{\n    \"object\": \"organization.user\",\n    \"id\": \"user_abc\",\n    \"name\": \"First Last\",\n    \"email\": \"user@example.com\",\n    \"role\": \"owner\",\n    \"added_at\": 1711471533\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/organization/users/user_abc \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
      },
    },
  }
)
@tag("Users")
op `retrieve-user`(
  /** The ID of the user. */
  @path
  user_id: string,
): User;

/** Modifies a user's role in the organization. */
@summary("Modify user")
@post
@route("/organization/users/{user_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Modify user",
    group: "administration",
    returns: "The updated [User](https://platform.openai.com/docs/api-reference/users/object) object.",
    examples: #{
      response: "{\n    \"object\": \"organization.user\",\n    \"id\": \"user_abc\",\n    \"name\": \"First Last\",\n    \"email\": \"user@example.com\",\n    \"role\": \"owner\",\n    \"added_at\": 1711471533\n}\n",
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/organization/users/user_abc \\\n  -H \"Authorization: Bearer $OPENAI_ADMIN_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{\n      \"role\": \"owner\"\n  }'\n",
      },
    },
  }
)
@tag("Users")
op `modify-user`(
  /** The ID of the user. */
  @path
  user_id: string,

  /** The new user role to modify. This must be one of `owner` or `member`. */
  @body
  body: UserRoleUpdateRequest,
): User;
