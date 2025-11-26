import "./common.tsp";
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.App.DynamicSessions;

/** The session resource. */
@added(Versions.v2025_02_02_preview)
model Session {
  /** The identifier of the session. */
  identifier: string;

  /** The date and time when the session was created. */
  createdAt: utcDateTime;

  /** The date and time when the session was last accessed. */
  lastAccessedAt: utcDateTime;

  /** The date and time when the session will expire. */
  expireAt: utcDateTime;

  /** The ETag of the session, representing the underlying container ID. */
  etag: eTag;
}

/** The sessions list response. */
@added(Versions.v2025_02_02_preview)
model SessionsListResponse {
  /** The list of sessions. */
  sessions: Session[];

  /** The link to the next page of sessions. */
  nextLink?: url;
}
