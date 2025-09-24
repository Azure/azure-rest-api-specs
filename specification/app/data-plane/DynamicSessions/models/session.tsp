import "./common.tsp";
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.App.DynamicSessions;

@added(Versions.v2025_02_02_preview)
@doc("The session resource.")
model Session {
  @doc("The identifier of the session.")
  identifier: string;

  @doc("The date and time when the session was created.")
  createdAt: utcDateTime;

  @doc("The date and time when the session was last accessed.")
  lastAccessedAt: utcDateTime;

  @doc("The date and time when the session will expire.")
  expireAt: utcDateTime;

  @doc("The ETag of the session, representing the underlying container ID.")
  etag: eTag;
}

@added(Versions.v2025_02_02_preview)
@doc("The sessions list response.")
model SessionsListResponse {
  @doc("The list of sessions.")
  sessions: Session[];

  @doc("The link to the next page of sessions.")
  nextLink?: url;
}
