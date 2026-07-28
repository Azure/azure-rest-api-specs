using TypeSpec.Http;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Enums
// ---------------------------------------------------------------------------

/** The publish scope for the generated Microsoft Teams app. */
union Microsoft365PublishScope {
  string,

  /** Publish the app for the acting user only. */
  personal: "Personal",

  /** Publish the app to a shared scope within the organization. */
  shared: "Shared",

  /** Publish the app tenant-wide. */
  tenant: "Tenant",
}

// ---------------------------------------------------------------------------
// Request models
// ---------------------------------------------------------------------------

/**
 * An agentic-user template describing how the agent participates as an agentic user in Microsoft 365.
 * Only used when `useAgenticUserTemplate` is true on the publish request.
 */
model Microsoft365AgenticUserTemplate {
  /** Identifier of the agentic-user template. */
  id?: string;

  /** Name of the agentic-user template file embedded in the generated app package. */
  file?: string;

  /** Schema version of the agentic-user template. */
  schemaVersion?: string;

  /** Blueprint identity client id used for the agentic user. */
  agentIdentityBlueprintId?: string;

  /** Communication protocol used by the agentic user. */
  communicationProtocol?: string;
}

/**
 * Request body for publishing a Foundry agent to Microsoft 365 / Microsoft Teams. The agent is
 * identified by the `agent_name` in the route and resolved server-side, so the agent id, bot id, and
 * app-registration id are not supplied in the body.
 */
model Microsoft365PublishRequest {
  /**
   * Display name used as the published Teams app name. When omitted, the agent name from the route is
   * used.
   */
  agentDisplayName?: string;

  /**
   * ARM resource id of the Azure Bot Service that fronts this agent in Microsoft Teams. Required for
   * workspaces on the default bot-based Teams backend; optional for workspaces on the API-based backend.
   */
  botServiceArmId?: string;

  /**
   * When true, the agent is published as an autopilot (digital worker) agent: the bot id is taken from
   * the agent's blueprint identity and the generated Teams manifest is marked as a digital worker.
   */
  publishAsAutopilot?: boolean;

  /** When true, the supplied `agenticUserTemplate` is embedded in the generated Teams app package. */
  useAgenticUserTemplate?: boolean = false;

  /** Optional agentic-user template. Required when `useAgenticUserTemplate` is true. */
  agenticUserTemplate?: Microsoft365AgenticUserTemplate;

  /** Publish scope for the Teams app. */
  publishScope: Microsoft365PublishScope;

  /**
   * App version (for example `1.2.3`) written into the Teams manifest. May contain only digits and
   * periods, must not start with `0`, and must end with a digit. When omitted, a platform default is
   * used.
   */
  appVersion?: string;

  /** Short, one-line description shown in the Teams app listing. */
  shortDescription?: string;

  /** Full description shown on the Teams app details page. */
  fullDescription?: string;

  /** Display name of the developer / publisher shown in the Teams app listing. */
  developerName?: string;

  /** Developer / publisher website URL shown in the Teams app listing. Must be an https URL. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Wire field name uses the 'Url' suffix; renaming would break the documented contract."
  developerWebsiteUrl?: string;

  /** Privacy policy URL shown in the Teams app listing. Must be an http or https URL. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Wire field name uses the 'Url' suffix; renaming would break the documented contract."
  privacyUrl?: string;

  /** Terms-of-use URL shown in the Teams app listing. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Wire field name uses the 'Url' suffix; renaming would break the documented contract."
  termsOfUseUrl?: string;

  /**
   * Optional base64-encoded PNG used as the color (full-bleed) icon in the Teams app package. Must be a
   * 192x192 PNG (perfect square, no border or rounded corners). Max 1 MB after decode. When omitted, the
   * platform default color icon is used.
   */
  colorIconBase64?: string;

  /**
   * Optional base64-encoded PNG used as the outline icon in the Teams app package. Must be a 32x32 PNG.
   * Max 1 MB after decode. When omitted, the platform default outline icon is used.
   */
  outlineIconBase64?: string;
}

// ---------------------------------------------------------------------------
// Response models
// ---------------------------------------------------------------------------

/** Response from publishing an agent to Microsoft 365 / Microsoft Teams. */
model Microsoft365PublishResponse {
  /** The Microsoft 365 title id of the published app. */
  titleId?: string;

  /** The Microsoft Teams app id of the published app. */
  teamsAppId?: string;
}

/** The generated Microsoft 365 app package (Microsoft Teams app zip). */
model Microsoft365AppPackageResponse {
  /** The media type of the returned package content. */
  @header("Content-Type")
  content_type: "application/zip";

  /** The Microsoft Teams app package zip content. */
  @body
  content: bytes;
}

/**
 * Default and previously-published values used to pre-populate a Microsoft 365 publish request for a
 * Foundry agent.
 */
model Microsoft365PublishDefaults {
  /** The publish scope. */
  appPublishScope?: Microsoft365PublishScope;

  /** The agent name. */
  agentName?: string;

  /**
   * The user-facing display name for the agent. Defaults to the agent name if not previously
   * overridden.
   */
  agentDisplayName?: string;

  /** The app-registration client id associated with the agent. */
  appRegistrationClientId?: string;

  /** The most recently published app version. */
  appVersion?: string;

  /** The recommended next app version (the most recent app version, incremented). */
  recommendedNextAppVersion?: string;

  /** The Microsoft 365 title id of the previously-published app, if any. */
  titleId?: string;

  /** The Microsoft Teams app id of the previously-published app, if any. */
  teamsAppId?: string;

  /** Short, one-line description shown in the Teams app listing. */
  shortDescription?: string;

  /** Full description shown on the Teams app details page. */
  fullDescription?: string;

  /** Display name of the developer / publisher. */
  developerName?: string;

  /** Developer / publisher website URL. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Wire field name uses the 'Url' suffix; renaming would break the documented contract."
  developerWebsiteUrl?: string;

  /** Privacy policy URL. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Wire field name uses the 'Url' suffix; renaming would break the documented contract."
  privacyUrl?: string;

  /** Terms-of-use URL. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Wire field name uses the 'Url' suffix; renaming would break the documented contract."
  termsOfUseUrl?: string;
}
