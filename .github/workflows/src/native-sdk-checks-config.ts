import type { NativeSdkLanguage } from "./native-sdk-checks.ts";

// Populate only after provisioning and verifying the private Azure Pipelines definitions.
// An empty configuration deliberately leaves private SDK validation pending.
export const nativeSdkChecks: readonly NativeSdkLanguage[] = [];
