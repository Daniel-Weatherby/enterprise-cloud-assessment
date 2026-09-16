# Technical Report Scaffold — Enterprise Cloud Infrastructure Design

Target: approximately 1,500 words.

Do not submit this unchanged. Replace test placeholders with evidence from the deployment and rewrite the wording so it accurately reflects what you actually implemented and observed.

## 1. Introduction — approximately 120-150 words

Suggested content:

This project demonstrates the automated deployment and management of a small web application in Microsoft Azure using Infrastructure as Code and CI/CD practices. The application is a static website hosted in an Azure Storage account. Terraform defines the cloud infrastructure and GitHub provides source control and automated workflows.

The implementation was intentionally kept functionally simple so the project could focus on repeatability, automation, security, deployment quality, cloud cost and sustainability. A GitHub Actions workflow validates proposed infrastructure changes and another workflow deploys approved changes to Azure. Authentication between GitHub and Azure uses OpenID Connect rather than a long-lived client secret.

Briefly state that the report explains the design, automation decisions, CI/CD strategy and testing outcomes.

## 2. Design — approximately 350-400 words

### Architecture

Describe:

Developer -> GitHub -> GitHub Actions -> Microsoft Entra ID/OIDC -> Terraform -> Azure Storage static website.

### Azure resource choice

Explain why Azure Storage static website hosting suits a small static application.

Key rationale:

- no VM or operating system required;
- managed platform;
- low operational overhead;
- low cost for small traffic volumes;
- suitable for HTML/CSS/JavaScript;
- limitation: no server-side runtime.

### Infrastructure as Code

Discuss:

- Terraform declares desired infrastructure state;
- code can be reviewed and versioned;
- environment can be reproduced;
- drift/change can be identified through `terraform plan`;
- remote state allows CI/CD to maintain consistent deployment state.

### Security design

Discuss:

- HTTPS-only traffic;
- TLS 1.2 minimum;
- workload storage account shared-key authentication disabled;
- OIDC removes a long-lived Azure secret from GitHub;
- RBAC is scoped to the assessment resource group;
- static site remains publicly readable because public access is a functional requirement.

## 3. Automation Choices — approximately 250-300 words

Explain why Terraform and GitHub Actions were selected.

Terraform:

- declarative IaC;
- repeatable deployment;
- provider ecosystem;
- plan-before-apply model.

GitHub Actions:

- directly integrated with source control;
- workflow triggered by repository events;
- validation can occur before deployment;
- deployment history is visible.

Explain the bootstrap boundary:

A small one-time bootstrap step is required before Terraform can use remote state and OIDC. This creates the state store and federated identity. After bootstrap, normal workload deployment is automated through the repository.

### Cost, scale and sustainability

Critically evaluate rather than simply claiming "cloud is green".

Discuss:

- static hosting avoids continuously running general-purpose compute;
- LRS was selected because cross-region redundancy would add unnecessary storage replication for a disposable assessment workload;
- managed services reduce operating-system administration;
- resource usage is aligned to the actual workload;
- limitation: Azure still consumes shared datacentre resources, so the architecture reduces unnecessary provisioned capacity rather than eliminating environmental impact.

## 4. CI/CD Strategy — approximately 250-300 words

Describe two workflow stages.

### Pull-request validation

- checkout;
- OIDC authentication;
- Terraform setup;
- formatting check;
- backend initialisation;
- validation;
- plan.

Explain why `plan` acts as a change preview and quality gate.

### Main deployment

- repeat validation;
- create plan;
- Terraform apply;
- collect Terraform outputs;
- deploy files into Azure Storage `$web`;
- publish deployment endpoint in workflow summary.

Discuss separation between:

- infrastructure deployment through Terraform; and
- application content deployment using Azure CLI.

Explain that separating these concerns makes the pipeline clearer and avoids using Terraform as a general-purpose file synchronisation tool.

## 5. Test Methods and Findings — approximately 300 words

Use actual evidence from `docs/test-plan.md`.

Suggested table:

| Test | Method | Expected | Actual | Result |
|---|---|---|---|---|
| Terraform formatting | `terraform fmt -check` | No formatting errors | TODO | TODO |
| Terraform validation | `terraform validate` | Configuration valid | TODO | TODO |
| Terraform plan | GitHub Actions | Plan completes | TODO | TODO |
| Infrastructure deployment | Push to `main` | Apply succeeds | TODO | TODO |
| Website access | Browser | Site loads | TODO | TODO |
| Change propagation | Edit + push | Site updates automatically | TODO | TODO |
| No-change plan | Rerun plan | No changes | TODO | TODO |

Interpret the findings. Do not just state that tests passed.

## 6. Conclusion — approximately 100-130 words

Summarise:

- IaC made the infrastructure reproducible;
- CI/CD linked repository changes to automated deployment;
- OIDC improved credential handling;
- managed static hosting aligned service choice to workload requirements;
- testing demonstrated that both infrastructure and website changes could be deployed consistently.

Also identify one or two production improvements, for example:

- separate development/production environments;
- approval gate before production apply;
- custom domain/CDN/WAF;
- monitoring and alerting;
- policy-as-code;
- narrower custom Azure RBAC role.

## Appendix

Include:

- GitHub repository URL;
- architecture diagram;
- Terraform files or link;
- workflow files;
- relevant workflow screenshots;
- Azure resource screenshots;
- test evidence;
- any planning notes.
