# sample-aws-api-s3

#### Introduction
This project lists all AWS buckets by accessing them using settings from `appsettings` and local credentials. It includes both a Terraform project and an API.

#### Setup
1. Clone the repository:
   ```sh
   git clone https://github.com/fcsantos/sample-aws-api-s3.git
   cd sample-aws-api-s3
   ```

2. Configure AWS credentials:
   - Ensure that your AWS credentials are correctly set up in your local environment.

3. Update `appsettings.json` with your AWS configuration.

#### Terraform Project
1. Navigate to the Terraform directory:
   ```sh
   cd terraform
   ```

2. Initialize Terraform:
   ```sh
   terraform init
   ```

3. Apply the Terraform configuration:
   ```sh
   terraform apply
   ```

#### API Project
1. Navigate to the API directory:
   ```sh
   cd api
   ```

2. Run the project:
   ```sh
   dotnet run
   ```

#### Usage
The API supports the following operations:
- Buckets: create, list, delete
- Files: upload, list, preview, delete

#### License
This project is not licensed.
