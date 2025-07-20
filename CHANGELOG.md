# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [MVP-2] - Released

### Added

- Switched to Selenium for browser-level interactions, replacing raw HTTP requests.
- Integrated ChatGPT o4 as the new LLM.
- Improved prompt quality and structure for clearer and more precise evaluations.

### Changed

- Prompts now better reflect end-user language and reduce ambiguity.

---

## [MVP-1] - Released

### Added

- Introduced per-criterion prompt generation with manual crafting for higher accuracy.
- Switched to DeepSeek as the language model provider.

### Changed

- Replaced generic prompts with criterion-specific ones tailored to each test case.

---

## [MVP-0] - Released

### Added

- Basic evaluation engine returning pass/fail per criterion.
- Integration with Microsoft Phi-4 as the initial LLM backend.

