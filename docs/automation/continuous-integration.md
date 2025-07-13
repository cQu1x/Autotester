# Continuous Integration Guide

This document describes the automated CI pipeline for the project, including the tools used and steps executed on each commit and pull request.

---

##  Overview

Our CI system ensures that every code change is automatically built, tested, and validated before being merged into the main branch.

CI is powered by **GitHub Actions** and defined in the following files:

- `.github/workflows/flutter_ci.yml`
- `.github/workflows/go-ci.yml`
- `.github/workflows/python-ci.yml`

---

## Tools Used

| Tool            | Purpose                          |
|-----------------|----------------------------------|
| GitHub Actions  | CI runner                        |
| Docker          | Containerized build/test         |
| go test,golangCI| Backend unit tests and linting   |
| Flutter         | Frontend build & widget testing  |
| pytest          | Python backend testing           |

---

## 🧪 Pipeline Steps

###  Backend (Go)
1. Run `go mod tidy`
2. Run `go test ./...`

###  Frontend (Flutter)
1. Run `flutter pub get`
2. Run `flutter test`

###  Python (LLM Service)
1. Run `black --check`
2. Run `isort --check-only`
3. Run `pytest`

---

##  Triggers

CI workflows run on:

- Every pull request to `main, go-backend, fontend_branch`
- Manual dispatch via GitHub UI

---
