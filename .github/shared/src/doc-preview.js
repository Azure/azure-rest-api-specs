const DOCS_NAMESPACE = "_swagger_specs";
const SPEC_FILE_REGEX =
  "(specification/)+(.*)/(resourcemanager|resource-manager|dataplane|data-plane|control-plane)/(.*)/(preview|stable|privatepreview)/(.*?)/(example)?(.*)";

/**
 * Extract swagger file metadata from path.
 * @param {string} specPath
 * @returns {{
 *   path: string,
 *   serviceName: string,
 *   serviceType: string,
 *   resourceProvider: string,
 *   releaseState: string,
 *   apiVersion: string,
 *   fileName: string
 * } | null}
 */
export function parseSwaggerFilePath(specPath) {
  const m = specPath.match(SPEC_FILE_REGEX);
  if (!m) {
    console.log(
      `Path "${specPath}" does not match expected swagger file pattern.`,
    );
    return null;
  }
  const [
    path,
    ,
    serviceName,
    serviceType,
    resourceProvider,
    releaseState,
    apiVersion,
    ,
    fileName,
  ] = m;
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
 * @param {{owner: string, repo: string, prNumber: string}} prKey
 * @returns {object}
 */
export function repoJSONTemplate({ repoName, prNumber }) {
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
 * @returns {object}
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
 * @param {{owner: string, repo: string, prNumber: string}} key
 * @returns {string}
 */
// TODO: Use aka.ms link for Teams channel
export function indexMd(buildId, { repoName, prNumber }) {
  return `# Documentation Preview for swagger pipeline build #${buildId}

Welcome to documentation preview for ${repoName}/pull/${prNumber} 
created via the swagger pipeline.

Your documentation may be viewed in the menu on the left hand side.

If you have issues around documentation generation, please feel free to contact 
us in the [Docs Support Teams Channel](https://teams.microsoft.com/l/channel/19%3A7506cc3e220f430ab89d992c7db5284f%40thread.skype/API%20Reference%20and%20Samples?groupId=de9ddba4-2574-4830-87ed-41668c07a1ca&tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47)`;
}

/**
 * Given a list of changed swagger files, select an API version and a list of
 * swagger files in that API version to process.
 * @param {string[]} swaggerFiles
 **/
export function getSwaggersToProcess(swaggerFiles) {
  const swaggerFileObjs = swaggerFiles
    .map(parseSwaggerFilePath)
    .filter(Boolean);

  const versions = swaggerFileObjs.map((obj) => obj.apiVersion).filter(Boolean);
  const uniqueVersions = [...new Set(versions)];
  if (uniqueVersions.length === 0) {
    console.log(
      "No API versions found in eligible swagger files. No documentation artifacts will be written.",
    );
    return { selectedVersion: null, swaggersToProcess: [] };
  }

  let selectedVersion = uniqueVersions[0];
  if (uniqueVersions.length > 1) {
    const sortedVersions = [...uniqueVersions].sort();
    selectedVersion = sortedVersions[sortedVersions.length - 1];
    console.log(
      `Multiple API versions found: ${JSON.stringify(sortedVersions)}. Selected version: ${selectedVersion}`,
    );
  } else {
    console.log(`Single API version found: ${selectedVersion}`);
  }

  const swaggersToProcess = swaggerFileObjs
    .filter((obj) => obj.apiVersion === selectedVersion)
    .map((obj) => obj.path);

  return { selectedVersion, swaggersToProcess };
}
