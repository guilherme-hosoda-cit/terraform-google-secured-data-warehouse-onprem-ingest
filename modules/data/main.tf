/**
 * Copyright 2023-2025 Google LLC
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

// Creates a BigQuery dataset with Customer-Managed Encryption Keys (CMEK)
module "bigquery_data" {
  source  = "terraform-google-modules/bigquery/google"
  version = "10.0.1"

  project_id                  = var.project_id
  dataset_id                  = var.dataset_id
  description                 = var.dataset_description
  dataset_name                = var.dataset_name
  dataset_labels              = var.labels
  location                    = var.location
  encryption_key              = var.bigquery_encryption_key
  delete_contents_on_destroy  = var.delete_contents_on_destroy
  default_table_expiration_ms = var.dataset_default_table_expiration_ms
  access                      = var.access
}

// Sets the BigQuery regional project default CMEK
module "set_bq_project_cmek" {
  source = "../set-bq-project-cmek"

  project_id                = var.project_id
  location                  = var.location
  crypto_key                = var.bigquery_encryption_key
  terraform_service_account = var.terraform_service_account

  depends_on = [
    module.bigquery_data
  ]
}
