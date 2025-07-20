# Inno Test
![Logo](./Assests/logo.jpg)

### One line description
Automatically check websites using custom test cases — simple, fast, and without programming skills.

### Link to the Demo Video
https://drive.google.com/file/d/1QEE76XP4mnRaU0ynXxHeObb-Hm-ILD3P/view?usp=sharing

### Link to product
[innotest.tech](https://innotest.tech/)

### Project Goal(s) and Description
The goal of the project is to create a simple and accessible tool for checking websites for basic interface elements such as fields, buttons, and headings. The user enters a URL and specifies what needs to be checked, and the system runs an automated test and provides a result in the form of ✅/❌ for each question.

## Development

## Roadmap

- [x] **MVP-0**
  - [x] Interface Layout (Figma)  
  - [x] User scenario elaboration  
  - [x] Without working logic  

- [x] **MVP-1**
  - [x] Front-to-back communication  
  - [x] DOM parsing and checking by conditions  
  - [x] Adding test steps (+)  
  - [x] Entering URLs and conditions  

- [x] **MVP-2**
  - [x] Use selenium to enhance accuracy  
  - [x] Increase range of tests

- [ ] **MVP-3**
  - [ ] Export results in PDF format  
  - [ ] UI/UX testing with users


### Kanban board

We use a GitLab Issue Board with the following columns:

- To Do  
  _Entry criteria:_
    - Issue is estimated
    - Issue uses the defined template
    - Label To Do is applied

- In Progress  
  _Entry criteria:_
    - A new branch is created for the issue
    - Assigned to a team member

- In Review  
  _Entry criteria:_
    - Merge request is created
    - Reviewer is assigned

- Ready to deploy  
  _Entry criteria:_
    - Review is complete
    - MR is approved

- User Testing  
  _Entry criteria:_
    - Feature is deployed to staging
    - Customer is informed and test scenario is ready

- Done  
  _Entry criteria:_
    - All acceptance criteria are met
    - Feedback (if any) is resolved
    - Issue is closed

## Installation and Deployment

### Prerequisites
 - Go 1.24+
 - Dart 3.8.1 (Flutter 3.32.4)
 - Python 3.12+
 - Git

### Local Development Setup

  ` git clone https://github.com/cQu1x/Autotester
    cd Autotester
    docker-compose build
    docker-compose up -d `
 

## Documentation
### Quality assurance

- [Quality Attribute Scenarios](https://github.com/cQu1x/Autotester/blob/main/docs/quality-assurance/quality-attribute-scenarios.md)
- [Automated Tests](https://github.com/cQu1x/Autotester/blob/main/docs/quality-assurance/automated-tests.md)
- [User Acceptance Tests](https://github.com/cQu1x/Autotester/blob/main/docs/quality-assurance/user-acceptance-tests.md)

### Build and Deployment

- [Continuous Integration](https://github.com/cQu1x/Autotester/blob/main/docs/automation/continuous-integration.md)

###  Architecture

- [Architecture Overview](https://github.com/cQu1x/Autotester/blob/main/docs/architecture/architecture.md)
- [Static View](https://github.com/cQu1x/Autotester/blob/main/docs/architecture/static-view.md)
- [Dynamic View](https://github.com/cQu1x/Autotester/blob/main/docs/architecture/dynamic-view.md)
- [Deployment View](https://github.com/cQu1x/Autotester/blob/main/docs/architecture/deployment-view.md)

### MIT Licence:
https://github.com/cQu1x/Autotester/blob/main/LICENSE
