// @ts-check
import { sdkLabels } from "../../src/sdk-types.js";
import { LabelAction } from "../../src/label.js";
import { stringify } from "querystring";
import { extractInputs } from "../../src/context.js";

const wfName = 'sdk-breaking-change-labels';

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<{labelName: string, labelAction: LabelAction, issueNumber: number}>}
 */
export async function getLabelAndAction({ github, context, core }) {
  const inputs = await extractInputs(github, context, core);
  const ado_build_id = inputs.ado_build_id;
  const ado_project_url = inputs.ado_project_url;
  const head_sha = inputs.head_sha;
  if(!ado_build_id || !ado_project_url || !head_sha) {
    throw new Error(`Required inputs are not valid: ado_build_id:${ado_build_id}, ado_project_url:${ado_project_url}, head_sha:${head_sha}`);
  }
  return await getLabelAndActionImpl({ado_build_id, ado_project_url, head_sha, core, github});
}

/**
 * @param {Object} params
 * @param {string} params.ado_build_id
 * @param {string} params.ado_project_url
 * @param {string} params.head_sha
 * @param {(import("@octokit/core").Octokit & import("@octokit/plugin-rest-endpoint-methods/dist-types/types.js").Api)} params.github
 * @param {typeof import("@actions/core")} params.core
 * @returns {Promise<{labelName: string, labelAction: LabelAction, issueNumber: number}>}
 */
export async function getLabelAndActionImpl({ado_build_id, ado_project_url, head_sha, core, github }) {
  let issue_number = NaN;
  let labelAction;
  let labelName = "";
  const artifactName = "spec-gen-sdk-breaking-change-artifact";
  const artifactFileName = artifactName + ".json";
  const apiUrl = `${ado_project_url}/_apis/build/builds/${ado_build_id}/artifacts?artifactName=${artifactName}&api-version=7.0`;
  try {
    core.info(`Calling Azure DevOps API to get the artifact: ${apiUrl}`);

    // Use Node.js fetch to call the API
    const response = await fetch(apiUrl, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json'
      }
    });

    if (response.ok) {
      // Step 1: Get the download URL for the artifact
      const artifacts = await response.json();
      core.info(`Artifacts found: ${stringify(artifacts)}`);
      if (!artifacts.resource || !artifacts.resource.downloadUrl) {
        throw new Error(`Download URL not found for the artifact ${artifactName}`);
      }

      let downloadUrl = artifacts.resource.downloadUrl;
      const index = downloadUrl.indexOf("?format=zip");
      if (index !== -1) {
        // Keep everything up to (but not including) "?format=zip"
        downloadUrl = downloadUrl.substring(0, index);
      }
      downloadUrl += `?format=file&subPath=/${artifactFileName}`;
      core.info(`Downloading artifact from: ${downloadUrl}`);

      // Step 2: Fetch Artifact Content (as a Buffer)
      const artifactResponse = await fetch(downloadUrl);
      if (!artifactResponse.ok) {
        throw new Error(`Failed to fetch artifact: ${artifactResponse.statusText}`);
      }

      const artifactData = await artifactResponse.text();
      core.info(`Artifact content: ${artifactData}`);

      // Parse the JSON data
      const breakingChangeResult = JSON.parse(artifactData);
      const labelActionText = breakingChangeResult.labelAction;
      const breakingChangeLanguage = breakingChangeResult.language;
      if (breakingChangeLanguage) {
        labelName = sdkLabels[`${breakingChangeLanguage}`].breakingChange;
      }

      // Set label action and name based on the artifacts
      if (labelActionText === true) {
        labelAction = LabelAction.Add;
      } else if (labelActionText === false) {
        labelAction = LabelAction.Remove;
      }

      // Get the issue number from the check run
      if (!issue_number) {
        const { issueNumber } = await getIssueNumber({head_sha, core, github});
        issue_number = issueNumber;
      }
    } else {
      core.error(`Failed to fetch artifacts: ${response.status}, ${response.statusText}`);
      const errorText = await response.text();
      core.error(`Error details: ${errorText}`);
    }
  } catch (error) {
    core.error(`Error processing breaking change label artifact: ${error}`);
  }

  if (!labelAction) {
    core.info('No label action found, defaulting to None');
    labelAction = LabelAction.None;
  }  
  
  return { labelName, labelAction, issueNumber: issue_number };
}

/**
 * Retrieves the PR number associated with a specific commit SHA
 * @param {Object} params
 * @param {String} params.head_sha - The head_sha
 * @param {typeof import("@actions/core")} params.core - GitHub Actions core for logging
 * @param {import('github-script').GitHub} params.github - GitHub API client
 * @returns {Promise<{issueNumber: number}>} - The PR number or NaN if not found
 */
export async function getIssueNumber({head_sha, core, github})
{
  let issueNumber = NaN;

  if (!head_sha) {
    core.info('No head_sha found in check run');
    return { issueNumber };
  }

  core.info(`Searching for PRs with commit SHA: ${head_sha}`);

  try {
    const searchResponse = await github.rest.search.issuesAndPullRequests({
      q: `sha:${head_sha} type:pr state:open`
    });

    const totalCount = searchResponse.data.total_count;
    const itemsCount = searchResponse.data.items.length;

    core.info(`Search results: ${totalCount} total matches, ${itemsCount} items returned`);

    if (itemsCount > 0) {
      const firstItem = searchResponse.data.items[0];
      issueNumber = firstItem.number;
      core.info(`Found the first matched PR #${issueNumber}: ${firstItem.html_url}`);

      if (itemsCount > 1) {
        core.warning(`Multiple PRs found for commit ${head_sha}: ${searchResponse.data.items.map(item => `#${item.html_url}`).join(', ')}`);
      }
    } else {
      core.info(`No open PRs found for commit ${head_sha}`);
    }
  } catch (error) {
    core.error(`${wfName}: Error searching for PRs with commit ${head_sha}: ${error.message}`);
    throw error;
  }

  return { issueNumber };
}
