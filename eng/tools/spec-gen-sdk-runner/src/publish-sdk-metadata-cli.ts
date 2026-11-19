import { publishSdkMetadata } from "./publish-sdk-metadata.ts";

function required(name: string): string {
  const value = process.env[name];
  if (!value || value.includes("$(")) throw new Error(`Missing publisher configuration: ${name}`);
  return value;
}

try {
  const result = await publishSdkMetadata({
    collectionUri: required("SDK_METADATA_COLLECTION_URI"),
    projectId: required("SDK_METADATA_PROJECT_ID"),
    buildId: Number(required("SDK_METADATA_BUILD_ID")),
    allowedDefinitionIds: required("SDK_METADATA_DEFINITION_IDS").split(",").map(Number),
    publisherAppId: Number(required("SDK_METADATA_PUBLISHER_APP_ID")),
    adoToken: required("SYSTEM_ACCESSTOKEN"),
    githubToken: required("GH_TOKEN"),
  });
  console.log(`SDK metadata publication: ${result}`);
} catch (error) {
  // Do not dump HTTP responses, downloaded metadata, or credentials into public logs.
  console.error(error instanceof Error ? error.message : "SDK metadata publication failed");
  process.exitCode = 1;
}
