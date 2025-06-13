/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
  int_required_roles = [
    "roles/owner"
  ]

  int_org_required_roles = [
    "roles/orgpolicy.policyAdmin",
    "roles/accesscontextmanager.policyAdmin",
    "roles/resourcemanager.organizationAdmin",
    "roles/billing.user"
  ]

  folder_required_roles = [
    "roles/resourcemanager.folderAdmin",
    "roles/resourcemanager.projectCreator",
    "roles/resourcemanager.projectDeleter",
    "roles/resourcemanager.projectIamAdmin",
    "roles/compute.xpnAdmin",
    "roles/compute.networkAdmin",
    "roles/cloudkms.cryptoOperator",
    "roles/vpcaccess.admin",
    "roles/logging.admin",
    "roles/iam.serviceAccountTokenCreator",
    "roles/iam.serviceAccountAdmin",
    "roles/serviceusage.serviceUsageAdmin",
  ]

}

resource "google_service_account" "int_test" {
  project      = module.project.project_id
  account_id   = "ci-account"
  display_name = "ci-account"
}

resource "google_organization_iam_member" "int_test" {
  for_each = toset(local.int_org_required_roles)
  org_id   = var.org_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.int_test.email}"
}

resource "google_folder_iam_member" "int_test" {
  for_each = toset(local.folder_required_roles)

  folder = google_folder.int_test.id
  role   = each.value
  member = "serviceAccount:${google_service_account.int_test.email}"
}

resource "google_project_iam_member" "int_test" {
  for_each = toset(local.int_required_roles)

  project = module.project.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.int_test.email}"
}

resource "google_billing_account_iam_member" "int_test" {
  billing_account_id = var.billing_account
  role               = "roles/billing.user"
  member             = "serviceAccount:${google_service_account.int_test.email}"
}

resource "google_service_account_iam_member" "cloud_build_impersonation" {
  count = var.build_project_number == null ? 0 : 1

  service_account_id = google_service_account.int_test.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${var.build_project_number}@cloudbuild.gserviceaccount.com"
}

resource "google_service_account_iam_member" "self_impersonation" {
  service_account_id = google_service_account.int_test.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${google_service_account.int_test.email}"
}

resource "google_service_account_key" "int_test" {
  service_account_id = google_service_account.int_test.id
}
