// The root .github project does not install this local tool's npm dependencies.
// Package-local type checking excludes this shim and uses the installed declarations.
declare module "@github/copilot-sdk" {
  interface PermissionRequest {
    kind: "shell" | "write" | "mcp" | "read" | "url" | "custom-tool" | "memory" | "hook";
    toolCallId?: string;
  }

  interface SessionConfig {
    model?: string;
    workingDirectory?: string;
    skillDirectories?: string[];
    onPermissionRequest?: (
      request: PermissionRequest,
      invocation: { sessionId: string },
    ) =>
      | { kind: "approve-once" }
      | { kind: "reject"; feedback: string }
      | Promise<{ kind: "approve-once" } | { kind: "reject"; feedback: string }>;
    systemMessage?: {
      mode: "append";
      content: string;
    };
  }

  interface AssistantMessageEvent {
    data: {
      content: string;
    };
  }

  export class CopilotSession {
    sendAndWait(
      options: { prompt: string },
      timeout?: number,
    ): Promise<AssistantMessageEvent | undefined>;
    disconnect(): Promise<void>;
  }

  export class CopilotClient {
    constructor(options?: { cliPath?: string; gitHubToken?: string });
    start(): Promise<void>;
    stop(): Promise<Error[]>;
    getAuthStatus(): Promise<{ isAuthenticated: boolean }>;
    createSession(config: SessionConfig): Promise<CopilotSession>;
  }
}

declare module "adm-zip" {
  export default class AdmZip {
    constructor(input?: Buffer);
    extractAllTo(targetPath: string, overwrite?: boolean): void;
  }
}
