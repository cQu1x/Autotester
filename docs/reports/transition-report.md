
# Meeting Transcript (Cleaned and Translated)

We will record this meeting for the SIGA project. Full transcription is needed.

---

## Progress Overview

We’ve added integration tests recently. There were major issues with bypassing Cloudflare protection; it took us two days to resolve this. Eventually, we switched from Selenium to Playwright, and it now seems to be working.

PDF reports are also being handled.

---

## Clarification on Testing Terminology

**Mikhail:** What do you mean by “integration tests”?

**Response:** By integration tests, we meant more complex user scenarios. For example: log in to GitFlame, create a repository named “test-repository-1”, etc. The system performs those steps and verifies completion.

**Clarification:** This sounds more like end-to-end testing than traditional integration testing. End-to-end tests simulate full user scenarios across the entire system. Integration tests typically refer to internal services interacting via APIs.

Let’s all align on terminology to avoid confusion. We also brought in our testing expert who confirmed this is more aligned with end-to-end testing.

---

## Technical Issues & Timeouts

We’ve encountered a timeout issue — our end-to-end tests are long (2–3 minutes each). The tests sometimes fail because the frontend or backend takes too long to respond. We’re working on syncing all timeout settings.

Currently, we can only show these tests in console format. It’s not very visual — you see logs but not a real user experience.

---

## Lack of Feedback for User Actions

The system lacks feedback during testing, which makes it unclear what’s happening. A report indicating the steps performed would be useful.

Both Playwright and Selenium support taking screenshots — a visual report (via screenshots or GIFs) could help prove what actions were performed.

We’re planning to add a textual PDF report (which fields were filled, buttons clicked, etc.) but have not yet implemented screenshots.

---

## Future Commitment

If anyone is interested in continuing with the project — let us know. There's no obligation, but this could be a strong opportunity.

---

## Playwright Demonstration

Currently, we pass the GitFlame URL, username, and password, and Playwright tries to log in and create a test repository.

Logs show: logging in, submitting credentials, loading the main page. But repository creation failed due to a recent update in GitFlame — some site elements changed.

We’re currently working with a stripped-down version of the HTML page (without styles/scripts), which helps the LLM work faster by reducing token size dramatically (e.g., from 30,000 to 3,000 tokens).

This optimization allows the LLM to interpret and generate more steps per prompt.

---

## Prompt Structure & Flexibility

Our prompt is currently hardcoded, which limits flexibility. Ideally, prompts should be dynamic and adaptable to the current context.

Future improvements could include splitting tasks into subtasks (agent sessions) for better parallelism and performance.

---

## Domain Understanding & Testing Strategy

We still lack a deep understanding of domain-specific testing processes — especially test case modeling, architecture, and strategy. This will be important to develop further.

---

## GitLab SSO Success Case

Interestingly, GitLab (with Innopolis SSO) works well with our system. We successfully logged in and retrieved repository count — this proves our approach works in some cases.

---

## Presentation Strategy

Prepare a video compilation of the system’s working parts (successful test steps, console logs, screenshots). This will make your presentation more convincing.

Be honest: mention current limitations, technical issues, and what you learned. Include a section on lessons learned, self-critique, and future plans.

---

## Final Reflections

We’ve made real progress: from initial ideas to working test cases and architecture.

Yes, there were problems, but we also learned a lot — both technically and in teamwork.

Everyone should reflect on their contribution and experience honestly. This will help guide the future of the project.

Good luck on the presentation!
