import "./common.tsp";
using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.App.DynamicSessions;

@doc("The session resource.")
model Session {
  @doc("The date and time when the session was created.")
  createdAt: utcDateTime;

  @doc("The date and time when the session was last accessed.")
  lastAccessedAt: utcDateTime;

  @doc("The date and time when the session will expire.")
  expireAt: utcDateTime;

  @doc("The ETag of the session, representing the underlying container ID.")
  etag: string;
}

@doc("The sessions list response.")
model SessionsListResponse {
  @doc("The list of sessions.")
  sessions: SessionsListResponseEntry[];
}

@doc("The sessions list response entry.")
model SessionsListResponseEntry {
  @doc("The identifier of the session.")
  identifier: string;

  @doc("The date and time when the session will expire.")
  expireAt: utcDateTime;
}
