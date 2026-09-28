import { inspect } from "util";

const DOCS_NAMESPACE = "_swagger_specs";
const SPEC_FILE_REGEX =
  "(specification/)+(.*)/(resourcemanager|resource-manager|dataplane|data-plane|control-plane)/(.*)/(preview|stable|privatepreview)/(.*?)/(example)?(.*)";

export type SwaggerFileMetadata = {
  path: string;
  serviceName: string;
  serviceType: string;
  resourceProvider: string;
  releaseState: string;
  apiVersion: string;
  fileName: string;
};

export type RepoJSONTemplate = {
  repo: {
    url: string;
    prNumber: string;
    name: string;
  }[];
};

export type MappingJSONStructure = {
  target_api_root_dir: string;
  enable_markdown_fragment: boolean;
  markdown_fragment_folder: string;
  use_yaml_toc: boolean;
  formalize_url: boolean;
  version_list: string[];
  organizations: {
    index: string;
    default_toc_title: string;
    version: string;
    services: {
      toc_title: string;
      url_group: string;
      swagger_files: {
        source: string;
      }[];
    }[];
  }[];
};

/**
 * Extract swagger file metadata from path.
 */
export function parseSwaggerFilePath(specPath: string): SwaggerFileMetadata {
  const m = specPath.match(SPEC_FILE_REGEX);
  if (!m) {
    throw new Error(`Path "${specPath}" does not match expected swagger file pattern.`);
  }
  const [path, , serviceName, serviceType, resourceProvider, releaseState, apiVersion, , fileName] =
    m;
  return {
    path,
    serviceName,
    serviceType,
    resourceProvider,
    releaseState,
    apiVersion,
    fileName,
  };
}

export function repoJSONTemplate(repoName: string, prNumber: string): object {
  return {
    repo: [
      {
        url: `https://github.com/${repoName}`,
        prNumber: prNumber,
        name: DOCS_NAMESPACE,
      },
    ],
  };
}

export function mappingJSONTemplate(files: string[]): MappingJSONStructure {
  return {
    target_api_root_dir: "structured",
    enable_markdown_fragment: true,
    markdown_fragment_folder: "authored",
    use_yaml_toc: true,
    formalize_url: true,
    version_list: ["default"],
    organizations: [
      {
        index: "index.md",
        default_toc_title: "Getting Started",
        version: "default",
        services: [
          {
            toc_title: "Documentation Preview",
            url_group: "documentation-preview",
            swagger_files: files.map((source) => ({
              source: `${DOCS_NAMESPACE}/${source}`,
            })),
          },
        ],
      },
    ],
  };
}

export function indexMd(buildId: string, repoName: string, prNumber: string): string {
  return `# Documentation Preview for swagger pipeline build #${buildId}

Welcome to documentation preview for ${repoName}/pull/${prNumber} 
created via the swagger pipeline.

Your documentation may be viewed in the menu on the left hand side.

If you have issues around documentation generation, please feel free to contact 
us in the [Docs Support Teams Channel](https://aka.ms/ci-fix/api-docs-help)`;
}

/**
 * Given a list of changed swagger files, select an API version and a list of
 * swagger files in that API version to process.
 */
export function getSwaggersToProcess(swaggerFiles: string[]) {
  const swaggerFileObjs = [];
  for (const file of swaggerFiles) {
    try {
      const parsed = parseSwaggerFilePath(file);
      swaggerFileObjs.push(parsed);
    } catch (error) {
      console.log(`Skipping file "${file}" due to parsing error: ${inspect(error)}`);
      continue;
    }
  }

  const versions = swaggerFileObjs.map((obj) => obj.apiVersion).filter(Boolean);
  if (versions.length === 0) {
    console.log("No API versions found in eligible swagger files.");
    return { selectedVersion: null, swaggersToProcess: [] };
  }
  const uniqueVersions = Array.from(new Set(versions));

  let selectedVersion;
  if (uniqueVersions.length === 1) {
    selectedVersion = uniqueVersions[0];
    console.log(`Single API version found: ${selectedVersion}`);
  } else {
    // This sorting logic is ported from the original code which sorts only the
    // strings and doesn't attempt to parse versions for more semantically-aware
    // sorting.
    const sortedVersions = [...uniqueVersions].sort();
    selectedVersion = sortedVersions[sortedVersions.length - 1];
    console.log(
      `Multiple API versions found: ${JSON.stringify(sortedVersions)}. Selected version: ${selectedVersion}`,
    );
  }

  const swaggersToProcess = swaggerFileObjs
    .filter((obj) => obj.apiVersion === selectedVersion)
    .map((obj) => obj.path);

  return { selectedVersion, swaggersToProcess };
}
