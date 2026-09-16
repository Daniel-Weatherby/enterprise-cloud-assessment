# 7-10 Minute Presentation Run Sheet

## 0:00-0:45 — Problem and design

- State the objective: automate deployment of a simple Azure-hosted application.
- Explain why the application is intentionally simple.
- Show the architecture diagram.

## 0:45-2:00 — Terraform / IaC

Show:

- `providers.tf`
- `main.tf`
- `outputs.tf`

Explain:

- declarative desired state;
- repeatability;
- version control;
- Azure Storage static website;
- security settings including HTTPS/TLS;
- remote Terraform state.

## 2:00-3:15 — CI/CD strategy

Show:

- `validate.yml`
- `deploy.yml`

Explain:

- pull request validation/plan;
- main branch deployment;
- GitHub Actions;
- OIDC authentication;
- no long-lived Azure client secret.

## 3:15-5:30 — Live demonstration

1. Change a line in `web/index.html`.
2. Commit and push.
3. Open the workflow run.
4. Show Terraform validation and apply.
5. Show website upload.
6. Open the website and demonstrate the changed content.

## 5:30-6:45 — Testing

Discuss:

- `terraform fmt`
- `terraform validate`
- Terraform plan
- workflow success
- website functional test
- repeat deployment/no-change test

## 6:45-8:00 — Cost, scalability and sustainability

Explain:

- static hosting instead of a VM;
- Standard LRS rather than unnecessary higher-redundancy storage for a demo;
- no always-on compute;
- managed service lowers administration;
- trade-off: static hosting cannot run server-side application logic.

## 8:00-9:00 — Security and limitations

Explain:

- OIDC/federated identity;
- RBAC limited to the assessment resource group;
- TLS 1.2 minimum;
- shared-key authentication disabled for the workload storage account;
- public website is intentional;
- production design could add CDN/WAF/custom domain/private build controls.

## 9:00-9:30 — Conclusion

Summarise how a source-code change progresses from GitHub to an automated Azure deployment.
