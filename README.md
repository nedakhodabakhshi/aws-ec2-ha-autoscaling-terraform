# AWS EC2 High Availability & Auto Scaling Project (Terraform)

##  Overview
This project demonstrates a **production-like High Availability and Auto Scaling architecture on AWS** using **Terraform** and **AWS CLI**.

The goal of this project is to showcase real-world CloudOps practices such as:
- Infrastructure as Code (IaC)
- High Availability across multiple Availability Zones
- Auto Scaling based on CPU utilization
- Secure traffic flow using Application Load Balancer and Security Groups
- Observability using CloudWatch Alarms

This project was built without using the AWS Console for provisioning, following real production workflows.

---

##  Architecture
**Traffic Flow:**

Internet
|
Application Load Balancer (ALB)
|
Target Group
|
Auto Scaling Group
|
EC2 Instances (Multi-AZ)


### Key Characteristics
- Multi-AZ deployment using default VPC subnets
- No direct internet access to EC2 instances
- Auto recovery from instance failure
- Automatic scaling based on CPU load

---

##  AWS Services Used
- Amazon EC2
- Application Load Balancer (ALB)
- Auto Scaling Group (ASG)
- Launch Template
- Security Groups
- Amazon CloudWatch (Metrics & Alarms)
- IAM (via AWS CLI credentials)
- Default VPC & Subnets

---

##  Tools & Technologies
- Terraform
- AWS CLI
- Amazon Linux 2023
- Nginx (demo web server)

---

##  Project Structure

```text
aws-ec2-ha-autoscaling-terraform/
├── terraform/
│   ├── provider.tf
│   ├── variables.tf
│   ├── main.tf
│   └── outputs.tf
├── screenshots/
└── README.md

---

##  Security Design
Two Security Groups are used following the **principle of least privilege**:

### ALB Security Group
- Inbound: HTTP (80) from `0.0.0.0/0`
- Outbound: All traffic

### EC2 Security Group
- Inbound: HTTP (80) **only from ALB Security Group**
- Outbound: All traffic

❌ EC2 instances are not publicly accessible  
✅ All traffic goes through ALB

---

##  Auto Scaling Configuration
- Minimum instances: `1`
- Desired instances: `1`
- Maximum instances: `3`

### Scaling Policies
- **Scale Out**: CPU > 70%
- **Scale In**: CPU < 30%

CloudWatch Alarms trigger scaling actions automatically.

---

## Deployment Workflow
This project follows a **production-style Terraform workflow**:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply 

Testing Scenarios
1️⃣ High Availability Test

Manually terminate an EC2 instance

Auto Scaling Group launches a replacement automatically

Application remains available via ALB

2️⃣ Auto Scaling Test

Generate load on the ALB endpoint

CPU usage increases

CloudWatch alarm triggers scale-out

New EC2 instances are launched automatically

 Outputs

After a successful apply, Terraform provides:

ALB DNS name

Public application URL

Auto Scaling Group name

Target Group ARN

 Cost Awareness

This project creates billable AWS resources:

Application Load Balancer

EC2 instances

After testing, clean up all resources

terraform destroy

 Learning Outcomes

Through this project, I practiced:

Designing highly available architectures

Implementing Auto Scaling in AWS

Writing clean and readable Terraform code

Applying real CloudOps workflows

Understanding production-grade security patterns
