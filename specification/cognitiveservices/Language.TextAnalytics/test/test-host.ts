import { AzureCoreTestLibrary } from "@azure-tools/cadl-azure-core/testing";
import { createTestHost, createTestWrapper } from "@cadl-lang/compiler/testing";
import { OpenAPITestLibrary } from "@cadl-lang/openapi/testing";
import { RestTestLibrary } from "@cadl-lang/rest/testing";
import { VersioningTestLibrary } from "@cadl-lang/versioning/testing";
import { AzureLanguageTestLibrary } from "../src/testing/index.js";

export async function createAzureLanguageTestHost() {
  return createTestHost({
    libraries: [
      AzureCoreTestLibrary,
      AzureLanguageTestLibrary,
      OpenAPITestLibrary,
      RestTestLibrary,
      VersioningTestLibrary,
    ],
  });
}

export async function createAzureLanguageTestRunner() {
  const host = await createAzureLanguageTestHost();
  return createTestWrapper(
    host,
    (code) =>
      `import "${AzureCoreTestLibrary.name}"; import "${AzureLanguageTestLibrary.name}"; import "${OpenAPITestLibrary.name}"; import "${RestTestLibrary.name}"; using Azure.Language; ${code}`,
    { miscOptions: { "disable-linter": true } }
  );
}
