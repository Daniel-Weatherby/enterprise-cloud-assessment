# Test Plan

Use this document to collect evidence for the report and presentation.

## 1. Terraform formatting test

**Method**

```powershell
terraform fmt -check -recursive
```

**Expected result**

Exit code 0 with no formatting errors.

**Actual result**

Record after execution.

---

## 2. Terraform configuration validation

**Method**

```powershell
terraform validate
```

**Expected result**

`Success! The configuration is valid.`

**Actual result**

Record after execution.

---

## 3. Terraform plan test

**Method**

Run the GitHub pull-request workflow or:

```powershell
terraform plan
```

**Expected result**

Terraform produces an execution plan without configuration errors.

**Actual result**

Record the resource actions and include a screenshot if useful.

---

## 4. Automated deployment test

**Method**

Push a commit to `main`.

**Expected result**

The GitHub Actions deployment workflow:

1. Authenticates through OIDC.
2. Initialises Terraform.
3. Validates the configuration.
4. Produces a plan.
5. Applies the infrastructure.
6. Uploads website files.

**Actual result**

Record workflow result and run URL.

---

## 5. Functional website test

**Method**

Open the Terraform `website_endpoint` output in a browser.

**Expected result**

HTTP/HTTPS request succeeds and displays the assessment website.

**Actual result**

Record endpoint and screenshot.

---

## 6. Change propagation test

**Method**

Modify a visible line in `web/index.html`, commit and push to `main`.

**Expected result**

The CI/CD workflow automatically updates the website without manually changing the Azure resource.

**Actual result**

Record the commit SHA, workflow run and displayed change.

---

## 7. Authentication/security test

**Method**

Inspect the GitHub workflow and repository settings.

**Expected result**

No Azure client secret is stored in the repository. GitHub Actions uses an OIDC token and Entra federated credential.

**Actual result**

Record evidence.

---

## 8. Terraform state persistence test

**Method**

After a successful deployment, run another plan without changing the code.

**Expected result**

Terraform reports no infrastructure changes.

**Actual result**

Record output.
