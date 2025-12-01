# 🛡️ TechCorp IAM Modernization Project
![Certification Status](https://img.shields.io/badge/Certification-Tata%20Consultancy%20Services-blue)

**Based on the Tata Cybersecurity Analyst Job Simulation.**

# EntraID-Zero-Trust-Policies
Identity and Access Management (IAM) configurations for TechCorp enterprise simulation.

# Project: Zero Trust Access Control Configuration

## 📌 Overview
This repository contains configuration artifacts for a **Microsoft Entra ID (Azure AD)** Identity and Access Management (IAM) implementation. The goal of this project was to design a robust defense strategy for a global enterprise (TechCorp) to prevent unauthorized access from high-risk geolocations.

## 🛠 Technology Stack
- **Platform:** Microsoft Entra ID (Azure Active Directory)
- **Protocol:** Microsoft Graph API
- **Concept:** Zero Trust Security Model (Verify Explicitly)

## 📂 File Description: `block-high-risk-countries.json`
This JSON definition represents a **Conditional Access Policy**. In a real-world scenario, this script can be deployed via the Microsoft Graph API to programmatically enforce security rules across the tenant.

### Key Logic Breakdown:
1.  **Trigger:** The policy monitors all user sign-ins (`includeUsers: ["All"]`).
2.  **Risk Evaluation:** It specifically targets sign-ins flagged as "High" or "Medium" risk by Microsoft's Identity Protection AI.
3.  **Location Fencing:** It includes ALL locations by default but **excludes** trusted corporate IP ranges (e.g., Head Office).
4.  **Action:** If a login attempt originates from outside the trusted perimeter AND is flagged as risky, the system performs a **hard block** (`builtInControls: ["block"]`).

## 🚀 How to Deploy (Simulation)
1.  Authenticate to Microsoft Graph Explorer.
2.  POST this JSON payload to the endpoint: `https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies`.
3.  The policy will instantly activate across the tenant.

---
*This project is part of my cybersecurity portfolio demonstrating Infrastructure as Code (IaC) for Identity Management.*
