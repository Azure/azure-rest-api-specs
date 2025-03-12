// @ts-check
import { sdkLabels } from "../../src/sdk-types.js";
import { LabelAction } from "../../src/label.js";

const wfName = 'sdk-breaking-change-labels';

/**
 * @param {import('github-script').AsyncFunctionArguments} AsyncFunctionArguments
 * @returns {Promise<{labelName: string, labelAction: LabelAction, issueNumber: number, state: string}>}
 */
export async function getLabelAndAction({ github, context, core }) {
  let issue_number = NaN;
  let check_run_id = process.env.CHECK_RUN_ID || context.payload.check_run?.id;  
  let labelAction;
  let labelName = "";

  // Determine check run ID to use (from manual input or hardcoded default)
  if (!check_run_id) {
    throw new Error('No check run ID provided');
  }
  core.info(`Fetching check run with ID: ${check_run_id}`);
  
  // First fetch the check run with specific ID
  const checkRunData = await github.rest.checks.get({
    owner: context.repo.owner,
    repo: context.repo.repo,
    check_run_id: parseInt(check_run_id, 10)
  });
  
  // Use the check run data we retrieved instead of from the payload
  const checkRun = checkRunData.data;
  if (!checkRun) {
    throw new Error('No check run data found in the API response');
  }
  core.info(`Check run name: ${checkRun.name}`);
  if (!checkRun.name.includes("(SDK Generation Job)")) {
    core.info(`Ignoring check run as it's not an SDK generation job`);
    core.setOutput('result', 'neutral');
    return { labelName, labelAction: LabelAction.None, issueNumber: issue_number, state: 'neutral' };
  }

  // Extract build ID from details_url if available
  if (checkRun.details_url) {
    core.info(`Details URL:, ${checkRun.details_url}`);
    
    // Extract buildId using regex
    const buildIdMatch = checkRun.details_url.match(/buildId=(\d+)/);
    if (buildIdMatch && buildIdMatch[1]) {
      const buildId = buildIdMatch[1];
      
      // Extract organization and project from URL
      const urlParts = new URL(checkRun.details_url);
      const pathSegments = urlParts.pathname.split('/').filter(Boolean);
      
      if (pathSegments.length >= 2) {
        const organization = pathSegments[0]; // e.g., azure-sdk
        const project = pathSegments[1]; // e.g., fadad8ea-1e34-4d7a-9016-fd29b14e8b94

        // Construct artifacts URL
        const artifactsUrl = `https://dev.azure.com/${organization}/${project}/_build/results?buildId=${buildId}&view=artifacts`;
        core.info(`Artifacts URL: ${artifactsUrl}`);
        
        // Call Azure DevOps REST API to list artifacts
        try {          
          // API URL to list artifacts
          const apiUrl = `https://dev.azure.com/${organization}/${project}/_apis/build/builds/${buildId}/artifacts?api-version=7.0`;              
          core.info('Calling Azure DevOps API to list artifacts...');
          
          // Use Node.js fetch to call the API
          const response = await fetch(apiUrl, {
            method: 'GET',
            headers: {
              'Content-Type': 'application/json'
            }
          });
          
          if (response.ok) {
            const artifacts = await response.json();
            core.info(`Artifacts found: ${artifacts.count}`);
            
            // Process artifacts as needed
            let addLabel = false;
            let removeLabel = false;
            let language = "";
            for (const artifact of artifacts.value) {

              // label artifact name example: 'spec-gen-sdk-azure-sdk-for-js-true'
              if (artifact.name.startsWith("spec-gen-sdk_")) {
                core.info(`Artifact: ${artifact.name}`);
                if(artifact.name.endsWith("true")) {
                  addLabel = true;
                  language = artifact.name.split("_")[1];
                } else if(artifact.name.endsWith("false")) {
                  removeLabel = true;
                  language = artifact.name.split("_")[1];
                }
              }
            }

            // Set label action and name based on the artifacts
            if (addLabel) {
              labelAction = LabelAction.Add;
            } else if (removeLabel) {
              labelAction = LabelAction.Remove;
            }
            if (language) {
              labelName = sdkLabels[`${language}`].breakingChange;
            }
          } else {
            core.error(`Failed to fetch artifacts: ${response.status}, ${response.statusText}`);
            const errorText = await response.text();
            core.error(`Error details: ${errorText}`);
          }
        } catch (apiError) {
          core.error(`Error calling Azure DevOps API: ${apiError}`);
        }
      } else {
        core.error(`Could not extract organization and project from URL: ${checkRun.details_url}`);
      }
    } else {
      core.error(`Could not extract buildId from details_url: ${checkRun.details_url}`);
    }
  } else {
    core.info('No details_url found in check run');
  }
  // Get the issue number from the check run
  if (Number.isNaN(issue_number)) {
    const { issueNumber } = await getIssueNumber({checkRun, core, github});
    issue_number = issueNumber;
  }

  if (!labelAction) {
    core.info('No label action found, defaulting to None');
    labelAction = LabelAction.None;
  }  
  
  return { labelName, labelAction, issueNumber: issue_number, state: labelAction !== LabelAction.None ? 'success' : 'neutral' };  
}

/**
 * Retrieves the PR number associated with a specific commit SHA
 * @param {Object} params
 * @param {import('github').CheckRun} params.checkRun - The check run object containing head_sha
 * @param {typeof import("@actions/core")} params.core - GitHub Actions core for logging
 * @param {import('github-script').GitHub} params.github - GitHub API client
 * @returns {Promise<{issueNumber: number}>} - The PR number or NaN if not found
 */
async function getIssueNumber({checkRun, core, github})
{
  let issueNumber = NaN;

  if (!checkRun.head_sha) {
    core.info('No head_sha found in check run');
    return { issueNumber };
  }

  core.info(`Searching for PRs with commit SHA: ${checkRun.head_sha}`);

  try {
    const searchResponse = await github.rest.search.issuesAndPullRequests({
      q: `sha:${checkRun.head_sha} type:pr state:open`
    });

    const totalCount = searchResponse.data.total_count;
    const itemsCount = searchResponse.data.items.length;

    core.info(`Search results: ${totalCount} total matches, ${itemsCount} items returned`);

    if (itemsCount > 0) {
      const firstItem = searchResponse.data.items[0];
      issueNumber = firstItem.number;
      core.info(`Found the first matched PR #${issueNumber}: ${firstItem.html_url}`);

      if (itemsCount > 1) {
        core.warning(`Multiple PRs found for commit ${checkRun.head_sha}: ${searchResponse.data.items.map(item => `#${item.html_url}`).join(', ')}`);
      }
    } else {
      core.info(`No open PRs found for commit ${checkRun.head_sha}`);
    }
  } catch (error) {
    core.error(`${wfName}: Error searching for PRs with commit ${checkRun.head_sha}: ${error.message}`);
    throw error;
  }

  return { issueNumber };
}