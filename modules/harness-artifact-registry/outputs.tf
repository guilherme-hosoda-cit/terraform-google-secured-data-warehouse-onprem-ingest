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

output "project_id" {
  description = "The project ID of the template project."
  value       = module.external_flex_template_project.project_id

  depends_on = [
    module.external_flex_template_project
  ]
}

output "sdx_project_number" {
  description = "The Project Number to configure Secure data exchange with egress rule for the dataflow templates."
  value       = module.external_flex_template_project.project_number

  depends_on = [
    module.external_flex_template_project
  ]
}

output "flex_template_bucket_name" {
  description = "The name of the bucket created to store the flex template."
  value       = google_storage_bucket.templates_bucket.name
}

output "flex_template_repository_name" {
  description = "The name of the flex template artifact registry repository."
  value       = google_artifact_registry_repository.flex_templates.name
}

output "docker_flex_template_repository_url" {
  description = "URL of the docker flex template artifact registry repository."
  value       = local.docker_repository_url
}

output "docker_flex_template_repository_id" {
  description = "ID of the docker flex template artifact registry repository."
  value       = local.docker_repository_id
}

output "python_flex_template_repository_url" {
  description = "URL of the docker flex template artifact registry repository."
  value       = local.python_repository_url
}

output "python_flex_template_repository_id" {
  description = "ID of the docker flex template artifact registry repository."
  value       = local.python_repository_id
}

output "cloudbuild_bucket_name" {
  description = "The name of the Google Storage Bucket used to save temporary files in Cloud Build builds."
  value       = google_storage_bucket.cloudbuild_bucket.name
}

output "cloudbuild_builder_email" {
  description = "The email of the service account used in the build steps."
  value       = google_service_account.cloud_builder.email
}

output "pip_index_url" {
  description = "The URL of the Python Package Index repository to be used to load the Python third-party packages."
  value       = local.pip_index_url
}
