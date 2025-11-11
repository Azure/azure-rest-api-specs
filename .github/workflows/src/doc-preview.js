// @ts-check
const DOCS_NAMESPACE = "_swagger_specs";
const SPEC_FILE_REGEX =
  "(specification/)+(.*)/(resourcemanager|resource-manager|dataplane|data-plane|control-plane)/(.*)/(preview|stable|privatepreview)/(.*?)/(example)?(.*)";

/**
 * @typedef {Object} SwaggerFileMetadata
 * @property {string} path
 * @property {string} serviceName
 * @property {string} serviceType
 * @property {string} resourceProvider
 * @property {string} releaseState
 * @property {string} apiVersion
 * @property {string} fileName
 */

/**
 * @typedef {Object} RepoJSONTemplate
 * @property {Object[]} repo
 * @property {string} repo[].url
 * @property {string} repo[].prNumber
 * @property {string} repo[].name
 */

/**
 * @typedef {Object} MappingJSONStructure
 * @property {string} target_api_root_dir
 * @property {boolean} enable_markdown_fragment
 * @property {string} markdown_fragment_folder
 * @property {boolean} use_yaml_toc
 * @property {boolean} formalize_url
 * @property {string[]} version_list
 * @property {Object[]} organizations
 * @property {string} organizations[].index
 * @property {string} organizations[].default_toc_title
 * @property {string} organizations[].version
 * @property {Object[]} organizations[].services
 * @property {string} organizations[].services[].toc_title
 * @property {string} organizations[].services[].url_group
 * @property {Object[]} organizations[].services[].swagger_files
 * @property {string} organizations[].services[].swagger_files[].source
 */

/**
 * Extract swagger file metadata from path.
 * @param {string} specPath
 * @returns {SwaggerFileMetadata}
 */
export function parseSwaggerFilePath(specPath) {
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

/**
 * @param {string} repoName
 * @param {string} prNumber
 * @returns {object}
 */
export function repoJSONTemplate(repoName, prNumber) {
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

/**
 * @param {string[]} files
 * @returns {MappingJSONStructure}
 */
export function mappingJSONTemplate(files) {
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

/**
 * @param {string} buildId
 * @param {string} repoName
 * @param {string} prNumber
 * @returns {string}
 */
export function indexMd(buildId, repoName, prNumber) {
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
 * @param {string[]} swaggerFiles
 **/
export function getSwaggersToProcess(swaggerFiles) {
  const swaggerFileObjs = [];
  for (const file of swaggerFiles) {
    try {
      const parsed = parseSwaggerFilePath(file);
      swaggerFileObjs.push(parsed);
    } catch (error) {
      console.log(`Skipping file "${file}" due to parsing error: ${error}`);
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
