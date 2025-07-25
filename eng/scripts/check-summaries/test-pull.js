import { Octokit } from "@octokit/rest"

const client = new Octokit({
    ...(process.env.GITHUB_TOKEN && { auth: process.env.GITHUB_TOKEN })
})

async function testSpecificWorkflowRun() {
    console.log('Testing specific workflow run parsing...')

    try {
        // Use one of the recent workflow runs
        const runId = 16506085673

        // Get jobs for this workflow run
        const { data: jobs } = await client.rest.actions.listJobsForWorkflowRun({
            owner: 'Azure',
            repo: 'azure-rest-api-specs',
            run_id: runId
        })

        console.log(`Found ${jobs.jobs.length} jobs for run ${runId}`)

        const summarizeJob = jobs.jobs.find(job =>
            job.name === '[TEST-IGNORE] Summarize Checks'
        )

        if (summarizeJob) {
            console.log(`Found summarize job: ${summarizeJob.id}`)
            console.log(`Job status: ${summarizeJob.status}`)
            console.log(`Job conclusion: ${summarizeJob.conclusion}`)

            // Try to get logs
            try {
                const { data: logs } = await client.rest.actions.downloadJobLogsForWorkflowRun({
                    owner: 'Azure',
                    repo: 'azure-rest-api-specs',
                    job_id: summarizeJob.id
                })

                const logText = logs.toString()
                console.log('\n--- Sample of logs ---')
                console.log(logText.substring(0, 1000))

                // Look for the input information
                const inputsMatch = logText.match(/inputs: ({.*?})/s)
                if (inputsMatch) {
                    console.log('\n--- Found inputs ---')
                    console.log(inputsMatch[1])

                    try {
                        const inputs = JSON.parse(inputsMatch[1])
                        console.log('Parsed inputs:', inputs)
                    } catch (parseError) {
                        console.error('Error parsing inputs JSON:', parseError.message)
                    }
                }

                // Look for PR information
                const prMatch = logText.match(/Handling.*?event for PR #(\d+)/s) ||
                               logText.match(/on Azure\/azure-rest-api-specs#(\d+)/s)

                if (prMatch) {
                    console.log(`Found PR number in logs: ${prMatch[1]}`)
                }

            } catch (logError) {
                console.error('Error getting logs:', logError.message)
            }
        } else {
            console.log('No summarize job found')
            console.log('Available jobs:')
            jobs.jobs.forEach(job => console.log(`- ${job.name}: ${job.status}`))
        }

    } catch (error) {
        console.error('Error:', error.message)
    }
}

testSpecificWorkflowRun().catch(console.error)