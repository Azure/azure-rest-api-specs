import * as z from "zod";
import { APIViewRequestDataSchema, SpecGenSdkArtifactInfoSchema } from "./sdk-types.ts";

export const SDK_METADATA_MAX_TEXT_BYTES = 65_535;
export const SDK_METADATA_COLLECTION_URI = "https://dev.azure.com/azure-sdk/";
export const SdkMetadataIdSchema = z.number().int().positive().safe();
export const SdkMetadataGuidSchema = z
  .string()
  .regex(/^[0-9a-f]{8}(?:-[0-9a-f]{4}){3}-[0-9a-f]{12}$/i);
const Timestamp = z.iso.datetime({ offset: true });

export const SdkMetadataSchema = z.strictObject({
  schemaVersion: z.literal(1),
  kind: z.literal("spec-gen-sdk-metadata"),
  build: z.strictObject({
    collectionUri: z.literal(SDK_METADATA_COLLECTION_URI),
    projectId: SdkMetadataGuidSchema,
    definitionId: SdkMetadataIdSchema,
    buildId: SdkMetadataIdSchema,
    stageAttempt: SdkMetadataIdSchema,
    jobAttempt: SdkMetadataIdSchema,
    jobId: SdkMetadataGuidSchema,
  }),
  sourceCheck: z.strictObject({
    id: SdkMetadataIdSchema,
    name: z.string().min(1),
    startedAt: Timestamp,
    completedAt: Timestamp,
  }),
  artifact: SpecGenSdkArtifactInfoSchema.extend({
    headSha: z.string().regex(/^[0-9a-f]{40}$/i),
    prNumber: z.string().regex(/^[1-9]\d*$/),
    result: z.enum(["succeeded", "failed", "warning", "pending", "inProgress", "notEnabled"]),
    apiViewRequestData: z.array(APIViewRequestDataSchema.passthrough()),
  }).passthrough(),
});
export type SdkMetadata = z.infer<typeof SdkMetadataSchema>;
type BuildIdentity = Pick<SdkMetadata["build"], "projectId" | "definitionId" | "buildId">;

function assertTextSize(text: string): void {
  if (Buffer.byteLength(text, "utf8") > SDK_METADATA_MAX_TEXT_BYTES) {
    throw new Error("SDK metadata is oversized: exceeds the 65,535-byte check output.text limit");
  }
}

export function serializeSdkMetadata(value: unknown): string {
  const text = JSON.stringify(SdkMetadataSchema.parse(value));
  assertTextSize(text);
  return text;
}

export function parseSdkMetadata(text: string): SdkMetadata {
  assertTextSize(text);
  return SdkMetadataSchema.parse(JSON.parse(text));
}

export function sdkMetadataCheckName(definitionId: number): string {
  return `SDK metadata / ${definitionId}`;
}

export function sdkMetadataExternalIdPrefix(build: BuildIdentity): string {
  return `spec-gen-sdk-metadata:v1:${build.projectId}:${build.definitionId}:${build.buildId}:`;
}

export function sdkMetadataExternalId(
  build: BuildIdentity & Pick<SdkMetadata["build"], "stageAttempt" | "jobAttempt">,
): string {
  return `${sdkMetadataExternalIdPrefix(build)}${build.stageAttempt}:${build.jobAttempt}`;
}

export function nativeSdkBuildIdentity(check: {
  external_id: string | null;
  details_url: string | null;
}): BuildIdentity & { projectRef: string } {
  const url = new URL(check.details_url ?? "");
  const parts = /^([1-9]\d*)\|([1-9]\d*)\|([0-9a-f-]+)$/i.exec(check.external_id ?? "");
  const projectRef = /^\/azure-sdk\/([A-Za-z0-9-]+)\/_build\/results$/.exec(url.pathname)?.[1];
  if (
    url.origin !== "https://dev.azure.com" ||
    url.username ||
    url.password ||
    url.hash ||
    !parts ||
    !SdkMetadataGuidSchema.safeParse(parts[3]).success ||
    !projectRef ||
    (SdkMetadataGuidSchema.safeParse(projectRef).success &&
      projectRef.toLowerCase() !== parts[3].toLowerCase()) ||
    url.searchParams.get("buildId") !== parts[2] ||
    url.searchParams.getAll("buildId").length !== 1
  ) {
    throw new Error("Invalid native SDK build identity");
  }
  return {
    definitionId: SdkMetadataIdSchema.parse(Number(parts[1])),
    buildId: SdkMetadataIdSchema.parse(Number(parts[2])),
    projectId: parts[3],
    projectRef,
  };
}
